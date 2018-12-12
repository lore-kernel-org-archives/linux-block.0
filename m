Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD91C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF8D2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="voAEuZ3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF8D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeLLQI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:08:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52292 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeLLQI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:08:27 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so9802256itg.2
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTWmfczjfsPlChSBBzlpHyVSwDk1SdZNm5LFwlwhmdE=;
        b=voAEuZ3UqfTC8DcYAVjRYfotXygfeVxlOUvaPR3dMiiymNhI+Oz/DQaIHCiohH1uSn
         pUYezAhZzkjUtNmEIRZ9jLFomZ3Rqi/K47SGHsmrweD6u+wu3BCleZf1q8pL1SBBQnay
         XJHhVKOy6yAfZVNnOq8vliaCRujEskz/t+phtmO8yxfG/6keMpRoqGXWssImtldNJowx
         iJ5oe194pxp+AbeHxkJ+EMAFwh7G9zykdra6m2PHe7FfErfV7AjqL1hSD8AiAwR4ODkj
         /87cXgUs8cCTTKJPYenvZyqKRSjK5ilR0/RGubADC1r733Kpec0nnumy3fHweJYwvh45
         JlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTWmfczjfsPlChSBBzlpHyVSwDk1SdZNm5LFwlwhmdE=;
        b=LRDTcUWao4iMVCvSKgW6pDEnxpYazWNBA5fc8SrnVeE2XHItg74T8MQKut6zDlyAkS
         Shmmq6/nlPrVWIhitFQ7WDX32Vs1OFFwYUstlsQiJHd2+3L0sv47B7IfO3QGmKTPaA9K
         Dvkm5StPJFiTGDXGew5te/hjbp2TX78YQZqnJeXBmgnL6vQqsS2gjiqxFtsMZgkQqPCp
         iD/2q2oO7db9o+hN8A2EmL1IRUYWCcn9id1FMwIxbHg2WxbF1txFVNtm/CW9eCsjxgE4
         vSvtjIW9OLJ93JCCNg1nMntJi5tH74yM8uycij7Nr36eSr/NNZ8NCr9VB0GB21mWruxQ
         ktcA==
X-Gm-Message-State: AA+aEWaO/0/NDOi9G5JOSpiY/3tTXAH3YpNH0KqSqFjUs+eirCm8PZpB
        PcxAmx2aN5+rCsxNC8dD/fAzYWM8kRaf8A==
X-Google-Smtp-Source: AFSGD/VeQEVy72W1aiGzlaWz1CdXBWDdXUxet9v+l1KMGMfC2+pAs+0jsrQ7dlhraUp/4ZGBLofk4A==
X-Received: by 2002:a24:f982:: with SMTP id l124mr6268953ith.59.1544630906481;
        Wed, 12 Dec 2018 08:08:26 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r21sm3153879ita.27.2018.12.12.08.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:08:23 -0800 (PST)
Subject: Re: [PATCH] nvme: provide fallback for discard alloc failure
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <eea978e4-2c63-26d7-dbb6-8023c58675d4@kernel.dk>
Message-ID: <0256153d-6572-ecf0-d690-64dbfe419d32@kernel.dk>
Date:   Wed, 12 Dec 2018 09:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <eea978e4-2c63-26d7-dbb6-8023c58675d4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/18 9:04 AM, Jens Axboe wrote:
> When boxes are run near (or to) OOM, we have a problem with the discard
> page allocation in sd. If we fail allocating the special page, we return
                     ^^

nvme, of course, a bit too much reuse in the patch description.

-- 
Jens Axboe

