Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0787BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 23:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379393AbiFPXa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379117AbiFPXaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 19:30:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D16004B
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422254; x=1686958254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI/cVxZcV0=;
  b=gfT/qclWgO8D+x6Mxli2GDuemGduTvZSHYCI8HbRiJgupIljWtXS0mDU
   SPr0d4mFseP2f30s3R56u0zXbD+AW+3u2U54SHK5+krykQuHEtniGddK9
   fXWl3/xyojTN50DhsF02crCrtOxp/xLlVqgIJYB3ynwhfqOsoi9AVSNig
   ptvduHtnZGxKFNWCPeASx55hFotG/WPyVgFh11ltJHnZijB3R2B31wjth
   tTcyyRZOvNU4kCtCTplYb3CtJwLWEmjlEcwZQ8BsiOkU6y7E+z2N7gvZl
   xmDIakaDcan7R60KLeqCXqwxphF25m/+EtY766qid2oiIMuDzDbWLHD0C
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307679376"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:30:52 +0800
IronPort-SDR: iUbgm1DUwLeQ8HUSPN78dHotOWSV5umgj2DaLtaXH/VJTRaD3VruYoGjVtyxKZ4ic7aIXlffYQ
 IRJv7D0WsfIyFbkbReDUcGwLG1kmcVZVGtXxnOXHUolT0PGB0LpJgymqPuNK4ezlvL6ES3FN0Y
 ebLWLyUy4ZXeyjgJCDNRbkVXuDY/oeYvawwYGexMFP5m1ocqeJIT+UH57q4+ID0WoFGR2kOYXY
 KAdAnOl79cf/tRcBJ4UZTc0ra4/YUJxdXkjVpXNt6R7Tj4yxCjT399EBnqUBQ1xhq9MMfUHxYY
 7xUvqKSnTLo74ogX8yXg847j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:49:04 -0700
IronPort-SDR: UvItTewPhd3npF4ikSrV1CFK5QjJdEs/LUHQPG1MHvgdBFxsBG2RCVLm3aC7cfCMTCCKwxqJOq
 xQcVT04IyzbECx4L2D/E7CBsOOUXrpV8DE1zUNjEXYbNN7514ZRh1oRE7Fpz3fsi7Pn+UyDrhM
 tvjnFk7ecmD/MjFue+UUrFIlpVJbw5KKM01w3qx87sMs65W2E7QIqhveWiJwsBe3XlGTsyApkt
 6L8WcIs6xTTHvM0st9Ndgy1hx1qihwII79DQf4BymeL5DFMlVTdtlMpvugvdNbxZByN7Mkz585
 Brc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:30:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJMH6Qlwz1SVp5
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:30:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655422250; x=1658014251; bh=3JUll1cokzNoMWjmBVYm6Y8IVuyZM8XJyZI
        /cVxZcV0=; b=QrmRAjk+25AzX0pmuPjm21UbJvARRDhpRqZ8MwiHGxi+ExbXMdm
        KfWGaMfH86r+rqGZFUK3ugIbHq8FopF/CgqfnQjd0OTiUR90tAxXL6VqAHOOhkZI
        KGSDWUHHy0BNQh8nGkS6W5bM7aRI2w6QGd02G+8eSVrcXCm06MiM+4YsMB/nKjL9
        Eq6GwkqowHdlry39C7IEa89LanvFqo0WItYGNC0Sj+wKmyYDuQqTESGipfgGpCcD
        kQQ/njwlbMb6i/SpGKFXo/J5VGgQktL/Fxf9h/1MtXdl4dGOVzCxttSvCxDwQAPU
        Ob7mFLLGyECGCgsJNZjX0S84j5RQ0W46SKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pS66hIr1ZqgF for <linux-block@vger.kernel.org>;
        Thu, 16 Jun 2022 16:30:50 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJMC59mkz1Rvlc;
        Thu, 16 Jun 2022 16:30:47 -0700 (PDT)
Message-ID: <ab75c1ca-986f-c3af-6c8c-c2c5b7e40bbd@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 08:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>,
        jonathan.derrick@linux.dev, Johannes.Thumshirn@wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
 <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
 <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 19:09, Pankaj Raghav wrote:
> On 2022-06-15 22:28, Bart Van Assche wrote:
> isk_name, zone->len);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zone->len =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_warn("%s: Invalid zone size", disk->disk_name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't allow zoned=
 device with non power_of_2 zone size with
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zone capacity les=
s than zone size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>=20
>> Please change "power_of_2" into "power-of-2".
>>
> Ok.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_power_of_2(zone->=
len) && zone->capacity < zone->len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_warn("%s: Invalid zone capacity for non power of 2
>>> zone size",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 disk->disk_name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENODEV;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The above check seems wrong to me. I don't see why devices that report=
 a
>> capacity that is less than the zone size should be rejected.
>>
> This was brought up by Damien during previous reviews. The argument was
> that the reason to allow non power-of-2 zoned device is to remove the
> gaps between zone size and zone capacity. Allowing a npo2 zone size wit=
h
> a different capacity, even though it is technically possible, it does
> not make any practical sense. That is why this check was introduced.
> Does that answer your question?

Add a comment explaining this restriction, clearly mentioning that it is =
a
Linux restrictions and not mandated by the specifications.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Division is used =
to calculate nr_zones for both power_of_2
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and non power_of_=
2 zone sizes as it is not in the hot path.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> Shouldn't the above comment be moved to the patch description? I'm not
>> sure whether having such a comment in the source code is valuable.
>>
> Yeah, I will remove it. Maybe it is very obvious at this point.
>>> +static inline sector_t blk_queue_offset_from_zone_start(struct
>>> request_queue *q,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sector_t sec)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 sector_t zone_sectors =3D blk_queue_zone_sectors(=
q);
>>> +=C2=A0=C2=A0=C2=A0 u64 remainder =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!blk_queue_is_zoned(q))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>
>> "return false" should only occur in functions returning a boolean. Thi=
s
>> function returns type sector_t.
>>
> Good catch. It was a copy paste mistake. Fixed it.
>> Thanks,
>>
>> Bart.
>=20
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel


--=20
Damien Le Moal
Western Digital Research
