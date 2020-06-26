Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93AC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4C1207E8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="i8m5TBik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgFZGNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZGNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:13:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC7C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:13:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so8237723ejc.3
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oq1NZyvf1AcEgId735Moz3QUr8Xo/WfMRFU+37k8nnM=;
        b=i8m5TBikCUx5+vI4Di4KyLXgteUb/teOoPaNWjl/bqmMYr3TZ7gpaFaV5GvB0xdaQh
         NOuOMq+ivg9KIz3VUUUk/JfHs2KxGwlczkRvbpewlbJ0ljGi3XqGJfBHff70fQSrmgdp
         zZ9BrsG/0YRs/7NCroPWPp2yR8b058bmN48fPmrdgXXVrmNqpDcxV4I+8fT+E/FP/1LC
         FXt4MFQ9K1o8OaIJ5ehCQw08TuRSs73PDsN2FrPajHEn56nqNrk36mzMhgWb9wfGbueG
         e/pgQteKNu6bdCao5UExTLSq/raVHg4Ip2SfOCfP6nahUpRfd/9OHOuFmGAFJKBvq2u2
         PYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oq1NZyvf1AcEgId735Moz3QUr8Xo/WfMRFU+37k8nnM=;
        b=RiIlPtjPWxfRRHHMIIJjQFD1Q2TVhpyDH4z3C9qNsJYmirTQNl57ODNZkxz8GrjpNE
         uQ4o4+RTZBrHxgMNApYggSG3/cWrzj2DTf35tSlwlpZ09ueQVAQaCQxwi/x8/szGP36w
         CyDOdhIYMO0QdjfxKXgolOR81ZHSXKxfJfNn7Hz4sRO4m/cwHHvfKZjApKqUZGNzzuF1
         kCVZyVhlTfFdY95/+N3Aabtery7AEhOapJud4Ox+euz+BFv0jaCSnZc+3KMmB7xKoG2K
         fg6bCEnTOs+QTbvse9g+cmJb9FnfThdCJ6a5sFKC/Dn2ogNW9AyfBuLc/WFsSSMvYO1y
         KX6A==
X-Gm-Message-State: AOAM5331b8iqW0es/nModMQNcDu2iJ2Cu2MkXWXJJGlWUqF81kK4i6t1
        6xuobzLwHSiw6XSlC26jx9xQuA==
X-Google-Smtp-Source: ABdhPJxeSI8gZmvwZQpO/0dnlCsm5oDAoXGH5DbHNJEnk/Plmh0jKMoJ4hD4tA1FyFqm/ao5sPXH9Q==
X-Received: by 2002:a17:906:4f13:: with SMTP id t19mr1138066eju.269.1593151992290;
        Thu, 25 Jun 2020 23:13:12 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id s14sm11134214edq.36.2020.06.25.23.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:13:11 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:13:10 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 00:04, Damien Le Moal wrote:
>On 2020/06/26 6:49, Keith Busch wrote:
>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier González wrote:
>>>  drivers/nvme/host/zns.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>> index 7d8381fe7665..de806788a184 100644
>>> --- a/drivers/nvme/host/zns.c
>>> +++ b/drivers/nvme/host/zns.c
>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>>  		sector += ns->zsze * nz;
>>>  	}
>>>
>>> +	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
>>> +				zone_idx, ns->nr_zones);
>>> +		ret = -EINVAL;
>>> +		goto out_free;
>>> +	}
>>> +
>>>  	ret = zone_idx;
>>
>> nr_zones is unsigned, so it's never < 0.
>>
>> The API we're providing doesn't require zone_idx equal the namespace's
>> nr_zones at the end, though. A subset of the total number of zones can
>> be requested here.
>>

I did see nr_zones coming with -1; guess it is my compiler.

>
>Yes, absolutely. zone_idx is not an absolute zone number. It is the index of the
>reported zone descriptor in the current report range requested by the user,
>which is not necessarily for the entire drive (i.e., provided nr zones is less
>than the total number of zones of the disk and/or start sector is > 0). So
>zone_idx indicates the actual number of zones reported, it is not the total

I see. As I can see, when nr_zones comes undefined I believed we could
assume that zone_idx is absolute, but I can be wrong.

Does it make sense to support this check with an additional counter and
a explicit nr_zones initialization when undefined or you
prefer to just remove it as Matias suggested?

Javier
