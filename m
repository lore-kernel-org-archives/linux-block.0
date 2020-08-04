Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A8C433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227F7208A9
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVOGzAgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHDM4p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDM4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 08:56:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6344C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 05:56:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so4383234pfa.8
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sd86GKM4RcWtK+zQ2qUhQaa6//R52dI1a0Ct8woB7Pw=;
        b=IVOGzAggmutYx7+l0R+c7yN3hAKmBbGyxm/aM0abKFIHdanthdrLNi9OQk/p+TptIT
         R7OUJfHzOU+BY98liqOAeMqta6yC86DsTIvBCMwbUFcz8BNngM7l1kCfb6V+VDIQ8pqB
         6DNCR79RIHowJDW6Bf0EGfCtKf3sCRpH7FIc47DNDw+XArVdYjba84pbOyI3JUGBlMBu
         vvC3nH34T9kEGWKxwegxjPyQnPFIM5Dam3WFSu6hhpqD5w0024ATITmlW7RFF1r/vkjK
         12y+2fpGsLMU1ozTRepAF8xFA23XcUIq96Cr3llZUrgt96RQrTe/UFTm0KFTP3IfAcfI
         0Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sd86GKM4RcWtK+zQ2qUhQaa6//R52dI1a0Ct8woB7Pw=;
        b=nlTIiaDSw6AERu18AuZfkK2iwZWRM1Kc0YLafsVMIxg7QxVvEO9BE1lqWNspfpkvJd
         LzfXvh5rDJR7RruaCG4ES/avZ2C2zTwJoK2brrc2YkRxtaAr6dcdt4LP3nd5W+l8woyx
         Qc6bjOWJN+PwwlL2qq2cAgxv8v7xWT8ubaufaTlMRLs7BFLw2agYzObr+xLEHSTZMOzw
         nJP0qaKyVro4kDX3PWwQNs4GmL1DFzl1M9yDy9aPiX0Q7DfR4r8Rzz1WVtJHYIbDSPk1
         NxGsRpaqat3jB5SdIey31kFWftCs99GFyzDFrED/DRbcabhZ9zFnZUNGBly5wBeS+nTO
         ugqQ==
X-Gm-Message-State: AOAM5333VC1LqelbUaUATafVQZFJx4/lLmHS7/hAUwW9kW90wmeu1v+o
        4uizjYEQEtzelmuUTLmsd+z4gpTr3Dw=
X-Google-Smtp-Source: ABdhPJy53ciABbs7RzlCjRiIjamKMzFxLjgWxHiTkjtrPhlr8ydGu8M6T7PrL0ktnpAGmJTxDo3Jrw==
X-Received: by 2002:a62:29c6:: with SMTP id p189mr19850644pfp.55.1596545804018;
        Tue, 04 Aug 2020 05:56:44 -0700 (PDT)
Received: from ubuntu ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l7sm2584921pjf.43.2020.08.04.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 05:56:43 -0700 (PDT)
Date:   Tue, 4 Aug 2020 05:56:37 -0700
From:   Liu Yong <pkfxxxing@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] fs/io_uring.c: fix null ptr deference in io_send_recvmsg()
Message-ID: <20200804125637.GA22088@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In io_send_recvmsg(), there is no check for the req->file.
User can change the opcode from IORING_OP_NOP to IORING_OP_SENDMSG
through competition after the io_req_set_file().

This vulnerability will leak sensitive kernel information.

[352693.910110] BUG: kernel NULL pointer dereference, address: 0000000000000028
[352693.910112] #PF: supervisor read access in kernel mode
[352693.910112] #PF: error_code(0x0000) - not-present page
[352693.910113] PGD 8000000251396067 P4D 8000000251396067 PUD 1d64ba067 PMD 0
[352693.910115] Oops: 0000 [#3] SMP PTI
[352693.910116] CPU: 11 PID: 303132 Comm: test Tainted: G      D
[352693.910117] Hardware name: Dell Inc. OptiPlex 3060/0T0MHW, BIOS 1.4.2 06/11/2019
[352693.910120] RIP: 0010:sock_from_file+0x9/0x30
[352693.910122] RSP: 0018:ffffc0a5084cfc50 EFLAGS: 00010246
[352693.910122] RAX: ffff9f6ee284d000 RBX: ffff9f6bd3675000 RCX: ffffffff8b111340
[352693.910123] RDX: 0000000000000001 RSI: ffffc0a5084cfc64 RDI: 0000000000000000
[352693.910124] RBP: ffffc0a5084cfc50 R08: 0000000000000000 R09: ffff9f6ee51a9200
[352693.910124] R10: ffff9f6ee284d200 R11: 0000000000000000 R12: ffff9f6ee51a9200
[352693.910125] R13: 0000000000000001 R14: ffffffff8b111340 R15: ffff9f6ee284d000
[352693.910126] FS:  00000000016d7880(0000) GS:ffff9f6eee2c0000(0000) knlGS:0000000000000000
[352693.910126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[352693.910127] CR2: 0000000000000028 CR3: 000000041fb4a005 CR4: 00000000003626e0
[352693.910127] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[352693.910128] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[352693.910128] Call Trace:
[352693.910132]  io_send_recvmsg+0x49/0x170
[352693.910134]  ? __switch_to_asm+0x34/0x70
[352693.910135]  __io_submit_sqe+0x45e/0x8e0
[352693.910136]  ? __switch_to_asm+0x34/0x70
[352693.910137]  ? __switch_to_asm+0x40/0x70
[352693.910138]  ? __switch_to_asm+0x34/0x70
[352693.910138]  ? __switch_to_asm+0x40/0x70
[352693.910139]  ? __switch_to_asm+0x34/0x70
[352693.910140]  ? __switch_to_asm+0x40/0x70
[352693.910141]  ? __switch_to_asm+0x34/0x70
[352693.910142]  ? __switch_to_asm+0x40/0x70
[352693.910143]  ? __switch_to_asm+0x34/0x70
[352693.910144]  ? __switch_to_asm+0x34/0x70
[352693.910145]  __io_queue_sqe+0x23/0x230
[352693.910146]  io_queue_sqe+0x7a/0x90
[352693.910148]  io_submit_sqe+0x23d/0x330
[352693.910149]  io_ring_submit+0xca/0x200
[352693.910150]  ? do_nanosleep+0xad/0x160
[352693.910151]  ? hrtimer_init_sleeper+0x2c/0x90
[352693.910152]  ? hrtimer_nanosleep+0xc2/0x1a0
[352693.910154]  __x64_sys_io_uring_enter+0x1e4/0x2c0
[352693.910156]  do_syscall_64+0x57/0x190
[352693.910157]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Liu Yong <pkfxxxing@gmail.com>
---
 fs/io_uring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e0200406765c..0a26100b8260 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1675,6 +1675,9 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 
+	if (!req->file)
+		return -EBADF;
+
 	sock = sock_from_file(req->file, &ret);
 	if (sock) {
 		struct user_msghdr __user *msg;
-- 
2.17.1

