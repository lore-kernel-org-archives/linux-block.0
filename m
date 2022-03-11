Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04367C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 08:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbiCKJAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243730AbiCKJAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 04:00:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73341BB722
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 00:59:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r13so17651064ejd.5
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G64fpheblSLP81xsfCcTMm/w43U6C4+OfpzMU4aumxM=;
        b=bcJcncRtBIs509i0VHLbfp7JvFTQqdmuWL67LnKnpkjYBZX6w8sBnx2452CLVTnMXo
         IKUWhehLe84pMDIQidNxt8g8sjHQCDAXb4fBVrB2Zdq9cqh9vN8TOHHhKZrBGJuEVI0Z
         Q54eH18VG7lb+hTmvW+zPVfTf4t3itb9zRMqS+yIRAQO7T4Q+Xnwu+9CF0Vl6inAWUMd
         FSY3aLV0Si8EWz5e3aPw5EbmiDM9MJr2qsvthGpCLxdPRWaRlvsNbNYiKTMdSfUrdnt5
         V/WC7ZXsvCiEG89fGqU15ZF7TF5iGTMqPaBHlKZrdn+yDeH/hE/Ve2DtRO8lApJJSfmc
         U/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G64fpheblSLP81xsfCcTMm/w43U6C4+OfpzMU4aumxM=;
        b=SWKfAtv15RR0NDk6tZ3a2nUs+xFK7OM7latZ/V4Qux4Ke0OVSo0dL8LDV4QqaQjGMo
         3iaXSvjcAle3rIYH+R5dzFE5CHnEl+maP4urlbhCEeWsHNZBKs9A3udfltzYDOxR/Jox
         4RWxXoCRkvtPRtb3ZugCe95eSe3MJNuYfJNOCX3OOfE3sJHElquAbF5aclSEHbq/MC+O
         HB54b6r+glpKaAQFOUiXQOGzjVvE2O5WtlWyjvGFNgMgCzkRwQT88/ZJQIDOLxfioPSw
         Wzs9LdVevRJzlkwPfZRlkyBIbgdbgjZL8R4HY2GEkLjAqX9MyKlaQD4i3IUvo3z9XRdh
         r9rw==
X-Gm-Message-State: AOAM5300rPq/KbgsfeovCtof+rcapm9eV2Drd9nTM9JSur4pMzEbxV3H
        Aq7hrlfOt1AjenNUsNr48ipeYA==
X-Google-Smtp-Source: ABdhPJyac4jXH7dT28BK3Z9Zkjxoc1MPNtVDYQV0VUf2kAKjcdr/4vp+AKTfrAUKQoO8NWSrVr47Og==
X-Received: by 2002:a17:907:3d86:b0:6db:9d9e:e470 with SMTP id he6-20020a1709073d8600b006db9d9ee470mr2767730ejc.373.1646989167197;
        Fri, 11 Mar 2022 00:59:27 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090649cc00b006d0bee77b9asm2724958ejv.72.2022.03.11.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:59:26 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:59:25 +0100
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
Message-ID: <20220311085925.c66kly5zy6otgcer@ArmHalley.local>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
 <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
 <YisMUruNKNlV8FhW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YisMUruNKNlV8FhW@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.03.2022 00:46, Christoph Hellwig wrote:
>On Fri, Mar 11, 2022 at 08:53:17AM +0100, Javier González wrote:
>> How do you propose we meed the request from Damien to support _all_
>> existing users if we remove the PO2 constraint from the block layer?
>
>By actually making the users support it.  Not by adding crap to
>block drivers to pretend that they are exposing something totally
>different than what they actually are.

Ok. Is it reasonable for you that we start removing the PO2 check in the
block layer and then add btrfs support? This will mean that some
applications that assume PO2 will not work.

	Damien: Are you OK with this?

We can then work on other parts as needed (e.g., ZoneFS)
