Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0E6C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 23:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895492193E
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 23:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T4urjDOM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kzgbdrQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINX3C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 19:29:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49391 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgINX2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 19:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600126131; x=1631662131;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PIO23R52jveVpoyyZ7V2+vQf8TwUU2sRwXXC7LFelmM=;
  b=T4urjDOMK3ojt2Sjnq8+ufuJPdneDbaM1p+B5wpBD/55M5m/h9odqeBg
   msHfe9K+lgjWItMmuMOjp5Ifk6e0SBbXp3jR/53+2yDlmYBpPJNxXnEuI
   KBFuLzxqT7c/CJZnVGb2xANeundtJG4DduIQ76d99d6CXEZ0olYhPWwc3
   3h4E+8wI7xz9d0HLKt0iuCcDC5VK+iv6FtIr2tWPa6ouoYnzDoatOMVYT
   ypt/xn8gj3sU306AU4IhVPJpOojPvnygBOVZ3Y4Su+INtvgrSUgbQHoUL
   fQtdAnpcaeiTmUN3u81PZHuDoFcriMqintTZ5f253nCBEhe0rrIQfQfr3
   w==;
IronPort-SDR: HJ72lekkjC3w+lNIE18vrjcp932yaAbpDkBpRSCZocEiajGv7lpRuhE3W40X9j1We2x6T7HFPe
 lzyXeMEieilLP30oounVNDFzQxzrT23OdtFEmN9c6rRlDJFWzweNE6URizLTGJY6wPBjAD3pej
 mm0owS4V6M0aexIMCT1DMJckaS3S/ba+o+9/MFXA0tLC51enM5Tdv7Ojekk6a0woC2QeCNlgfs
 gq9Zkzl5jtDHhjZprtFYRgtDDloCoLbSYDIqsHck5DWpOvdxX6O66gh5zQkvTdY6h2K2IW/SX4
 mX4=
X-IronPort-AV: E=Sophos;i="5.76,427,1592841600"; 
   d="scan'208";a="151719348"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 07:28:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmI0L8dW5oHv3uGpKGbFT5/3elyFBAujPiqjPIZ4DHGaspN3Q1DvE/aLbI1WJemDBH96SPFpXXdSRy4Mu+s2P2VotCA6xw/idhhuBDglJsvxrW3uEzT2hDO7ed2cpv+NvglbWcvscrwr8hVBpFhdRQpRc4KkCnQIvmibREAc4JPfEuBxbkKR/CtlhLTltIGrz5m0xWGml/9aVh2D+LoPKioq2yESls7syQrae/7umHKnpGmehxCganEkcgaFOtVjXPPjeI1EOACjYOVBXrGoutUYaydk4abQk+lJ9YZ4vXA5xPNj0hK6G7jjPWq3E1Qdh6ggJ2Vj1uYz2TM8FJflBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+LYwmbuv2UEErq0FF9w79ta+mmmGN38RJHK3Nu8wtQ=;
 b=KJfKDJ3fmvcQnSDDo/CrfhpEoG+EfqdDSbG0sf3mGUsqlrW8RCxBirdDgGLL+NcdRMoRRmHpfh6H0xc5xzp6hxW0+lDuoqml0Iyc0mFxvXCFk7Rut35U5SyKi1O19GKtLYqNurrieLsSE15cBRc+f4Dmud07SMCz7ky2TP4ujdRM8I9g64iMnQq4GgqibgHqQLgoCGhAV0g3y7kKGZl5XT9rBJSjYQMGFy+1y2PCGY70rKK4Lpeohe9piNBdtQfICLe2jGL+Q70xd0uMISjqv77OgicqRLGKYA4KmU4xSU2DsyMsLGeLWZGIkr+Kyl1/q+wiAaL8SLbQYkEfri+gAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+LYwmbuv2UEErq0FF9w79ta+mmmGN38RJHK3Nu8wtQ=;
 b=kzgbdrQ7uEr8Jc3QkpEAc7ETHFjlo/JutjiMusYaTTDKJfSGuenvzQkLEBnwQdTK8qnT5ZfGHm1ZYCsIYJyyFXYd8Su1FW8ndKKqLoemMnCVfsl3oqU3TLNK2zR9k9vHsK7XRnO7NzuyjMO1lohHQtmruLqItTxCYzbjseVdD2I=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3588.namprd04.prod.outlook.com (2603:10b6:910:90::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Mon, 14 Sep
 2020 23:28:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 23:28:48 +0000
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
Date:   Mon, 14 Sep 2020 23:28:48 +0000
Message-ID: <CY4PR04MB37516F6F0DBA96CE512A4AFFE7230@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-2-snitzer@redhat.com> <20200912135252.GA210077@T590>
 <CY4PR04MB3751DAB758BAF8EB8A792FD2E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200914145209.GB14410@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07592fb8-e8a9-4cde-b2e1-08d85905ee6f
x-ms-traffictypediagnostic: CY4PR0401MB3588:
x-microsoft-antispam-prvs: <CY4PR0401MB358848E70D8F9DF03BA2EFABE7230@CY4PR0401MB3588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwoiT6ahLbhft73oW7wCJK+UHfkXpeuNbxDxWUaEXUg/JXqhZdF1frxbCAHgTsda/466q1NWtwlanwEgGJR+8OCvFlqZOY4Z4MIO4LvzefqsU2kR5nRm6R+GzxFK9jXkcFlpUEZ5M+A0SUiZrta+bRQBUcqyNUS24es+K2RZ0qUWrTC9/0SxglAzjZ17WKZWpWDpo4oBmUKwY11Sjrxl9jFAXGcZ5Aq57lcyNJv4K+BywcM2Y07VmEHw/znd7SDMTTmLBv5F8r8Lq+5KpvU+rWI+EGSOtQG756oZqS+lvkJlVznrpFjg42mZTEBols3Ak9Xpek9rn6MGLAMg6wP19g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(66446008)(478600001)(7696005)(71200400001)(6506007)(53546011)(54906003)(316002)(4326008)(186003)(86362001)(9686003)(55016002)(6916009)(8676002)(83380400001)(2906002)(33656002)(64756008)(66556008)(66476007)(91956017)(66946007)(76116006)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UYVSQw0gZtxXEqbM0IBiz66VC3KVTkUbpEsubmsjU1m+F/KJRM2K5oju5FDgs+hf8clb6mVHajqCXXLccqIG2YTQOKNEXJgxIEimzylDRmjmEICwoA5jivpJDQp+NgZHWRW76xyz6tllQSc009b7I6o59ZM+TfUppMvImgthCIbCU/uJRfJOZfaEbbmKTWf+gZMmZNMrczmcR9H7chLMUAKP5/XLgzCpeHwb7ro7C/l25WRCEhS5TGcall6zgOSHk2L3t9W9H0mReMqOUXM44QDfaHPpYJTxv68pJ4tit7xV/cG+Yddt3MRacN7uZZ0Ow5OXTOwuzbCk7rX9OwPa9SmyG/jo+zOb0BkPp4edU5M0WWvWJQpAQSo7muNM3vgalBuZgQBzxm+m6hNRh0LyNvR9uGNsGaraFLeUBxoSlGEC3iT/XLvuN5CJkEHp86Ldu4Ymeb3gMBD/1t6oyLXl6J5yVFjOzajOg4o4Kd1gcJnBxl4m6hXBIoi80bP382eqLxAdFuElujRlXsZ2H/6IoDBJVNy7u4XXnieG2aZbDNohbwezL/i5dfXCQH36JK5alGlIhBudhhrxZzPFgMTe2kBa236JFXBb+2thTUH1bHj5NeunBCaXrxz8INUl0AMKy6gsrN6KYkxxZaRY2hKKyr4Es6kYJLCE4JWKHdItBaGKsdl2Y/gJSyTy3kO5CTOeEr6b+C1476LHcsz5N0po9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07592fb8-e8a9-4cde-b2e1-08d85905ee6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 23:28:48.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOGvImA+P/s747yz6vdvQHcHOPRWLbutF3WeRoAkJpgF0Yr8UCB+153FinWNtMJHkw6JYHoR/HvwyqkSRVzBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3588
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/14 23:52, Mike Snitzer wrote:=0A=
> On Sun, Sep 13 2020 at  8:43pm -0400,=0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
> =0A=
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
> Thanks for the additional context, sorry to make you so concerned! ;)=0A=
=0A=
No worries :)=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
