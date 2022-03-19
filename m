Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB2C433EF
	for <linux-block@archiver.kernel.org>; Sat, 19 Mar 2022 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiCSRPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Mar 2022 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiCSRPx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Mar 2022 13:15:53 -0400
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5C28AC69
        for <linux-block@vger.kernel.org>; Sat, 19 Mar 2022 10:14:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id EA0C381
        for <linux-block@vger.kernel.org>; Sat, 19 Mar 2022 10:14:31 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6RvKu1QlmWX1 for <linux-block@vger.kernel.org>;
        Sat, 19 Mar 2022 10:14:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id 29D2540
        for <linux-block@vger.kernel.org>; Sat, 19 Mar 2022 10:14:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 29D2540
Date:   Sat, 19 Mar 2022 10:14:29 -0700 (PDT)
From:   Eric Wheeler <linux-block@lists.ewheeler.net>
To:     linux-block@vger.kernel.org
Subject: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
Message-ID: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello all,

In loop.c do_req_filebacked() for REQ_OP_FLUSH, lo_req_flush() is called: 
it does not appear that lo_req_flush() does anything to make sure 
ki_complete has been called for pending work, it just calls vfs_fsync().

Is this a consistency problem?

For example, if the loop driver has queued async kiocb's to the filesystem 
via .read_iter/.write_iter, is it the filesystem's responsibility to 
complete that work before returning from vfs_sync() or is it possible that 
the vfs_sync() completes before ->ki_complete() is called?

Relatedly, does vfs_fsync() do anything for direct IO?  Ultimately 
f_op->fsync() is called so maybe the FS is told to commit its structures 
like sparse allocations that may not be on disk yet.


--
Eric Wheeler
