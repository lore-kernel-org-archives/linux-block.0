Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28770C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 04:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D429820840
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 04:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vfe9qI97";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jqtPAv5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLEFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 23:05:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39345 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKLEFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 23:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573531545; x=1605067545;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=h3OlXAWKdZYGTCLCQQRRIuQ/5CtSORQZHnuAPzJ0pR0=;
  b=Vfe9qI97M8lmrXnJbrHtgcKkrVEJTbiFvXA6asbQ9TM91ooILav8K1Lg
   j0M2EvKGbIRD9aUH7PTgxAz5zEaq4W2tWIZCXnertT7HZ7xCqnvO2/jXK
   SzV4/DN9fzO+7FIxM6QtPuqjN5rM6zJO6FXf+lE+AgHi3xMeiakjenMXK
   EI5i60rB/dxshfJe8tpQYvX/nx0f7FNJ7ICc/Qd0v7P3nDadG52XOAAIw
   cx0eL0wRB3ObWLD+DJEhYqdBA+J6fZQMhgBJY9QJV+IFsjOrg6J4S1CPc
   3tmtX/fx04TLsNrqdX/qyGyOBe4gResB3jkzxkuRM4BqpbfdMRILf4bNo
   w==;
IronPort-SDR: TPC7BAdRqhp79F2XHR2YtRNw9gLP7xm5Rj7fEuij1E+SK0o6ic9W1x7Y+C+/o5WA5Zxlh54H1I
 aqjP6e7K5oz13/syHfoEm6Ux6XNVfipgoXuN7Ks2iiDM078Ox45rpNiCbqSFY87fAtoqxJvLlm
 JoI9TE0cFvJloHcafO3xnAjfYINkYXuJAaB0bjfFA/TQDG3j8XzMVLeJ4BDKfoh1clW2umT78a
 k8+E3wiW4jDdNxMcIM/gQ0hL10WWZxemkUwYZy2H/ry0EQ85VKmjE3QUqChEaRqkimTxHPBf7d
 GjM=
X-IronPort-AV: E=Sophos;i="5.68,295,1569254400"; 
   d="scan'208";a="124326515"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 12:05:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFVQmaVbnzA2JScYkmPcLqvpE+mYt4Yj26bxX7Q7nRExfyGXtrvETAKTzVG1WgX0XCVFBjsORQcthmdDizTLPXEXW/i+lmXz4FdisL9JYVLvrn0rBNknRTEL7iyrUsfqOkty4SnEFw/oaC2XUR7zHC7n3JF+5ipYx8MGYPp9PLZQ2b8o1jvEdb6Yrl06dAUcxPpIwebUoCd1WlA0mINaHikBIKhGNK3kf7PCkH2YGfFrHk2IRd5osSvDR6ZSKzKDL/rcr/LHEDdp/EOg/tX0+sLflWqYlbgGYBMZFNm1x7RA6EDl4BakquRmJOlbH3nQZwYMlVDLxxmMWX6I90SI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbHtRgXJNPPh1Tgi2OvQj4WLJzuAqnxT+d30Y8lO4wo=;
 b=NO/OtCZEQG9umcR9GWx08z4BCgZx6kxcD9iag8UvfNAPJFVI3GxlKq7vUj1d36afh8+ru+wTTWoNefjWqqZP8wil2barI4pnsMDZScw76RZ1qCxRLjPDtc7Kx7n75bs1xJr2KCXhK9ryZjONwR9Sxdcfyc1vfrYb7yg9yB/+3l+7GgtWOYsHW1pBzAoEr/5fA+aBiDkvu1g6Vij1DxALwgTyVJ3zihNbFBI7A6OEckFy0LzVjgJzN5UrQM6cWtYekaPy4Cq4GwPWpCTOv0iWKSo2qT1OOHY0LggFkT/T+pYEM/cBAQhjeLTgYSu1J4B/r+dy3PnlVbPFRQvyBFONBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbHtRgXJNPPh1Tgi2OvQj4WLJzuAqnxT+d30Y8lO4wo=;
 b=jqtPAv5acND8nTncx/+wnAcL5G8Mhzj4Gz87je7cNbUx0ihlBD+8DCfccO0VpF+STzWB1WXbFQMcpMKNmCOrx4C5OSHUdBKIrQE8hSWliLpjovV9CUmG1m2ya3hPUpW3xIukh2uGbvCduJql60bEzrXo4qrCkqKm/p/4iL2VXak=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5367.namprd04.prod.outlook.com (20.178.50.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 04:05:42 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 04:05:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Topic: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Index: AQHVlis75ysrnBQ8Tkec+aEy36lA2g==
Date:   Tue, 12 Nov 2019 04:05:41 +0000
Message-ID: <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b783c7f-e7df-453a-f87d-08d7672595e8
x-ms-traffictypediagnostic: BYAPR04MB5367:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB53678B8F971056C23BFB6395E7770@BYAPR04MB5367.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(71190400001)(6246003)(66066001)(99286004)(53546011)(6506007)(86362001)(26005)(478600001)(110136005)(71200400001)(966005)(186003)(316002)(33656002)(2906002)(6116002)(2501003)(6436002)(102836004)(9686003)(3846002)(55016002)(74316002)(6306002)(7736002)(305945005)(66556008)(66476007)(64756008)(66946007)(486006)(229853002)(476003)(52536014)(76116006)(8676002)(25786009)(81156014)(8936002)(66446008)(81166006)(91956017)(4326008)(14454004)(14444005)(256004)(76176011)(7696005)(446003)(5660300002)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5367;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahQp8FnBeW/KfrzO21B/afoOe2gMPsDxg6HJwAYOEDbEJkgODkciNz3OyRdVj3GA3+eP5hWc46mK3D0QkYNf+gdGK4SqWsDCWAsRQ/2EGvdq2RDakfVXu2RpmnpGJkJIza2v7ikbp6TEkP25+9m2GAc2nt1M+7isO4x70FzG0mzXIeuv+0nqJ+gaAbT3mUoBIugn9M0HyCOCaqic4aWo7p6TV2Mc64kttEPUQ4wbHx7n4inbFtLt4g2NZe/wkKL45b4/4O2vIX4/GS+ssgsXj3voiydMQacuByAxydkSwYQIeh6a3SELzxuw58e9rSi/B9Dkr2weawQTjcB08nS3r/smBuH3RlgzFetHbw40+JWCaFkPXGh6n3dohTSsDdNATCJskO6Z3H2XTvL/u5aTO04wjjz1WaHASR9pKkopVV4+1iAsIN72dY9iGkdNcZmfzuHeuhBpVeFBwQXYu8KnOUKSJ6wTVibCEwUgw01afYOWIFD6ux+RFPnOUVgvG9azjTbRJKQCAHIAWZDk1Z2u1wFb4uFJnyT6xMZD4nmf3zM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b783c7f-e7df-453a-f87d-08d7672595e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 04:05:41.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9O8KzClfS6YqNetQaiA6ptlsL7e/VCYx6I6VUBNzPJn2Ouol6lGdCGw4vO/xtK9HTyQNy5ed0yYao7k/E6iig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5367
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/08 20:54, Tetsuo Handa wrote:=0A=
> syzbot found that a thread can stall for minutes inside fallocate()=0A=
> after that thread was killed by SIGKILL [1]. While trying to allocate=0A=
> 64TB of disk space using fallocate() is legal, delaying termination of=0A=
> killed thread for minutes is bad. Thus, allow iteration functions in=0A=
> block/blk-lib.c to be killable.=0A=
> =0A=
> [1] https://syzkaller.appspot.com/bug?id=3D9386d051e11e09973d5a4cf79af5e8=
cedf79386d=0A=
> =0A=
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>=0A=
> Reported-by: syzbot <syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.co=
m>=0A=
> ---=0A=
>  block/blk-lib.c | 44 ++++++++++++++++++++++++++++++++++++++++----=0A=
>  1 file changed, 40 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
> index 5f2c429..6ca7cae 100644=0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -7,9 +7,22 @@=0A=
>  #include <linux/bio.h>=0A=
>  #include <linux/blkdev.h>=0A=
>  #include <linux/scatterlist.h>=0A=
> +#include <linux/sched/signal.h>=0A=
>  =0A=
>  #include "blk.h"=0A=
>  =0A=
> +static int blk_should_abort(struct bio *bio)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	cond_resched();=0A=
> +	if (!fatal_signal_pending(current))=0A=
> +		return 0;=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
=0A=
This will change the behavior of __blkdev_issue_discard() to a sync IO=0A=
execution instead of the current async execution since submit_bio_wait()=0A=
call is the responsibility of the caller (e.g. blkdev_issue_discard()).=0A=
Have you checked if users of __blkdev_issue_discard() are OK with that ?=0A=
f2fs, ext4, xfs, dm and nvme use this function.=0A=
=0A=
Looking at f2fs, this does not look like it is going to work as expected=0A=
since the bio setup, including end_io callback, is done after this=0A=
function is called and a regular submit_bio() execution is being used.=0A=
=0A=
> +	bio_put(bio);=0A=
> +	return ret ? ret : -EINTR;=0A=
> +}=0A=
> +=0A=
>  struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t g=
fp)=0A=
>  {=0A=
>  	struct bio *new =3D bio_alloc(gfp, nr_pages);=0A=
> @@ -55,6 +68,7 @@ int __blkdev_issue_discard(struct block_device *bdev, s=
ector_t sector,=0A=
>  		return -EINVAL;=0A=
>  =0A=
>  	while (nr_sects) {=0A=
> +		int ret;=0A=
=0A=
Please add a white line after the declaration similarly to your change=0A=
in __blkdev_issue_write_same() and __blkdev_issue_zero_pages().=0A=
=0A=
>  		sector_t req_sects =3D min_t(sector_t, nr_sects,=0A=
>  				bio_allowed_max_sectors(q));=0A=
>  =0A=
> @@ -75,7 +89,11 @@ int __blkdev_issue_discard(struct block_device *bdev, =
sector_t sector,=0A=
>  		 * us to schedule out to avoid softlocking if preempt=0A=
>  		 * is disabled.=0A=
>  		 */=0A=
> -		cond_resched();=0A=
> +		ret =3D blk_should_abort(bio);=0A=
> +		if (ret) {=0A=
> +			*biop =3D NULL;=0A=
> +			return ret;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> @@ -154,6 +172,8 @@ static int __blkdev_issue_write_same(struct block_dev=
ice *bdev, sector_t sector,=0A=
>  	max_write_same_sectors =3D bio_allowed_max_sectors(q);=0A=
>  =0A=
>  	while (nr_sects) {=0A=
> +		int ret;=0A=
> +=0A=
>  		bio =3D blk_next_bio(bio, 1, gfp_mask);=0A=
>  		bio->bi_iter.bi_sector =3D sector;=0A=
>  		bio_set_dev(bio, bdev);=0A=
> @@ -171,7 +191,11 @@ static int __blkdev_issue_write_same(struct block_de=
vice *bdev, sector_t sector,=0A=
>  			bio->bi_iter.bi_size =3D nr_sects << 9;=0A=
>  			nr_sects =3D 0;=0A=
>  		}=0A=
> -		cond_resched();=0A=
> +		ret =3D blk_should_abort(bio);=0A=
> +		if (ret) {=0A=
> +			*biop =3D NULL;=0A=
> +			return ret;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> @@ -230,6 +254,8 @@ static int __blkdev_issue_write_zeroes(struct block_d=
evice *bdev,=0A=
>  		return -EOPNOTSUPP;=0A=
>  =0A=
>  	while (nr_sects) {=0A=
> +		int ret;=0A=
> +=0A=
>  		bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
>  		bio->bi_iter.bi_sector =3D sector;=0A=
>  		bio_set_dev(bio, bdev);=0A=
> @@ -245,7 +271,11 @@ static int __blkdev_issue_write_zeroes(struct block_=
device *bdev,=0A=
>  			bio->bi_iter.bi_size =3D nr_sects << 9;=0A=
>  			nr_sects =3D 0;=0A=
>  		}=0A=
> -		cond_resched();=0A=
> +		ret =3D blk_should_abort(bio);=0A=
> +		if (ret) {=0A=
> +			*biop =3D NULL;=0A=
> +			return ret;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> @@ -281,6 +311,8 @@ static int __blkdev_issue_zero_pages(struct block_dev=
ice *bdev,=0A=
>  		return -EPERM;=0A=
>  =0A=
>  	while (nr_sects !=3D 0) {=0A=
> +		int ret;=0A=
> +=0A=
>  		bio =3D blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),=0A=
>  				   gfp_mask);=0A=
>  		bio->bi_iter.bi_sector =3D sector;=0A=
> @@ -295,7 +327,11 @@ static int __blkdev_issue_zero_pages(struct block_de=
vice *bdev,=0A=
>  			if (bi_size < sz)=0A=
>  				break;=0A=
>  		}=0A=
> -		cond_resched();=0A=
> +		ret =3D blk_should_abort(bio);=0A=
> +		if (ret) {=0A=
> +			*biop =3D NULL;=0A=
> +			return ret;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
