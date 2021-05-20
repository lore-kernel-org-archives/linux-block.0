Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3DC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 06:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9938361184
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 06:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhETG6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 02:58:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1038 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhETG6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 02:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621493833; x=1653029833;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9iGMXv5ArJLB/a5vOIShcjOX6nR1B1L9iOGX/yv+H3E=;
  b=Z2lZuDZB95kC0SWmEqkxJ2ug2DrjN3z/GtCe2N2WbM+E0JEPvY9Yw8dE
   jf5RK+0iWgjvlZlcWmDkbRhUqYAtRvyO94PGyg6iRMkTdfGCgIcwfSqa4
   WrgKW7Gb3to6/JFRUdDfGxqfIMyVlu29BalCHYL952KjanJXTRUvalkV9
   Wn44maGvy6CIf/QDEDDCtVsaMzHqyXx4ALU0Jjq25NXH+86f71KJY62zP
   mDOsYE7Ha5qmy4RXWNTKn/S83NtzgIM5P8jX/ds7qTF1MThwmsWcLth5I
   17LOUWK7DbdJNnv5qMyvibKV1pnnPZN+w/GS/zvrs9aRwOG9ZIbWdrox9
   g==;
IronPort-SDR: EOqP2ITmTr3dYklgrBhocwz4ph9m0MVkmeB1fFz5DSSRGBDKAwMyiXJAyZmFp4E76I3t7Yqug9
 K90vT2IWi7x1ncWKCJHDdSnFkrs3uCHX8KvPMcAdQZHHz2+uAz0cGMPwPTTyXctbuZHfLSJeq5
 wzNGvnP9dNSxlX0lmfJQcsNFnYG62sepQu4K3fcmPwU0BXiOa7dh0pTlcm/05XcRx1TjJIneBs
 Kq3F7xaRSNytnL1gv6u2NdkzLSMMOf0EKueVdMo6I01SLyq4z7DmplIKf0Mo6gTO7sFKdfoFr1
 Aa8=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168811000"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:57:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxvDrVXHyoZ2DO2c/KqbUxKdhOcIUcS35aVMdgAsz+xFHWSqhIPzqJxwpR8c5kG+oXlIiQ2EKORRJVxwxhk3ANb7uSmQ2De6g9fy8ZZo3IXEh8KiRjE4HuiDHuQbvMD+YvjBXhaybn5qye/qXUQdCYrjz7t7K08Zzp75EYAFvbkBUvwGSJLIkR6vFCVZRqpnip0oW7KtBKdF8D9tyj5ODpt2lBf35h14QmWCpv3HFlKE5gF94AAN3/k8eRJkrCrxdXsevSIt590OqV1dhNL1FPbUroSxCVAV6XXB1HKlbuYSoOsyHg8s+VAIFycaDrK47cdVcnchOic6LSngB281Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPG3x1uS8dlEJS2xSangT8AMXvjR2w8kOJ8uKE2q5bg=;
 b=HqYY6IOChp9E0PFKFn7FVj5WJqHpb2Rf6JZVXjPV5CqlIdNtc2i2BrHgF5bhSYCjBQFNtEvHTi2zg0jRi9S2Q9cJe3rRQ1jM9g1PU0HtaiA6rg4E9oiuizLnw9aviUcE9Jj5m/JMlDVgVIzUmpzHcyI0lH1SrRKch6kiKuu4WGFgAfg6dOwA67l8+duFtZCR/4LAYmhvLB3v4XhgFWVFyMFrXFnWPPiq0c+ZdxJfCN17jPmFaGB1VLmuBcG7a2RMsPRWEoQhquLy6AiuBRxtOAyBEoMPEL8ZFK0aj2a2ARlIos3LIiabSVowNP02vBnMTV+EuMOIgJ2w5daS5BOs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPG3x1uS8dlEJS2xSangT8AMXvjR2w8kOJ8uKE2q5bg=;
 b=SRXtqeqckgHBRoFWTyMOpi5fm1QHdibAD3SPwFDZ/RciiPprV4albyEr5opM+V2OmHbofOEBLLmT/16bBvILf8TPphDecRw2xccfjdci0gRgEOMcYPS8Tb8jZsQv9YSxjimPUAQRuFrP3a18tv4mIuGH7U1NDr9tNIjqJb5BDkY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5884.namprd04.prod.outlook.com (2603:10b6:5:163::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 06:57:12 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 06:57:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 10/11] dm: introduce zone append emulation
Thread-Topic: [PATCH v2 10/11] dm: introduce zone append emulation
Thread-Index: AQHXTS/HzFxr6ld09EaK3LHUbCl8CQ==
Date:   Thu, 20 May 2021 06:57:12 +0000
Message-ID: <DM6PR04MB7081B0CE6B5CCAA7B11CB434E72A9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-11-damien.lemoal@wdc.com>
 <68203e46-01bc-011c-ab8e-9c94ca60adce@suse.de>
 <DM6PR04MB7081B70FFD57914608B0349AE72A9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <be8be72c-0272-2969-ec46-ebb01db9d2ca@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d5e8:c272:2ab7:c99a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7450ac4-26d8-4f55-bcfc-08d91b5c7ede
x-ms-traffictypediagnostic: DM6PR04MB5884:
x-microsoft-antispam-prvs: <DM6PR04MB5884AF59A5AD6D71CD97E606E72A9@DM6PR04MB5884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfUrxYcYq9Dij/3TG0JywGwCVq9s1LTeZNa0X31US0TlI6BpGye+LABdw5OHsLW93Vz9FLjd236bmoVG8GwJu0skbnGmPG1Q+a2GTTPxv9l7OgliHKRgq0nLUlHkWaVikpfSebH7C59oDe0uS5/kZmAiox3kkVEmfRMJmINHwvBSu07LAqdmRLxG4Tqmf+lKmBQa1afy3VqY3mL0Aa8fL7LjDhawtzEH1jEWnl7oUEk5kucKSuk+dh0XHSh3LrwZVNS9gFi/l5udend0IIcmJR3WxzfAap/hd4urvxMcyUecDmBdIrZNJw89xvIA/X9YI5cEI2L2ozUVrGBTG7LAcHPkPlLT7Zm0I7mVQKYbtS6Eq9BZ7TnkowPGv2dNFfmW4P2WOeB3OuYuPjs0lABz2XW2sFR2vYg3rlULYerpCksEc6qlPDIPsE1bimcJnR9eh0rOD68KLZwSJALLGx1mjnNtwU5iy7Kr5NwFZ0FKRG9hXpSa5k6pyEK2pc1Oj7qTYPZOWylEc1PSXE8V3txXHzmAiq02qTGCkY/wAxim3EQn2nasWh3zvmYFjRmn9sa2zfNeOOIG04Cj5Ws9HcIQD+2udmdaKMtj9T7RpSwaLZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(5660300002)(2906002)(110136005)(316002)(91956017)(86362001)(83380400001)(33656002)(53546011)(6506007)(71200400001)(38100700002)(9686003)(7696005)(52536014)(122000001)(66476007)(186003)(76116006)(8936002)(55016002)(66946007)(8676002)(66446008)(64756008)(66556008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bMTHETSK5XdRreWHNCxtUxQ/EiJTe1aNg2uzZW0o5OmezWyVPkXoZ8VpBJwX?=
 =?us-ascii?Q?lHEpiAg7DTzQgvV0jaK5aM+wzDknrK5Pe9i5FVXx0JeR/om0ogyZ1IRtqHde?=
 =?us-ascii?Q?uDbuiFP2XXFqeOTAQJy1Yxjueq5iJEgZDaoS6y7R35/egQYTZeM3ct+aD4Vj?=
 =?us-ascii?Q?7p9iF5Z81bdkqp8VJOhXavyJ4r/LsZ2uTqvucW1OBuCwPdT0D3fbYbcZlxqf?=
 =?us-ascii?Q?RRkadQyesLgC1S/OpVWTHiAMv9IkanQeWqWhl5GBb3LRFpghrWtmba5kQHkq?=
 =?us-ascii?Q?jYh7xRGzs0fhischZSY0V58ObQFNoGd/OoTczFLeHwnEK8c5c38encY0h0NP?=
 =?us-ascii?Q?G5GE3a/A8YECuDcJOuyet52lpl3686J7Bcup9NRTgGTD6HsPNDeJG+n2th4i?=
 =?us-ascii?Q?vbGZ8n7SboL+bOMT1cSLqgbGHq7Yfyk//SIRQnhULZjEuA+P02fgU2eBM16G?=
 =?us-ascii?Q?tN+d3e8JSdBaZMQJhlmSt5Sbg9qi54wx8muq3f18o69j0FpKOMoesc9Kccrk?=
 =?us-ascii?Q?TAnpFTDL6MOSAbWGxzFXl3LwcHI6z2cbF5YqhLSAzTaLTht5xZ283T3e8aod?=
 =?us-ascii?Q?I6SQGfKweAqt05XJP120C3L2Ege3R3fZ4GrZBJcO78nEwC1Qpg7bkpstl+AH?=
 =?us-ascii?Q?bp4FH/X3RyUHaauMr2p1hpf9gkUUGkInm0DLzPqB89t2sfe+cior9BMBbF3L?=
 =?us-ascii?Q?FJM5Z0yXt42umC4vDqcPTw+zN+Tle3jxw+dB9eR+/h4Hi23SQjf53P/kDg1y?=
 =?us-ascii?Q?aEoiZVAmoya9TwlcQu3LiAYuhqSR69t7dDYZfDSqiM5shVVaZzq4oGy+y9NO?=
 =?us-ascii?Q?RcyiNq7Qo8yqFtXNAGUbR//6ALMDJziEcxFL4Uw7ek+5w1WoUZzzhcmfvHsR?=
 =?us-ascii?Q?m69CbEy7kWkIJPLYNMoyYlPCNTlzd32Ojb2dAT3n9OKBP6bhZuBDXJwL/0kg?=
 =?us-ascii?Q?2ft8WdBdnZlAEiy+KilbwAx9x92CFCvSSWQKat2zl1D0iYEnSfIbz4hlsVHw?=
 =?us-ascii?Q?5wjsqGTVAaFhwDDWcq5HyrYwKZDg3yacQeWlSX+DiRc9HRC+TfResCNIZQcY?=
 =?us-ascii?Q?08jJof7jPp2vQXSHz8e7IJSlZ5quoBhLu+3Jpzz6l23VM6g5VVGbjWsS6QOj?=
 =?us-ascii?Q?7TPWGagqPvmwncxwcHTECqNzr9wQsAl4//QJMZlJIegk4HpFBYOL9MNw4B+d?=
 =?us-ascii?Q?DsHeL3afzK51o4PwqoT97pzKxJdd4dbI7sBn+a+svNsFwHwmoTFIaQMcgTdo?=
 =?us-ascii?Q?X9HJ7ntcylWspyYJP6yo/iczj92onoaO7PMWQwgn22Hl/LO012ajavdIxc2l?=
 =?us-ascii?Q?qpRyqEEJvgnvRapaE1mEYl32+EpkafzZ7UoyhoiJCxVs+nDBZw5zOFMDAdSc?=
 =?us-ascii?Q?z4xYE1ZRhXjic2+hj3JUqp5UToOO4P/zLCDvPBh+XCHxoIjhSQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7450ac4-26d8-4f55-bcfc-08d91b5c7ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 06:57:12.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5acpR1qHVXw3vBdf47MHeVY/DQDEPPRLOx+zpS/dyQN40CUbhEp9fBJAeCRPLTVHB2ervVOk6z0phwSkcI/tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5884
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/20 15:47, Hannes Reinecke wrote:=0A=
> On 5/20/21 8:25 AM, Damien Le Moal wrote:=0A=
>> On 2021/05/20 15:10, Hannes Reinecke wrote:=0A=
>> [...]=0A=
>>>> +/*=0A=
>>>> + * First phase of BIO mapping for targets with zone append emulation:=
=0A=
>>>> + * check all BIO that change a zone writer pointer and change zone=0A=
>>>> + * append operations into regular write operations.=0A=
>>>> + */=0A=
>>>> +static bool dm_zone_map_bio_begin(struct mapped_device *md,=0A=
>>>> +				  struct bio *orig_bio, struct bio *clone)=0A=
>>>> +{=0A=
>>>> +	sector_t zone_sectors =3D blk_queue_zone_sectors(md->queue);=0A=
>>>> +	unsigned int zno =3D bio_zone_no(orig_bio);=0A=
>>>> +	unsigned long flags;=0A=
>>>> +	bool good_io =3D false;=0A=
>>>> +=0A=
>>>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * If the target zone is in an error state, recover by inspecting th=
e=0A=
>>>> +	 * zone to get its current write pointer position. Note that since t=
he=0A=
>>>> +	 * target zone is already locked, a BIO issuing context should never=
=0A=
>>>> +	 * see the zone write in the DM_ZONE_UPDATING_WP_OFST state.=0A=
>>>> +	 */=0A=
>>>> +	if (md->zwp_offset[zno] =3D=3D DM_ZONE_INVALID_WP_OFST) {=0A=
>>>> +		unsigned int wp_offset;=0A=
>>>> +		int ret;=0A=
>>>> +=0A=
>>>> +		md->zwp_offset[zno] =3D DM_ZONE_UPDATING_WP_OFST;=0A=
>>>> +=0A=
>>>> +		spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
>>>> +		ret =3D dm_update_zone_wp_offset(md, zno, &wp_offset);=0A=
>>>> +		spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>>>> +=0A=
>>>> +		if (ret) {=0A=
>>>> +			md->zwp_offset[zno] =3D DM_ZONE_INVALID_WP_OFST;=0A=
>>>> +			goto out;=0A=
>>>> +		}=0A=
>>>> +		md->zwp_offset[zno] =3D wp_offset;=0A=
>>>> +	} else if (md->zwp_offset[zno] =3D=3D DM_ZONE_UPDATING_WP_OFST) {=0A=
>>>> +		DMWARN_LIMIT("Invalid DM_ZONE_UPDATING_WP_OFST state");=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	switch (bio_op(orig_bio)) {=0A=
>>>> +	case REQ_OP_WRITE_ZEROES:=0A=
>>>> +	case REQ_OP_WRITE_SAME:=0A=
>>>> +	case REQ_OP_WRITE:=0A=
>>>> +		break;=0A=
>>>> +	case REQ_OP_ZONE_RESET:=0A=
>>>> +	case REQ_OP_ZONE_FINISH:=0A=
>>>> +		goto good;=0A=
>>>> +	case REQ_OP_ZONE_APPEND:=0A=
>>>> +		/*=0A=
>>>> +		 * Change zone append operations into a non-mergeable regular=0A=
>>>> +		 * writes directed at the current write pointer position of the=0A=
>>>> +		 * target zone.=0A=
>>>> +		 */=0A=
>>>> +		clone->bi_opf =3D REQ_OP_WRITE | REQ_NOMERGE |=0A=
>>>> +			(orig_bio->bi_opf & (~REQ_OP_MASK));=0A=
>>>> +		clone->bi_iter.bi_sector =3D=0A=
>>>> +			orig_bio->bi_iter.bi_sector + md->zwp_offset[zno];=0A=
>>>> +		break;=0A=
>>>> +	default:=0A=
>>>> +		DMWARN_LIMIT("Invalid BIO operation");=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	/* Cannot write to a full zone */=0A=
>>>> +	if (md->zwp_offset[zno] >=3D zone_sectors)=0A=
>>>> +		goto out;=0A=
>>>> +=0A=
>>>> +	/* Writes must be aligned to the zone write pointer */=0A=
>>>> +	if ((clone->bi_iter.bi_sector & (zone_sectors - 1)) !=3D md->zwp_off=
set[zno])=0A=
>>>> +		goto out;=0A=
>>>> +=0A=
>>>> +good:=0A=
>>>> +	good_io =3D true;=0A=
>>>> +=0A=
>>>> +out:=0A=
>>>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
>>>=0A=
>>> I'm not happy with the spinlock. Can't the same effect be achieved with=
=0A=
>>> some clever READ_ONCE()/WRITE_ONCE/cmpexch magic?=0A=
>>> Especially as you have a separate 'zone lock' mechanism ...=0A=
>>=0A=
>> hmmm... Let me see. Given that what the bio completion is relatively sim=
ple, it=0A=
>> may be possible. With more coffee, I amy be able to come up with somethi=
ng clever.=0A=
>>=0A=
> More coffee is always a good idea :-)=0A=
> I would look at killing the intermediate state UPDATING_WP_OFST and only =
=0A=
> update the pointer on endio (or if it failed).=0A=
> That way we would need to update the pointer only once if we have a =0A=
> final state, and don't need to do the double update you are doing now.=0A=
=0A=
Good point. That should work. Definitely more coffee needed :)=0A=
=0A=
> =0A=
>>>=0A=
>>>> +=0A=
>>>> +	return good_io;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +/*=0A=
>>>> + * Second phase of BIO mapping for targets with zone append emulation=
:=0A=
>>>> + * update the zone write pointer offset array to account for the addi=
tional=0A=
>>>> + * data written to a zone. Note that at this point, the remapped clon=
e BIO=0A=
>>>> + * may already have completed, so we do not touch it.=0A=
>>>> + */=0A=
>>>> +static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,=0A=
>>>> +					struct bio *orig_bio,=0A=
>>>> +					unsigned int nr_sectors)=0A=
>>>> +{=0A=
>>>> +	unsigned int zno =3D bio_zone_no(orig_bio);=0A=
>>>> +	blk_status_t sts =3D BLK_STS_OK;=0A=
>>>> +	unsigned long flags;=0A=
>>>> +=0A=
>>>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>>>> +=0A=
>>>> +	/* Update the zone wp offset */=0A=
>>>> +	switch (bio_op(orig_bio)) {=0A=
>>>> +	case REQ_OP_ZONE_RESET:=0A=
>>>> +		md->zwp_offset[zno] =3D 0;=0A=
>>>> +		break;=0A=
>>>> +	case REQ_OP_ZONE_FINISH:=0A=
>>>> +		md->zwp_offset[zno] =3D blk_queue_zone_sectors(md->queue);=0A=
>>>> +		break;=0A=
>>>> +	case REQ_OP_WRITE_ZEROES:=0A=
>>>> +	case REQ_OP_WRITE_SAME:=0A=
>>>> +	case REQ_OP_WRITE:=0A=
>>>> +		md->zwp_offset[zno] +=3D nr_sectors;=0A=
>>>> +		break;=0A=
>>>> +	case REQ_OP_ZONE_APPEND:=0A=
>>>> +		/*=0A=
>>>> +		 * Check that the target did not truncate the write operation=0A=
>>>> +		 * emulating a zone append.=0A=
>>>> +		 */=0A=
>>>> +		if (nr_sectors !=3D bio_sectors(orig_bio)) {=0A=
>>>> +			DMWARN_LIMIT("Truncated write for zone append");=0A=
>>>> +			sts =3D BLK_STS_IOERR;=0A=
>>>> +			break;=0A=
>>>> +		}=0A=
>>>> +		md->zwp_offset[zno] +=3D nr_sectors;=0A=
>>>> +		break;=0A=
>>>> +	default:=0A=
>>>> +		DMWARN_LIMIT("Invalid BIO operation");=0A=
>>>> +		sts =3D BLK_STS_IOERR;=0A=
>>>> +		break;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
>>>=0A=
>>> You don't need the spinlock here; using WRITE_ONCE() should be sufficie=
nt.=0A=
>>=0A=
>> If other references to zwp_offset use READ_ONCE(), no ?=0A=
>>=0A=
> Why, but of course.=0A=
> If you touch one you have to touch all :-)=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
