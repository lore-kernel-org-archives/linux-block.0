Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0009C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 02:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbiCQC70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiCQC7Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 22:59:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914A11A29
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 19:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647485889; x=1679021889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=voU3hCz3plPI989cBFwqM42kKd7U4fnJpMMbKemNCx4=;
  b=J5XBNLRqPEI4Pm6Fc9+BnPqP6TxVdcKI85BTQd75UzPywuXHxwK9joNy
   sFJFE9+VNN0p/LVWOX9QTeKf2qWOYj83lBmOXOgLDx11qZsSz4oynuwNf
   k+o5C6puFUXQa+10RHsJWl/2j6aSXaHsKAbH6UkocMc8PY36OQx1nAmwR
   TV3zMLE3Vx27nQnhDXRmYoE/54fP2Eba0iUmCUAvvxKeRqB3cqWO9scpZ
   6ImSVszX74vGHChGnFnLNKDmJBRe1m0YKmpox229GsYtgAW9RRWDZ6mwi
   NY/qtJYZadGdb82SJMx3FhuCodLZccsWY5kwraNkiwo8CeP4tyRGKlfs0
   A==;
X-IronPort-AV: E=Sophos;i="5.90,188,1643644800"; 
   d="scan'208";a="307515492"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 10:58:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCLrxx8vOLAPDcY1U43emLZDiRTkBzHe/tPheWuOW9zqEzkK63g41pvqJRzyyPXGW1VwBsZZ8EIeLVUVVdqVX6JHnZUC0pkjRafrsDMHGaGgr40TNaFHdSeh6/2wWTBMZStOc3rvf3WJDdvXmdkpFFk9WW3ZprBBHV5cYXgorTfx0puzgZ/fGJKcR42xsPk65WWUzb3oP/7anunWwJK4NLukaIDG31PhoC7ORap91cKObbv1VyLyH0mYeRqrDdU3lMHw8PGUxz5GD9w7PJT6UPexEOqX+YA5OfMqDR8uQf50iTNGSut6ugAsLoiPkpirXf2qsFNefQJZNBulNv6Ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vS9ug3ObrVKnh4CIwyT/Um/8a/61aQR/GAjMdRwFks=;
 b=k7NTpTxqTq4qe0oA0SfgVm0EImWOywiMFVq7Xycv6utwZjXxzt9U7FTVF3N7QLioPLzW1/XjxjocRBtG8vWcJePeqS0Iun/opf57AMlGVo68GmyZyx28dH8+57KKKtFrnPYOHwMOZGxwxRlfgJDsLDEIIE7oa/+Y1VsKpQEhaUTMIVWVwcgxO3KOdifvdVCOmA+3nx0k5ulsiOWIwu6ouVBsOz8ihSCe0z5x2u7N7ePsK9inqX/xi0JC0nWPmSAiy87Q2vpmD1lp7fQB6HtuJ6AIetm6OqOh3kH8kmtEhijtaqaKdueEFgcylIIfWgy949w3ZER7XNaqxBALlwILbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vS9ug3ObrVKnh4CIwyT/Um/8a/61aQR/GAjMdRwFks=;
 b=YvIkxrGcxL8BWro3W7Qmc8553PdHRVgkA8kXr6czJ9pVOB7T+ZSED+8xOa5j6LSRtP7RIOogmzho34dzIDYIOieQU2GXD9n2vjRCKBLJu+t5ybsN/iWEjHs+l3p/w0rsjj4PD/yA6vjWr5vh0icYdlNDaid9lMqXHxS03Wvw3J4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Thu, 17 Mar 2022 02:58:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d%3]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 02:58:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: limit request dispatch loop duration
Thread-Topic: [PATCH] block: limit request dispatch loop duration
Thread-Index: AQHYOPy1/KvO7JD5KkK+9HCheDmIt6zB7m4AgAD1PAA=
Date:   Thu, 17 Mar 2022 02:58:04 +0000
Message-ID: <20220317025804.v6yxv4pxncnqgudc@shindev>
References: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
 <59f724e7-1b42-b2fd-7d32-264cec939810@kernel.dk>
In-Reply-To: <59f724e7-1b42-b2fd-7d32-264cec939810@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6bd85c7-5c82-484f-a325-08da07c1f523
x-ms-traffictypediagnostic: BYAPR04MB4871:EE_
x-microsoft-antispam-prvs: <BYAPR04MB48711A6F789EAFEF3D0EB11FED129@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ew8oonA9Gsy2/3Pa+rdfrwTcCtCRMtGWrE49K0bt/LuAe8QeH/BipRyU227PdG9QKqH8E5jrsaaQ+eezV8F+4uAgo1HsoONgc3Dl1yXN6iiN3ThP+8EuxaqDBPdOTL1fLvTqRvx+AFnNX1tQY5sNjUCmAxK5f9/cQiV2WqmVu54pNc/YTfZ4t00kxpZWarGG3z9/U9OAWSkOYsJjc5a6MuidI8ZHUhUixy2LVq2Q527qhV2o4IcNqQXj38lQ0HM2ep8Pkg23fTcTYtF+kx98OL9s41JUOwB9o2F6WRchs0NSZMf5NsEVbazHsS8QCoWPfEzB+aML0SKsnff6zXeErDaBMms1qqaA5WJVMlx/jPyQll9ljLmalzc79noKYnRsRHCJdMJ/D/16GRojVVpUaNC33l89wa91sh2aEZ8w/5wcXVuGSIh7Fnr64xyDBKRftYgWJC5hssL9PuYZ/do6x2sJDKGpGRqxa2oheN2x4REXenaJyeZXzaNPSPWoJQVuKyyDrzIM2/auv26SxSR7Z2/JX2Q6qnu4HC5Fs+pOEo5VyfJPoQRL8hUwcpcU2cHsMj4qSSByOhLmL+He73OF+sK8aMxW9j6IbkHJxPbqzDimWaugNaN0Jzoac3LNK5tujRAXtgCws/qee141mq+Pr5LJl2feW8fMKrpcEojnA3DtAaOFwmVp4HywdXluP0yCS1ECF7tY9CKGkWMWCUfoQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(54906003)(186003)(38100700002)(6916009)(33716001)(26005)(82960400001)(1076003)(508600001)(316002)(122000001)(66946007)(6486002)(76116006)(91956017)(66556008)(6512007)(64756008)(8676002)(71200400001)(4326008)(83380400001)(66446008)(9686003)(86362001)(8936002)(2906002)(53546011)(44832011)(5660300002)(6506007)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v7H9ErGeHXErLy3FNn/XocHcFfMbcpzzlBlGjl4KnDDx+bBIYrBPZKAKorss?=
 =?us-ascii?Q?cLnTPxen7tUBZATiFq3WATk6QjvZWxKFeJATitPVWLPzhNw4fcbz2N513DkC?=
 =?us-ascii?Q?bfPZdJcCPgrjcchnyo4JUtHL17xsSHT4qNHCXnTnUd5ZqGvILYT5rG/u+JH/?=
 =?us-ascii?Q?yseq6v1Q+hmmQSxYjybY1/mf7k9Y+rOiYw64WbcThPRDJBEVO0/HLPI0zblE?=
 =?us-ascii?Q?+QiU5iBW18v29PTmQDqYFIJUlg8bKA0TuiB13g/N7DHIkxb17wD5wiATnoGQ?=
 =?us-ascii?Q?U4T1IlZ0zxQkC7QTo5ZIPWw0S3YMNF1BCC1la9cUWmRhOSLcWVyTf7FhCZcd?=
 =?us-ascii?Q?Ov83GEPeQfp3jSWtln7gmRXN8nbD8vmz43LzwC3K+zPJyXZcbawBSZ7hEN/W?=
 =?us-ascii?Q?f105WvFpQP2G70zxwCko9rGixqTiq2yqC+SviBDpGnPDgi/Nkm18YzzdOFm2?=
 =?us-ascii?Q?RfABSrk7iqs/NJVADUANGwDQPYRK61I3j82KQC7YRpMrLVGTFwoMmudTwQNO?=
 =?us-ascii?Q?1AfZGpTpagMy6w7CxDNzhKAJ/QKJcw4YWKz/GdLq70V/wBpu5/V8Bq0u6FQU?=
 =?us-ascii?Q?fV1EhVKMwk/249qaHTwDvJbenGBhYVWd7yXWsJb/ALOmRAsRcWqfz5xFMank?=
 =?us-ascii?Q?0OSfzOJBMU86j2dmGs17JOJQLd97c77T69T2E3wq78x9PYVlwc25UTEAhexC?=
 =?us-ascii?Q?XyFkXzCaGRXWZLfAIRtdahFOSFDlCGH89DjrW4T0ifyZi/Tr8XijfOxoIDey?=
 =?us-ascii?Q?0Ol0VkGwPhhrHhp+f662sueRDyZCc4a5h+EbE94fV08vqpqWS0vja7nVufaS?=
 =?us-ascii?Q?MIOatihSgKWE+tT88cRgFCrdW2RAGB5ldJRa6U9Hp2TJoK+IuK8uqlzhQh2t?=
 =?us-ascii?Q?dGp9fiGoqdWd0egEAeNWYyUYyeeKOiCJ0lD8U/d5lKx7UpndLLqJRdEpIQLg?=
 =?us-ascii?Q?nniuHjaNy6U+jSv7LTnklLSSKyRk22/BPt9F5518eVx2XWxwm+wfypOuI/oY?=
 =?us-ascii?Q?B1w5pw5zV3R0fMl5Pll9Z73WxbvFu4Rz3eIRjqFZJ1JM4Rv5LprKqCjogLW7?=
 =?us-ascii?Q?wVVItxVD0HlcJEcssrglOM0MUOvan0pJiYVIDFKz+5k+yy2QTIKTgLEDB9qI?=
 =?us-ascii?Q?cKpLzo1H6rgNyNFk78LubzZTvCkdCstG37BeX7pE2C7/F13dyQodwOywav72?=
 =?us-ascii?Q?96QquqsP+dne43h3K1w9MUt2HgmuAwAp7HRV39I9jejT+BiQqZJbSKC3yYzz?=
 =?us-ascii?Q?VlBhDn1hlomqiqLx1qql9Gp7J0u3KLD6SrauHMufr38C28xS3E/PfijAlSj8?=
 =?us-ascii?Q?stZbJBx5ZTtfMbHnDj3Kb0Dn66I0APxH2lnpQbYzj669LZWN4st2ZWvBuApb?=
 =?us-ascii?Q?ZlN45xK/8xwxZ1eW2sg/xPYt3baAqp12VrjkcuuJ5q6IHoroh7NwUgVwGG0k?=
 =?us-ascii?Q?EGe8ORmrbPhz2Op6F82je+uJFMmZYqlVnAiY0Ux9JEZgaXnRnUXyjUIcxuVa?=
 =?us-ascii?Q?MEDumZZUup9s53A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C2951D15C48C54CB360A1D510EE1EBE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd85c7-5c82-484f-a325-08da07c1f523
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 02:58:04.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsXpzoJH1r5CKelO+wmApeZvmYT5x5YQx6ZrI9XlyfY5G4pc9hL/es+Wi0ClDrRIUOORYuyWxJBFY4Ll+6AKsmjfXs/L/pi00nyMwQ7aGXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 16, 2022 / 06:20, Jens Axboe wrote:
> On 3/16/22 12:11 AM, Shin'ichiro Kawasaki wrote:
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 55488ba97823..64941615befc 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_m=
q_hw_ctx *hctx)
> >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	int ret;
> > +	unsigned long end =3D jiffies + HZ;
> > =20
> >  	do {
> >  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > +		if (ret =3D=3D 1 &&
> > +		    (need_resched() || time_is_after_jiffies(end))) {
> > +			blk_mq_delay_run_hw_queue(hctx, 0);
> > +			break;
> > +		}
> >  	} while (ret =3D=3D 1);
> > =20
> >  	return ret;
>=20
> I think it'd look cleaner as:
>=20
> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> {
> 	unsigned long end =3D jiffies + HZ;
> 	int ret;
>=20
> 	do {
> 		ret =3D __blk_mq_do_dispatch_sched(hctx);
> 		if (ret !=3D 1)
> 			break;
> 		if (need_resched() || time_is_after_jiffies(end)) {
> 			blk_mq_delay_run_hw_queue(hctx, 0);
> 			break;
> 		}
> 	} while (1);
>=20
> 	return ret;
> }

Thank you for this suggestion. It looks nice since avoids duplicated 'ret =
=3D=3D 1'.
Will reflect in v2.

--=20
Best Regards,
Shin'ichiro Kawasaki=
