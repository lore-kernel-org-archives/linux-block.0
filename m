Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AEBC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2748F2084B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RCXefB5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDBOUW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:20:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35790 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOUW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 10:20:22 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so5535815itc.0
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2019 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Tp8KZUxNEJXRRBYQYe769aEySsaQ/J5CCb9l6tyWbhI=;
        b=RCXefB5vA0MUOuanzOLksCWmfQqTokeqQXwjUgx2zVkMYQd2Srv2aVhqGs3ogeJl5D
         S14iRtlM6Xja/ogd0OSmbqqiPiJETNSSDA9KCcyV6/6ZCD6rJRtNE5QO8x+3JROd5PS7
         3+nsdW3V2dQEBgLgwed9pW/o8O7cbcYsM++d3Ia5OO4rw07ORFiQ7E46gYpqLBs69HXI
         nJ2bSVdbOHlO5T6fq3E1jrVAteCZpjKKXjK3tTnARDSyOlfaINbzsWLb/q1tJVB9JkUn
         8zLNDNwH/IU651Hf7YYdMlOql03mvLFPh1Ayh/HATQDmv7i3i+X1ylQBj95tnHOr0+iI
         tL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tp8KZUxNEJXRRBYQYe769aEySsaQ/J5CCb9l6tyWbhI=;
        b=atFcgGxClXstiR9+waDWI1xSM8my8frDPUQL28E/i80eNq+SpKNzuVE8dYhKPjUuaI
         1FzqFMimsd0rNpf3f5hDo7IHsrBQQc2Aip8NNMMl6Mxg/dhUAep6HVOSPoyqU9Hx3Csv
         o3zsYUN8XGgq98w+SoJ9E1DnrcpLDSlZ3ic1CO0RM0RGVYpLjZH3L4QXLJFiEw5pAJSv
         4cTx9hN9bWfgMEZgCt8fD/Q14X7scHwlqPhCM5WhI+AVRgC1Su8yr5Mq6ijPpYwpGHpi
         RtjNciMHox0dxjdWcR5w4UFBB02blkPfavmwGAPdZxgBDTZea/xCMcDk/eggkGlKcrS/
         +apQ==
X-Gm-Message-State: APjAAAXfuaRJmCtznUZ1xCBm+3cuqEW5UBA21e7EjYMHs3/UtT7nMwhw
        eOcKHnOjqTiMSiHASY0PcJZr3s5W7K3xIQ==
X-Google-Smtp-Source: APXvYqxFQBlNtDpujFvaHTnru7S4gR8SZBrJ/yx3gSSDdbSKQbekUZaNy6fCGaKD6i+ihoGaB4NFqw==
X-Received: by 2002:a24:7350:: with SMTP id y77mr4275471itb.52.1554214821007;
        Tue, 02 Apr 2019 07:20:21 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f14sm5523920ion.46.2019.04.02.07.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:20:19 -0700 (PDT)
Subject: Re: [PATCH] block: use blk_free_flush_queue() to free hctx->fq in
 blk_mq_init_hctx
To:     Shenghui Wang <shhuiw@foxmail.com>, linux-block@vger.kernel.org
References: <20190401134036.8377-1-shhuiw@foxmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b13e24d4-cc99-c973-9401-9944ba04b596@kernel.dk>
Date:   Tue, 2 Apr 2019 08:20:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401134036.8377-1-shhuiw@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/1/19 7:40 AM, Shenghui Wang wrote:
> kfree() can leak the hctx->fq->flush_rq field.

Applied, thanks.

-- 
Jens Axboe

