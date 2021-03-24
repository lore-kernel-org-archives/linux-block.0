Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496FC433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA21619F8
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhCXHHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:07:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhCXHH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 03:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616569648; x=1648105648;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aFZQauMNi+pN4c/Ew3CLEutGYOBRnqk6x6Bleu/xGy8=;
  b=TI05/+Qoua6f+Gv1HvU3+zoa/wzLIzPkdGdrp5KWG9C1ExQWorqpNVDS
   h1JA2TyinGDQ1lnfUHaebnSGgu2qhlkMPSERRFtkZnOk1hgzNSbXOqoJY
   0ggm8zXUPSFYsSUjJC6CTch7EEPuiNQ6+Nzxp8HepfkxBUbB6RxCINg61
   HSuCypF9uxZPBYyJzQxy6AMjSkrLtm0/Q69Jan57wsJFP34Rt6cjNhuw3
   cfDdDN32iFkduf+b8FVv+YGzFxvsJrlDXqNJS79iErsjTf9L22ekYIC6q
   gKtbZw5Yifga2rpvjGDNy/EmNUbSMfRt/SDAQku2UcxzFnttFKdhZGi+6
   A==;
IronPort-SDR: i4YbWf6KUzJ0Gy4AJg+9ovEk3zZSxqrj6fzETX7kueeI0bQk1PmCr1Mscs902BmO09hrppUFLw
 XfV2y2ZjsAwi926JWb8vbuOx5SzPkI8XPGlggZKsUCDAW849Ow36ZVv4uZO8pbLaKbzDbaL6bZ
 Y8zfLMe9CLmZ/68zFOf6Jo3gI384Jo6bMd7je7kKkbynZFWJdMWQ7D3Qfs8rU9l94dnfC2saHI
 A5RPIpWtqFWePk9kHqIIP7TD8yRSiNvF3tYLHix+Yu1ejzRuOSKlJZPXAQ2Mify81Ik5lpXy9j
 OmM=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="273632878"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 15:07:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTyxEmjCRL0hqmuNrGjDAd7o1OlolpJ71zaCTAO3vHcM7KH0cf27mN/Pshm+Q4UagMs/toXEiHWSjJAljK7t13/j/nZIxuNM58cCh0WLz0743ZuUcxc95I+KO1FST3L9sy4HiO7YaFvAzQ2USk13uPTkWG/MzdxP93EfosKP8fwvA/A929KS2tIl5IeYJ9gDHxiCloztwmvduTMDt/3Q7dIAuwseV16fpR/n3p2JkTt7Tcq+hQEio3X2Uv5giZEHAHKbVymXcJBv0XwE3aL6vRMr5Cks4fT07jw+HNSQQ3JkNK4B5PwnTctw/Uzes35+B91g+LeCbcXXmx7DObeENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+9jpLUO1BPSBr/esqa5Y5+X6hI5K054hglDVVDqeG8=;
 b=lzRel9p3rQd2ksLSZPmEM9LftzypnnFbdqM8F8vRyS9dAQKjHyhLL88zMC7jHDDBofYzx3S6lyNRumSHW301U3ItsKIjr6RqVU+OF8vq9loTACIuDi2EU4pcNqkqThKRSjs3dLFL2Ajcyv2N7EvKogLAAeJBONDRZ2ecR9MRBE5j/jG2zLrvG1Nud9dHLb25tRJyL2p01m/MlIF30/QzYOTmJTpu1nEo3WlaXGz/8iaTeGgIABo7vweVRPBG2wSbr1kVbyfrymkONressMM2l1pRpbOrRfyzEVP+pLqQeVWuHE3z+vWmrm3ZLSYlXMNNHpSTKx/BioYRPFmxzImSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+9jpLUO1BPSBr/esqa5Y5+X6hI5K054hglDVVDqeG8=;
 b=oz/bcMtl9LLTIaoxxzoroWQYkIXb+39ZJMyUS7KfBuQUlTzVOGTR4nsS3Uu+M4Z6kvYih4b0d5WrSoyogPwDIGPb6ubu9aPEHAHOEFY/IifdnQhn/wzkWOM+a1RE/kT2H3F5ZMVG5/y9Znp9oguZ5uZOJZbeNi1tefpBlGHGwnc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7574.namprd04.prod.outlook.com (2603:10b6:510:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 07:07:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 07:07:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Thread-Topic: [PATCH] block: support zone append bvecs
Thread-Index: AQHXH9Svt3fpY4sr0kWipTtEnnUH/A==
Date:   Wed, 24 Mar 2021 07:07:27 +0000
Message-ID: <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
 <20210323123002.GA30758@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:49ae:1f03:f20b:3ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 777927fe-6e88-490f-5e12-08d8ee937bb7
x-ms-traffictypediagnostic: PH0PR04MB7574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7574490B8AA42BF1E243A4A99B639@PH0PR04MB7574.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H46U960IeneXeEdjGdP0uS/BIK79EFiXJLHPvBdWBy+5iKydOebAaRvDrxbH7/vQzZs7Cv+yquBaF6mkLW3hqKa+CGnUAIaf3AoGYbcd53mnoF/clfj9GmqGiTBVJpC3jNIW4RYPu4q5w/o4I3y36jEUDf0KYjafpt2RbWjzlgZHwddsk6IUCDoCWvjbt28HcfyzwaAK4BNDtZR+ArnIlefHcDWvLQQ5wvMkRh9oNc4PwGFDT6FKWLB2kbny295Wr4w5v02Ri54lEEq4vvNZRVkTgkPgLxaTnkYY04w9+PA9OGX+5Kq3qvs1iZZBghxuBFt1NttYIosc7/whNBm/rGZe7EUwDanXz1XXjl1duxi7v1x4lKaIAbmop+I22IajuIyhoSMnkq/ea1Lo5z4ii4lNzi6w753zZNyOycyI2peNjxX/QckTAlCfCweUtE7ilOEMl3cITIvuOnf0UZ7KavaxHKA9ZqISXmvoYVrWrn4YajFSUSWcP8LXIZNQdTRYtwPbpvPG8/MMJDXpoHBY/9vALrnB1SLrENHdedmhfBeiEr7RjB7K3bQnocad+Fgj7Iox//9tRPr71m4FCqYOmmvozZ4mrrz1Ltj+Jksnhfx19UuqYMBUE/PhdZXiaDnZokedgK6l/Ww5AWgOAxi5EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(64756008)(86362001)(76116006)(53546011)(478600001)(71200400001)(66476007)(66556008)(83380400001)(38100700001)(6506007)(33656002)(2906002)(66446008)(66946007)(91956017)(316002)(4326008)(6916009)(186003)(52536014)(5660300002)(55016002)(54906003)(8676002)(7696005)(9686003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CiUZ3AKnoko0/ETay1cNg9U+qwaC8Y7/KwTAzRCQV9RPQIwyN4rEi4eijDP+?=
 =?us-ascii?Q?BWurYuo85fx+bx/3Wk7WkwBqgPr6sKBC0AOBmrRPxYZGAYng6lmiZ6auDsnY?=
 =?us-ascii?Q?ZmHDHbekawnKsJ4A4+w1Q1jolEDrWRHZelJG6Pp/UD2Y0z1nck26D0GGsWo1?=
 =?us-ascii?Q?WBFP6PIKjCgpwYNR8E/JwGA2iwDHGPGk+fF0Z/5cn1B5wxB/P9Km80e60hKC?=
 =?us-ascii?Q?E8VdWwEVsl/FcIRoWynbmP0GL4ywRjRdHvMc5E1O2QpgpJ9In0LWDAfLTsM6?=
 =?us-ascii?Q?hl6ywLj+vrg4MVa8ZFN3nntrKOSkaY13fX91Tr3ie9N6h5rG4p0LrwUWUzG/?=
 =?us-ascii?Q?PCmKODxCXBEnvgrrX0A8BSczw0KEaT1x1zirCkPaByilRULD5OKMtVW81zBK?=
 =?us-ascii?Q?DpNfElMjmx/MbtJ6+6pcXbpnM42LYSW10ONNMFwQ0HhDUYuLffF2xjRwCBdr?=
 =?us-ascii?Q?zi/Wq2RwyOr07T/oeYNCKLQO4FLSX002lSJ/dw7a+4pF9n1IYNwvfzeTG1dN?=
 =?us-ascii?Q?HJ+y3Gs87J/COU+6WVI5VgQ+8nAGeeUhW4cmaPyC/y1Bv9WzaCLYvzwbNCOL?=
 =?us-ascii?Q?ZR82OfJjhfZkLQkwfieVQP6W5j9DDmoR8NyH4Kr9TPk23atPVIkX8sND7gKf?=
 =?us-ascii?Q?U0ICePbl2vDHgVk+SGLmKdAlDIAyIfWggOczGbf8yAyLI/M8/8i/PFE4RHtA?=
 =?us-ascii?Q?Hk5E3tAOu+adS36PcOu2Y0lAGcsJArAcM07x0Wd1AamnuJZwyeQHFFokMZ8H?=
 =?us-ascii?Q?U7+6+FbS8K7lPt+MVdq5ZWoV/KvbJr2giEWDVX+vIXOW1eRjmoqB50lFVnZa?=
 =?us-ascii?Q?ROIQWY9qpbnJ+3kUSxpJysMNHZA3KwX64WQpUlCVFc70+PwnePk33MZkx5Ii?=
 =?us-ascii?Q?ZNVbAYgqTi7eroOT5tYdVJw/ZsLoBqz38CS416JzOhuS8JECu6kLgBzXnlTb?=
 =?us-ascii?Q?emZvj8w4BcZILRGmWjiQ4pFEdCu5eAkkHt/VnEIpgTPl0cO+PooqFZ/j+CKt?=
 =?us-ascii?Q?iqygnaIKP6Z69FWXZ2PxN8o/yO72mfVsNDOCqcQvEgi8rZnZMPRnDT3v9dgJ?=
 =?us-ascii?Q?Osd97gs/Ako4PkJIBC9A9VjMy67MaDKVckM3fTWreXcsglWiXApLZ0ic4+jr?=
 =?us-ascii?Q?EF3S84dGiCcNHBlaba9EPD6Zo6qnEaiiJ60DJcgGYumOSrONOo1ap5p8vEDq?=
 =?us-ascii?Q?IorTWB4SxKBIAiI0e5ovvXxp4y6H9yJIMgqS6FwPNHdjCiCttdibFG5MWLT9?=
 =?us-ascii?Q?ewl4uaFZEB1wMdloOgO9VlG2pw60IeKraXTYfRqHwVpXnWoEj+9G/+0EidrS?=
 =?us-ascii?Q?BxE3cCz+cCUJzxJKPYLLTSi4bKMoGCdT6Eh9ne70VCuu/czsOhxClOTYsT70?=
 =?us-ascii?Q?sQNW9GGLdMaGNsIZgcf06HU91GhI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777927fe-6e88-490f-5e12-08d8ee937bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 07:07:27.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLzJGJ4tOFCUu78HHunTTa9bkbxBxYfVqmiJDirup6tIrHCVpmpP+QPehwE+vJKt36Wkm0fon/IFUL9BldYMaIBhw4mb7cNfsUbsU+YCLPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7574
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/03/2021 13:30, Christoph Hellwig wrote:=0A=
> On Tue, Mar 23, 2021 at 08:06:56PM +0900, Johannes Thumshirn wrote:=0A=
>> diff --git a/block/bio.c b/block/bio.c=0A=
>> index 26b7f721cda8..215fe24a01ee 100644=0A=
>> --- a/block/bio.c=0A=
>> +++ b/block/bio.c=0A=
>> @@ -1094,8 +1094,14 @@ int bio_iov_iter_get_pages(struct bio *bio, struc=
t iov_iter *iter)=0A=
>>  	int ret =3D 0;=0A=
>>  =0A=
>>  	if (iov_iter_is_bvec(iter)) {=0A=
>> -		if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
>> -			return -EINVAL;=0A=
>> +		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>> +			struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
>> +			unsigned int max_append =3D=0A=
>> +				queue_max_zone_append_sectors(q) << 9;=0A=
>> +=0A=
>> +			if (WARN_ON_ONCE(iter->count > max_append))=0A=
>> +				return -EINVAL;=0A=
>> +		}=0A=
> =0A=
> That is not correct.  bio_iov_iter_get_pages just fills the bio as far=0A=
> as we can, and then returns 0 for the next call to continue.  Basically=
=0A=
> what you want here is a partial version of bio_iov_bvec_set.=0A=
> =0A=
=0A=
Isn't that what I did? The above is checking if we have REQ_OP_ZONE_APPEND =
and=0A=
then returns EINVAL if iter->count is bigger than queue_max_zone_append_sec=
tors().=0A=
If the check doesn't fail, its going to call bio_iov_bvec_set().=0A=
