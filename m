Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CAC43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 16:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8052020857
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IeFiMNSR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SeWO8P24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCZQsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:48:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39222 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZQsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 12:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585241294; x=1616777294;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BqzT8+bMd0eJkHAThLZVVjGREyHxtvfsjwRBeXlbFCA=;
  b=IeFiMNSRnZpFPm21NQ2As4a+n7GoNbClUMIv0unsj/FkBw5XB/dyNSWE
   kaimVQ5juDJAmwOZSb2LoQw0ELQz2rtMSktRZv28ytyCSZUXqJWTIbwRz
   xnXTGhqL6gM5CQLIUg5zx5ZiH1D5KFolY3AWRxMlh7cjZFQvgVXPI9dJZ
   qHiN/yaR5R43HsS44xyPq0MoU6MvngLia07yoQxAhdQRF2u3y16WlVb6Q
   Dal2FzZQGtol9/xbEnmioLEvphQUsvjLZaSZ2q0YyWouRDSfnrx9P9Ha2
   M3cxPjfbozfT3EznxuGXF9IHezXLT43mP2Lj3tF+Sb3f5n1oD9wxLzvJ1
   Q==;
IronPort-SDR: Ecr4vatMTX3HQAYWq++FwieZxHCU++iU0kbTdEXStf0ql3yAvW8qRDrhPJOzmo05/jNuBYo0Jo
 KzXr5HIcMuza63MWLdzkULroQqmJrA34o4b0hrpewbqtsTjWsLq1MV/qHHeGSVE49MvFria/u2
 mQRYX+UE6BXoDRKtjYdKcbIZBoGTejB7HuRZRSm5BeQlzd42vSoThrzcJhVGkisqsjMwpxMtas
 qoHH3xQBR32Xbwvp3flh5df3D7fQKsU9gtl3f4rrNMw6fzD+4AqcR1UyceO4bBHl2gykEL7eRj
 3ZY=
X-IronPort-AV: E=Sophos;i="5.72,309,1580745600"; 
   d="scan'208";a="134027778"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2020 00:48:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6kRV32U/UGWxNYyqOmmNNhu71OL45ziatPpjdScnvK5/lcx7SsXJXxMNTRcWzaVJqouXcpJQlInrWWHCnNOVc/imGfDG2bg5MGoexGYGWnuuKECeHuZfm4QJi19MqXtWr+ci4PM7mHW5WtjoyYvLYmB1z7EyvhylfewQLMMsbECQb3U+x1uvd8SdO3gqxq39GV7Z/cJRmcXVpHq8PI/n54bzyblPTCPHiROWQ3NI/ay/9aOhN5DWTQwgE7SXxx07kPpj9Izs2aVvcm4QgtNCGkKjjgax1lfJmc61GjELTgxT1O78YWH4fDNxWjezDTlWFgv3Qj41jUtmsV+2zmi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jKzrwcW0x5xeZYvdUG6eyXi3nQxTIFB5La4HUSa4xI=;
 b=dUSkD5TD5GA1iUWR1MCSP9bRhR0CdGbC2Wksfk78ruaWyXVjQ3bGL7hokJp5tyjO8/Xbrf6Jx4wp7MMqqEve6M8X0MWwxNVvvxRVob5ZSCW8KECZMTPBQU0507s29mfeFqYGDMKZCjEnTDEdlue2bMNNsDWym2cF16cQ+A405ghiJdtYBCR0pb8/OKJZexIOJDaeWYiEvFhrEpksgFteBqPhlKagl/L1KN8cPC3zFIdqn7HJ8s3JAtAN2QB061n6fzWm5ObjxHjYHtpWpWlZfVleTlYfaWillJs8nnLDzB0Epp+hz3Nm8wKseurQYP/g0xOQHt3xF81I3lnCleiE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jKzrwcW0x5xeZYvdUG6eyXi3nQxTIFB5La4HUSa4xI=;
 b=SeWO8P24erssu7YGZx0ZbIyvdxixzMzIb9ijwyGVe8rNHkGdadtnHprbZhxC9hX+rWamSO3dT9dvIA7ac5TRaXrPBziOthPsgv0hTboW6fdtpcryINaeHNtAGYezFYffdZxAF9tbJccBEvsQT0kj6PgmUrNruUKGUlsRuiEJQ+I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5573.namprd04.prod.outlook.com (2603:10b6:a03:e2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 26 Mar
 2020 16:48:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 16:48:08 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bob.liu@oracle.com" <bob.liu@oracle.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
Thread-Topic: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
Thread-Index: AQHV4kDQBBKrum0yDUCw7xwsJ2OWDw==
Date:   Thu, 26 Mar 2020 16:48:08 +0000
Message-ID: <BYAPR04MB4965C03A4E397333E5141B9086CF0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
 <20200319102819.GA26418@infradead.org> <yq1tv2k8pjn.fsf@oracle.com>
 <20200325162656.GJ29351@magnolia> <20200325163223.GA27156@infradead.org>
 <yq1d090jqlm.fsf@oracle.com> <20200326092935.GA6478@infradead.org>
 <yq1lfnngp6l.fsf@oracle.com> <20200326144556.GA4317@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a1498e3-a818-441d-0617-08d7d1a57688
x-ms-traffictypediagnostic: BYAPR04MB5573:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB55738CEC7CC96FF34308486A86CF0@BYAPR04MB5573.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(53546011)(8676002)(110136005)(5660300002)(6506007)(55016002)(52536014)(9686003)(33656002)(2906002)(81156014)(7696005)(316002)(186003)(71200400001)(478600001)(81166006)(86362001)(26005)(76116006)(64756008)(66446008)(54906003)(7416002)(66946007)(66476007)(66556008)(8936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5573;H:BYAPR04MB4965.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCTPhFoW+QtCCKjbdWlLzyIFUfmDlQoDlS2SMZAoxBAsXYYSJFy/wkAYNWndRQ/gZSZs3LJ5fx7Gp+cyIvZYtbS+4KMgk2uxXGToZRtqORynCYKYHbMJ7+0iivvqMEDPkShJMC6uM8KEFHLY13wGbw3azMA2OQ4Jiao2zvlDSIPmY/aiQVUB1jxiSI4P+QwA3oFxImlzSQh6HdKALAqCeoAZDFolRqt/alEWuuTx2jBfTmSgJC4l84zi02iCqPJa28OQnASzK3tNm9ABvV0pt73CC8aBzHvz1cS6krI9Cc0gfJNV7ilsCCF0nJwGUNG4fj5bGZWTEimyg2MkUUdIy7N4m3BXHI0I/pfx+QWyeRgbwQz1R6ivEWKk86BqF6dyqsQExhkAOpddMALVszfMIlZnVdTPTiSeWB+dIpk++yQUA2bj+JZUAV81ZR6DuwTo
x-ms-exchange-antispam-messagedata: KVES1B2XWpvXJn/wU0WHWUDgKv9z0TaRYeVb66a0++nh+iZQ7kAntrXQQCUVF/BS7T5tHQbu93X0rA5wwu8hM1lp4hi4s1ZrbS/nePzwPMWQiyrr3+vV4SZ/QtpWr0sA52uZn0RG+QKIuvnbTNBomw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1498e3-a818-441d-0617-08d7d1a57688
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 16:48:08.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SaPhnbvAFoZ223+FxntTsi5J6CAzOwkIwl02Bqp+uxsz9u+Fbo2GVSEpqniPqn79aFSczTOp1lkmNmxnOqBYQTbHnWnWHAEA2HNrQV4PiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5573
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/26/2020 07:46 AM, Christoph Hellwig wrote:=0A=
> On Thu, Mar 26, 2020 at 10:34:42AM -0400, Martin K. Petersen wrote:=0A=
>>> I just worry about the proliferation of identical merging and=0A=
>>> splitting code throughout the block stack as we add additional=0A=
>>> single-range, no payload operations (Verify, etc.). I prefer to=0A=
>>> enforce the semantics in the LLD and not in the plumbing. But I=0A=
>>> won't object to a separate REQ_OP_ALLOCATE if you find the=0A=
>>> resulting code duplication acceptable.=0A=
> I find it acceptable for now.  And I think we should find some way=0A=
> (e.g. by being table driven) to share code between differnet=0A=
> opcodes.=0A=
>=0A=
=0A=
With reference to Martin's comment (verify etc) there is a significant=0A=
advantage when using payloadless bio to offload the functionality=0A=
to the directly attached device and over the fabrics when dealing=0A=
with larger disks.=0A=
=0A=
How about we create a helper which is independent of the operations=0A=
can accept req_op and issues the payloadless bios. Something like=0A=
following totally untested :-=0A=
=0A=
diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
index cf9e75a730b4..d3fccd3211cc 100644=0A=
--- a/block/blk-lib.c=0A=
+++ b/block/blk-lib.c=0A=
@@ -209,6 +209,33 @@ int blkdev_issue_write_same(struct block_device=0A=
*bdev, sector_t sector,=0A=
  }=0A=
  EXPORT_SYMBOL(blkdev_issue_write_same);=0A=
=0A=
+static void __blkdev_issue_payloadless(struct block_device *bdev,=0A=
unsigned op,=0A=
+               sector_t sector, sector_t nr_sects, gfp_t gfp_mask,=0A=
+               struct bio **biop, unsigned bio_opf, unsigned int=0A=
max_sectors)=0A=
+{=0A=
+       struct bio *bio =3D *biop;=0A=
+=0A=
+       while (nr_sects) {=0A=
+               bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
+               bio->bi_iter.bi_sector =3D sector;=0A=
+               bio_set_dev(bio, bdev);=0A=
+               bio->bi_opf =3D op;=0A=
+               bio->bi_opf |=3D bio_opf;=0A=
+=0A=
+               if (nr_sects > max_sectors) {=0A=
+                       bio->bi_iter.bi_size =3D max_sectors << 9;=0A=
+                       nr_sects -=3D max_sectors;=0A=
+                       sector +=3D max_sectors;=0A=
+               } else {=0A=
+                       bio->bi_iter.bi_size =3D nr_sects << 9;=0A=
+                       nr_sects =3D 0;=0A=
+               }=0A=
+               cond_resched();=0A=
+       }=0A=
+=0A=
+       *biop =3D bio;=0A=
+}=0A=
+=0A=
  static int __blkdev_issue_write_zeroes(struct block_device *bdev,=0A=
                 sector_t sector, sector_t nr_sects, gfp_t gfp_mask,=0A=
                 struct bio **biop, unsigned flags)=0A=
@@ -216,6 +243,7 @@ static int __blkdev_issue_write_zeroes(struct=0A=
block_device *bdev,=0A=
         struct bio *bio =3D *biop;=0A=
         unsigned int max_write_zeroes_sectors;=0A=
         struct request_queue *q =3D bdev_get_queue(bdev);=0A=
+       unsigned int unmap =3D (flags & BLKDEV_ZERO_NOUNMAP) ? REQ_NOUNMAP=
=0A=
: 0;=0A=
=0A=
         if (!q)=0A=
                 return -ENXIO;=0A=
@@ -229,24 +257,8 @@ static int __blkdev_issue_write_zeroes(struct=0A=
block_device *bdev,=0A=
         if (max_write_zeroes_sectors =3D=3D 0)=0A=
                 return -EOPNOTSUPP;=0A=
=0A=
-       while (nr_sects) {=0A=
-               bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
-               bio->bi_iter.bi_sector =3D sector;=0A=
-               bio_set_dev(bio, bdev);=0A=
-               bio->bi_opf =3D REQ_OP_WRITE_ZEROES;=0A=
-               if (flags & BLKDEV_ZERO_NOUNMAP)=0A=
-                       bio->bi_opf |=3D REQ_NOUNMAP;=0A=
-=0A=
-               if (nr_sects > max_write_zeroes_sectors) {=0A=
-                       bio->bi_iter.bi_size =3D max_write_zeroes_sectors=
=0A=
<< 9;=0A=
-                       nr_sects -=3D max_write_zeroes_sectors;=0A=
-                       sector +=3D max_write_zeroes_sectors;=0A=
-               } else {=0A=
-                       bio->bi_iter.bi_size =3D nr_sects << 9;=0A=
-                       nr_sects =3D 0;=0A=
-               }=0A=
-               cond_resched();=0A=
-       }=0A=
+       __blkdev_issue_payloadless(bdev, REQ_OP_WRITE_ZEROES, sector,=0A=
nr_sects,=0A=
+                       gfp_mask, biop, unmap, max_write_zeroes_sectors);=
=0A=
=0A=
         *biop =3D bio;=0A=
         return 0;=0A=
=0A=
I'll be happy to send out a well tested patch based on the above=0A=
suggestion or any feedback I get and re-spin this series or OP can=0A=
re-spin this series whatever works.=0A=
