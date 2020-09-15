Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEEC433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 02:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E5F20678
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 02:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Adc4WjDG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f4Wp7uuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgIOCP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 22:15:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36297 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOCPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 22:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600136125; x=1631672125;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=suckeJwsUSbGpngWnRIanarZMK2k67p0OKVjE+knmkw=;
  b=Adc4WjDG+lY4J2eqJAXMpWdU6VJCQU2ZJLkcgXcoJyPQHucRwu9EJ9mw
   tEZW2gY5iz60laNJElPDmzN2jE/08WdwGgJYVzup4tlPJtmJKiJxQF7AZ
   uwYEe2NL3BgJ34Z9dE1XHH43Xa+EqpaHAS7KdElY5o0vMiWmfwAeP03Qu
   mfYlYkj3Q0YMezEF+wnKNe8VQP7zvDsKuGz/fQFpS8ii4VdoRqpG15ZNh
   9yOVFEA1IhgllUr4LL5ogqYITxwobQW12Qill7w3bC6k3j9jwGoVfsWxp
   6P+GOazAdHa7NAIy67eq83gbeGDBMbvAGyCFZ/eHRsdGvU5zr7ckWdwZK
   A==;
IronPort-SDR: dAqien0Z8Gug0O+797wO2xXOabWJXS5+0hvmm8UjQWcW9iRjiVNB8oYAnVi7vTVUWEE9OA/eJm
 Kz+om2f0+anmtyPjZLkkboZiky9p1uNtlA3WhKaQN6Iue4BxdNDtI0GaV0VsFbuS6MSwFRGib1
 OVsOMaceRcxEgJlp1kKPhvjbWkEGGHodShr00rOoMoziU7LG5mUXuQWluu1V5fw7yihLVVt9PC
 VKS/6N9FXab6LVLh65fyQZccLqzv9JGnqzr9a91zN4ljGjfTH7zitKfwFEB/bpCTqB47QqqXAB
 e/M=
X-IronPort-AV: E=Sophos;i="5.76,427,1592841600"; 
   d="scan'208";a="257009658"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 10:15:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brlEG6SHDoKSirhv22NdG14eO2IrVr170r+siu4C1QY3fnkkhXekCpWKKp2fqBiKkkDlVOyTpA6NamjAVOGsfQgCQgxjWqkL8bMvdXfwsfop+KDRYTwZxS2F9Fj7sWnuo+h2wWjTEgoAcEOUyrj1GcMo2AfinLoXmNOLfD1Bv2MHgn2glDzNBNrPYns4BXppD7ymAdRNyzVcjFMM/O1atf2/jgdVjQQRNY5EIa1K9DV5CjnsiAJg6XXPpVDfgZ52V9sCZC/DV0bZ4vQKDjPOVxb3+huLm0QO5AY4KvaXkMFxbNGP5UXZhuHdKcCScOEQK4HuMsaxw8OMsCgJbXFpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx4iVP6pI3+E2VPGok6Bfl5dED3T1dLEz448R2dTKtQ=;
 b=gQnwMl0BIBsdAN2L/XmVDktRYxeCKtYBSEipeoHelT6RQ1GDNtTK4TE08o8Jv88uM1kDvtYjOkzO+tg+NEIoH5Ix1OhhSvaDhZK6X1NU/mt9W9VWt0m1bYnsKF7w0iTpz4L4WXIQfI2hYVg/5yzza3JpQdgi7vrtP0CJviqNqgj0hpwSHx5aLWdbRJeo/22mLDrc1hvbS+weqDv/8qscaGsOf5P2f25+hKMWXu44R0Jgrs3XhJ9BPxUwkd5YZxViMJ3VdJj6AEml2MDZ0iSmwiJoMxeq0n88cokYk54x1Thf/NKbOtaoeXnJMyXaKu1PGMg/9RoGuAQKngGkz1n6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx4iVP6pI3+E2VPGok6Bfl5dED3T1dLEz448R2dTKtQ=;
 b=f4Wp7uuODdm7Swe3mnhPmwZYGg3c3TnIRxJMLZ1wJ0x/EHUfb9aYocPzfLa4zNjkjT7LN28pg0z/2yfA/oHzez/zoU9pQMDK/M+zL9Yn5xY6CDY5ZcdYEdY2tVZWbov+M7ItkZKcrzRztEdIZjL3TfL0dvjUYtxrZsVZsNMivdA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1049.namprd04.prod.outlook.com (2603:10b6:910:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 02:15:23 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 02:15:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Mike Snitzer <snitzer@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Topic: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more
 carefully
Thread-Index: AQHWiIYMLoBPwOGRnUWZi2d6qpID+A==
Date:   Tue, 15 Sep 2020 02:15:23 +0000
Message-ID: <CY4PR04MB3751C73F80061266BEFA458DE7200@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com> <20200912135252.GA210077@T590>
 <CY4PR04MB3751DAB758BAF8EB8A792FD2E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200915020344.GB738570@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4be38949-90b2-4d7f-7ed3-08d8591d3445
x-ms-traffictypediagnostic: CY4PR04MB1049:
x-microsoft-antispam-prvs: <CY4PR04MB1049A96B37F0C715838DCADEE7200@CY4PR04MB1049.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OxVgo6NVkiHpMyD55fURLDuHxo/W/5jwpM857tz33NBVXdmaBSHVOhe5FQcF+nNO0EvM+wspJ2PKhogkdz8T91tP/iG+31oH40FYX79lEh01pP9kqF1Z2c5EqMRcrouOzo/rIe8Jlf+Jky+O2qRQX8A63rdrFstEhsN+dXJmIry8CrHvoluWjb+B3cdX+798bEp3FMDsvlBH1lbSGvFXr9hDzWHAFM4D8sojem32iIFS7ldYT+4YR14hwcGJKRIc1+PX09/1PQQ9mlVEh86WjJufdWvHLrn6dI1Pp7AJz6lJwLfygEpMx7LQ/BQS37ouCw95od/93ztHY3TkCkZrUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(9686003)(66946007)(64756008)(4326008)(66556008)(66476007)(7696005)(86362001)(5660300002)(66446008)(478600001)(91956017)(54906003)(76116006)(71200400001)(8936002)(52536014)(83380400001)(33656002)(6916009)(55016002)(53546011)(316002)(8676002)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rHqxoh18V28bpWcdtHXjgGMo6z9LS4lkTnJETU3Shz33qDagtUNYXVkv2g1ZtFzj0m/aUmExJFnwtk5hQ71V5zbRjASs79t4VynIHGTGwsKUlg1bhgEd2bfkPaKRZveEzExJaGP62Mbyl7XuniFP4oH/TTPWW62f8k6aAA2gDDS7faz/h5rxXj4hjaPrHKfqkztcXK2slUBgZKRLLRaMQB1D+4dn2VbSOqonpgLPuCpSq3rVHWrh48FB978jSB6jOGqRjLNIQ9lNX78i5bWc6mG8fbVCgWiult+ybaw/nqs5CpjUDm9hPEosAk7RMvX7rdKAypfMQnxivT64YF1srTUIVBibb1rLFXl6SEUMs6SNXj7HQGZ49mBBIKaHVtWBzWtjD/JYx/CN6ZB3/LVCyoJxWgBfpUGL9cY655GcUhnU0R1Zy1yEnypi85Tcvp0IJegztI2u7eGzbUm2j0El9BML1gREU4QwWRMr34Fq9qgRYUHxG1cYn/fQ3azLd2Sw9PMob6z0kmIqZp+HCxFEZ4tQL0IwC15BM/pDLkX5RtmrDnwgWfHvz0hxu3tO16oooyUPBwgEfmCbesoeWxbariTXgNUnKUq9Bg/vDDSY4lXzVlQg7ujjKAJhffFZyiD4rSEYrHTRiJKz7WHGTyVm82ONH1f0Rjzx3kWFLLE3IoBRY8nf2/jLqMqNXG1vwz0BnN88bqTOX4ZAg/GTdF7evQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be38949-90b2-4d7f-7ed3-08d8591d3445
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 02:15:23.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Omq27anF8l64Ks1qxguibiP6cOggxcfMlm0o34M7V0XUVpNtoRS+okj3TpFPvGExeMIRcAtxtExr9o2+QxG4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1049
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/15 11:04, Ming Lei wrote:=0A=
> On Mon, Sep 14, 2020 at 12:43:06AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/09/12 22:53, Ming Lei wrote:=0A=
>>> On Fri, Sep 11, 2020 at 05:53:36PM -0400, Mike Snitzer wrote:=0A=
>>>> blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and=
=0A=
>>>> REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for=0A=
>>>> those operations.=0A=
>>>=0A=
>>> Actually WRITE_SAME & WRITE_ZEROS are handled by the following if=0A=
>>> chunk_sectors is set:=0A=
>>>=0A=
>>>         return min(blk_max_size_offset(q, offset),=0A=
>>>                         blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>>>  =0A=
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
>>>> +	}>> +=0A=
>>>> +	return min(blk_max_size_offset(q, offset), max_sectors);=0A=
>>>>  }=0A=
>>>=0A=
>>> It depends if offset & chunk_sectors limit for WRITE_SAME & WRITE_ZEROS=
=0A=
>>> needs to be considered.=0A=
>>=0A=
>> That limit is needed for zoned block devices to ensure that *any* write =
request,=0A=
>> no matter the command, do not cross zone boundaries. Otherwise, the writ=
e would=0A=
>> be immediately failed by the device.=0A=
> =0A=
> Looks both blk_bio_write_zeroes_split() and blk_bio_write_same_split()=0A=
> don't consider chunk_sectors limit, is that an issue for zone block?=0A=
=0A=
Hu... Never looked at these. Yes, it will be a problem. write zeroes for NV=
Me=0A=
ZNS drives and write same for SCSI/ZBC drives. So yes, definitely something=
=0A=
that needs to be fixed. User of these will be file systems that in the case=
 of=0A=
zoned block devices would be FS with zone support. f2fs does not use these=
=0A=
commands, and btrfs (posted recently) needs to be checked. But the FS itsel=
f=0A=
being zone aware, the requests will be zone aligned.=0A=
=0A=
But definitely worth fixing.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
