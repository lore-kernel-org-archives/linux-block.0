Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F29C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11A920855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nZJrXeLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfAQNyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:54:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44593 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfAQNyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 08:54:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4471187pgr.11
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 05:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2pB3Sy1nsN8br99qlgkRZ1OXNL0JnrGQxDKXfgA9KK0=;
        b=nZJrXeLqGAlsa/Ofbkbns2uDP0VDoBuUNt8uuc7hdmJJhAY2x4XifJLVWZXaHCXfyP
         RQKRG6ag5E8GaIRG8Du/ZpUpCgZxyyu8eYUuQPYH1xQbAYSLUfa4S9cYcWfkTxTW/BKm
         9bEb05lhtuVLXC71fkAizidrDg9GEaAo6PB1noBpGaVA7E+YZHarDSDjbWm2tJn/u3TM
         zZdFgGMX05+JpDJe8/1yQh9nejkWZEjApfdeHl/yMy5Rnus1JNaqyfDlzf6KasSuvgLS
         e/qjJNpfm4PDGGJ5TONrH0onWuGtVwH3EX5iU4oCQxIZlhc4cy+oRlC2wKKtj//WO/iy
         7e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2pB3Sy1nsN8br99qlgkRZ1OXNL0JnrGQxDKXfgA9KK0=;
        b=ARCkVcPH+YGpd1vMMLgVHhu682IVpTEo4/QcFbliajtPKS/Ca/T9B0/ti7Rad2KVor
         IWwl0N4M99I+zSoqxQ2JF8Jdf4xvQvvhNiZjTXSwotP5zLZLDP73fPILw8v7HVN5nzC+
         pZtbsf8E/LI24xTaSDpjRtsKgLlaoDgjCGaxdxql79edeMvLNj2AiG71oON69TZLScpa
         p0ggH0VLwJJ1b00K4a7pAbiihZ4ACs1EamWi6fWl1PaxwrHp1+ZjIKUemyo64DI3uUOD
         lHMpZQwqVbiW0qvKn56t2Nx0d4I1lNrPFzqAc8JlHou/xHoXlNHDZhq1C/AiP7DuKorO
         LXKw==
X-Gm-Message-State: AJcUukeMMZtOXR1k8Q5qZgIK3EG9WwpzkWfr/vVuiJi4xiNjmdscRrYX
        aP24DY38Gm7kzkNDysJJWsaFEQ==
X-Google-Smtp-Source: ALg8bN6SDO82K2p6rgeJ5pBDM9X331XM5qOuvQZti+ymKzNdyTUr9pejlDuvcMKPFhgWQnazDARAUQ==
X-Received: by 2002:a63:5723:: with SMTP id l35mr13059633pgb.228.1547733259352;
        Thu, 17 Jan 2019 05:54:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm2438883pfn.94.2019.01.17.05.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:54:18 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <362738449bd3f83d18cb1056acc9b875@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf948a5c-a05f-82c8-2ce9-937dec069567@kernel.dk>
Date:   Thu, 17 Jan 2019 06:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <362738449bd3f83d18cb1056acc9b875@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 5:02 AM, Roman Penyaev wrote:
> Hi Jens,
> 
> On 2019-01-16 18:49, Jens Axboe wrote:
> 
> [...]
> 
>> +static void *io_mem_alloc(size_t size)
>> +{
>> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP 
>> |
>> +				__GFP_NORETRY;
>> +
>> +	return (void *) __get_free_pages(gfp_flags, get_order(size));
> 
> Since these pages are shared between kernel and userspace, do we need
> to care about d-cache aliasing on armv6 (or other "strange" archs
> which I've never seen) with vivt or vipt cpu caches?
> 
> E.g. vmalloc_user() targets this problem by aligning kernel address
> on SHMLBA, so no flush_dcache_page() is required.

I'm honestly not sure, it'd be trivial enough to stick a
flush_dcache_page() into the few areas we'd need it. The rings are
already page (SHMLBA) aligned.

-- 
Jens Axboe

