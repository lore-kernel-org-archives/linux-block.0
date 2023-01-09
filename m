Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A80C5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjAIXc2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjAIXc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:32:27 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC2DEFF
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673307146; x=1704843146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vA+kJo9mcJSrJYNA7MLo5GyUZM6NH7xAAwytRE5TsWs=;
  b=l1qI6I+Homs8T9AbWVPOEu63jSNrQjr5dVDdlCHa5oLVeJB3h44HQlbD
   YCFNbPH4ZGx1QMAFiMAXH/V48v2FcTzUcxf/mIujmEAiEuCk5RNbJUyys
   GAXwGEy+WhsVq4PhHxsmekfeRscSVnvzoqq9mx7Kt+q9QRzQumf3CH3dr
   JwM4KqvyqEStjdnboald+vkDhHtX9qL7RaJRjwEtEItbk6Fl9s74MFhOs
   dy7wQJM+LH3cR6uZrTzdzD1HC4PXnHGNXkO9B0Nhdlf4LHjfP0fzOlVes
   92edFjtuUj0fbfuELaolQ8PCvOt+r2L+Sxs9ZbCqZZMAxA0GE9ZIwZhEf
   A==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="225442521"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:32:25 +0800
IronPort-SDR: 5zD8+ozdbn/RIjSWJldnVreKe+YVh327qFud9eLocXWGYeh50m/XtjbQHVTIPAmFbiwDPGYDF1
 6QA0sJK4bO4TpP42H9E9d9XMXbpkKm/5YCu1nVepI6KQREMsEv3NYJj8dLG8zm2dA+ZNT87WrG
 YjEW03XO72lsGfNjo0xlWNEyr9NVVceL0KHkhf7gw0LYuUz4iaiQ/P1ASd5wvHVFIVP6H5wz6K
 s1rbzkWB9cduJ+BYNMast6ZpMpmvjmR3pKuvvB6wMw4sdA7lUF5oZiWl9HYOa99vDU3csoOTDx
 qY4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:50:16 -0800
IronPort-SDR: 43Bvzk9GiV3Gm3LdfaMWMp0hgEd4xjoUX55oAZ70+8UAo+BxGFrSfSm3DqXA761o1MzVLFsABe
 yd8q1ISpMMBjfZw+NOuQcPaMy7qvbnEDJrNnpWPEW5I10Y3EdIzEiYqbG0HPfVAdFiw3Ygispb
 AkePKwwA3e/0C6qLlPeJ1dq3RH/ZBSTlbp28Om0M+JyNGG5yO7GeUUCn0q/EWrqOXLef2ZmQX1
 WSyNd6i8dynuwQoqA2JWZp1PdcjHXyT8yiAtLg14aENi/ozDSLL6/InmLKmnYeeClkVWVpe521
 ZOE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:32:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrVbY2rpgz1Rwtl
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:32:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673307144; x=1675899145; bh=vA+kJo9mcJSrJYNA7MLo5GyUZM6NH7xAAwy
        tRE5TsWs=; b=AejY6Icqa8AwqZc/pZT8fGX2FtL+GL78uZpF+iz3G0SCFA0fMVA
        aX7/16nS5iOqL6flVyBcXCG2V5Kx6NHV0QqR/MBLFlN/cnoYd9yZKVBctmrKNXbu
        YrqeCdZc6NTxHDOJ23VMK8IRJ3hYdfh+yW9g1EQiV1Qk/Ne7PIy7Su1CLLwV3E5M
        9CIz+UK/kUQJkEIcFvnp3Mn5gP0mfU8QxE4S5HVkKfWt5LO/zKyQBklXAikrIIln
        TMQDKLh+bkD9TwoBvLZDNmpKBzBINQFrFkvnqSCHWnyxko0HTN52du1bD/WK2eT3
        IbOpJ6tEi1D6yoLuOE08WR1UKt9HwZR44+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 56xtX4Dupx8u for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 15:32:24 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrVbV5NJpz1RvLy;
        Mon,  9 Jan 2023 15:32:22 -0800 (PST)
Message-ID: <81962ced-f62a-7716-49b7-c6735ebc13d3@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:32:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
 <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
 <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 08:20, Viacheslav A.Dubeyko wrote:
> 
> 
>> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>>> My point here that we could summarize:
>>>> (1) what features already implemented and supported,
>>>> (2) what features are under implementation and what is progress,
>>>> (3) what features need to be implemented yet.
>>>>
>>>> Have we implemented everything already? :)
>>>
>>> Standards are full of features that are not useful in a general purpose
>>> system. So we likely never will implement everything. We never did for
>>> SCSI and ATA and never will either.
>> Indeed, and that's a very important point. Some people read specs and
>> find things that aren't in the Linux driver (any spec, not a specific
>> one), and think they need to be added. No. We only add them if they make
>> sense, both in terms of use cases, but also as long as they can get
>> implemented cleanly. Parts of basically any spec is garbage and don't
>> necessarily fit within the given subsystem either.
>>
>> The above would make me worried about patches coming from anyone with
>> that mindset.
>>
> 
> OK. We already have discussion about garbage in spec. :)
> So, what would we like finally implement and what never makes sense to do?
> Should we identify really important stuff for implementation?

If users need and request something that is not currently supported, we
can discuss implementing it. Until such user-driven request is raised, I
personally do not see any point in discussing anything.

> 
> Thanks,
> Slava.
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

