Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76355C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCAD6103A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhHRJxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:53:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58073 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 05:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629280391; x=1660816391;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qfIRmLLjnAoqtV5P/F/aSR0QMtHHOSSnogKsBVtiTYY=;
  b=Q6HGgTxNnGsbcMMH11m2T9NqXULw8QuI2iRTAY8safRmxB9apqEEntE1
   B+Ut2lXHemxKbB7gNxE3Wa9gD7IitFPVvZfrkqWlQXvhEVbB2sXR94Kdm
   xFK3cXm+jIR5jTHTi8rwPCbZ7VN/Kb63S918yVz2QP6313Xowpths/PQm
   pQ1EjOE6WbPIMJ59rM6MQnfYOLUC8VU8q09kng7D4imCyyOfCTXCRH/zh
   u1tEs5IX8/TqhhGkM/udqxA8hqNA5TTz4fZgBnZBobv9UXxv5KjKRW3Mf
   7Q2L9Z/hqVLRwnIvjio9YN3cVmyx6E1PmfSZ8G3tjgnJ7f5UCb/SJvoor
   A==;
X-IronPort-AV: E=Sophos;i="5.84,330,1620662400"; 
   d="scan'208";a="177628215"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2021 17:53:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCOPO6LcDsAyS9LNYvDusle69OjBOisY5OJbEV0fL5K21L2untW1n7CtbknYCYhyuHE6PoNrO47T3sFt9BUrwnK1lRtil7EAetpC/7VoarMHRwjMmypmuULa1ykOh7T5asokMa20nc9JlJkKbHhEO8cArkVAo7SdJlIifIaqBthhwTpr1UwP90EqfMl+NxYW3pD9HaNjZw/J0MTMdV9saffKJpysZcp3W3TXT3a4JUTLZ6JEaz/QNAQCZlCZ+A7GmsHtFK6IhHGWLafvt/aXRo0n+mnCjA4X631dUFgFooVCshX1iWuA1meTPT0rP78UD55tUCx11yz4HTgOaLPJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzsAq8TZxZc1nFOXM4ySmLlFwqrhuAveaG1hUGP/yrE=;
 b=IHfDDvjS3ofXrBy7OJkvuxnDaZYslLueNBJ65dqMvW5IhzbLX19pMTKzd37sdovLkYgLdJOP9grq2xoEyQQ5skbQakP5Q0FjAZA0HbKQGyzIaJ4sLZtHItI7Jrf9VJBLPY7oP9rIiFriVwjiYWL4g2c4FmIBWZsOjKgoi1I5xZ2hfra90Ltq3jnLwYnb+CWbFFp9+7MWD8d86ywfcpySMvLlHBToIPQfkHnrpY0l2Mes/f7Nr+JtD7BpEQ/b5xhZ27muHpAr2x1r7PNqQ2cq1QmYIzNjjMrpATgAzJWYDA9ldpa/K9GnVs9UJaJdT1XT6KY6xlrXQH96ERBOd/Mq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzsAq8TZxZc1nFOXM4ySmLlFwqrhuAveaG1hUGP/yrE=;
 b=K/80t+f2Frl94xMJv/+a4DE/nbWcDTIx7f0zl5IbCCeR1oOI4BPtDtTNEozAG4KkFKZ6hJwn1aE2ggbkvFN9qrOI7sxPgJV8hE3kDX2j25m6i7l9W9mbKWVmu20N36LihrauswLiTusKJGY11NeYQx1tt5YPuxUyjWhJmxeOcaQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5561.namprd04.prod.outlook.com (2603:10b6:5:12e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Wed, 18 Aug
 2021 09:53:09 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:53:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4 0/6] IO priority fixes and improvements
Thread-Topic: [PATCH v4 0/6] IO priority fixes and improvements
Thread-Index: AQHXjmIw1CLSs99bxUeB3ntO4vk/cw==
Date:   Wed, 18 Aug 2021 09:53:09 +0000
Message-ID: <DM6PR04MB7081B903196654C3BB0656E6E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11abc060-3b9e-44cd-d432-08d9622dfc35
x-ms-traffictypediagnostic: DM6PR04MB5561:
x-microsoft-antispam-prvs: <DM6PR04MB55612C7033B342CBC5AEE506E7FF9@DM6PR04MB5561.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k8J9ajsPxS0IyqDjez1+oK3h+fZKDjQL8Drx1FJG+gZzE6VfQ0NdwqBz0CFEbRLIRYWv0iioe7+uUU06vP9wcb7qzYhNJRqkDns5NQuzQs+TcDFuqvCU+O+8nR75YI2WBlmkw+OXL8tObnDi3ajrc7XZSGOvhhFEcLX58hCy0mMRaHkgaM540kgoPx4F92HvlFW3B+XeQDOMuGkGjzVCgi6r+AB7W3rXRVJLIv62yg7svpS1zSgPkxBoNnpEBCqukTPyBbobJow662O/CzjT9OndnMjZcK/b+Tf/BLTWfVKFhcfse1YMTmLI4eD2nwfa4KtRZ5zk8yC2/Nn37Ny0pagyKGavLkbxgxiu1EtNNHi6oPfMoFmQf1PUseXEmrPtuEiIDeEA4kGJn1UxCR2UjA1x5Tn9ERkisxVsGjbsdoSdzXzqWbL1jEGZI3L8mLaEdBrj5qyLkB0Mr+JPuo/2KZhKZ0SIGbpZ9PMaZ9FWLGb8zp/88Iw3UZ4xcyCuJIaODhQSKMBGNDmFZkW+syQ0dz/YcZL6/2iGYX9822cINqkfcs99LLlvDnLS3++A4ny+ene5j832TfAch0X/BJwaei6U9ztuBWGAmrZ/KevYyydKqzTkw6Qd5Aoa/USLjM9cuv1ArERiYxy3sdRqmbGofGT6ZFEQYcwJriZ5aI43/ExYR3klfL6QNPRYJlvcDkkvf9oEtq/sglQ7jrHFf7Orjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(33656002)(26005)(186003)(53546011)(86362001)(6506007)(71200400001)(316002)(122000001)(2906002)(7696005)(110136005)(478600001)(83380400001)(66476007)(9686003)(76116006)(91956017)(52536014)(5660300002)(66946007)(8936002)(8676002)(55016002)(38070700005)(64756008)(66556008)(66446008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oUjya4wg3HgrhTGtqoE9CgqiU4veHiIrUV0QaA4/tQD8/Bay7HxfAo49H5p?=
 =?us-ascii?Q?Y1OQXJL4PY+CoLed8wZwnpDOGWwZXp04JNqHHr2EkLkSXy2rSRJ1L3XKnU/L?=
 =?us-ascii?Q?t1dgc5lIounfTv5IFr0Ksh0wXKhinnE//MIfT5Lz2jqE6/Pdz0uMetPf6EzF?=
 =?us-ascii?Q?SvHzg7RDaSF+9Edwp1+HYgXI81U81T/3rV3Rl6/3zAcigDUCl8BTWSZ/rhVO?=
 =?us-ascii?Q?emHRlR/IaMlw0IIaEkaqtCb8QWBzY+MKlen53MLPr1wOfrvWulxyeH0CGyFn?=
 =?us-ascii?Q?ButOBcF+QPbalUiapwc6z4x4Z1yxe3/cgXc9sjY76i8tRuEW4sCHT8G6g13w?=
 =?us-ascii?Q?10XCd3f3tk4Jx0EGjoBJhtQbo2cFtXQIAKjFYErqcvbd0mB1wK3NVvOpmuYv?=
 =?us-ascii?Q?flmoU8nQnnii0laq8crQLq4QNQUCNEuO1GGzPzsp4KdYygZ040AkjlSjzSRw?=
 =?us-ascii?Q?dzvMGgpDXRfcqyfSTphQe/BAhhebz6lAnlB/oLsNjcahSBn+ohpo29YrDaU1?=
 =?us-ascii?Q?O2T53xVCj25zyHmj+/RCxAlWnqo2uoTvEeg1EQoT3s+D5MflZ5s41pIir1lP?=
 =?us-ascii?Q?ZoFFCMncb9B8tAYREqeYhy3wnOjGvH4NpobTDv7f1tE/uyIbIwff14zob7a+?=
 =?us-ascii?Q?rcuVgqGedN7/Mu4V4MFKMFnFkuNmNr1XzBbjmYW4Hs42y8zVQim1d8BNbXFX?=
 =?us-ascii?Q?FODiolExxaUOuquq/waXfK1K4wOl6oRErVKSdqgXlbJ6YJDOmznDV8UzuhRP?=
 =?us-ascii?Q?HPUjLWoDbcclfvo1/k7mnRtasFdGlE2qztp7qJEkYnQYnBXTQPRO9TgvdZVu?=
 =?us-ascii?Q?CVQTi1g6kNJ7HwzPeqctkOS8Qip2W94AZjB+CZv66CX6n6f6G4Q77m+ODUl+?=
 =?us-ascii?Q?WEDpnWzGwbZEI/z4z6c0zwMVuqIMORhGoXyUH17DXuzDytl8u2T6WykAnb01?=
 =?us-ascii?Q?ozkNzQlvMVQpDidLq1QwwUvDR4oj0ycuGHvFjQ66Umz2/GldK0PR4fcIRIlx?=
 =?us-ascii?Q?SS836nXs2UxFcEAq2QbhQhYXesPLwyPBh/T/SOzD8wmiIYSdPdW+6m+QqMme?=
 =?us-ascii?Q?yg5FiptHZoIiMF5SkFnUA02x9ztTM8dSjWb5xshH4P87CZwOWBJCTuXGO1/e?=
 =?us-ascii?Q?qVl1BuVdvItAmw4KBebRYGDhlWz/DT5S58ccAxoOPZKEnhSUetY5TA5OsipX?=
 =?us-ascii?Q?bN7soa7ov5E7y+/ss62CFNrPcBfEpfFMZ2wP7UBD/txKuaNADLnHlBnCoD6u?=
 =?us-ascii?Q?TQfnn2GRdqiCknoA0QacPGuLKobYh3NL8JPCaOO+lxmxvTF5uJOdbIrFKKZF?=
 =?us-ascii?Q?9cVO2cu+y8Qo4vRol4QRtNsOFAti5+0SO3pInsKwGpk/Mg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11abc060-3b9e-44cd-d432-08d9622dfc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 09:53:09.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7O8UN6j7DgPENxWNsZALMvhmOOlNM7VZnfTbyBVuLETvDL8T0LbPTZfO0j41jBmV8jPdG9WTx3F3/VoN2/LQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5561
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/11 12:37, Damien Le Moal wrote:=0A=
> This series fixes problems with IO priority values handling and cleans=0A=
> up several macro names and code for clarity.=0A=
=0A=
Jens,=0A=
=0A=
Any comment on this ?=0A=
=0A=
> =0A=
> Changes from v3:=0A=
> * Split former patch 2 into patches 2, 3 and 4 to facilitate review and=
=0A=
>   have more descriptive commit titles.=0A=
> * In patch 5, keep IOPRIO_BE_NR as an alias for the new IOPRIO_NR_LEVELS=
=0A=
>   macro. Change this patch title and commit message accordingly.=0A=
> * In patch 6, define IOPRIO_BE_NORM as an alias of IOPRIO_NORM.=0A=
> =0A=
> Changes from v2:=0A=
> * Fixed typo in a comment in patch 3=0A=
> * Added reviewed-by tags=0A=
> =0A=
> Changes from v1:=0A=
> * Added patch 4 to unify the default priority value used in various=0A=
>   places.=0A=
> * Fixed patch 2 as suggested by Bart: remove extra parenthesis and move=
=0A=
>   ioprio_valid() from the uapi header to the kernel header.=0A=
> * In patch 2, add priority value masking.=0A=
> =0A=
> Damien Le Moal (6):=0A=
>   block: bfq: fix bfq_set_next_ioprio_data()=0A=
>   block: improve ioprio class description comment=0A=
>   block: change ioprio_valid() to an inline function=0A=
>   block: fix IOPRIO_PRIO_CLASS() and IOPRIO_PRIO_VALUE() macros=0A=
>   block: Introduce IOPRIO_NR_LEVELS=0A=
>   block: fix default IO priority handling=0A=
> =0A=
>  block/bfq-iosched.c          | 10 +++++-----=0A=
>  block/bfq-iosched.h          |  4 ++--=0A=
>  block/bfq-wf2q.c             |  6 +++---=0A=
>  block/ioprio.c               |  9 ++++-----=0A=
>  drivers/nvme/host/lightnvm.c |  2 +-=0A=
>  fs/f2fs/sysfs.c              |  2 +-=0A=
>  include/linux/ioprio.h       | 17 ++++++++++++++++-=0A=
>  include/uapi/linux/ioprio.h  | 34 ++++++++++++++++++++--------------=0A=
>  8 files changed, 52 insertions(+), 32 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
