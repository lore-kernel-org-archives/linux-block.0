Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF7FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 02:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354709AbiCQCdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 22:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354401AbiCQCdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 22:33:36 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 19:32:20 PDT
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7E1F60E
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 19:32:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id 4BCFB81;
        Wed, 16 Mar 2022 19:27:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lng6l6f0Osa2; Wed, 16 Mar 2022 19:26:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id 5D8D739;
        Wed, 16 Mar 2022 19:26:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5D8D739
Date:   Wed, 16 Mar 2022 19:26:57 -0700 (PDT)
From:   Eric Wheeler <linux-block@lists.ewheeler.net>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-block@vger.kernel.org
Subject: loop: are parallel requests serialized by the single workqueue?
Message-ID: <59a58637-837-fc28-6cb9-d584aa21d60@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I was studying the loop.c DIO & AIO changes you made back in 2015 that 
increased loop performance and reduced the memory footprint 
(bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6).  

I have a few questions if you are able to comment, here is a quick 
summary:

The direct IO path starts by queuing the work:

  .queue_rq       = loop_queue_rq:

	-> loop_queue_work(lo, cmd);
	-> INIT_WORK(&worker->work, loop_workfn);
		... queue_work(lo->workqueue, work);

Then from within the workqueue:

	-> loop_workfn()
	-> loop_process_work(worker, &worker->cmd_list, worker->lo);
	-> loop_handle_cmd(cmd);
	-> do_req_filebacked(lo, blk_mq_rq_from_pdu(cmd) );
	-> lo_rw_aio(lo, cmd, pos, READ) // (or WRITE)

From here the kiocb is setup and this is the 5.17-rc8 code at the 
bottom of lo_rw_aio() when it sets up the dispatch to the filesystem:

	cmd->iocb.ki_pos = pos;
	cmd->iocb.ki_filp = file;
	cmd->iocb.ki_complete = lo_rw_aio_complete;
	cmd->iocb.ki_flags = IOCB_DIRECT;
	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);

	if (rw == WRITE)
		ret = call_write_iter(file, &cmd->iocb, &iter);
	else
		ret = call_read_iter(file, &cmd->iocb, &iter);

	lo_rw_aio_do_completion(cmd);

	if (ret != -EIOCBQUEUED)
		lo_rw_aio_complete(&cmd->iocb, ret);


After having called `call_read_iter` it is in the filesystem's
handler.

Since ki_complete is defined, does that mean the filesystem will _always_ 
take these in and always queue these internally and return -EIOCBQUEUED 
from call_read_iter()?  Another way to ask: if ki_complete!=NULL, can a 
filesystem ever behave synchronously?  (Is there documentation about this 
somewhere?  I couldn't find anything definitive.)



About the cleanup after dispatch at the bottom of lo_rw_aio() from this 
code (also shown above):

	lo_rw_aio_do_completion(cmd);

	if (ret != -EIOCBQUEUED)
		lo_rw_aio_complete(&cmd->iocb, ret);

* It appears that lo_rw_aio_do_completion() will `kfree(cmd->bvec)`.  If 
  the filesystem queued the cmd->iocb for internal use, would it have made 
  a copy of cmd->bvec so that this is safe?

* If ret != -EIOCBQUEUED, then lo_rw_aio_complete() is called which calls 
  lo_rw_aio_do_completion() a second time.  Now lo_rw_aio_do_completion 
  does do this ref check, so it _is_ safe:

	if (!atomic_dec_and_test(&cmd->ref))
		return;

For my own understanding, is this equivalent?

-	lo_rw_aio_do_completion(cmd);

	if (ret != -EIOCBQUEUED)
		lo_rw_aio_complete(&cmd->iocb, ret);
+	else
+		lo_rw_aio_do_completion(cmd);



Related questions: 

* For REQ_OP_FLUSH, lo_req_flush() is called: it does not appear that 
  lo_req_flush() does anything to make sure ki_complete has been called 
  for pending work, it just calls vfs_fsync().

  Is this a consistency problem?

  For example, if loop has queued async kiocb's to the filesystem via
  .read_iter/.write_iter, is it the filesystem's responsibility to 
  complete that work before returning from vfs_sync() or is it possible 
  that the vfs_sync() completes before ->ki_complete() is called?

* Would there be any benefit to parallelizing the do_req_filebackend()  
  calls with (for example) multiple work queues?

* If so, then besides flushing the parallel work and doing vfs_fsync (from 
  lo_req_flush), are there any other consistency issues to consider on 
  REQ_OP_FLUSH?  
     * Can READs and WRITEs be out-of-order between flushes?

Thanks for your help!

-Eric

--
Eric Wheeler
