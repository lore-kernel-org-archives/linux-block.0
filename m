Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiCJXsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiCJXsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 18:48:39 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542453B3D5
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 15:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646956056; x=1678492056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N2kQeAyoMoxkHPLdFc15XbRSGH7Gf7dXx1eFHNmcejE=;
  b=YHGWSEAFzzQuhD5F3eboyL6PozenNne6YZLoXMczjC8DZM0u9YMUicdS
   fZo9flWnrmKUzVzxmMedeKQ/QRhwnGBIQGTojmbeR35qVBpJZHTRGcOEu
   YqfIHIcKGATh+pNU+o7H7Iig80pdv0eWTdn0/SZyXbQvE+scHppcD/FSf
   UXZspSFqzgqCwXBQ3FDJsj3xdyoT6Ld8gFfoiJVzuiVFMmXQ4u7KIQTV6
   50wj9jtg2aMfdDaFDo2beMYRDFftH67q6Vd2njwq1+weCpBotF5xYqBMC
   P0qSLcf/s0GJ7cR4y5/OUFO1YS4L2THQpzuW1t1+SKhn1Y49jy1lsaZ5o
   A==;
X-IronPort-AV: E=Sophos;i="5.90,172,1643644800"; 
   d="scan'208";a="193937906"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 07:44:39 +0800
IronPort-SDR: dyBhwpgmIosMoZKluTqV03P6UvJxiyLxmfTNZyiTM+s/p/y54Y6aWqbb0nad6zh6Wv/G6ol+gC
 4BQcioDr7szDvdNSAwJdaXu5PtCNgNYakbLMmqReWceEP2dTFcq7gokyH+GyGrc+mNLFKKGkJ1
 nYdGjfYnUnPHtEDUYZX6g7TFjAU7a5pWq4HfMoicgicCSkM75dOqvemx0dTuHGvKVabxj4AwS1
 A7BtfefC2df8y3fhlzTYyyND5gLiMrCm7x1sEd3I/e8+Eb5Sh5EIRFRU+rq+rLNGDeroprMNun
 RsmZUoEPxA2MnkwX6wvo7/92
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 15:15:52 -0800
IronPort-SDR: WljkDyk0EM6TJNTINIDrfSF+GQZgZRM+J6I9IipGADLaO8w8vUFPsF1icP1ooXjg8Bz4Ozz7P6
 YstEYuYUmYXPbLTGdPDiuCEIldCNhdUkNBpl5MYRd09JTzxQrQGffBPqxXlue/g8l2jmHGKQim
 o23Zrda2ONuoP0XGWdgW0+C6viDM6TR21hci4sQmftV5CbJT8XcjHCh4/j2eNTbCGqkIeU3mAa
 r5bFx/utLUuHY/l4xNXLvWEn1wRnb5x9wBNa+wx9/q34DYvir5OqJsFrEpstJSO9VqFc//3huR
 cVk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 15:44:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KF5JQ4qpVz1SHwl
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 15:44:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646955877; x=1649547878; bh=N2kQeAyoMoxkHPLdFc15XbRSGH7Gf7dXx1e
        FHNmcejE=; b=ctLXIDfHZgQgh7wXNiF76dXtTMezfyfqP4lAP6mPh7t5bCREIug
        yQ5DPM+06lhSEjrQmPLynKtd9aaJAn/azVL5PfzN/H6YU/GKfZdktqHWgiEb8Ma7
        JJbVpyMop2xe/tmkwCXeg5oA6N3bDmmxGsln8c/6CJSyhlxZuNwmNE76FdtK1S80
        UEZcT8YjTTtjDXD1jxBUk05+Hkm1cu03/cXUSesP0uclYS/H5ci1pgglnnkyZkFz
        3G7eYKq95HkMAwLpe4ISOkQEntMg346Gm/YyIciLwQ87rhp6pow6gA1JPbdXJR6E
        4HlzTBcsSufRJv0r0EnkhNiLr65NLyW0HQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vzkmAzxYLdy6 for <linux-block@vger.kernel.org>;
        Thu, 10 Mar 2022 15:44:37 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KF5JM0jbgz1Rvlx;
        Thu, 10 Mar 2022 15:44:34 -0800 (PST)
Message-ID: <ddf396a7-0a4b-9949-4067-a19f8787b480@opensource.wdc.com>
Date:   Fri, 11 Mar 2022 08:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
 <20220310151628.awfihyvsjc7hawnz@ArmHalley.local>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220310151628.awfihyvsjc7hawnz@ArmHalley.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/22 00:16, Javier Gonz=C3=A1lez wrote:
> On 10.03.2022 07:07, Keith Busch wrote:
>> On Thu, Mar 10, 2022 at 02:58:07PM +0000, Matias Bj=C3=B8rling wrote:
>>>  >> Yes, these drives are intended for Linux users that would use the
>>>>>> zoned block device. Append is supported but holes in the LBA space
>>>>>> (due to diff in zone cap and zone size) is still a problem for the=
se users.
>>>>>
>>>>> With respect to the specific users, what does it break specifically=
? What are
>>>> key features are they missing when there's holes?
>>>>
>>>> What we hear is that it breaks existing mapping in applications, whe=
re the
>>>> address space is seen as contiguous; with holes it needs to account =
for the
>>>> unmapped space. This affects performance and and CPU due to unnecess=
ary
>>>> splits. This is for both reads and writes.
>>>>
>>>> For more details, I guess they will have to jump in and share the pa=
rts that
>>>> they consider is proper to share in the mailing list.
>>>>
>>>> I guess we will have more conversations around this as we push the b=
lock
>>>> layer changes after this series.
>>>
>>> Ok, so I hear that one issue is I/O splits - If I assume that reads
>>> are sequential, zone cap/size between 100MiB and 1GiB, then my gut
>>> feeling would tell me its less CPU intensive to split every 100MiB to
>>> 1GiB of reads, than it would be to not have power of 2 zones due to
>>> the extra per io calculations.
>>
>> Don't you need to split anyway when spanning two zones to avoid the zo=
ne
>> boundary error?
>=20
> If you have size =3D capacity then you can do a cross-zone read. This i=
s
> only a problem when we have gaps.
>=20
>> Maybe this is a silly idea, but it would be a trivial device-mapper
>> to remap the gaps out of the lba range.
>=20
> One thing we have considered is that as we remove the PO2 constraint
> from the block layer is that devices exposing PO2 zone sizes are able t=
o
> do the emulation the other way around to support things like this.
>=20
> A device mapper is also a fine place to put this, but it seems like a
> very simple task. Is it worth all the boilerplate code for the device
> mapper only for this?

Boiler plate ? DM already support zoned devices. Writing a "dm-unhole"
target would be extremely simple as it would essentially be a variation
of dm-linear. There should be no DM core changes needed.

--=20
Damien Le Moal
Western Digital Research
