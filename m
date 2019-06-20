Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7998C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE63620B1F
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jiE9TlsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFTHfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:35:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41844 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTHfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 03:35:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so3231687eds.8
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bkJIVmzRu4B+rkHeWwgRuFzMyUV3Ol5NJZigu87ZRLs=;
        b=jiE9TlsICjMryu0gYuIV5nvTzabSWlx106Eg6NFMdly3pbhjj9a1KAyqXDPPnapqFs
         U7vU/TktAxOS937V7ZSdEtLkmA8S6/9fV7BerGAhK62YjTAvjc3pPbRJni23I8Vh85e2
         5e+THbCY4W43BtGHYTAEMt/CX9VAkgIWHOD3o/bOI45NwRBKAQVabBYjbIGElv+/rCW8
         ZJnI6IP9DfCnjBSx2sQ0U01frh1Q5ScTTszPz6Tkvz1p3U/n0Hq+3oNHV7y0L1ry96ZU
         Bbu08mpCFNbgdo7z0h/IuuR+tmYTjXD2qcj6x9I2LUggM6DB2ZFfzOVNsT6EJn8IfP1Q
         tOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bkJIVmzRu4B+rkHeWwgRuFzMyUV3Ol5NJZigu87ZRLs=;
        b=rEn/LYzj0MzMJA0ICbRSgSfe2k1GEQg5D83Ye/jjWXdoibNDiUl2i+PDbYWT29auxO
         wG/jgA9tq7PO5OUfv6RNbODTyCjwa10j5BSfQLZKS1iYwg2NevBMaVJu4ctVeVbNthAK
         I9V/pFOAnTU3KIAbASqgItTcJgdU5iGaIj9sKtMDTPCUMwwqx+K1k4A3uIMzZ4JnColH
         nHb9OvQKOv0GhNPk7m1/yQH3JCvirqLoG40dxiz5DJcZLXKEGpRIn9wJHQfpER5Zf2KI
         0JhdVO6//l/hN2EPoC0kH3s3WaYq4DiGV3lEUkJbL5FbaCHWcEQKSL4znmSdkCTkhZr6
         275g==
X-Gm-Message-State: APjAAAVv9zn6wCrrmWKkJTBzTafRk28v5LMO6yoPBASXTQGWhIzvp9jj
        0jmOTe/Kjb1vD2PQFK3fB92frNeoicM4+CfK
X-Google-Smtp-Source: APXvYqz5aXc+yO5M49+Hij+i8IWUlqLlhu2rV6qIsM/+IZqVURftjOXh3ymwVugG0SVchHg3gaRzfQ==
X-Received: by 2002:a50:8a85:: with SMTP id j5mr88372562edj.304.1561016134653;
        Thu, 20 Jun 2019 00:35:34 -0700 (PDT)
Received: from [192.168.0.115] (xd520f259.cust.hiper.dk. [213.32.242.89])
        by smtp.gmail.com with ESMTPSA id c49sm6676324eda.74.2019.06.20.00.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:34 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] block: improve print_req_error
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ec88bfe-2eb2-bf20-39bc-7f25fabe6ebb@kernel.dk>
Date:   Thu, 20 Jun 2019 01:35:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 11:12 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch-series is based on the initial patch posted by
> Christoph Hellwig <hch@lst.de>. While debugging the driver and block
> layer this print message is very meaningful. Also, we centralize the
> REQ_OP_XXX to the string conversion in the blk-core.c so that other
> dependent subsystems can use this helper without having to duplicate
> the code e.g. f2fs, blk-mq-debugfs.c.
> 
> Please consider this for 5.3.

Something is wonky here. For 5.2, I just merged:

commit f9bc64a0f0f884036d76d71edeaafb994c5ceddf (origin/for-5.3/block)
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Thu Jun 13 07:14:21 2019 -0700

    block: use req_op() to maintain consistency

and then you go and do something different for 5.3?

-- 
Jens Axboe

