Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5208C33CA2
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985F2070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 22:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mHUfGE12";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C8JvobO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgAHWCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:02:42 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49880 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHWCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 17:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578520961; x=1610056961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/PDubpFb3z1zjLgY8J3c51bcuSTdykjGThS6RWaKKb8=;
  b=mHUfGE12cLQNZMUj5cHNedBJPRix3Yq+itGy6zTnbVRYJJEMw9LX1wxC
   LSnuFA+TzMuaK8D3AFRMsBE+fExpVp3XzQTj+d5eAq6BBKQnrv0CiXX9+
   N/mc2bg2JJ4U6VStuQfaYVNLFd73+b5UgL9EaReHlaEwT1dPp+uzXWwXr
   NYNNwaKsZsTAbJfAzI8A86BtrioD+JIyKmzfx+2CyOc7L1RAwevAFr9SA
   D3fd5CtSMAZ/aLC4vEC9jpWWWWgbu0TPyuyvDZ8GjsAGxVkrk7gzmhsrN
   1ob8wpaEs9Teiqy5eyEoHMvzULTJqekWA0/8uW74XL1qVi2n8aDcSrHFL
   A==;
IronPort-SDR: sfRy6vj2kGVDWqKrrvmsELV2yAZ8AP8F8zoL6OJXq+RA7oL0wveHSaiTPPN5fv3hU4udN/kq4N
 J5X85ETRv3gRaZD/f2NoTCQlsZZzss9UQis/7YlOFyYTGCN2I5MdacTCHIlCES5A+dPnjjeygf
 7on467g0AW+u38L1T2SbrOARFPkvo4wFPDrLbRGl612lUYhaeMbzzNCJB27wUcRHaOu6I2VEsC
 keoQ1sdlJBsUEkl40V84vE4rL9BtONNKFby4BRjQqMOV7Y44NjTqiQpf7KxxeR7njULY2oigtc
 t3k=
X-IronPort-AV: E=Sophos;i="5.69,411,1571673600"; 
   d="scan'208";a="234786519"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 06:02:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT4MWOsae2frf1XUbYBkV2EK/eQaiBuVJfuYTutJpURBfFmeog3ieqL6S1TBgpN6Ef0GyexNFq0Rhe9Kk+xVzwu6D8k0UjdaE5NErleeTHujnIjwcuPhxLw0RNfoKvyFHWfxyH8yCCQnzXZ2tcNv8x2usaoCnRYTl/mBKPeP3lawAEKsUWFGd9+xvx6/4rWSVQmjS60W897WuN3L5vFX7AG2qHrP+om1XrYOWk85miT3gpztIYNdnRclRrb/S7Z9QlBtXIwRFtFNPupf3ZTmJl2UTAvss3OGU2t51hIecSPyxlJNMuxLPzdV1rKK8UuxXGlgDCxAO0Lv7F7WsT/2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtuJpgoN9ODzgBje668xx1sHkgD78o33cNBWgmUF7wA=;
 b=nNmg43lpeNiyA6a75L1HlOpdXLU4FYMuPvisuqdoOWAFplyBatTQBWjCfzv/6Ba7r6l8uRT3JJlZJ31qL44v/yTNn7tfpD6HEGOaV1TjO+PGJbVyWMb7obZTl2eMKPMI85WyYRNAPUPu1d7F153NiBBKhASQaQtgpUkg3q9sMbalhTOhegDhSYLDym3FVzwEcSc6EbnsCMdAYumvITLlo3CPhCVsNO/C1WDoKuoh4RwC28UsPdCr7Qsyd9NPDtp6/JNdoyMmOa2+DmH9GgqDqm/JSXWLeYOiTKkSmpyZ2s1u6LyjUmhrSNS6Bt/3VczhnfgKf4h7M0AaHhKoiIKiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtuJpgoN9ODzgBje668xx1sHkgD78o33cNBWgmUF7wA=;
 b=C8JvobO05qam+uhMkNF1RA1IcBVfkBnRg3lkVPztPUX4gl1+0vlqshf+ya7AZn84Y66b8sg6QN6ECVWhcXe4xuKM22F2A64p54kbq50CN0JtLsU+q8xqHKkC5wwanSo4PqKdyvFKvJQPl8pDwILaiev8CcjcapozJwjBmxDTjwE=
Received: from BN8PR04MB6433.namprd04.prod.outlook.com (10.255.235.211) by
 BN8PR04MB6385.namprd04.prod.outlook.com (20.179.141.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 22:02:39 +0000
Received: from BN8PR04MB6433.namprd04.prod.outlook.com
 ([fe80::f892:80a0:2042:4ccc]) by BN8PR04MB6433.namprd04.prod.outlook.com
 ([fe80::f892:80a0:2042:4ccc%5]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 22:02:39 +0000
From:   Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: RE: [PATCH] block: streamline merge possibility checks
Thread-Topic: [PATCH] block: streamline merge possibility checks
Thread-Index: AQHVtds3u76vDO3mPEO6F6L+CNYUh6fCl7WAgB5QHYCAAITAMA==
Date:   Wed, 8 Jan 2020 22:02:38 +0000
Message-ID: <BN8PR04MB643390C7263ACE2AFBDF5917E13E0@BN8PR04MB6433.namprd04.prod.outlook.com>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
 <df9c90e7-9aa7-4f77-7161-1bc38de6f8ba@oracle.com>
 <20200108134437.GF4455@infradead.org>
In-Reply-To: <20200108134437.GF4455@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dmitry.Fomichev@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3935bf8-13b8-49f7-5ba4-08d794867a21
x-ms-traffictypediagnostic: BN8PR04MB6385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB638582A4F36232DC287A049EE13E0@BN8PR04MB6385.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(13464003)(2906002)(478600001)(86362001)(52536014)(66476007)(5660300002)(9686003)(54906003)(55016002)(81156014)(81166006)(8936002)(316002)(110136005)(8676002)(66446008)(64756008)(66556008)(66946007)(76116006)(53546011)(6506007)(26005)(71200400001)(7696005)(33656002)(4326008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB6385;H:BN8PR04MB6433.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3oZHLvwFLCsO+3s6QMkZhIWBgq9chZFQArg5Xb6begI0WM454aZTWcuJAfx3jZ7MRvB0ELZ3OMxb042lFO0s7sbChDIqKjQNJT8b0XRTRileuDhW8Tsxk3kM4UJrVgvkp7CaDDI3l/6/sp7/uINjeahaxtgNATvxPTvvMtZwlftNj8UycCw5KoBtUOPTD7OKm1zSCNWXMilpq2aB26SB0UPYAnhLnTR6bgUYUXHBBREcE9pQ6R9IBXmIi0hypllGE27TbEYhy+aXRJfA7tv6klme6Dbf1Ph2liOpJCyFUfbUlOM4PhUQ0B+GM0EAmwacDRQYlg/9PiijG/NFybuxfbPBk6yIrL9VK1UMwykXPUHcSELH96HD2fi+MOp6AJlhX5PI7sirunm0A572xtUcfmoxATXcg7Wck6zHXBKM/6yT2+UqBWvoyEZqZi1228ofMeHWFDKvtTkTsJkRBuuM0rSG2poLTHNp4POoTx2s4sv3aad2hwsgWE7B2n5R3BeS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3935bf8-13b8-49f7-5ba4-08d794867a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 22:02:38.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ0dwUCDSJOic1gqe3YovdLvTBx6HbaxQayWSuHERVl8X46ftkHxNLY93/FksGStty7i3lKTokDVWyUaA/+UOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6385
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, January 8, 2020 8:45 AM
> To: Bob Liu <bob.liu@oracle.com>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>; linux-
> block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Damien Le Moal
> <Damien.LeMoal@wdc.com>
> Subject: Re: [PATCH] block: streamline merge possibility checks
>=20
> On Fri, Dec 20, 2019 at 02:50:05PM +0800, Bob Liu wrote:
> > On 12/19/19 3:41 AM, Dmitry Fomichev wrote:
> > > Checks for data direction in attempt_merge() and blk_rq_merge_ok()
> >
> > Speak about these two functions, do you think attempt_merge() can be
> built on blk_rq_merge_ok()?
> > Things like..
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 48e6725..2a00c4c 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -724,28 +724,7 @@ static enum elv_merge blk_try_req_merge(struct
> request *req,
> >  static struct request *attempt_merge(struct request_queue *q,
> >                                      struct request *req, struct reques=
t *next)
> >  {
> > -       if (!rq_mergeable(req) || !rq_mergeable(next))
> > -               return NULL;
> > -
> > -       if (req_op(req) !=3D req_op(next))
> > -               return NULL;
> > -
> > -       if (rq_data_dir(req) !=3D rq_data_dir(next)
> > -           || req->rq_disk !=3D next->rq_disk)
> > -               return NULL;
> > -
> > -       if (req_op(req) =3D=3D REQ_OP_WRITE_SAME &&
> > -           !blk_write_same_mergeable(req->bio, next->bio))
> > -               return NULL;
> > -
> > -       /*
> > -        * Don't allow merge of different write hints, or for a hint wi=
th
> > -        * non-hint IO.
> > -        */
> > -       if (req->write_hint !=3D next->write_hint)
> > -               return NULL;
> > -
> > -       if (req->ioprio !=3D next->ioprio)
> > +       if (!blk_rq_merge_ok(req, next->bio))
> >                 return NULL;
>=20
> This looks sensible, but we might have to be a bit more careful.
> rq_mergeable checks for RQF_NOMERGE_FLAGS and various ops, while
> bio_mergeable is missing those.  So I think you need to go through
> carefully if we need to keep any extra checks, but otherwise using
> blk_rq_merge_ok looks sensible.

I tried this patch as is and, indeed, it leads to blktests failures and fil=
esystem
errors, apparently because of the RQF_NOMERGE_FLAGS  difference.
However, the patch below seems to work - I've been running my host system
with it for a couple of days with no issues. This one is added on top of
"block: streamline merge possibility checks" patch.

From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Wed, 8 Jan 2020 14:24:06 -0500
Subject: [PATCH] block: simplify merge checks

The code parts to decide on merge possibility in attempt_merge() and
blk_rq_merge_ok() look very similar. It is possible to move these
checks to a common inline helper function.

Suggested-by: Bob Liu <bob.liu@oracle.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/blk-merge.c | 56 +++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f68d67b367d6..49052a53051f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -732,6 +732,36 @@ static enum elv_merge blk_try_req_merge(struct request=
 *req,
 	return ELEVATOR_NO_MERGE;
 }
=20
+static inline bool blk_rq_mergeable(struct request *rq, struct bio *bio)
+{
+	if (!rq_mergeable(rq))
+		return false;
+
+	if (req_op(rq) !=3D bio_op(bio))
+		return false;
+
+	/* must be same device */
+	if (rq->rq_disk !=3D bio->bi_disk)
+		return false;
+
+	/* must be using the same buffer */
+	if (req_op(rq) =3D=3D REQ_OP_WRITE_SAME &&
+	    !blk_write_same_mergeable(rq->bio, bio))
+		return false;
+
+	/*
+	 * Don't allow merge of different write hints, or for a hint with
+	 * non-hint IO.
+	 */
+	if (rq->write_hint !=3D bio->bi_write_hint)
+		return false;
+
+	if (rq->ioprio !=3D bio_prio(bio))
+		return false;
+
+	return true;
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be held.
@@ -739,7 +769,7 @@ static enum elv_merge blk_try_req_merge(struct request =
*req,
 static struct request *attempt_merge(struct request_queue *q,
 				     struct request *req, struct request *next)
 {
-	if (!blk_rq_merge_ok(req, next->bio))
+	if (!rq_mergeable(next) || !blk_rq_mergeable(req, next->bio))
 		return NULL;
=20
 	/*
@@ -841,35 +871,13 @@ int blk_attempt_req_merge(struct request_queue *q, st=
ruct request *rq,
=20
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 {
-	if (!rq_mergeable(rq) || !bio_mergeable(bio))
-		return false;
-
-	if (req_op(rq) !=3D bio_op(bio))
-		return false;
-
-	/* must be same device */
-	if (rq->rq_disk !=3D bio->bi_disk)
+	if (!bio_mergeable(bio) || !blk_rq_mergeable(rq, bio))
 		return false;
=20
 	/* only merge integrity protected bio into ditto rq */
 	if (blk_integrity_merge_bio(rq->q, rq, bio) =3D=3D false)
 		return false;
=20
-	/* must be using the same buffer */
-	if (req_op(rq) =3D=3D REQ_OP_WRITE_SAME &&
-	    !blk_write_same_mergeable(rq->bio, bio))
-		return false;
-
-	/*
-	 * Don't allow merge of different write hints, or for a hint with
-	 * non-hint IO.
-	 */
-	if (rq->write_hint !=3D bio->bi_write_hint)
-		return false;
-
-	if (rq->ioprio !=3D bio_prio(bio))
-		return false;
-
 	return true;
 }
=20
--=20
2.21.0

