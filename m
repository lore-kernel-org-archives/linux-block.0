Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AF3C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 02:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiCJCQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiCJCQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 21:16:26 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F610CF3D
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 18:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646878525; x=1678414525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RtHJfTTdURuzi492J61thdvSlR4rCdwHNLw51oObB+g=;
  b=DVuSW2maW/wYyCmN7EhwRzScwe5DRIAG0Tcshslm7ISqxgixtt/96dxN
   9Ufd6p+LXI5oEvB4pDZaaeXyWDIqAQ47ArkTyOxAYYqZ8vr6aPDiinpa9
   WYKpU3rxdI5tfnhYlzC8GllHgEEPzP+Vn9SC9gYQxksdlXmh8Q1Zo/dHP
   Ta5XJveF/NfYbR5kI9fxAdpCXjKnNnoTy+fZOgbICnkbv/65lTABY2Zh3
   cHk0U8rO0KnGFA5Vu4YqyjzjDCrQzrgi1EQP3mxJNiw5PKn+OxI62D+bN
   Eysf4oWri/mP21TEhmNN64zO6QfdciCf0JZPCy6SD0Snn7AZ2YL5lzRRH
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643644800"; 
   d="scan'208";a="193836311"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 10:15:25 +0800
IronPort-SDR: UWvW+XUI5p2rPTHuLrH08w8eZzLRViEeOmebTcz+GKfT/nCBlhIcGJjiCKSLbmI2y8XHhpEchw
 Xj9vFP4twM85eh+VISxLT3xc4Wk+wSk1j8INZnWY4YIkiJnEjGt7S+yWGOv1MksKZ+hKxxnJcA
 CwHopX7hkqhUtsuJsiLcQEGW9agP9V7v4bRXKBlImfGhfVDzWgIL7ZirIaATXLafwRvoKHJD8l
 tQn4p5hASdPVkwklMr5qxzihvFZqPowkGImkuoznKzUNc5upDpjrCyJ2NRhBVhGiL7ce2V1IRd
 mBlIOg6An5RTG1Mp5j5u5Z53
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:46:39 -0800
IronPort-SDR: D3y0yDasCEpQXgwftChRierHNRPxI7Ladp24wtglYEZY2bU/omYG7WXLqLoNS0VXqh1TKJ6QYy
 JxHCwicX1tYcUEfeAFUVWz8l8uyzJ3TAbY4RvUemjt5pLuoSVCg0ZOX+KjCF/p2Ujyw27PVugO
 IoFH6nzx34Vo5qxQoJERNm09BOqL5BVG6GB2VEZsZuvK9UwzkkBmTLIp1Gr9aldYDtrE0OAscG
 9z0ahQpKCwQdAhyFShT0NtNoIpr/ufwMgvMSgHE8L19N+zOcczDTQGieE2wT/fAUlErJJtViaf
 zZk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 18:15:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KDXhs0RYyz1SVp1
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 18:15:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646878524; x=1649470525; bh=RtHJfTTdURuzi492J61thdvSlR4rCdwHNLw
        51oObB+g=; b=ZX//HLljkBm90+/VPUcHJy62LpLB/gQNv/XCW3SY1M14cU8KPf3
        FTNCI+mofgSJdGbDCTBe+HuElgU/oVN2Af90Q4+0E28rUpL/cVLcFeSoabttKKbQ
        lvfseJG3ofL5C6JzNiyh4yXCzAb/n/mqCrSg0fBEWKZOcZa/iqxyBdf4+Rba/RZ4
        HCUBjUYDt0S+JP8c6zXlbxhQdzccT1xnIqFRhRFJxWk+pIf/eujmXtcjKuRryYh1
        LSpQK2GzwCz1WzAjzU9wfrHLT2GICciRC/xl8aMLT4P+tVhltWJ08rBhSI9A3Tfz
        /LVO98xPmQ/CO/2ZcbBfYkiHv/Cx4PIWLZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cby1HjxVwlgg for <linux-block@vger.kernel.org>;
        Wed,  9 Mar 2022 18:15:24 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KDXhq5Q4Bz1Rvlx;
        Wed,  9 Mar 2022 18:15:23 -0800 (PST)
Message-ID: <26978007-81ef-2249-c6fb-593be5aed907@opensource.wdc.com>
Date:   Thu, 10 Mar 2022 11:15:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220309220222.20931-1-kch@nvidia.com>
 <20220309220222.20931-2-kch@nvidia.com>
 <1dd210d4-a3d7-30d4-341a-d7b308679008@opensource.wdc.com>
 <78d45c05-2e9d-47e8-89db-331553acd433@nvidia.com>
 <bcf0efa6-6fa0-5e81-64f4-b78a07e4dd65@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bcf0efa6-6fa0-5e81-64f4-b78a07e4dd65@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/22 11:02, Chaitanya Kulkarni wrote:
> On 3/9/22 17:57, Chaitanya Kulkarni wrote:
>> On 3/9/22 15:38, Damien Le Moal wrote:
>>> On 3/10/22 07:02, Chaitanya Kulkarni wrote:
>>
>> [..]
>>
>>>> @@ -2044,7 +2044,7 @@ static int null_add_dev(struct nullb_device *d=
ev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_queue_flag_clear(QUEUE_FLAG_ADD_R=
ANDOM, nullb->q);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&lock);
>>>> -=C2=A0=C2=A0=C2=A0 nullb->index =3D ida_simple_get(&nullb_indexes, =
0, 0, GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0 nullb->index =3D ida_alloc(&nullb_indexes, GFP_K=
ERNEL);
>>>
>>> Do we need error check here ? Not entirely sure if ida_free() tolerat=
es
>>> being passed a failed ida_alloc() nullb_indexes... A quick look at
>>> ida_free() does not show anything obvious, so it may be worth checkin=
g
>>> in detail.
>>>
>>
>> Good point, but original code doesn't have error checking, this patch
>> eventually ends up calling same function what original code was doing.
>>
>> Since this is just a replacement patch should we add a 2nd patch on th=
e
>> top of this for error handling ? or you prefer to have it in the same
>> one ?
>>
>> -ck
>>
>=20
> Also nullb->index is defined as unsigned int [1] so in order to add
> error handling we need to change the type of variable, so I think it
> makes to make it a separate patch than removing deprecated API, lmk.

One patch to add the missing error check and change the index type, with
cc stable for backport, and a second patch to switch to the new api on
top of the fix, without cc stable. No ?

>=20
> -ck
>=20
> [1]
> 109 struct nullb {
> 110         struct nullb_device *dev;
> 111         struct list_head list;
> *112         unsigned int index;*
> 113         struct request_queue *q;
> 114         struct gendisk *disk;
> 115         struct blk_mq_tag_set *tag_set;
> 116         struct blk_mq_tag_set __tag_set;
> 117         unsigned int queue_depth;
> 118         atomic_long_t cur_bytes;
> 119         struct hrtimer bw_timer;
> 120         unsigned long cache_flush_pos;
> 121         spinlock_t lock;
> 122
> 123         struct nullb_queue *queues;
> 124         unsigned int nr_queues;
> 125         char disk_name[DISK_NAME_LEN];
> 126 };
> 127
> 128 blk_status_t null_handle_discard(struct nullb_device *dev, sector_t=
=20
> sector,
> 129                                  sector_t nr_sectors);
>=20
>=20
>=20


--=20
Damien Le Moal
Western Digital Research
