Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10DEC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F448206FB
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ovy9ByqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKKJVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKKJVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 04:21:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC7C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 01:21:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t11so1489848edj.13
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 01:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Q5zxvMuV3Azks8Ot8yG9MlzIKDLAnbtKky+Zy7lFTo=;
        b=ovy9ByqAVRH79WjGKXbFwo7C6JmauMHkytViMDqh3ab1Wy4iGWqtglsJiodVPA4AVa
         gW26kDW53ZFkJwHEk/WPSLrLbNNcH7ps8hKSVmiwKGExvECfD5mzdKLAYhoyu8giouDR
         xphGtC20qdUl+B3MLakLRdgEXbCWeKBJ2so9DsxkEZZqnuZC2pgARfXWC/EL5zj21HBe
         f8dXlLp3xiaxqnnW14TvuFAsq0NAlyCPQPCYizFtCvIxNx/IRCb4hiDg/6nNEoTCvPZl
         0o3uqd1/dpP5sVKJYX7JTC4dIsDAh4rSO3I3RnMSjbvh4vr0L57Xehis3Ld1V9MmkFbw
         5hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Q5zxvMuV3Azks8Ot8yG9MlzIKDLAnbtKky+Zy7lFTo=;
        b=DDhRqc2R4Er/t61bkHy/O0fBWFA4F/aEHPDbw6nqQouNPeIULZhYLfFLD33DwbjvgQ
         /2iP0ni69dLvZioeGxARB/g+EhIoMrAijl2DT47jNT8cqDtfSsd+UbfiNchLEFEE5vxi
         iZ6yVgsQ5o9LEvoiW/z7Qb1aW59a4fDydPTaXO7IOkNO7sp1th6tyHCBCdZpn0cV4+8R
         jw1REJey2rt1KdBgDbaMpCGvYmzJDsDZGjUz6VJD9DaOjXV/KsPncK1MNZEWdOTlqxTU
         KG5Km+keDkfU0FfG45TStQ2x69sPygAqaHcI0NGtoqlTitvcp4jXWf7fueGiEKNBNa9u
         mm6A==
X-Gm-Message-State: AOAM533HpOlw+jcbqOB0rfsmPK/DvGMVwLFGlAjOf9+AoRH8ffRkWLix
        050P881Z2vkvqyjZv5syococHg==
X-Google-Smtp-Source: ABdhPJzGmXFCrl6cG26vGGLly392mTClcMtd5NDXKHm4xd+EVZxauYh7lT+zZkeS0/qnoJe3H2Z/Ug==
X-Received: by 2002:a50:d885:: with SMTP id p5mr3783825edj.169.1605086488511;
        Wed, 11 Nov 2020 01:21:28 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id f18sm634293edt.32.2020.11.11.01.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:21:27 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:21:27 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, joshi.k@samsung.com, k.jensen@samsung.com,
        Niklas.Cassel@wdc.com
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201111092127.hue2hhdugkxy33ff@MacBook-Pro.localdomain>
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
 <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
 <20201111081530.GB23062@lst.de>
 <e8f50827-4bc9-7300-0f8b-ed0a854fb50b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <e8f50827-4bc9-7300-0f8b-ed0a854fb50b@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.11.2020 00:36, Sagi Grimberg wrote:
>
>>>>>-	if (id->nsattr & NVME_NS_ATTR_RO)
>>>>>+	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>>>>   		set_disk_ro(disk, true);
>>>>
>>>>If the FORCE_RO flag is set, the disk is set to read-only. If that flag
>>>>is later cleared, nothing clears the disk's read-only setting.
>>>
>>>Yea, that is true also for the non-force case, but before it broke
>>>BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
>>>well I think...
>>
>>Let me prioritize the hard r/o setting.  mkp actually has an older patch
>>that did just that which I'll resurrect.
>
>Sounds good.

Cool. I'll repost fixing the log page update. I can then rebase on the
patches you send for this - or you can put them on top if it is easier.

Thanks!
