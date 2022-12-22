Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E9C4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 14:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiLVOtx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiLVOtw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 09:49:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F7BE0B
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 06:49:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0D4324668;
        Thu, 22 Dec 2022 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671720589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+oheTlsSrc1vG18NgCX/3Yz+uG2IIWWt/keNJwwN8U=;
        b=lG+8tt/votMT78YM1G+q+4dY56l5utIQ6iyNOWIMVfID8tG/TqudatUaX4UmyPQmDDDyLQ
        E3xjgJSSkgZrSEOWb+hoYGqmExDi6OSGqgbmJAxare4RKB4jygYxVbmn3IkMfzSQkqY8VB
        rz18y17C1k/8QN5aOtEOsTnDU8Yvk/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671720589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+oheTlsSrc1vG18NgCX/3Yz+uG2IIWWt/keNJwwN8U=;
        b=fMzqpA23e7fsyRf6G6t3qL9wT7wn+/PJxBmnqEKezvda809sQrJVaPcCW5T9Jb+AYeclg0
        EhnYLIS3gOIKMXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2B2213918;
        Thu, 22 Dec 2022 14:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0PxPN41upGMHUwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 14:49:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C25EA0732; Thu, 22 Dec 2022 15:49:49 +0100 (CET)
Date:   Thu, 22 Dec 2022 15:49:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, yukuai3@huawei.com
Subject: Re: [bug report]BUG: KFENCE: use-after-free read in
 bfq_exit_icq_bfqq+0x132/0x270
Message-ID: <20221222144949.sqmrmycfg2hg5ymq@quack3>
References: <CAHj4cs-MzFV6WTfveRXTARsik9wTGgado2U4vnT8oH6vmfFjzQ@mail.gmail.com>
 <b480e35d-5171-425b-31c6-3a7fe5b8a666@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b480e35d-5171-425b-31c6-3a7fe5b8a666@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for report and the CC!

On Mon 19-12-22 10:52:57, Jens Axboe wrote:
> On 12/19/22 12:16 AM, Yi Zhang wrote:
> > Below issue was triggered during blktests nvme-tcp with for-next
> > (6.1.0, block, 2280cbf6), pls help check it
> > 
> > [  782.395936] run blktests nvme/013 at 2022-12-18 07:32:09
> > [  782.425739] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  782.435780] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [  782.446357] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0042-3910-8039-c6c04f544833.
> > [  782.460744] nvme nvme0: creating 32 I/O queues.
> > [  782.466760] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> > [  782.479615] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> > 127.0.0.1:4420
> > [  783.612793] XFS (nvme0n1): Mounting V5 Filesystem
> > [  783.650705] XFS (nvme0n1): Ending clean mount
> > [  799.653271] ==================================================================
> > [  799.660496] BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
> > [  799.669117] Use-after-free read at 0x000000008c692c21 (in kfence-#11):
> > [  799.675647]  bfq_exit_icq_bfqq+0x132/0x270
> > [  799.679753]  bfq_exit_icq+0x5b/0x80
> > [  799.683255]  exit_io_context+0x81/0xb0
> > [  799.687015]  do_exit+0x74b/0xaf0
> > [  799.690256]  kthread_exit+0x25/0x30
> > [  799.693758]  kthread+0xc8/0x110
> > [  799.696904]  ret_from_fork+0x1f/0x30
> > [  799.701991] kfence-#11: 0x00000000f1839eaa-0x0000000011c747a1,
> > size=568, cache=bfq_queue
> > [  799.711549] allocated by task 19533 on cpu 9 at 499.180335s:
> > [  799.717218]  bfq_get_queue+0xe0/0x530
> > [  799.720884]  bfq_get_bfqq_handle_split+0x75/0x120
> > [  799.725592]  bfq_insert_requests+0x1d15/0x2710
> > [  799.730045]  blk_mq_sched_insert_requests+0x5c/0x170
> > [  799.735021]  blk_mq_flush_plug_list+0x115/0x2e0
> > [  799.739551]  __blk_flush_plug+0xf2/0x130
> > [  799.743479]  blk_finish_plug+0x25/0x40
> > [  799.747231]  __iomap_dio_rw+0x520/0x7b0
> > [  799.751070]  btrfs_dio_write+0x42/0x50
> > [  799.754832]  btrfs_do_write_iter+0x2f4/0x5d0
> > [  799.759112]  nvmet_file_submit_bvec+0xa6/0xe0 [nvmet]
> > [  799.764193]  nvmet_file_execute_io+0x1a4/0x250 [nvmet]
> > [  799.769349]  process_one_work+0x1c4/0x380
> > [  799.773361]  worker_thread+0x4d/0x380
> > [  799.777028]  kthread+0xe6/0x110
> > [  799.780174]  ret_from_fork+0x1f/0x30
> > [  799.785252] freed by task 19533 on cpu 9 at 799.653250s:
> > [  799.790584]  bfq_put_queue+0x183/0x2c0
> > [  799.794344]  bfq_exit_icq_bfqq+0x129/0x270
> > [  799.798442]  bfq_exit_icq+0x5b/0x80
> > [  799.801934]  exit_io_context+0x81/0xb0
> > [  799.805687]  do_exit+0x74b/0xaf0
> > [  799.808920]  kthread_exit+0x25/0x30
> > [  799.812413]  kthread+0xc8/0x110
> > [  799.815561]  ret_from_fork+0x1f/0x30
> > [  799.820648] CPU: 9 PID: 19533 Comm: kworker/dying Not tainted 6.1.0 #1
> > [  799.827181] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> > 2.15.1 06/15/2022
> > [  799.834746] ==================================================================
> > [  823.081364] XFS (nvme0n1): Unmounting Filesystem
> > [  823.159994] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

Can you use addr2line to find which dereference is exactly causing the
problem? Hum, it seems to point to some strange issue because we've just
freed bfqq in this exit_io_context() invocation and seeing you are testing
linux-block tree I think the problem might be caused by 64dc8c732f5c
("block, bfq: fix possible uaf for 'bfqq->bic'"). Kuai, I think we've
messed up bfq_exit_icq_bfqq() and now bic_set_bfqq() can access already
freed 'old_bfqq'. So we need something like:


                spin_lock_irqsave(&bfqd->lock, flags);
                bfqq->bic = NULL;
-               bfq_exit_bfqq(bfqd, bfqq);
                bic_set_bfqq(bic, NULL, is_sync);
+               bfq_exit_bfqq(bfqd, bfqq);
                spin_unlock_irqrestore(&bfqd->lock, flags);

so free bfqq only after it is removed from the bic...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
