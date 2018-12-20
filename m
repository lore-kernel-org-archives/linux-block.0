Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02CBC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5E32186A
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v91F5Oks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbeLTRiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:38:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50958 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbeLTRiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 12:38:09 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so3196798iti.0
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJbjPaTRDz2ATyIeQcfwTFt+GaPBYJxP9I720dJkZA0=;
        b=v91F5OksszPj/0iCvTNIc/kiL8TWJXmEh8LB5j9ifE7i71p4dD9yfHbSshBztPRSns
         j+F2kQcbSL6N/Um5TL9G4ZF7q5yMdEQ+or5HW7SkizxTOkB9dMeSHIbuHExKlQIa7pj+
         UYFZaeC/ZyKfiorL42q4kVtlgEnu3GPv63HCyBrt/3nqeNQp7tc9VMUhdTLlmnaWuwht
         Xcg3a0BLQ+tjMeMRgYQ4d277IJgrNXtf0K7NDFMO5m61iJIHsFEkMw7hT06YL5Za2Kch
         80ZGo/mM2K1Gh9QOFk5wuAVz3SwPkDX2c7URniA7S8FQGL2MUqs/rZ1xdK4xAenwJzVt
         GK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJbjPaTRDz2ATyIeQcfwTFt+GaPBYJxP9I720dJkZA0=;
        b=f/CKUi44CNu09iYng0zoN+wRbuY/UvSLIAj7SNjDvMDyy9MVWdGlUV4cVLbjaKc03g
         6QOBoK/+yqSKACQcc8bNT5SV7xhSJ/tQ8AmnzbjGw6KWarghPTLoeway/iM/n/ggvYak
         Bhbyn7Kn/UaSU31FLMhqjbG3EFe8paD1Mnh/RfJFn45ZiqGby4dHQRtXUyKJ6y8kJ50z
         wB4fH+FkNlzpSs7DTvZutEZH4upOQy6bFdB+CmbdPkTQnzKsodRlLsfNyYszDhK7ga0E
         AbzwvIdkEWV8BTI7Oq9qa93eJoEWaI58Aza1cInWd1nksLfQuunBAfD+B30YgoJhdvg0
         fc6A==
X-Gm-Message-State: AA+aEWav6dYFQtfI5BoJ8N+jQlpeyC8gdNkwCzr8Hf87hWzAih7nm31V
        WlloCNw4NUlxXoXEVJ1znEAShQ==
X-Google-Smtp-Source: AFSGD/VRiQGW6UF51Q9Vuyu9uRjUQfx2f2NvYhVCDANUtHZd5jrUA75P/Gkv2+kD7xR2JtFPvbFPTA==
X-Received: by 2002:a24:cfc4:: with SMTP id y187mr10275277itf.144.1545327488807;
        Thu, 20 Dec 2018 09:38:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y23sm7223666ita.1.2018.12.20.09.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:38:08 -0800 (PST)
Subject: Re: [PATCH v2] bsg: deprecate BIDI support in bsg
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20181220173620.29120-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c991ddba-a171-16b5-4221-b21146c75196@kernel.dk>
Date:   Thu, 20 Dec 2018 10:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220173620.29120-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 10:36 AM, Christoph Hellwig wrote:
> Besides the OSD command set that never got traction, the only SCSI
> command using bidirectional buffers is XDWRITEREAD in the 10 and 32 byte
> variants, which is extremely esoteric and has been removed from the spec
> again as of SBC4r15.  It probably doesn't make sense to keep the support
> code around just for that, so start deprecating the support.

Applied, thanks.

-- 
Jens Axboe

