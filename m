Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4715CC2BBD1
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF95C21973
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N3+EEqpY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xaInUZt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgIOBKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:10:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57648 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgIOBJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 21:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600132199; x=1631668199;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oomI+ZtMj99HOYRcehAZUEvTzGMbFxeHjeRE7L1n1tc=;
  b=N3+EEqpYYmZhYYMibF6UIHDEAEPHFBNBtG/nvHt2cYg+J9iSZuwcBKsH
   Gd9NrWL3yXyEpKgCoBHQa85BB+krO15o1pHnk99qhAgmfymysaAi1eDyY
   RVDnA0lkew5uVSUoSXBu86fKM0AvlYVY37IWu4jJGqGhzRV1SUvI3ScUZ
   DW0FdTVzCoL/kXY89V9sRLe1r4LFFT4bPVorrh0xMJyg49OkgDJKyEE7/
   Dvv4sqATrvrxcz57E1ZNqU7WiEPORJLZA/BsgtWq8sysdMXrUTikq2RCt
   OGO4eGeqQArVCdnO6BSNP5ZaTMDvf8yQ5PQIMuopG/xOfMQq7uN/7+kIg
   Q==;
IronPort-SDR: PXTazu/HhwydpTBSFv/U8ByZxxZNKZYa5JrZrv3tghME9DkBoipXZaCZ4qvn546xN+aAq8AM4D
 Gp8C6nT3cobygyS6BiTwGprbkcqnWWiVVrhG3YlBzlfaU6U/eDPxLSJ1tOrAXbgdoOf0p8tq2b
 YF7WPCWtiTD3yOG5rtbPmDnCPwIdAiaD74FvmI6hp3XKdhwRHBB0xLixtdtH3/x2iKu8cqFYU9
 d02eytIcr+ElZTYoZqTNRSHgIEpVce7ABTDzXlIlWLDsgIqvoS2sXyk19rUG8MI3odTkCWQuPh
 INY=
X-IronPort-AV: E=Sophos;i="5.76,427,1592841600"; 
   d="scan'208";a="151727879"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 09:09:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5KAO4zTqzcsW5F1ViupECW1IK7nLHZIAQCqN7N5sTVQSwkUxMb+TTb/kOHlqM3r09qh9SeNzLQkrQp+lfbwSpE+IFhk6vkgLSUBe8PAHf3XK3dllGcGY9RYB4rZCvNAer9nEiAAz7kBrw28HqWzydks99K6mlgyRvcCHeZxVpupoG9E6w+0306Q3dsS6zkxYjbEpXzc5Day8Uj8L7ULOL1AsL4PumnjzNZoNiDiFvXr8v1zJHxpicCy49dWF7vuNmyYdI9QDvrSF00prpDWjs3p8ODUYkV7ICapm2T4GCOpP0Bm9IFkGmAsw/v/bIVCuwLgakOsW8yu80ET9sYjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcenMl4SYbTrcwSiozzI8Ydz43rsKzBkiE1eqxA+0q4=;
 b=IGfNwMToLcYJ+vDAiH7o0u8UptgJ5Mc+801NZ9FCeSgtH7R2NQ6ae7st7GRS56BviWcSKZkJ/ZD7+k3scTER/8nf//h9c3ZPTaa4vzMmXeX+PAT3v4iCjwCNayLqnpORN19IPGuTChlj/0TU3fkv7PMfbDYSsFYWl01f43/1Nj2rORRuzw2Gl8qfGrEMgDG8AUD/zQhaW4hlsJGUlJScc09HQQkBBAyqh3PQxOSXmW0totKVNo2MhGtQhRiKvkdOowWSf+cl0JetuNJbsEDTuq89vMRZDOuGYJBCQvloS1En51ElHYdR3oTZgDJyGPG+afUCJMbbjZaFwDJh31Hkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcenMl4SYbTrcwSiozzI8Ydz43rsKzBkiE1eqxA+0q4=;
 b=xaInUZt/fWWcANybngtiy8Ctukkd4dh9CnAlAH6QZ/jQun/Aqjkmi0xepbHJTOqC+KL8QVXsjp1BD79kOj1vN5Yy8S7TIWxxUOATCs/eH+bNA4+bi//GFm2tqDgk5gmYwHlfRhLQ4iTGTbcHnpGD6xM5t6n75S31Hq5DBLzxfhg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 01:09:55 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 01:09:55 +0000
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
Date:   Tue, 15 Sep 2020 01:09:55 +0000
Message-ID: <CY4PR04MB37510A739D28F993250E2B66E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com>
 <CY4PR04MB375160D4EFBA9BE0957AC7EDE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200914150352.GC14410@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e83c05d-1e87-4ed7-1043-08d859140f06
x-ms-traffictypediagnostic: CY4PR04MB0567:
x-microsoft-antispam-prvs: <CY4PR04MB0567A6DFE9F0E0749FB98B98E7200@CY4PR04MB0567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78B41B6maDjGgBXvRZolzcCwZTCWQZxUgH6ibJf81i41scNF6GD7leey2DB72oxB6qbPAuZsI/c/xmLXoo2Lv17xab0+2ZNv3LhWPiixdAtm/4w71F4/24Q/K7sxdZT/ByKkMhmbEciSVFkwUyC4RuJKLMnkjcSYQQ79SvzqRTbw6RxvX6CkKTtTT2daxWPyU1CruNm9jDldZEBMExmL9bq7Z6c3oVJfTVJQbamC1i3oHoHdt9HJa7JsdVJOcob/FNXu9woJTL9rFTzXPJEYUTOH1xHSwkzFNka4BTQbIiZzaHZxpDC3iSn2N+IZmYYb7vZn8npYhjoVn8w7wQ5D9DRKuz3ByaWJ25tux0JpzxQRE9cqkk+CRXWIfH/7kToq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(6916009)(71200400001)(186003)(8676002)(83380400001)(54906003)(4326008)(52536014)(478600001)(7696005)(9686003)(33656002)(316002)(6506007)(55016002)(66946007)(66446008)(64756008)(5660300002)(91956017)(86362001)(76116006)(66476007)(8936002)(53546011)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: u7b8u3byQn65o1yTR2z2gcRzZV2CkGfEEHD318nbEA6ID0LP4t9MT1YDBkiU0FQJ6eufbxS8ELUgmKJUQabQRiMeWfQMUwVCG4p+tI4V1wdt0xpTCpd/1kNAhoqIJUweS3WZ+0bvGCA9eBU1s6xOnt8Q1wEkSw8R2QWa7E5geJG/sHE43ErpQ5k4j/LavT58Ays0GIrPMuje71UQftmbAuOd7Zlvp9552uaVOll6BBI0e58nAb2gYBxVc6mzjTmCujtNdOzOb94nctYsMDitFvMX5OYtkDnxpUvd56y3kMx+8j8I896/1h1ioqAaWhkYDLmRM2erB/KxGK/aauYeSok6HDS+lhsKMTFcmc6K/Hr15C4CQHtn875MzeU+Zi9ydJZZGe1BtWAalE/k1+MUzMPs+R5GcztJZHOnFp7iC5rPTrdNilfxu9xiWGzy0Ayls9FgyGywzH3H+V+Cgio5DVZOwmDZcKPd6J+LokzA0vDpyzCCnMRrHPM5HjMhzmoxNVZ3eiq0NJYRH7BzGKH6TxvucUUyC/Rcj9n7nAUhZA59tRidh8ZxM1xB9B7Pnv31DbCplKaME04EoRC4zAyIuLU7J3ti9e4jm/2to3lZYW+oDIyJJF39YqmL1qGDIsBKviJh+/USMu9wNp76HKcogUlhwL/wKeVoRdLhvXULKGBB5DUjRAOFzHQZbJlv57ohxrBTLdhL5QCU91qgjc8g5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83c05d-1e87-4ed7-1043-08d859140f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 01:09:55.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nc+zHhj8ZqaRB1O8DWEkDwSRJO/Jz5ZtI4bSitw6e07PpN/zOmSaiazaJji9V8fok2WHFQ7oJ7gbVb1xtdDTrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0567
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/15 0:04, Mike Snitzer wrote:=0A=
> On Sun, Sep 13 2020 at  8:46pm -0400,=0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
> =0A=
>> On 2020/09/12 6:53, Mike Snitzer wrote:=0A=
>>> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and=
=0A=
>>> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for=0A=
>>> those operations.=0A=
>>>=0A=
>>> Also, there is no need to avoid blk_max_size_offset() if=0A=
>>> 'chunk_sectors' isn't set because it falls back to 'max_sectors'.=0A=
>>>=0A=
>>> Signed-off-by: Mike Snitzer <snitzer@redhat.com>=0A=
>>> ---=0A=
>>>  include/linux/blkdev.h | 19 +++++++++++++------=0A=
>>>  1 file changed, 13 insertions(+), 6 deletions(-)=0A=
>>>=0A=
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index bb5636cc17b9..453a3d735d66 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_secto=
rs(struct request *rq,=0A=
>>>  						  sector_t offset)=0A=
>>>  {=0A=
>>>  	struct request_queue *q =3D rq->q;=0A=
>>> +	int op;=0A=
>>> +	unsigned int max_sectors;=0A=
>>>  =0A=
>>>  	if (blk_rq_is_passthrough(rq))=0A=
>>>  		return q->limits.max_hw_sectors;=0A=
>>>  =0A=
>>> -	if (!q->limits.chunk_sectors ||=0A=
>>> -	    req_op(rq) =3D=3D REQ_OP_DISCARD ||=0A=
>>> -	    req_op(rq) =3D=3D REQ_OP_SECURE_ERASE)=0A=
>>> -		return blk_queue_get_max_sectors(q, req_op(rq));=0A=
>>> +	op =3D req_op(rq);=0A=
>>> +	max_sectors =3D blk_queue_get_max_sectors(q, op);=0A=
>>>  =0A=
>>> -	return min(blk_max_size_offset(q, offset),=0A=
>>> -			blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>>> +	switch (op) {=0A=
>>> +	case REQ_OP_DISCARD:=0A=
>>> +	case REQ_OP_SECURE_ERASE:=0A=
>>> +	case REQ_OP_WRITE_SAME:=0A=
>>> +	case REQ_OP_WRITE_ZEROES:=0A=
>>> +		return max_sectors;=0A=
>>> +	}=0A=
>>=0A=
>> Doesn't this break md devices ? (I think does use chunk_sectors for stri=
de size,=0A=
>> no ?)=0A=
>>=0A=
>> As mentioned in my reply to Ming's email, this will allow these commands=
 to=0A=
>> potentially cross over zone boundaries on zoned block devices, which wou=
ld be an=0A=
>> immediate command failure.=0A=
> =0A=
> Depending on the implementation it is beneficial to get a large=0A=
> discard (one not constrained by chunk_sectors, e.g. dm-stripe.c's=0A=
> optimization for handling large discards and issuing N discards, one per=
=0A=
> stripe).  Same could apply for other commands.=0A=
> =0A=
> Like all devices, zoned devices should impose command specific limits in=
=0A=
> the queue_limits (and not lean on chunk_sectors to do a=0A=
> one-size-fits-all).=0A=
=0A=
Yes, understood. But I think that  in the case of md, chunk_sectors is used=
 to=0A=
indicate the boundary between drives for a raid volume. So it does indeed m=
ake=0A=
sense to limit the IO size on submission since otherwise, the md driver its=
elf=0A=
would have to split that bio again anyway.=0A=
=0A=
> But that aside, yes I agree I didn't pay close enough attention to the=0A=
> implications of deferring the splitting of these commands until they=0A=
> were issued to underlying storage.  This chunk_sectors early splitting=0A=
> override is a bit of a mess... not quite following the logic given we=0A=
> were supposed to be waiting to split bios as late as possible.=0A=
=0A=
My view is that the multipage bvec (BIOs almost as large as we want) and la=
te=0A=
splitting is beneficial to get larger effective BIO sent to the device as h=
aving=0A=
more pages on hand allows bigger segments in the bio instead of always havi=
ng at=0A=
most PAGE_SIZE per segment. The effect of this is very visible with blktrac=
e. A=0A=
lot of requests end up being much larger than the device max_segments * pag=
e_size.=0A=
=0A=
However, if there is already a known limit on the BIO size when the BIO is =
being=0A=
built, it does not make much sense to try to grow a bio beyond that limit s=
ince=0A=
it will have to be split by the driver anyway. chunk_sectors is one such li=
mit=0A=
used for md (I think) to indicate boundaries between drives of a raid volum=
e.=0A=
And we reuse it (abuse it ?) for zoned block devices to ensure that any com=
mand=0A=
does not cross over zone boundaries since that triggers errors for writes w=
ithin=0A=
sequential zones or read/write crossing over zones of different types=0A=
(conventional->sequential zone boundary).=0A=
=0A=
I may not have the entire picture correctly here, but so far, this is my=0A=
understanding.=0A=
=0A=
Cheers.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
