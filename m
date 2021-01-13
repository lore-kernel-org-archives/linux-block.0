Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA9C433E6
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6622311B
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 01:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhAMBSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 20:18:06 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38339 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAMBSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 20:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610500685; x=1642036685;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=heQtdsr20nU//O33Bux0ItDHiSU3bNNiP8NEPE0CwYk=;
  b=VCU96S9iN3sAp/S5WIz0DDBRh5ob7L3ZIK4LysSVM6MNmFmowu0xvMX9
   +iut5TU/GTIQjs37M6La4BRGIvv124aIvDRSt8i3JNNZXCHDd1zTIq576
   4fOFzZpGr8WRiWn6uP/HLln8C6TFliVeRgGRwel71b2hgixGRzOCqXdep
   sG/ul2N/m0XlOsXg0Pr7++3D+dMcjIFSQo++KBtXkk3F1t4WJkKfP1aqC
   gD8com2UYzbXR1eDVLh0lnG40S96Vb7+O+tBDiwBPAE4KF7E5qbm1wHxr
   v0GwehrhZ0rULk5I7SviZ0HC+/l1UqdikLXKRKN/eiDcqVtmK4oe4Fb0l
   g==;
IronPort-SDR: w4LqwiLt6UcyeXymJ4qKmfaW51OQiDrWSi1yakFmk3Nz0WCfz1K0i9GsAbrzT4cum44c0Z38Fx
 pGYPRAtPrH0w72r4+PPrlehTzItuThEM6hNcPAJcXSWj+0J95FoKGug26ZZePeXQ6Wt5WR5u81
 RG3qJpeHVygImQEzjU9Nw15TRDeZZ3iKnYh/7O/M7/TIyrr/3Q8LO8W1FURd327XYgzKbYC0gm
 lkQfdoFrKZqRYWOar1h3Peaw9/7zqvbNsmrKmMQIp7DPUeAJPAa19FPjW4QIQjxc35PFMHHoXV
 Htk=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="161729471"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 09:16:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfo9bM8muCRYWRETkPELvZfJT8pf1dOTDlFxHl6utHCSe/HNVV3tkfMx955A38OdD89LJjuapw/sCWzU/t4RD/diz07IXXDjDETokXEfrZ1Gvofcm30D3nLOxJ7MlMeJEQ2dawqZy0Zww0psFsiKunLmV5CQ3ADIg7F1+iXEe//kKn02yf+1BN8myHYiZMGKt4IqnjlgrzejC+hg9FxjJKUenvnHjP+5sTyYG+928kqdBk7qw4TdaB4UEtRTCS+fuCL5lL0p8KZ8FgawnArl2vLtE+AkAz3PGRGVgIeVWPJaqUbjcCk7ilnvMKu+Pj+wfW+604jEOa844Bj54fVV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI00uYiEbGSqDjtNwm1MlmM9VSxRXFSfg26C/EQPRcQ=;
 b=koZ0ZgOmuqWvhV+yvYovr17EPTtoeqgEMeMZYpj5zQla0vZ/d7wx7ZNqMelUW1Vw4MLpdgHeLwNxwOIfyQ26jZK7WcopmyrysoNXi1Ly2tEEFhlMkcvOWWB4lDcnrmVaEDHhhjMfoxDrFFqioXJZ7MYlQs8Rg9QHpU/mQjwscmMXfuIOwwaWaeLPNHaVqPNCUK3xMvW98EMtFaWjdPGs+7SxD93H8oOE08hPNJ3KYeEu+s8xG02ZMedDEQSc8h2Rfu9bVpi8EwuJS1UK6IsVu7c6WVMS306X4C6Z8nsiw8LyJK/XQ482VfH37xquAml1duiN30N6kOFA3/c1bp7G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI00uYiEbGSqDjtNwm1MlmM9VSxRXFSfg26C/EQPRcQ=;
 b=sRC7xQRs+o1sJDjUSkWSUosl8D6jzFQOrF7y1k7cn1sIy2KRkVTKQhXa8Qh3NEjVGguNcZPsPgrERb42A6Qjwv90v+Gg3tkQFNpryDyIvEnTFH+E+gVS9/DTMHyZ5y6OUpWrsj2gBGwj0MxomMpIgXDWMfmkZmcf/vK/U63he4Q=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7095.namprd04.prod.outlook.com (2603:10b6:610:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Wed, 13 Jan
 2021 01:16:58 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%8]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 01:16:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH] bio: limit bio max size.
Thread-Topic: [PATCH] bio: limit bio max size.
Thread-Index: AQHW6UnJBbWZvTKpx0iP4pbQi8BDkg==
Date:   Wed, 13 Jan 2021 01:16:57 +0000
Message-ID: <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <BL0PR04MB6514F7F944D70DE024494544E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CGME20210112121356epcas1p124baa93f10eb3400539ba4db27c18955@epcas1p1.samsung.com>
 <20210112115846.31415-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 643e6648-38e5-46d6-5830-08d8b760ec31
x-ms-traffictypediagnostic: CH2PR04MB7095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB7095EF7EC88CD76852684C73E7A90@CH2PR04MB7095.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuF17WVog9wpjnyr0OD5nfnPuiuIRjFEzLyJB89yVbHZ3PCle/IB6sU/HVbeYC2gRgo24WjdtoTJWbEoXNxXGdUYTBbOteLCHPrJi8SisTD5lpYDidxiA4BF3gYiadUFlGVxncWnBCcyK95SL9im0hdavFGpp26cgfMK9GNCBmAIC43pxT05GaUkfSAGTK3JecBz9QNFEVIR52t4HwQfPFrXu2aruwD6PCqShvayqgTyvTYLNF8gRCosoebKgwryzq+QQ4vvs2qFsuiFthir5+FJctDzEhu8EQIfACa3BwS1SU2gPY1F+CkaRIOpbm91H3kC8fvOmhrxqOWDkIJF8ENVGb0pH1w/QKxRIjbermpwTKmUgdSAjE0Gn2LYv2PEQpDZ7CZ/FVsaCTYQ+413dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(6916009)(55016002)(66556008)(186003)(66476007)(6506007)(7696005)(64756008)(91956017)(53546011)(5660300002)(86362001)(478600001)(66946007)(52536014)(54906003)(71200400001)(83380400001)(316002)(7416002)(76116006)(4326008)(9686003)(2906002)(66446008)(8936002)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?okymbaTcrQIM9oGxUY/kYaKtibbx3vU61c/jGF97M5xeKH69/p9BCuXTzWnr?=
 =?us-ascii?Q?hcW1jWE2+5spFiZnF81LgVFP8YGhoaA2IvwrFRy383ODigPL4TJgWKwWwi7p?=
 =?us-ascii?Q?D17L/InaIgi+5fiHpESByuEM+J88c0S0vLMEurNKgawi3GjHXoGZ5ZZWI7HX?=
 =?us-ascii?Q?2GlpDKqYXwcEf4mo9532Dt3gZiSM/7BnjdAGbhj57aXcCgvgmkrwY+JKUBYE?=
 =?us-ascii?Q?K0Mf4lNUh8787Pk0WuLWoL1d1+m4GZO6Ywb55wQ52qqoO6CD4Y8X+4Z5VTVr?=
 =?us-ascii?Q?yNud3cL3EWGv439ljJo8zUkB1UEUl/j1wCqUJ/f2ftt/vN/0xhwx6W9Xn6ks?=
 =?us-ascii?Q?MksAlTEfJBtqv8qP7H73aCWCeCpqHbNb+4GFMXE/H/zNnCFa+ENIBfKQHSzm?=
 =?us-ascii?Q?LOJLK9umKXMSS+2l+rR9ldLyUcKEi5fiX7U52mPmYoVqM3KIbn30roae8Ptu?=
 =?us-ascii?Q?HxUkV53IF8VISZn4MPQ6e0ltDCVuFAJcmvjIqi1C1jaxFXhf0PJDr14DvWjH?=
 =?us-ascii?Q?dWaticmY/+iBT3blpZ5oTludxAGxjcHZ3J9TRwc1bVan2JWPAYXiurkiQKcd?=
 =?us-ascii?Q?PYn8DsruF5tXvzaA2YjGSh14Nj+T3S0LMRjnPc9GCyk6MqCja0dZr/5dbF6Y?=
 =?us-ascii?Q?Tq/DT21EYOCbesXJfA+n277xJJ7bLW5H9YtXRzxP3fXu4Saomgu8voAwqctW?=
 =?us-ascii?Q?3Ou2br30LorLleDSWGLGt+/n/mXxJ8iuhHNXM24FiD73jnkh5nyIOHFUsHrP?=
 =?us-ascii?Q?2PTcNwZbxR/ALayFwoT6+pu3c7R+sOpUKLaTnuFcK/MCC1p+ytuw7KXjSWNN?=
 =?us-ascii?Q?3fjbla1DMiTbc8xQv7zI/E3/TaodU/z0o3MDsYUHMKlHKWiH4vYCwsajRAdm?=
 =?us-ascii?Q?iCIitqu0wCp2bygezYMuXCZX9lIn6raYh+n2kBWvnCF2tfGe9Nslx4bvqRaz?=
 =?us-ascii?Q?C07IhaARL5hcSyZpc6Y+GgQ4grrmT30T9m4o1P8flfnvMBDvTvtgFM5IkZdL?=
 =?us-ascii?Q?UXpVmghFEVErYn+avd8p3evz2uO2iJjQUR/0gMxKXcUK9bUjs8hvA9buM2Mr?=
 =?us-ascii?Q?1wR4+q/z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643e6648-38e5-46d6-5830-08d8b760ec31
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 01:16:57.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmmsX3cTtJAR5RaHa5eaWGPuMvHLWE3n+vhmoYKDHjM4XM43ZTTaKjpLohVc7f/vD8lxLFMRwIJusiT1oPWp5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7095
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>=0A=
>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>> but sometimes it would lead to inefficient behaviors.=0A=
>>> in case of large chunk direct I/O, - 64MB chunk read in user space -=0A=
>>> all pages for 64MB would be merged to a bio structure if memory address=
 is=0A=
>>> continued phsycally. it makes some delay to submit until merge complete=
.=0A=
>>> bio max size should be limited as a proper size.=0A=
>>=0A=
>> But merging physically contiguous pages into the same bvec + later autom=
atic bio=0A=
>> split on submit should give you better throughput for large IOs compared=
 to=0A=
>> having to issue a bio chain of smaller BIOs that are arbitrarily sized a=
nd will=0A=
>> likely need splitting anyway (because of DMA boundaries etc).=0A=
>>=0A=
>> Do you have a specific case where you see higher performance with this p=
atch=0A=
>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and t=
oo small=0A=
>> considering that many hardware can execute larger IOs than that.=0A=
>>=0A=
> =0A=
> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB=
=0A=
> is merged into a bio structure.=0A=
> And elapsed time to merge complete was about 2ms.=0A=
> It means first bio-submit is after 2ms.=0A=
> If bio size is limited with 1MB with this patch, first bio-submit is abou=
t=0A=
> 100us by bio_full operation.=0A=
=0A=
bio_submit() will split the large BIO case into multiple requests while the=
=0A=
small BIO case will likely result one or two requests only. That likely exp=
lain=0A=
the time difference here. However, for the large case, the 2ms will issue A=
LL=0A=
requests needed for processing the entire 32MB user IO while the 1MB bio ca=
se=0A=
will need 32 different bio_submit() calls. So what is the actual total late=
ncy=0A=
difference for the entire 32MB user IO ? That is I think what needs to be=
=0A=
compared here.=0A=
=0A=
Also, what is your device max_sectors_kb and max queue depth ?=0A=
=0A=
> It's not large delay and can't be observed with low speed device.=0A=
> But it's needed to reduce merge delay for high speed device.=0A=
> I improved 512MB sequential read performance from 1900MB/s to 2000MB/s=0A=
> with this patch on android platform.=0A=
> As you said, 1MB might be small for some device.=0A=
> But method is needed to re-size, or select the bio max size.=0A=
=0A=
At the very least, I think that such limit should not be arbitrary as your =
patch=0A=
proposes but rely on the device characteristics (e.g.=0A=
max_hw_sectors_kb/max_sectors_kb and queue depth).=0A=
=0A=
> =0A=
>>=0A=
>>>=0A=
>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
>>> ---=0A=
>>>  block/bio.c         | 2 +-=0A=
>>>  include/linux/bio.h | 3 ++-=0A=
>>>  2 files changed, 3 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>> index 1f2cc1fbe283..dbe14d675f28 100644=0A=
>>> --- a/block/bio.c=0A=
>>> +++ b/block/bio.c=0A=
>>> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct p=
age *page,=0A=
>>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>>  =0A=
>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>>> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {=0A=
>>>  				*same_page =3D false;=0A=
>>>  				return false;=0A=
>>>  			}=0A=
>>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>>> index 1edda614f7ce..0f49b354b1f6 100644=0A=
>>> --- a/include/linux/bio.h=0A=
>>> +++ b/include/linux/bio.h=0A=
>>> @@ -20,6 +20,7 @@=0A=
>>>  #endif=0A=
>>>  =0A=
>>>  #define BIO_MAX_PAGES		256=0A=
>>> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)=0A=
>>>  =0A=
>>>  #define bio_prio(bio)			(bio)->bi_ioprio=0A=
>>>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio =3D prio)=0A=
>>> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsign=
ed len)=0A=
>>>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>>>  		return true;=0A=
>>>  =0A=
>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
>>> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)=0A=
>>>  		return true;=0A=
>>>  =0A=
>>>  	return false;=0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
