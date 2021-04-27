Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D65C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2EA613D1
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhD0PAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:00:47 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37879 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhD0PAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 11:00:47 -0400
Received: by mail-pl1-f171.google.com with SMTP id h20so31019531plr.4
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 08:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=korJ6mazYqQubZmu5kS5Mq2rMpLiEn9FoK20tMRVftA=;
        b=SxQm8MoPM6pF/eiDW6yt+ZaWyuXutbkNBJTTGoBd1iL7CLViaK8fs+MF5OD3hsn35t
         GRV8aMxr12XGNro9roTd1cXbyZSGxuZG8G0e3/dYMdWyNCzXmwkthwKlnSfNKCY8WY1C
         fj72N5apMcZLAil+oL3H/YYNEm+l9SPA/q8TLrPtm1qvSwSvM12KA6eprfGUIhI0Nrsz
         Q+n1HBoFvxb+Ibnuf6obkLfEUzpn0Oh5HLZqSsLE0bj6tefx+mHu8mp0daBkd97ABvV8
         VZkm8bFX1Kk8dq31IdhoBvYOYR8MH0ii+n04SHWpUuSguvT9LdDP3UTI0WWOTtfyzXAj
         O9OA==
X-Gm-Message-State: AOAM533EsGz652uQsjvQbHxYZ++e8uSMTwE0HA0hY7wp1oVHOcI1R/rZ
        MocKc+aHAwqHwZsldZd5b8o=
X-Google-Smtp-Source: ABdhPJwD0VpN/daH0on7r3YSdsR19dzO2lXocU4RfJ1wd/JsBEwjpEKU4luOv8Un0sXeUOc6tagWFw==
X-Received: by 2002:a17:90a:9e9:: with SMTP id 96mr14562100pjo.130.1619535602202;
        Tue, 27 Apr 2021 08:00:02 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b136sm2965211pfb.126.2021.04.27.08.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:00:01 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, yi.zhang@redhat.com
References: <68e4c8f1-1dc6-7dac-289c-5a7595af8d15@acm.org>
 <CGME20210427043022epcas1p47f11139bc1e08925bcbbdca79e5c8e36@epcas1p4.samsung.com>
 <20210427041224.8400-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c5f47617-f06a-d598-1794-118447e8e2b0@acm.org>
Date:   Tue, 27 Apr 2021 07:59:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427041224.8400-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 9:12 PM, Changheun Lee wrote:
> Actually I checked "bio->bi_disk" at first as below. It works well.

Agreed that the bi_disk pointer needs to be checked.

> I think "bi_bdev->bd_disk" checking might be needed too.

bio_max_size() occurs in the hot path. Since if-tests have a runtime
cost I'd like to keep the number of if-tests inside bio_max_size() to a
minimum.

I only found one bd_disk assignment in the kernel tree, namely inside
bdev_alloc(). The two bdev_alloc() calls I found inside the kernel tree
pass a valid disk pointer to bdev_alloc(). So I think it is not
necessary to check the disk pointer inside bio_max_size().

Thanks,

Bart.
