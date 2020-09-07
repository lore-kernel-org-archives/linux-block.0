Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDEC43461
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD932080A
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t0md+sgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgIGQlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbgIGQlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 12:41:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79463C061574
        for <linux-block@vger.kernel.org>; Mon,  7 Sep 2020 09:41:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b16so6961583pjp.0
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2020 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QI9owJq1qeNIbL5MGRj7H9ZbeWy3uMtOambIfQ05240=;
        b=t0md+sgRR59HAfNxNXQLb4d8jUGYK95h+b8RqrM3hkSN7fTSAyBDOpGa1vmbd0iKfM
         T4gFOAu/DuXESBPEiXk4p1IslX8AN2ySHrVut9XG7e359FtcveW84NdBYkOv8cBnhqWX
         n6Fh/5lJE65g9dwmUzzdWUbU+59YufFdlSEUVS7Tew1s0zHxsfCsBiI9MSMPC7/IJ3E8
         GDjEuqXJkX7zf3XqnaEhB/yZTMOl9b7L1RFN8r5H+dNs+Fz2Vx5pEKEvt8e/8Ll1vEeX
         lRsgbhP9G8BlrrHwMRX2UzjBty/etaulP1dKLCDBZwbKWKR0qtD4UsduAdYW7+YKW60M
         eVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QI9owJq1qeNIbL5MGRj7H9ZbeWy3uMtOambIfQ05240=;
        b=e3V6KKnkbKsQB4Yp5BwQ3MB/rqwh3GA95wqu9+lwxSoNzDaSt9GzUIcdGQBMc9Mmkk
         EwT6pWVQLmz0AWt2/ekRU1N/VD39jXaFAN3WyrWrKesc6JYDL6XdNwcUSJxRcrOGC6mm
         hwkI954+z3tPk6ZtE5iGUqhFNfnu2J2SW6CWpcyhMbkp+6ZAiJ38J0EoZSsleb4AOmXv
         uk5I0akkljhmkpYyq5h9LIEKudIjKNAY6JyEvg0jnkmgL8N17aP8BHFO83j30Ezbl1DA
         c8p8LVWX6l1hDgvA7qFWDNaiXZsvLPlYjvafXRRMeTgfaKMVoh9RS9btqIrmV6xFZtLA
         Qg8Q==
X-Gm-Message-State: AOAM533XQ/JHPYBdId+6iAxMzyID7G1Qy4JySvvaVFEUMMscTx5bISVm
        /Q58Q513VWDlpmlecoDaxq/rDA==
X-Google-Smtp-Source: ABdhPJxjMIPuK22ccwbpfS5Lc4urY7i8nlaAUy+/DPrUiHo0eKcYTMJtQ9YP2xudp317L+vQNfW2pA==
X-Received: by 2002:a17:90b:117:: with SMTP id p23mr149298pjz.67.1599496877962;
        Mon, 07 Sep 2020 09:41:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 142sm12521645pgf.68.2020.09.07.09.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:41:17 -0700 (PDT)
Subject: Re: [PATCH] kyber: Fix crash in kyber_finish_request()
To:     Yang Yang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com, Omar Sandoval <osandov@osandov.com>
References: <20200907074346.5383-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
Date:   Mon, 7 Sep 2020 10:41:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907074346.5383-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CC Omar

On 9/7/20 1:43 AM, Yang Yang wrote:
> Kernel crash when requeue flush request.
> It can be reproduced as below:
> 
> [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
> ...
> [    2.517468] pc : clear_bit+0x18/0x2c
> [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
> [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
> ...
> [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
> [    2.517602] Call trace:
> [    2.517606]  clear_bit+0x18/0x2c
> [    2.517619]  kyber_finish_request+0x74/0x80
> [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
> [    2.517637]  __scsi_queue_insert+0x11c/0x148
> [    2.517640]  scsi_softirq_done+0x114/0x130
> [    2.517643]  blk_done_softirq+0x7c/0xb0
> [    2.517651]  __do_softirq+0x208/0x3bc
> [    2.517657]  run_ksoftirqd+0x34/0x60
> [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
> [    2.517667]  kthread+0x110/0x120
> [    2.517669]  ret_from_fork+0x10/0x18
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  block/kyber-iosched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index a38c5ab103d1..af73afe7a05c 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -611,6 +611,9 @@ static void kyber_finish_request(struct request *rq)
>  {
>  	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
>  
> +	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
> +		return;
> +
>  	rq_clear_domain_token(kqd, rq);
>  }
>  
> 


-- 
Jens Axboe

