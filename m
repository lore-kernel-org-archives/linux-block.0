Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E054EC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAD32082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="su5ZJ9y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAD32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLEMpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:45:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeLEMpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 07:45:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so9954694pfo.7
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=G8QZPQEeeU7qt4lDRwZPt7OTduSBbsiDEUEl2XNu/G8=;
        b=su5ZJ9y/dK9va+H/NYnSjLSNIjaiayooyACVX+dH6qjpId3CB4k0GT/ZtJzD1eI6M4
         CS0MH0FW1QLzcqaBtdj2nP1wocBhlxiiUYvUVQb6n4L0NLsnK246zZR1dlO7a52Hx2UC
         r80V39umhiYbVUCsopcp9RdNtN9vuI9DZjfwNVLVJzraIWJ5MS0g0hnT0Hq/zISvnPrn
         MebikwCZEAAtazBz8XLPT+xsiluOBLU1VeKxA5V0sIdkXju5iXCQ/frMoFKX4l3KpMdT
         INnLuL+RVl61+kt4ohP0y4486K9gmIpS+NuiPu2dqEbrLHzSzUfoTpQWwJNUjhPebeyb
         79FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G8QZPQEeeU7qt4lDRwZPt7OTduSBbsiDEUEl2XNu/G8=;
        b=aSm60lDAhOByqLqonvE+Ass3ouhFlq8s5GI3jT+4b9mw8Tmcm8dIjIEQ6Om/QzkefN
         9xX5PQbgwWR/EXB2pwj6IGqb0YomAb3LFN7pCfXNLzUyyXrISyNm2wQMoJxyHKgGKznr
         7SFBdAgGQrMeu8YMdluzRNWf7BmG6REShBTEOrbFxFOcs1IdMPIx8yGvl0cKO2Al0DXo
         gIfpG5QF8f0pPxhvbP/HTid6cJXWsRJ16Md9cWZrTEPzbJMcQpNayVt697noSqx7tGFr
         06juKZMfDh0MznAqqvF2MGgDSzHGhZf1YoxHgDQWYJH1TxaFmKSzygYg4zaD5bYEU4fL
         WVFQ==
X-Gm-Message-State: AA+aEWY35Wb3rw0ZHOAl5KErEToJh9LKLh473NCNEb9rHZbm/qCz+HLy
        xa7rbfujzNu2UFAriw9A8Yj2EDsQwp4=
X-Google-Smtp-Source: AFSGD/UJz2US3CmpUC9eNqYdAmEtBSVPL/M9TffVKm0xFkTtz9Iksjgnik5ssp5vb9PvAhb/P7T4pg==
X-Received: by 2002:a63:a552:: with SMTP id r18mr20374466pgu.176.1544013918404;
        Wed, 05 Dec 2018 04:45:18 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a10sm25450183pfi.138.2018.12.05.04.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:45:17 -0800 (PST)
Subject: Re: Kernel crashes after 529262d56dbe "block: remove ->poll_fn"
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0bd2d36e-bef0-b836-7039-124ae4d346a6@virtuozzo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c374e085-a86b-6df3-2142-74968f067bc7@kernel.dk>
Date:   Wed, 5 Dec 2018 05:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0bd2d36e-bef0-b836-7039-124ae4d346a6@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 5:19 AM, Kirill Tkhai wrote:
> Hi,
> 
> commit 529262d56dbe from today linux-next makes my kernel crash:
> 
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sun Dec 2 17:46:26 2018 +0100
> 
>     block: remove ->poll_fn
> 
> Traceback is below, config and reproducer (not minimal, just a random one populating swap) are attached.
> 
> [   29.097612] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [   29.098730] #PF error: [INSTR]
> [   29.099104] PGD 0 P4D 0 
> [   29.099425] Oops: 0010 [#1] PREEMPT SMP
> [   29.099879] CPU: 3 PID: 925 Comm: bash Not tainted 4.20.0-rc5-next-20181205+ #244
> [   29.100658] RIP: 0010:          (null)
> [   29.101100] Code: Bad RIP value.
> [   29.101480] RSP: 0000:ffffc9000023fb80 EFLAGS: 00010202
> [   29.102061] RAX: ffffffff8182d0e0 RBX: ffff88807ceee000 RCX: 0000000000000000
> [   29.102818] RDX: ffff88807d560f40 RSI: 0000000000000000 RDI: ffff88807ceee000
> [   29.103661] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000002000
> [   29.104560] R10: 00000000ffffffff R11: ffff88807c854150 R12: 0000000000000000
> [   29.105458] R13: 0000000000000002 R14: ffff88807d7236c0 R15: ffffc9000023fe20
> [   29.106438] FS:  00007faba91d7740(0000) GS:ffff88807db80000(0000) knlGS:0000000000000000
> [   29.107304] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.107917] CR2: ffffffffffffffd6 CR3: 000000007a172000 CR4: 00000000000006a0
> [   29.109401] Call Trace:
> [   29.110017]  ? blk_poll+0x27c/0x340
> [   29.110691]  ? submit_bio+0x40/0x120
> [   29.111278]  ? swap_readpage+0x148/0x190
> [   29.111924]  ? read_swap_cache_async+0x53/0x60
> [   29.112670]  ? swap_cluster_readahead+0x231/0x2b0
> [   29.113310]  ? swapin_readahead+0x2ce/0x400
> [   29.113878]  ? pagecache_get_page+0x2b/0x210
> [   29.114416]  ? do_swap_page+0x42c/0x800
> [   29.114919]  ? __handle_mm_fault+0x544/0xdd0
> [   29.115455]  ? handle_mm_fault+0x112/0x230
> [   29.115978]  ? __do_page_fault+0x196/0x410
> [   29.116501]  ? __put_user_4+0x19/0x20
> [   29.116990]  ? page_fault+0x5/0x20
> [   29.117451]  ? page_fault+0x1b/0x20
> [   29.117925] CR2: 0000000000000000
> [   29.118472] ---[ end trace 0faa4ddc190b41fa ]---

Can you try this? The swap read-in poll attempts looks totally
incorrect.


diff --git a/mm/page_io.c b/mm/page_io.c
index 5bdfd21c1bd9..f3455f9f8dc7 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -401,6 +401,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	get_task_struct(current);
 	bio->bi_private = current;
 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
+	if (synchronous)
+		bio->bi_opf |= REQ_HIPRI;
 	count_vm_event(PSWPIN);
 	bio_get(bio);
 	qc = submit_bio(bio);
@@ -411,7 +413,7 @@ int swap_readpage(struct page *page, bool synchronous)
 			break;
 
 		if (!blk_poll(disk->queue, qc, true))
-			break;
+			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 	bio_put(bio);

-- 
Jens Axboe

