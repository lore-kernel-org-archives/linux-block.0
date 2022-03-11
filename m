Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C0C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 07:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbiCKHyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbiCKHyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 02:54:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03913CA77
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 23:53:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4842226wmb.3
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xwb70iZvFY3Ug69wBXrwkmTUB5j/QKwDZ/9LSmzVgoE=;
        b=hlivmh7hpdycrkE58yN/AKpN3BjGkgS14lhr/ZALDbCf3CHYm+LsaCW4TsOKhVU9fH
         HoSoWoXsaTDi34bCZVHib4WZ8R5tDpCTgd/milsDKvmXI11ndzsnzTKVfXEUaqmI0iOV
         sMabHJkfpBrKPDNakDSoMOsY5JLdb9UMv2YWR4usVTNOlUk+HW8P8ZvjyZpCFDm880Ew
         1qAjaWym74AqgyniqM1Dv1uQQaNUrCJTZ4pdnVwUduNlFz66yDr6vWOMfP9CQdw7HRSI
         lgD64tVAsh7i2ssmgUEKU8ymxxWcpUQsO/5MJM60ezc08cBzHNLPXdoICP+aKwuSxa4G
         AoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xwb70iZvFY3Ug69wBXrwkmTUB5j/QKwDZ/9LSmzVgoE=;
        b=SugA3/PorZGuuluIiof3/iXYCRYd3UGOR2KL16qkvfDGA7wBl7ynLqSk4GJ0if5tUD
         MKyXH8GvJODaQH8Ej8QqpTlVnjvWiEDRXFBd4K1vznnqgII1fwiHFwiwF8EWkotWSH6o
         vzaZL7uwuYwR6843ry+9exXiTV6tMQwirigo3NXY0bPUHIDHcMIr3CfRP1QoxBYV8yZa
         1X+oWYC1yZOLq0y4bOXKYwzZXuzgaEUKg5QC120BszFh6lCg5Vv1XL0rMLh8ux3ZpSia
         TUWKqIqfdv9geiiQ8AlcG+15Hu75LZUx5Hi6IL9h6lnkKIgW32v/NeFvnbWDqwpncPhS
         tGBg==
X-Gm-Message-State: AOAM532jy+z23L2VydzlFOyHuQDJppKxIZkw6RrKzhuzSFV5FUNNgPs4
        o85CInHRuQceMytjraJsQx/4wA==
X-Google-Smtp-Source: ABdhPJy/MRgCRkxNvQp+v2QGs4GsetEVTW4/ulUZAQQ1nVD5qskJ9yUZmwvUd1FbdLzu4s1hs1KL/g==
X-Received: by 2002:a05:600c:3c8b:b0:37f:1546:40c9 with SMTP id bg11-20020a05600c3c8b00b0037f154640c9mr6350055wmb.161.1646985199202;
        Thu, 10 Mar 2022 23:53:19 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000178a00b0020393321552sm1892851wrg.85.2022.03.10.23.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:53:18 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:53:17 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Yir9a8HusXWApk5l@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.03.2022 23:42, Christoph Hellwig wrote:
>On Fri, Mar 11, 2022 at 04:39:12PM +0900, Damien Le Moal wrote:
>> > (we need to look into it). F2FS will use the emulation layer for now;
>> > only !PO2 devices will pay the price. We will add a knob in the block
>> > layer so that F2FS can force enable the emulation.
>>
>> No. The FS has no business changing the device.

Ok. Then it can be something the user can set.

>
>And nvme will not support any kind of emulation if that wasn't clear.

How do you propose we meed the request from Damien to support _all_
existing users if we remove the PO2 constraint from the block layer?

The emulation is not the goal, but it seems to be a requirement

