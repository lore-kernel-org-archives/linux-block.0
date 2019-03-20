Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F8C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8723D21841
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rmGhomH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfCTUC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:02:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36522 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:02:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so2575651pgr.3
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KR/bW7s20hDk86v1lv6p/cTxbmRjXzrniGKhpetTnCQ=;
        b=rmGhomH9jTLZQO/v5pyWD/kIUxtM4vg0hgUcxGK1o1bk4NjF0S+FhPPHJafzW3FMZI
         HUsDXACKRgHxwK2uhtSRMVL03rhXQVLez8Rg9g9VYKo7h49SQoGoIgMMd6G9+hw8BGGj
         sUpRNZsJmdvyDhdvdSvohJys7nwaJEWZ6oKAJffAJj/KdZShWhAmXlu+uyR/zKAb03Tw
         jhIi1PbmjYHK+jXApT9U983D0zHPeV0yythlEOz/MFd1w6Tqp5Zso1MC6RvRhZlQl0zd
         s9/iDV5ddSGVAE1w2FhF/Qfc1CABQtahXAPGlru7cv07OCOaQANOj0rENom4d5jzDb+J
         9ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KR/bW7s20hDk86v1lv6p/cTxbmRjXzrniGKhpetTnCQ=;
        b=r+ZWuAfA51lYcKdinS0g2+70uEnCEds7j3ZVi8wRiVs5a0qzH6yDkRvLTD8afMWg39
         k3E8gAC0/JawRE1vompKkgMeJD9dd24Yy5t5ud3JMFIiw9JwZ9gfylZf9lU9K3hsuNXb
         zX0haERFsfux8ns/s21q16aFXRxiAZCDlxCvYQzuTRpY+PR4EPjtAIdQa4kbXXAAtoZA
         CcGfW/BbRxGAiIXfOcVzIfL3U6ZfEqolgIUgskGw5vrgQv9B82f/v/23uSuWFKfC63yU
         ET2bjOVUPt8iFfwrpS3Um6gIIWHi94CNHg7iJG9R9BJdq+q6wjmeSfmxpxkyaAFAG1Wo
         ufeA==
X-Gm-Message-State: APjAAAXMBYNOvw/y5KsED31ERCticlrkQhw31oAbG/lz+6OiC2AE3n1O
        B46LBNOj+kfYwYmyLG3AQKExOyAOFDc=
X-Google-Smtp-Source: APXvYqw97ZpkAQSu00RyAgMVS/GQPEK80yfK67t4nH5iVlEr3ZPeTxzat2aiKfnU25hPJ8cv/MKlVQ==
X-Received: by 2002:a17:902:2b8b:: with SMTP id l11mr10032830plb.18.1553112148470;
        Wed, 20 Mar 2019 13:02:28 -0700 (PDT)
Received: from [10.155.59.239] (96-86-215-89-static.hfc.comcastbusiness.net. [96.86.215.89])
        by smtp.gmail.com with ESMTPSA id j9sm5119344pfc.67.2019.03.20.13.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:02:26 -0700 (PDT)
Subject: Re: [PATCH v4] block: add BLK_MQ_POLL_CLASSIC for hybrid poll and
 return EINVAL for unexpected value
To:     Yufen Yu <yuyufen@huawei.com>, Damien.LeMoal@wdc.com
Cc:     linux-block@vger.kernel.org
References: <20190318144441.133569-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8524a688-9b2d-a8a3-bf90-43482c29b535@kernel.dk>
Date:   Wed, 20 Mar 2019 14:02:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318144441.133569-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/19 8:44 AM, Yufen Yu wrote:
> For q->poll_nsec == -1, means doing classic poll, not hybrid poll.
> We introduce a new flag BLK_MQ_POLL_CLASSIC to replace -1, which
> may make code much easier to read.
> 
> Additionally, since val is an int obtained with kstrtoint(), val can be
> a negative value other than -1, so return -EINVAL for that case.

Applied, thanks.

-- 
Jens Axboe

