Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2381C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 04:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E551212CC
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 04:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XRXS4RIh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L59cZqjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIOEWF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 00:22:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20828 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgIOEV7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 00:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600143717; x=1631679717;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YNqLbn6oIkbxWgMTJgXg07sw7TLcyL5oXDWUZLw1z0c=;
  b=XRXS4RIhsaHvLrEEfmTQBD/X5cVG0wUzrpMcfyeEd8tv/2SoLA6AmK8i
   p3tPLM9jF7xt3YECSy8pXASLKnnPJD8R/PRN59wBYxbH9kpdVwSSC4o8i
   366lDaU80UFgh0MmCg1AWhKy0kVcU/CLFuOxLm+N1Nu5wpGoc1OcZVztd
   UnjRnE7aqzjxp8lJZvIyDjCy64vYsiQfqNpGlHEGy4dSEuiuuupdEJp7a
   tJtXHVItGZ+hr89yDNxVdSllbet1Kgr2nVL99zbd+6DJySHI86HBpIrTX
   ouwf/FqkwtJx5Z2eBP3UlsMGmSzryXxuaivBQntUSuJVUOi+4lFJfTDsy
   A==;
IronPort-SDR: IWfgP9Fcr6GRtPdhtRmsL3APAvOB7Ly8jHU9XRK0Mcl9mxeDXOC0fr43p0CG3ilb4ugr7ePxUE
 9f75rbcG4zppIhGL4T97imXFGbgxxrC8aiCmBaG0m9AVwrAbkXXSShoSj+eXg9QZVH0uAuygTA
 QoohD/1Rm5Vp7dcKWvzQmQDefIy9Eh7VPLpKHTUWcWaRikuvfM7whCgM/WnEL7q4KOa7Q6TRWy
 x+vOylsrJjs6abSmw0tPAix7fp9YX+jPkJOpFNOXIMuZa/PNEhzBLR0vdVeKxKIg0bBmXzi8f0
 o8k=
X-IronPort-AV: E=Sophos;i="5.76,428,1592841600"; 
   d="scan'208";a="257020508"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 12:21:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcDx3tu3QlIcI6uGhDiAICg5+2AAezyEvLmYaOQAY/bTP+7lN/HM5oDbTWE8cNXoZPVL3S5QB3FlbxjT3j576Ynuy1ganYn3ihiJyOuJtgCNjxjn7+Fn1slViVcRF24PAQP0RVCQqUt/YTW5WDBfBVTYhUQ+rpbp4xMjlOebqK6GxVFEP0f7C7mZUrgXkYv7ypfIoriqZs4shNiTMgS+sYh9PsOtYRUrSF8F9FbA6USuBc6UIXwh8rJzN+809g1tqijAe3YSLB6h5MQKuRZT+nmF9k6UDyh+5P7qxEI4FARtAzjtX7yGaNTsMbkGxWcDKDfw8x3Hdd8wuQ3mUk2ZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVoSWN1PSrZNJqSemjjkop8Gp2uRZ4BtVe4d3e5sEOs=;
 b=UHv22W2dA3e2E1tZE3rgEw/iNSuuCDjik8cZU4000mxGEeDsroHWwv0J6xDm+DXuOy80M2PUubO9EQkHFnuXA/Ah6qP+eEzrKV9uxL3zMI5jCF/vQv188mETvoWJvt37Fkh81isg3eePKxLDaMuI2aZmKZm4dh2IJDnJKAL+v/S/1Pvkf7R+f833m969VKUf6HUcAEFtdHJhKkNMsdA06p/wixuq/mqeu6886UysGXtsIkDq+qr0tWkHhJY4fzOsf9W/Qkthx9LdstQWA7nZ3dfy+GLjMpWYuHGvXkAC2XudwK7cFOsHHoYiIyq7TbKYDVCBbBkvl3mxuRXj17Bp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVoSWN1PSrZNJqSemjjkop8Gp2uRZ4BtVe4d3e5sEOs=;
 b=L59cZqjKVaL6ir/+8a5Vn3HoPmFuGnocowqS2fTPbqgopMgpHFl9oyHaF68zTehUtjKLLTtrwwUOiC3aT+0SMRrwT/fuCbzEBZcBV5ouxYC3e1blCntjvHoLxbvOH/cIW4vgbUkXq+mlDZYNCLqr38XvdJQ7OYpAbkUpAiyEQv0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB3750.namprd04.prod.outlook.com (2603:10b6:903:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 04:21:54 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 04:21:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Topic: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Index: AQHWiIYMLoBPwOGRnUWZi2d6qpID+A==
Date:   Tue, 15 Sep 2020 04:21:54 +0000
Message-ID: <CY4PR04MB3751822DB93B9E155A0BE462E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
 <CY4PR04MB375160D4EFBA9BE0957AC7EDE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200914150352.GC14410@redhat.com>
 <CY4PR04MB37510A739D28F993250E2B66E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bce67ca5-377d-4970-dc26-08d8592ee07f
x-ms-traffictypediagnostic: CY4PR04MB3750:
x-microsoft-antispam-prvs: <CY4PR04MB3750A2D0283BAD0D4C9EE2F1E7200@CY4PR04MB3750.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHvZbGJic3MGFa4W4f/iiJHI1b+obM2XERRmY98W8Cde4rrT+zirzxVIN+Iy5/95IVAmE4Cf7SQl4uhLmX4d1ERdycrW8276Ad0KNB+v3zvZmQAv429/cDzoEHhKm4lB/XXr07K29vWxC81YfRiuzB+a4vkY/XHen13nmwR4yiI70Low6jmJUC6VNBxZk3AH1fu+cKqzxIKs7CT5CpF3ro162kYUKt71pfHiE2SI7WM/uVF3fxzev8GPQZx40KxBKgWB+DDuh4TNRkk1HEYj9pdfL8/G8vdxESoPWmuzkPbJr9DN6ueY5sM0R94uVDn7Mdkr/H1HpGlxnG0D4SSBjnBvwYso+9GfpMLXJS85u0ljmQMggk1vvgBvh4oyn5pv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(54906003)(53546011)(186003)(478600001)(2906002)(6506007)(8936002)(86362001)(83380400001)(55016002)(52536014)(316002)(7696005)(5660300002)(33656002)(6916009)(4326008)(71200400001)(66946007)(76116006)(66446008)(91956017)(66556008)(9686003)(8676002)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YX8VS30Gn7wARKBFecsYHLrbIkFzgj6FHxBoBBhKMc7SqyffAWShEBpAEjo/bDsY/I4B5altv4RcvblxY3rXehPQTFtVAEcOiQXAAIgLk8qFAuxgAWShVAVnGzX7les4/WvrxFNplHDqNJQKrV9mTmpVU2AaHQrw/wT4oD6OGoUzWg3yh6GYhb5PZRSeG320zb+zEzFRLcUEFSrvpuI9DnYtWscthskry68VvC59TjyPtk7UAfPhmhawDVMltO131C6qYvvLo4Ga9Q56TV0anAstwCA5U0k60j2XPdpY7rVXbBJEWlIVxyX1K2k0pD/9GB7eEi8KLrbM7eN7bS4q9DQNviVJgvVzgwCw5fJjxUfjkB69dNKzf5EJoUw0nOp8j+6aNLi86YqKJudLCOuMH5GD9xxSC0EAYSIYBavQVC1D5s+xWJ9s86QUmVSZa9qWaJolD0s7BR7d6UmcaM/WZvUoJKaWGm3woVJx2Gd6inBnJswcobk0AaKLBCA5YUGNrqi4NDFC3jO+GYXEJcCXtFkQVMUvS0Khsed2+MjhiGRmJhA04+IWt9QqXR6G/Jad4tVLeCacaralQkt/8cK/BYxU8HirnOGfObx0tLF/MoihZmFkw3KgqHqhVhyL4rTu7WpJjL+VgqX4HZZ5BiTJ6CAwarqswbNcN3OE01+XIwz2SvaXMg2MQmVy7IiQXToc0zASq7v/R1VzDO0Iw+EtRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce67ca5-377d-4970-dc26-08d8592ee07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 04:21:54.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ji0ue+4waCSS9GaYSrQMb0EooEo+D5+QswFherHo9trX9pFiwRukjwVxH/Jd/2/8Hzu7RZHl3qH8MfdsnvKfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3750
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/15 10:10, Damien Le Moal wrote:=0A=
> On 2020/09/15 0:04, Mike Snitzer wrote:=0A=
>> On Sun, Sep 13 2020 at  8:46pm -0400,=0A=
>> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
>>=0A=
>>> On 2020/09/12 6:53, Mike Snitzer wrote:=0A=
>>>> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and=
=0A=
>>>> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for=0A=
>>>> those operations.=0A=
>>>>=0A=
>>>> Also, there is no need to avoid blk_max_size_offset() if=0A=
>>>> 'chunk_sectors' isn't set because it falls back to 'max_sectors'.=0A=
>>>>=0A=
>>>> Signed-off-by: Mike Snitzer <snitzer@redhat.com>=0A=
>>>> ---=0A=
>>>>  include/linux/blkdev.h | 19 +++++++++++++------=0A=
>>>>  1 file changed, 13 insertions(+), 6 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>>> index bb5636cc17b9..453a3d735d66 100644=0A=
>>>> --- a/include/linux/blkdev.h=0A=
>>>> +++ b/include/linux/blkdev.h=0A=
>>>> @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sect=
ors(struct request *rq,=0A=
>>>>  						  sector_t offset)=0A=
>>>>  {=0A=
>>>>  	struct request_queue *q =3D rq->q;=0A=
>>>> +	int op;=0A=
>>>> +	unsigned int max_sectors;=0A=
>>>>  =0A=
>>>>  	if (blk_rq_is_passthrough(rq))=0A=
>>>>  		return q->limits.max_hw_sectors;=0A=
>>>>  =0A=
>>>> -	if (!q->limits.chunk_sectors ||=0A=
>>>> -	    req_op(rq) =3D=3D REQ_OP_DISCARD ||=0A=
>>>> -	    req_op(rq) =3D=3D REQ_OP_SECURE_ERASE)=0A=
>>>> -		return blk_queue_get_max_sectors(q, req_op(rq));=0A=
>>>> +	op =3D req_op(rq);=0A=
>>>> +	max_sectors =3D blk_queue_get_max_sectors(q, op);=0A=
>>>>  =0A=
>>>> -	return min(blk_max_size_offset(q, offset),=0A=
>>>> -			blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>>>> +	switch (op) {=0A=
>>>> +	case REQ_OP_DISCARD:=0A=
>>>> +	case REQ_OP_SECURE_ERASE:=0A=
>>>> +	case REQ_OP_WRITE_SAME:=0A=
>>>> +	case REQ_OP_WRITE_ZEROES:=0A=
>>>> +		return max_sectors;=0A=
>>>> +	}=0A=
>>>=0A=
>>> Doesn't this break md devices ? (I think does use chunk_sectors for str=
ide size,=0A=
>>> no ?)=0A=
>>>=0A=
>>> As mentioned in my reply to Ming's email, this will allow these command=
s to=0A=
>>> potentially cross over zone boundaries on zoned block devices, which wo=
uld be an=0A=
>>> immediate command failure.=0A=
>>=0A=
>> Depending on the implementation it is beneficial to get a large=0A=
>> discard (one not constrained by chunk_sectors, e.g. dm-stripe.c's=0A=
>> optimization for handling large discards and issuing N discards, one per=
=0A=
>> stripe).  Same could apply for other commands.=0A=
>>=0A=
>> Like all devices, zoned devices should impose command specific limits in=
=0A=
>> the queue_limits (and not lean on chunk_sectors to do a=0A=
>> one-size-fits-all).=0A=
> =0A=
> Yes, understood. But I think that  in the case of md, chunk_sectors is us=
ed to=0A=
> indicate the boundary between drives for a raid volume. So it does indeed=
 make=0A=
> sense to limit the IO size on submission since otherwise, the md driver i=
tself=0A=
> would have to split that bio again anyway.=0A=
> =0A=
>> But that aside, yes I agree I didn't pay close enough attention to the=
=0A=
>> implications of deferring the splitting of these commands until they=0A=
>> were issued to underlying storage.  This chunk_sectors early splitting=
=0A=
>> override is a bit of a mess... not quite following the logic given we=0A=
>> were supposed to be waiting to split bios as late as possible.=0A=
> =0A=
> My view is that the multipage bvec (BIOs almost as large as we want) and =
late=0A=
> splitting is beneficial to get larger effective BIO sent to the device as=
 having=0A=
> more pages on hand allows bigger segments in the bio instead of always ha=
ving at=0A=
> most PAGE_SIZE per segment. The effect of this is very visible with blktr=
ace. A=0A=
> lot of requests end up being much larger than the device max_segments * p=
age_size.=0A=
> =0A=
> However, if there is already a known limit on the BIO size when the BIO i=
s being=0A=
> built, it does not make much sense to try to grow a bio beyond that limit=
 since=0A=
> it will have to be split by the driver anyway. chunk_sectors is one such =
limit=0A=
> used for md (I think) to indicate boundaries between drives of a raid vol=
ume.=0A=
> And we reuse it (abuse it ?) for zoned block devices to ensure that any c=
ommand=0A=
> does not cross over zone boundaries since that triggers errors for writes=
 within=0A=
> sequential zones or read/write crossing over zones of different types=0A=
> (conventional->sequential zone boundary).=0A=
> =0A=
> I may not have the entire picture correctly here, but so far, this is my=
=0A=
> understanding.=0A=
=0A=
And I was wrong :) In light of Ming's comment + a little code refresher rea=
ding,=0A=
indeed, chunk_sectors will split BIOs so that *requests* do not exceed that=
=0A=
limit, but the initial BIO submission may be much larger regardless of=0A=
chunk_sectors.=0A=
=0A=
Ming, I think the point here is that building a large BIO first and splitti=
ng it=0A=
later (as opposed to limiting the bio size by stopping bio_add_page()) is m=
ore=0A=
efficient as there is only one bio submit instead of many, right ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
