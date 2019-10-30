Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D08CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E4720679
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O0gGjKRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJ3Olw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:41:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43224 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfJ3Olv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 10:41:51 -0400
Received: by mail-il1-f194.google.com with SMTP id j2so209378ilc.10
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8M4Q/hulOLKq5QBH7SseZicRn46BDfUKYYJB1woZ9F8=;
        b=O0gGjKRrxHys6Q2aujV+4MT2j/ZjsSYkDi9GKfTadrp+3OsaEj9MpPZeaVUYjh3jga
         Lt/pb1YjDeKkLIc9X0ysapeDeMirJQ5DAoWssEDfb1y9SMHca7Cpner/0PwQkojLHkpx
         N4TSDBzSztYw8kJfiT9Daj01/md5WfML34mttZWozPOAn5dmoM5foBsQXL+jEaHnmEzW
         RhhGAMAO5fVn+TzVSsErUinwOJRVAltcO+jIVr/z2lFeIAA+i5gdvsrvJVYsoFn6iVDd
         5t2q0XNohZr2NnrrDWO1Q8lxvwtpuTZKxxUQL9BKAIZqMKdtPXdqb1BwFUAK4RSsm2wv
         ZkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8M4Q/hulOLKq5QBH7SseZicRn46BDfUKYYJB1woZ9F8=;
        b=WbtVMo8gtnKFVA9E27Nm3rxHuBd7LJJuAAkgnyYC6ZiDHDzTE8WBo/AO/VC38mSBl7
         0e+YlIlfBc7KhZlXm0xbZ5iQPLGPSVBdLG+LYWTeyB/QKjX4xW8KSA0TyVqp0ZDhRxMm
         DP4cRKQBebR4fT86KHC4UcHHvaqHsRZ889zDU2JfOJqb8LTJJ64pYNYSaaAhMrCd5Pqv
         XmttTKQf/xZLNPtHJREjkXCfRr/DKYyXXF+dVKrPfnVAGpeZr7VaCYK/3miEyKklZycf
         1yllq99bTEu7SF2DpLniqzWhN3jS5Z+MiYNz038xWDcOsT8MWsyD6ZuAaLeiGYAgTudK
         Td6A==
X-Gm-Message-State: APjAAAVsyylMwQUpdc+0Za1lcVKsDvO6FjcYdTPHk9tYuATXCqO9hJnO
        a7Kt3s5KJ+UZF1LkuunArYhXnA==
X-Google-Smtp-Source: APXvYqyqrROuX3U0xP+PNenNQOMYso72VKgcxfO/6ysc4+hXLZApIoNa/HRe7jHr0SUpJ9LQw4UwlQ==
X-Received: by 2002:a92:580c:: with SMTP id m12mr389533ilb.225.1572446509207;
        Wed, 30 Oct 2019 07:41:49 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i79sm55737ild.6.2019.10.30.07.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:41:48 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
To:     syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        dhowells@redhat.com, gregkh@linuxfoundation.org,
        hannes@cmpxchg.org, joel@joelfernandes.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        mingo@redhat.com, patrick.bellasi@arm.com, rgb@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yamada.masahiro@socionext.com
References: <00000000000069801e05961be5fb@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
Date:   Wed, 30 Oct 2019 08:41:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <00000000000069801e05961be5fb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/19 1:44 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ef0524d3654628ead811f328af0a4a2953a8310f
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Oct 24 13:25:42 2019 +0000
> 
>       io_uring: replace workqueue usage with io-wq
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
> start commit:   c57cf383 Add linux-next specific files for 20191029
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
> dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000
> 
> Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
> Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")

Good catch, it's a case of NULL vs ERR_PTR() confusion. I'll fold in
the below fix.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index af1937d66aee..76d653085987 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3534,8 +3534,9 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	/* Do QD, or 4 * CPUS, whatever is smallest */
 	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
 	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm);
-	if (!ctx->io_wq) {
-		ret = -ENOMEM;
+	if (IS_ERR(ctx->io_wq)) {
+		ret = PTR_ERR(ctx->io_wq);
+		ctx->io_wq = NULL;
 		goto err;
 	}
 

-- 
Jens Axboe

