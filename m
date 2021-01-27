Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D8C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBCC20723
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhA0G7s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:59:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8870 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317535AbhA0BFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 20:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611709500; x=1643245500;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jp1Tk83nZC1VZXwg692H0eVI/BrlvXtPSd51iJLEZv0=;
  b=LjR2h5/55Vn8otaeocyJj22n9rmM+hzLAdx0h2M92kloB4Sgsws93fD/
   +UsxsVdYluh//jGxrJpRU8vokKd0CXEr81t/X22DZ9lJfKTdGBTV67oX5
   YIH3ykwbGxc+pJUJ4/0xEY4DiGp0gK6GBxGtw+aqlZUKf/eN3NJLcG7gx
   MyJ3RErrUThqT/+81SmxUTrJ3w32LDP/0tGsI/aeNkZ0NmniO7I4c/lBN
   KEaVcBslPDqLvUkq7Pqg6RZBoa7tebLW+Tfy2namUfEebQrQOTUy1+LDz
   iWDZw3EmP1lOHisBAGfEOix5dIdBbTMAxsk344gm9r2LlFL8qIdEIRS7g
   A==;
IronPort-SDR: nm6nNLuG6jy3tEgRxKtI0DkgF6j0X4fskPbgnQy66swPOR8qjbKZEftu6VVrl7ElwjV04TZi9U
 YwW6PdC8RlYVd0VL3e+bOmbc57wePifTZK7K56m/9p7lLj4cyXelJtt4mjmOhEaljHlWnRisys
 6d89UL/Ge7NiIj4dAAiBrRqRg58XEIEg+/NyfW/6pjdJuoMSqZ9ar7tUarxJUoWk0hpUIIiS+k
 l1rALMt7fX6qGTYlUt6+DCp12+nM6sy/x1tm+BJjlf/cw0UiRwsfVs8dRDQNJvxfc9Hz0j9LWS
 icE=
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; 
   d="scan'208";a="162847602"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 09:03:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz+LSVV6Ofwf1BJpj8lUobh/R7IJ8InjoGyTwwd4xd2aQCKpv4aiW1vDnRE49G+nPhgAk+fLinCIkllpzFtLg/meOX1Yh6FmHzU+Svin/Utc8rAXHrY9I/RlGTqPh2wfn4zJetdyKG8OAGsfHc5qgrh3HM7IlfRUNVIUpLylSkgBNm/XBO0mNrRnC4nMr3FHT5lsBspsbBLZSoiqsxeBaZvIsbSmnXc1Vj8B+QBwAicRSfYoGXaFaG4f/AMq/JNg8XdTmjw0LS1a6Rhq/bjqK16MM5ZrSolrsYcR/H1lapYAGWuey7paVAD4Evm7fWnRhh40hooAGxbz5Bem4cdR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VYekWUrEY9e6IiA8dLagj9F/kxMD/R/VsuF15hZl9E=;
 b=fUVxZBEifNEmJ4NXe8O4mNf1m80HbKSauLEdCMdt4nugXPYn4GO6tEg8HjVgNGSoqlp5MMpy0qtf9UdsyOREHB3itYmmQFsJZtg7/lgxbsFI6el6pVJRhA7JI3al6mtTiM3oOEps76UdHa0B2Ufl7ueItvT+11lgfkwxmIjUkfD2xTo0E0sLeOVFNrv7XW/DFmWFnUbkuw9bSOgUE8Yp1cj0P+sQAJdAb2PisEpsPMbzXqiGT3Tu/hhRc+Fn5270bl00ekiC1J8cDvB1+qxRzsA89F6ZwwYVpoytOMh3gh+1LIxUmer1vmdhk+U6Q4vByZTpWGYTVwu1iHxxJJQIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VYekWUrEY9e6IiA8dLagj9F/kxMD/R/VsuF15hZl9E=;
 b=Re1x39wPPKQpr+NZhIImAncsG/sZ1g97qthP42WzVPLitd64b4VKoT/t2blm03Vo3q/qSgW3wyYLH51A1LRrAG6xyboMECnWizmr0/lLL5xx0wmHTAxix/jxV8IAeX1s+QKCndXv6yz7gCW+BUEX53fKOf5qiuY/J4u95fRF12o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4978.namprd04.prod.outlook.com (2603:10b6:208:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Wed, 27 Jan
 2021 01:03:16 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 01:03:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Thread-Topic: [PATCH v3 1/2] bio: limit bio max size
Thread-Index: AQHW88bVafk/AI14qEmQ667BUb4FrQ==
Date:   Wed, 27 Jan 2021 01:03:16 +0000
Message-ID: <BL0PR04MB6514D7392DB2F6B9069A4B7FE7BB9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <BL0PR04MB65147D829369D0E6B45507E0E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CGME20210127003642epcas1p4f167d553fc79ef5029a928550adbebea@epcas1p4.samsung.com>
 <20210127002113.8280-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d5098c0-1529-48ce-a017-08d8c25f541a
x-ms-traffictypediagnostic: BL0PR04MB4978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4978AE20D05B7AF970D453E2E7BB9@BL0PR04MB4978.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jad5Fi+nYk5QlQAeVJ6nPWIvPeWJlaD0PsV4roGBZEe5ZZ+7Afy4SDyiNPjb8sBJINASKUcyzqqb5LsXPQqGgt4UnX4RKAWWGRJhOW7gtvR+ZmYv35lmM/ufdSjOk6Z6BYUw5N3ICPI0oN3lnX3fNMdiW0s2Oab/a/oeZCxrGh82pnhBp6OPSBiC1A0qDdru33ryDBEdbZUWOFcwFuyT6Jot3uzXhsPb4kBdMMQoVH27VDu2mxMYVY+h7ka+pUHsKIFklcNG45oKLzVpMFtJTYffHuxoIs0iyvPdEFh1sN3FY8CSpEXf2/RyD/mcd4xOXNRQvE4vE/NG8URguzvdKiS4J7CTf8YLhsp/G3aDsBWwhmsLVMzxe+4MT+m+qFOc6rTKKxBZPYlEAu+C01K+k0lf3xlY4VfQgacwLxKpn+dEwLCOECyl45Uc7il/X+9XHzzg2QlPs8HlCKdAG89ILRsp3mCLCGf+TanaciVYfzRDKOMMWpUE0ClGS0pd7aqe/t04QtupbZMbTMchsja0+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(66446008)(6506007)(52536014)(8936002)(66946007)(316002)(76116006)(7696005)(186003)(86362001)(55016002)(66556008)(478600001)(66476007)(91956017)(64756008)(9686003)(54906003)(71200400001)(33656002)(7416002)(4326008)(83380400001)(53546011)(6916009)(8676002)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EaGxRf7xQtBxg5ef+FouvdO4Bxz/AvQwFb9qfq8eSVY7MNMS/Ms2KOdJ3x4I?=
 =?us-ascii?Q?e7SndDh5Vyy4MveM3FB2nZOonSjKnxXadwofcgoU+ExbuV9IbdDdeJDUMkcH?=
 =?us-ascii?Q?sjuRwqcqGwJoZJ7xYQiyqNywqO70Q47JF3rvurso34tcoqMjRAg+nFYay/nd?=
 =?us-ascii?Q?PfX+JDTq8T1+AGnHEPrB+WKKbNg5hMVcsP1kb3bah/W/q2k1TsDyMwFzazyk?=
 =?us-ascii?Q?igTcy2fb5rlDs0PzcUUIYW9/SUee+vmtf1f/zZTj5lLRTcWCSwtkCOQC4ceL?=
 =?us-ascii?Q?30Zp24zIpwtI6lmVvDTFy3TFQW2ZWyXxQwSlY4qY0zC2cHUuaiGMSzXQUXwx?=
 =?us-ascii?Q?2LvEQGBQBAntr+8rhy1uDTfdfNUOmTSyFLO8VLbMUkdm0G08B1zX2UTmjrFe?=
 =?us-ascii?Q?Afhb61uJIke4Vi00j6itDw6i1+Okr+jYMpovaO/7zbwznV35ruBB9djFyzgl?=
 =?us-ascii?Q?BkQw1xUEzlukJY42SFKpb1lV3HSucFW+Cng4NtfMPVMglwv5yjs9zEsHnqTw?=
 =?us-ascii?Q?Rdt2elCJbckSvy+ReaTyx+npIVWGii5ZYoUBLfe0FEtXK4oQ7muEOQQqtitf?=
 =?us-ascii?Q?TDy8rt9CKifgJf1cNp8jMm3r+DVHx6H/oNOuxmW9MbwS1fjsAYbBj5lkLPpS?=
 =?us-ascii?Q?Uhx6DGcHTKvg3Up6nayf4sS1zk7yH0ocEVw6lANucyB5AesDkXcPv09A1lsR?=
 =?us-ascii?Q?rm2qhmcdVKleqzlQG6ghR2UbaY1sVAgfI8MIfc41gjSjEfq867OezQxp7x7t?=
 =?us-ascii?Q?sIWphZV5UqqbuM+fXyBMO2SoWJxS5psTZR00uws8y6ejEuEzRSSYTUjOq84A?=
 =?us-ascii?Q?oZaXrK0i+ku57MiWKcCyRpPtKAGORnndb1pzLuPrNoC6wvpMJogiSA/2xOCJ?=
 =?us-ascii?Q?NxR3lyHoZT8rckj0PEQDAp2n5goWkHBzeIoUUehFF4FRZZ+ML6N0PbdY2qu7?=
 =?us-ascii?Q?szDilmU4dl9exms39kkGRhESyba3VmieVz7aNhKIqesM0t5ODc9U29BR5EFR?=
 =?us-ascii?Q?TgvxpOcGIhKq+7bRHRs0FPHSpgkBWKimvP7TFX4LUOv/8YP6n6wv/MpFSfne?=
 =?us-ascii?Q?VMKVW4pUPcA6Rv4CtFOTetwzfqWJnG9e8N/31fwSEXz+WgimmnVcacONz2ud?=
 =?us-ascii?Q?bosiginzhkjr9E2HlkZPxE+MTQ1Xdp7itA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5098c0-1529-48ce-a017-08d8c25f541a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 01:03:16.0791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13tX6PYbusme/BjdWwVBeWEtlbfD1+laPEatAx8EPXzHmEo2Az+DC5osoqIslKon7vzA6QxPtx5NAWKwQT9nbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4978
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/27 9:36, Changheun Lee wrote:=0A=
>>> +=0A=
>>>  /**=0A=
>>>   * bio_reset - reinitialize a bio=0A=
>>>   * @bio:	bio to reset=0A=
>>> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct p=
age *page,=0A=
>>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>>  =0A=
>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>>> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>>>  				*same_page =3D false;=0A=
>>>  				return false;=0A=
>>>  			}=0A=
>>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>>> index 1edda614f7ce..cdb134ca7bf5 100644=0A=
>>> --- a/include/linux/bio.h=0A=
>>> +++ b/include/linux/bio.h=0A=
>>> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)=0A=
>>>  	return NULL;=0A=
>>>  }=0A=
>>>  =0A=
>>> +extern unsigned int bio_max_size(struct bio *);=0A=
>>=0A=
>> No need for extern.=0A=
> =0A=
> It's just for compile warning in my test environment.=0A=
> I'll remove it too. But I think compile warning could be in the other=0A=
> .c file which includes bio.h. Is it OK?=0A=
=0A=
Hmmm... not having extern should not generate a compilation warning. There =
are=0A=
tons of functions declared without extern in header files in the kernel. Wh=
at=0A=
compiler are you using ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
