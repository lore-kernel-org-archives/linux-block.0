Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22698C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 07:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347052AbiCKHWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiCKHWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 02:22:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6671B45E9
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 23:21:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y22so9840996eds.2
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xxhp4yvv1NYzlCG2nbenZ7fmxUPYEax/VW2j48oKhC4=;
        b=8IjNkbIJLzJBdeigItXIpSw3vBzZtd1ZOkzljugpGxEwuMHdpd+Ysy74U1aLyQdI3g
         7V1EapqpfmpyCpIgl+sfQMq3bBTcD86xlQhm0EGCMQQxGyBf0jgxAfDXOPJFb55nhkAF
         3spxDGmpmA9jY7tO6S0kS/jqHm9jM5rYQ3S02jqYrGNCvsdVdFQRbirUAj5TZ8/VYYQu
         4d6UvMBV5FDT06hc++VoJu83Fsp4XvVjNoHwXz4ZgBSloVVL1rp2UGKq7IcnOC1A/WDi
         hhdJSBH23df2NN4kN8Bgcq1FwTGGM7ALBTFQ0uMxUr4rAsAhLk/sofBbm2lOSZWo6/DM
         Yk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xxhp4yvv1NYzlCG2nbenZ7fmxUPYEax/VW2j48oKhC4=;
        b=Ec8oQwASh9t57SEMl9PPDts39KX4dVezW+hTaxdzCaEdexeGJUOf02TzFBpgALsQhT
         bm4K4DXrZyy37m42kdWRQWZSx7HcGLNJ9N4UnECcUosRgDcoxbw29RgidFuIsBfoGUVU
         IViBkDevTfMyxEJI5ehcWXk7dIKDA44er6/wg9nb5f6D8y6E03PEchDgshrSMB8dlR0F
         thFdCK9qEnbKN5/JH6UzPOnCgafBRF7nfdXS+ts53U9TJ96YOK5xnTZVyp7dncRUyg5d
         2YFdip/kJyhPFfZ0Cm5FYhiOFH6Gds/o63Xxj+rt1Q2kFXXSh/t9QbLv2xuRq4IENxhq
         5uvg==
X-Gm-Message-State: AOAM5326nreb2nphWEyBSZJNTlPp4aOTL+nuZtUgODm/2PnRLjzKm+Kk
        rcxVDiTN5PRsfx1Iw+QAWUy0Bw==
X-Google-Smtp-Source: ABdhPJyGfjZPO2Bs08SMjAxkpX+enCVOynhPWP7u3bGPt8Wxuo6KO1AsMGR6G6fZSrxLdaI0G+VNfA==
X-Received: by 2002:a05:6402:5179:b0:415:d7f3:c270 with SMTP id d25-20020a056402517900b00415d7f3c270mr7555835ede.259.1646983263289;
        Thu, 10 Mar 2022 23:21:03 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id c17-20020a05640227d100b00416bbe8ca69sm1432354ede.89.2022.03.10.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:21:02 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:21:01 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08.03.2022 05:42, Damien Le Moal wrote:
>On 3/8/22 00:15, Keith Busch wrote:
>> On Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier González wrote:
>>> As I mentioned in the last reply to to Dave, the main concern for me
>>> at the moment is supporting arbitrary zone sizes in the kernel. If we
>>> can agree on a path towards that, we can definitely commit to focus on
>>> ZoneFS and implement support for it on the different places we
>>> maintain in user-space.
>>
>> FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so it
>> looks like that requirement for zone sizes can be relaxed, too.
>
>As long as:
>1) Userspace does not break (really not sure about that one...)
>2) No performance regression: the overhead of using multiplications &
>divisions for sector to zone conversions must be acceptable for ZNS (it
>will not matter for SMR HDDs)

Good. The emulation patches we sent should cover this.

>All in kernel users of zoned devices will need some patching (zonefs,
>btrfs, f2fs). Some will not work anymore (e.g. f2fs) and others will
>need different constraints (btrfs needs 64K aligned zones). Not all
>zoned devices will be usable anymore, and I am not sure if this
>degradation in the support provided is acceptable.

We will do the work for btrfs (already have a prototype) and for zonefs
(we need to look into it). F2FS will use the emulation layer for now;
only !PO2 devices will pay the price. We will add a knob in the block
layer so that F2FS can force enable the emulation.
