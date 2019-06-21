Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B2C43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CF62083B
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g2i7pJ4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFUNNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:13:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39672 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUNNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 09:13:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so10061489edv.6
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6XGwmeOwlKSVTBVyAsB4aFpWNvK64SOug+dbRa2dIBc=;
        b=g2i7pJ4dd03mZG0WQzNY70IuD4isWP6wrHJbt1eDPspbrH8LWdsARy2JRG4gqKdJTe
         fFSESnljolpzF8FJ2LxIehaicnqD8HYbwc87MH8WGh2RMypCpcxRMhRA8WcQGXzuiPLF
         fsSDTogw2zQbDAS5UoCul66pOy9vKzg5qQCyfUJUY2mj+I/NClbvi23Z+n3OGwMQgPGP
         gBSJBV5yMMM56V0h9TweNvPidIDP4sO4KbiRPGLLjAr9MwwycYdebLwgqruNRE7GI9cj
         Gf0uVj6NEwiyCqzbHB46TXQE5fEdUp8chtO6woeasKD/2xMCkzs1tAAxFbAHM50GM+FZ
         TbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6XGwmeOwlKSVTBVyAsB4aFpWNvK64SOug+dbRa2dIBc=;
        b=fqgtxAJk/HvTXsDTvKxfaCT7W1A4d0BMqDcAy6bV7lA/cqlC+WZCCrUH3RJzZvSrgF
         GZRgeb4Tnn+IFCI0HOyRFBEFqBErdRN9qgvdcygNfVnFABOJqiLZBgQRapv+mPWgO6Sd
         6mcTWGRyInxBLRkxSo9ZAdCSlW5BBoltCMvj7j0zmcw+xoDhjegzkc8glS6rF2IvtIt9
         nelu/RG3saz7IaAzr57ex0akOgaUPBK8yl24geTblE+ld40oofofcaIWV8ywQ/BeQJi5
         Vo2eNDumV3M13uY94WzEPFKCYF75M0GX57Auh9EXj7pxL9KG2q2aW3sp5enTy0ImPbiJ
         6Kmw==
X-Gm-Message-State: APjAAAV/UfFVIzSuCPCqIDryBOJTNZZb9cxQNWhhzUC9fw8SLaa8kZEW
        exySkzFrc0wnaU1P43B1O+UyiG7zgqVsWb8K
X-Google-Smtp-Source: APXvYqwVT0b/aSjmvor1evdYxZfzrvzWzHWaYbG4iA2o71fd9yUMI2T+qcmwrC0vkwMVxY8q3NxZEw==
X-Received: by 2002:a05:6402:1612:: with SMTP id f18mr84636664edv.231.1561122819639;
        Fri, 21 Jun 2019 06:13:39 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id d12sm422255ejd.65.2019.06.21.06.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:13:38 -0700 (PDT)
Subject: Re: [io_uring]: fio's io_uring engine causing general protection
 fault
To:     Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "fio-owner@vger.kernel.org" <fio-owner@vger.kernel.org>
References: <7A8449F0-0E79-43B0-9FDD-45292691F0F2@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4882e4e8-2c58-9c37-9131-91217baa55c5@kernel.dk>
Date:   Fri, 21 Jun 2019 07:13:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <7A8449F0-0E79-43B0-9FDD-45292691F0F2@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/19 6:40 AM, Stephen  Bates wrote:
> Hi
> 
> I hit the following General Protection Fault when testing io_uring via the io_uring engine in fio. This was on a VM running 5.2-rc5 and the latest version of fio. The issue occurs for both null_blk and fake NVMe drives. I have not tested bare metal or real NVMe SSDs. The fio script used is given below.
> 
> [io_uring]
> time_based=1
> runtime=60
> filename=/dev/nvme2n1 (note /dev/nullb0 also fails)
> ioengine=io_uring
> bs=4k
> rw=readwrite
> direct=1
> fixedbufs=1
> sqthread_poll=1
> sqthread_poll_cpu=0
> 
> [  964.540374] general protection fault: 0000 [#1] SMP PTI
> [  964.542041] CPU: 0 PID: 872 Comm: io_uring-sq Not tainted 5.2.0-rc5-cpacket-io-uring #1
> [  964.545589] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [  964.549761] RIP: 0010:fput_many+0x7/0x90
> [  964.551522] Code: 01 48 85 ff 74 17 55 48 89 e5 53 48 8b 1f e8 a0 f9 ff ff 48 85 db 48 89 df 75 f0 5b 5d f3 c3 0f 1f 40 00 0f 1f 44 00 00 89 f6 <f0> 48 29 77 38 74 01 c3 55 48 89 e5 53 48 89 fb 65 48 \
> 8b 3c 25 c0
> [  964.559031] RSP: 0018:ffffadeb817ebc50 EFLAGS: 00010246
> [  964.561112] RAX: 0000000000000004 RBX: ffff8f46ad477480 RCX: 0000000000001805
> [  964.563911] RDX: 0000000000000000 RSI: 0000000000000001 RDI: f18b51b9a39552b5
> [  964.566580] RBP: ffffadeb817ebc58 R08: ffff8f46b7a318c0 R09: 000000000000015d
> [  964.569109] R10: ffffadeb817ebce8 R11: 0000000000000020 R12: ffff8f46ad4cd000
> [  964.571623] R13: 00000000fffffff7 R14: ffffadeb817ebe30 R15: 0000000000000004
> [  964.574153] FS:  0000000000000000(0000) GS:ffff8f46b7a00000(0000) knlGS:0000000000000000
> [  964.577020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  964.578917] CR2: 000055828f0bbbf0 CR3: 0000000232176004 CR4: 00000000003606f0
> [  964.581221] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  964.583511] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  964.585808] Call Trace:
> [  964.586626]  ? fput+0x13/0x20
> [  964.587613]  io_free_req+0x20/0x40
> [  964.588733]  io_put_req+0x1b/0x20
> [  964.589795]  io_submit_sqe+0x40a/0x680
> [  964.590919]  ? __switch_to_asm+0x34/0x70
> [  964.592090]  ? __switch_to_asm+0x40/0x70
> [  964.593270]  io_submit_sqes+0xb9/0x160
> [  964.594392]  ? io_submit_sqes+0xb9/0x160
> [  964.595564]  ? __switch_to_asm+0x40/0x70
> [  964.596737]  ? __switch_to_asm+0x34/0x70
> [  964.597918]  ? __schedule+0x3f2/0x6a0
> [  964.599015]  ? __switch_to_asm+0x34/0x70
> [  964.600444]  io_sq_thread+0x1af/0x470
> [  964.601568]  ? __switch_to_asm+0x34/0x70
> [  964.602655]  ? wait_woken+0x80/0x80
> [  964.603625]  ? __switch_to+0x85/0x410
> [  964.604638]  ? __switch_to_asm+0x40/0x70
> [  964.605726]  ? __switch_to_asm+0x34/0x70
> [  964.606811]  ? __schedule+0x3f2/0x6a0
> [  964.607827]  kthread+0x105/0x140
> [  964.608725]  ? io_submit_sqes+0x160/0x160
> [  964.609836]  ? kthread+0x105/0x140
> [  964.610780]  ? io_submit_sqes+0x160/0x160
> [  964.611887]  ? kthread_destroy_worker+0x50/0x50
> [  964.613158]  ret_from_fork+0x35/0x40
> [  964.614148] Modules linked in: crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper joydev input_leds serio_raw mac_hid sch_fq_codel sunrpc null_blk \
> ip_tables x_tables autofs4 8139too psmouse 8139cp floppy mii i2c_piix4 pata_acpi
> [  964.620856] ---[ end trace bdbba818b310272c ]---

Try this patch. Technically, it's not valid to use sqthread without
fixed files registered through io_uring_register(), and this case
looks to me like we're just not initializing ->file before we end
up failing the request due to a violation of that requirement.

Not tested, on vacation...


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 86a2bd721900..485832deb7ea 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -579,6 +579,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->cur_req++;
 	}
 
+	req->file = NULL;
 	req->ctx = ctx;
 	req->flags = 0;
 	/* one is dropped after submission, the other at completion */
@@ -1801,10 +1802,8 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 		req->sequence = ctx->cached_sq_head - 1;
 	}
 
-	if (!io_op_needs_file(s->sqe)) {
-		req->file = NULL;
+	if (!io_op_needs_file(s->sqe))
 		return 0;
-	}
 
 	if (flags & IOSQE_FIXED_FILE) {
 		if (unlikely(!ctx->user_files ||

-- 
Jens Axboe

