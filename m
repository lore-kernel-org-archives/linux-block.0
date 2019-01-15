Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF912C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7246420859
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1hnhTsOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfAOE2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:28:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45921 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAOE2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 23:28:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so659104plm.12
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2tN2sGcytVFY0+Ywgd3h3jYjcEeH9XS+csfG72SxBlE=;
        b=1hnhTsOEZiVMzvTpyXFrvUON6TXbKq+0+V8oZseLIoe4LOCylFDfiWv/Mzm+XQ75py
         CqhAKa6tnKZf6prEdBzYkvBuVoaTqtobyrTk+ZwWvBeCrroUJafEmDzG666viGVcH5Tb
         CPJ7D2OVbXlvk9WsUJQYYIp+NY+C54YGpHey9nzRKJyUOE5NuC/wv1E65Jis2yxtprkn
         wN3gcxM70/yKt7cUYFFH8UdB+Y0NZW84IQVRPIdkyXa+5mWTlRI5J9mcaZnkCo1ejpYD
         HfzBHNYJ7B0TlYYJkw1jZdkmXxgtFCUDi/HQZtVA8EivLY35k10fj+kq1zPb0wib1UE1
         Zdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2tN2sGcytVFY0+Ywgd3h3jYjcEeH9XS+csfG72SxBlE=;
        b=TMSCE9VuIAFBqx56m1Ul0Fnr4EWMyI21c7OAqvGQP1adRhvwrcyX9krujRwVg8FfDc
         Vw5nbejeIXl842vODR0ph+NRCwQw1t+aFiGaFaCWlXFspSydncTIp2qXHkFz39+FeKXO
         FHYTLFMZULk2qBz6ILBViccWASRTm8Vzou+ZIFtBHgEYPUSXbyM97QQQ7RUAGG95OQP4
         BV+kHVgEbVfvkAPMYOYk4tlb2FgAua3ExLpiaKHLCci72oySvbCgHLuD28DIZiFuI1GF
         ddylTGMzEhdGulcOvbeL5gHxsPdKlmlZyXsYuABAd5wYLcCfaquCGZGchF5vqUS7oI1m
         YFuw==
X-Gm-Message-State: AJcUukd85yvI34K+c08pbCCI/4O2briu4XwbzMB8LQtKy0iYSQmDEB5S
        P8DsTuieT6395jq3iEBPMaRVN70/Cyvb+g==
X-Google-Smtp-Source: ALg8bN66ctkOZ42Zqnq/Yrz89S+7Yao8f05uQZpY9H8hx5gZlFWOgDVZHZtLiCFYknv45shbKiA3fg==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr2124047plo.162.1547526517063;
        Mon, 14 Jan 2019 20:28:37 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v184sm2256197pfb.182.2019.01.14.20.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 20:28:35 -0800 (PST)
Subject: Re: [PATCH] sbitmap: Protect swap_lock from hardirq
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190115035952.13325-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2bebd6a-cc89-d6c2-8203-718b5c12ea4f@kernel.dk>
Date:   Mon, 14 Jan 2019 21:28:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115035952.13325-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 8:59 PM, Ming Lei wrote:
> The original report is actually one real deadlock:
> 
>     [  106.132865]  Possible interrupt unsafe locking scenario:
>     [  106.132865]
>     [  106.133659]        CPU0                    CPU1
>     [  106.134194]        ----                    ----
>     [  106.134733]   lock(&(&sb->map[i].swap_lock)->rlock);
>     [  106.135318]                                local_irq_disable();
>     [  106.136014]                                lock(&sbq->ws[i].wait);
>     [  106.136747]                                lock(&(&hctx->dispatch_wait_lock)->rlock);
>     [  106.137742]   <Interrupt>
>     [  106.138110]     lock(&sbq->ws[i].wait);
> 
> Because we may call blk_mq_get_driver_tag() directly from
> blk_mq_dispatch_rq_list() without holding any lock, then HARDIRQ may come
> and the above DEADLOCK is triggered.
> 
> ab53dcfb3e7b ("sbitmap: Protect swap_lock from hardirq") tries to fix
> this issue by using 'spin_lock_bh', which isn't enough because we complete
> request from hardirq context direclty in case of multiqueue.

Thanks Ming, I'll queue this up for shipping this week.

-- 
Jens Axboe

