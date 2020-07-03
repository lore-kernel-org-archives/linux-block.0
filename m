Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D2C433E1
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD77207FF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 08:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iSFKeOVq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="adwT/VQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGCIHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:07:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63169 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCIHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 04:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593763661; x=1625299661;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MAgDcj5/BEAEu7KbmMVmbGbaHu5cNoCNf8rGudqD3ks=;
  b=iSFKeOVqZ5iZ4O8w3GbeVxvh4gfqbkI51FaEfhCrYbGfpD0LV55YFv9G
   Rjy5EhRH/r/AkqhnFtWLesdf9OZyzpg5jeKfqipnt7d9+z08vGhY5Rgj5
   hwqVSIc/+GXZt69V/UvTAnFXcIwbjd1k4hBV3NrpKSp8AVTyDClHTo7U5
   DIYfddpGMr19UGjW1hUukZQkR/xU0uxFoK/+C+5t7A6v636IGERwuPBbC
   ohrQWkTeEps6WpL08ETu3U1fJqK8t8ZwdANxGRaVCt42rctMTy/NLpE3v
   GWX7no6dx6yQz6fdLv/eX8IgtXtBepVa/9ISmXy01YnlesCMGQk5fjjXv
   Q==;
IronPort-SDR: 2oYiCVJmazMRnbduVWOv+mVVie2LPFbjBmKXQLKGerIixG6Y8gKxSttga8NFL8hZLC62SRitY8
 hJYcjJsgiDvny+4tvdOSZYpP665nQFozfQFPGy1m0ONm/9b28HL9IRpbnyBaB8SQ1gLo2mrMCr
 UHurnZ1N+vJsR37ekeG35ULFdJQ91kNgtNu3MJdFpZnCwCQZ/b/vnvz+BLklfOQxkYB2IrYrir
 lsbVkBccdXboV5rShuvDAy4NgKX/DctSJfIxEClvfyI/m2cjC4r1MzhR2aVUAKwC7LPi8rzylG
 kOI=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; 
   d="scan'208";a="250797420"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 16:07:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAv1Pvf+ekdjo5UHGZtNsOaU/+YLm1Vspj5toSteRWLdBxN91JgAoroN8WMx1H5IEQ4KMtbebtaXHlhNz220h8lx+KHytQvqwquBgMkVCS+bl9v+j90TkOCqojew8OWo90DQRF9sX4o1lucQQ9sAsY0U9rsFBmVqwxaOOeX8bI01zeMakAhSkJVaij7nMBRc1MvqYNYxpW/n9FBcp61a8UI7bUQnEC9vqh7moK+cU4kspnDT7Zvjw/47E6mB61j9yoVXhrXOxY549PeWgdoEaB52FZdq8tFqhbRipdQ6SzyEbuPIAMjfvEsQyof24dSePWsNhvSR9GhzfisSbP/hZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+seU6I09ONvIJTEDp03RtJU7OTVIlSYRJUg9eSx/YVI=;
 b=V+VW75oP540rsdy+SC0tg4fVjjaOT4HitDcPTIZN+ATJw+dMrVBbAFsNUXofDe1UAKGiNP+U2e7ErCb3+nrsuwnu6P360uCRdNIAHpHqMCyMadRycigLPONtCz1qsdsZdhIqh/vwN+fTj4mLbZyusyw/KLJutxb3A7yCJgU8bxe1uCbPxIUPossljv+H1RBKvx41D/HsktzmFxBMQ4guLH6bYA8c0wU4csewKGBwX/qP6fQReuYUqnMQG2Z9i0k69jLdlwk9HsTE0o8VFbrBWG3HQvs/du7AiVjf+FmUhdmHsZTcce7EzjyP+7ek3X+WAKiksYxRtnnu895CtSxyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+seU6I09ONvIJTEDp03RtJU7OTVIlSYRJUg9eSx/YVI=;
 b=adwT/VQJTTX5YnmgfFTFz3Ta6vdhgLEg/r/ly7+oVcR8r9rLnxprOfkrCAb7tA+zxcYJ3U+5TV9tRTjmcuaSNatBQExCTLmCYL3ZXttt6rivlvUY4ZQlskRQSWmPxbRal9fXSCzkc/ZzIWHdWM2piNWDgJBBCDURRP+vDDHLmko=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1048.namprd04.prod.outlook.com (2603:10b6:910:54::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 08:07:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 08:07:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Thread-Topic: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Thread-Index: AQHWUIdfrrkmUrgUfEeGzF+AR69QhA==
Date:   Fri, 3 Jul 2020 08:07:38 +0000
Message-ID: <CY4PR04MB375124BE75E2E824F543EA11E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
 <CGME20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304@epcas5p4.samsung.com>
 <1593704330-11540-3-git-send-email-joshi.k@samsung.com>
 <CY4PR04MB37516E788EC8804D7DF9780EE76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200703065311.GB26058@test-zns>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27ee0aa2-d7c1-42dd-6508-08d81f2826d0
x-ms-traffictypediagnostic: CY4PR04MB1048:
x-microsoft-antispam-prvs: <CY4PR04MB10483D9E310325FD4BB02388E76A0@CY4PR04MB1048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icJr1vkJncYv/InXJhilfUJOoOl+enWid4hXUenoWgiRx5YWufEa7rjj8DCQmzhiFCLSRi8Su/2lebP5lAK6yJ4mRSg1S9dP35gPp5hzF+LiXT/RbUoGw+KfVNpVkcrmhJuCwxgrTPApUgsh/ySv4bcGvuM2Ahn0PEh/l5vOi7wc9gdZSFA+CEQ/3vVIDdMxeB6ohcmINYbrztbt9bdR70EUPSpQxhSvAYkm/z/jx7ePo+60xK59o/oS6gtj3/pcM9XMC2efvq1FDKHRbA2e5zK6Dk4UwsYRoUpNrVn+tqPZWAXdjc9CKh65G8d0CSa8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(5660300002)(64756008)(66556008)(66476007)(66946007)(66446008)(9686003)(186003)(478600001)(91956017)(76116006)(53546011)(71200400001)(6506007)(55016002)(316002)(7696005)(33656002)(8676002)(2906002)(6916009)(4326008)(8936002)(86362001)(83380400001)(54906003)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HlN5I5zK/vmw+wvnM6ot5VgSgKJ/jorgFJnChCs2zfUHwbV50/h4QljE2sFyZB0LbGv7w7uLH5Gv+mNHxC0gwrotnY8sLwAWG3HBFMvEYzl3x41ZckuOa0hfWfrGUFg1AcPZUfgmdNMkgyKOXee6D9byWcEN5mamrxnQv78t7Tr6R7DWZ4MjQopIp5jrSXa55kmsSOE80x8x0YWy0hBnEb88Sqw5yueEWpI7Nw44OfdWLXe7NZFO3J1ZW863sogBaS/isFPMjkhfn2r0vqS+IJQs9/+JtxBnhrwbwgc/djN98J1wqJO9mkjhv928mZhxl77GeyrILQhhf1iWmZzRnHWPG2uxjYLfRLhBfM9cO3I0HziGSohAOlHEUCyUrUI0Ype74jnjB5KCQllxvAuiXdo2cCPCGPs8mlD5aR5A3tkg7B2EIV+paVnk179X0DaWl0Ec2taptvg4vb35Fi+Lz9KPAL0RxRpauNqn8lKDErQocwsUQdKYh/Yx347pB69k
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ee0aa2-d7c1-42dd-6508-08d81f2826d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 08:07:38.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlcijtfZi0FFpKlB1kQ02PhkQp2B5rqidpD6baagyqCHkz8U3Vn42NLjJhAGZEtfGEn/OPzYGq0k+9u2u9+CgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1048
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/03 15:56, Kanchan Joshi wrote:=0A=
> On Fri, Jul 03, 2020 at 05:32:56AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/07/03 0:42, Kanchan Joshi wrote:=0A=
>>> zone-append with bvec iov_iter gives WARN_ON, and returns -EINVAL.=0A=
>>> Add new helper to process such iov_iter and add pages in bio honoring=
=0A=
>>> zone-append specific constraints.=0A=
>>>=0A=
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>> Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>=0A=
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>=0A=
>>> ---=0A=
>>>  block/bio.c | 31 ++++++++++++++++++++++++++++---=0A=
>>>  1 file changed, 28 insertions(+), 3 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>> index 0cecdbc..ade9da7 100644=0A=
>>> --- a/block/bio.c=0A=
>>> +++ b/block/bio.c=0A=
>>> @@ -975,6 +975,30 @@ static int __bio_iov_bvec_add_pages(struct bio *bi=
o, struct iov_iter *iter)=0A=
>>>  	iov_iter_advance(iter, size);=0A=
>>>  	return 0;=0A=
>>>  }=0A=
>>> +static int __bio_iov_bvec_append_add_pages(struct bio *bio, struct iov=
_iter *iter)=0A=
>>> +{=0A=
>>> +	const struct bio_vec *bv =3D iter->bvec;=0A=
>>> +	unsigned int len;=0A=
>>> +	size_t size;=0A=
>>> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
>>> +	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);=
=0A=
>>> +	bool same_page =3D false;=0A=
>>> +=0A=
>>> +	if (WARN_ON_ONCE(!max_append_sectors))=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	if (WARN_ON_ONCE(iter->iov_offset > bv->bv_len))=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	len =3D min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);=0A=
>>> +	size =3D bio_add_hw_page(q, bio, bv->bv_page, len,=0A=
>>> +				bv->bv_offset + iter->iov_offset,=0A=
>>> +				max_append_sectors, &same_page);=0A=
>>> +	if (unlikely(size !=3D len))=0A=
>>> +		return -EINVAL;=0A=
>>> +	iov_iter_advance(iter, size);=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>>=0A=
>>>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct=
 page *))=0A=
>>>=0A=
>>> @@ -1105,9 +1129,10 @@ int bio_iov_iter_get_pages(struct bio *bio, stru=
ct iov_iter *iter)=0A=
>>>=0A=
>>>  	do {=0A=
>>>  		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>>> -			if (WARN_ON_ONCE(is_bvec))=0A=
>>> -				return -EINVAL;=0A=
>>> -			ret =3D __bio_iov_append_get_pages(bio, iter);=0A=
>>> +			if (is_bvec)=0A=
>>> +				ret =3D __bio_iov_bvec_append_add_pages(bio, iter);=0A=
>>> +			else=0A=
>>> +				ret =3D __bio_iov_append_get_pages(bio, iter);=0A=
>>>  		} else {=0A=
>>>  			if (is_bvec)=0A=
>>>  				ret =3D __bio_iov_bvec_add_pages(bio, iter);=0A=
>>>=0A=
>>=0A=
>> The only user of this function that issues zone append requests is zonef=
s. The=0A=
>> issued requests are not using bvec iter but a user direct IO buffer iter=
. So=0A=
>> this change would have no user at all as far as I can see. Am I missing=
=0A=
>> something ? What IO path makes this change necessary ?=0A=
> =0A=
> Yes, zonefs does not use bvec iter. But while enabling io-uring path for=
=0A=
> zone-append, I hit into this condition returning -EINVAL. =0A=
> =0A=
> Reference (from user zone-append series cover letter):=0A=
> "Append using io_uring fixed-buffer --->=0A=
> This is flagged as not-supported at the moment. Reason being, for fixed-b=
uffer=0A=
> io-uring sends iov_iter of bvec type. But current append-infra in block-l=
ayer=0A=
> does not support such iov_iter."=0A=
> =0A=
> And zone-append doesn't have a problem in using bvec iter as well, so=0A=
> thought that this may make infra more complete/future-proof?=0A=
=0A=
As long as there is no possible user for this change, I do not see the poin=
t in=0A=
adding it.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
