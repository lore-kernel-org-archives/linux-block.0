Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB00C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 01:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB50222D4
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 01:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X6j8FHo9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pHQR95d+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfKMByT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:54:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20827 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfKMByS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 20:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573610057; x=1605146057;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eyvOOXwuwXGhuPNpxMS8ZDwUfmdlKWgqYwoxA0RD4NM=;
  b=X6j8FHo9x9qIAhjlgDxXzx3lHnvCARIJl4tcl9Y5K/CtwEa3l57rBRiN
   GenbiTkxFI3Q7c6811bP1SQbvUrm9JwLReI5cn+lBnvWraAdB74UO91TI
   yUd9n9Nf9vO92k6aIySkYskb4xS6SvcUhs712IgCeCb9qAASN7oW/wyNH
   HxdEtn+NV2cBlZ+5NBKUxMcWsSwH3lIENQk2KI2xSY/qRHoX/HGPIk8Lu
   86rimJ1+PmlnZoH0Sicg5RCJewDi3SiI6eAFKqKblZEnc4ch0eqol9Wvf
   gu8x5oKJMV2RAc+QpH/4kFFqtDnNLnPDi7yM1j62DXz1Cw6mFcjRoYupt
   Q==;
IronPort-SDR: FzvaCM9m+6h4VIOWRnWZ+Ct/T7RU+j6K4w61I7oDxYfloO/Fjl/xM2HXe9u9bncE2I/+PMSm8Y
 CQlPkLQvL77rJHumTF+38ighuVu3+2OjuemkPyfttdT+AuluzFoYB39Cp9adkdt13+elkY+fJH
 lGUjHRXQFhft0sK2smoXDTCYkfXu2SvDPPE//Lyl7ECOcQXbwt4ik52RdN9M06sZC31Qesvs9j
 KzRvvHmUkY2R7iw6D1G1ShytmxfLcCvY0kcQfR9IYTTfNNcR5RAeyjRDUh4gAOylL9akVJMzqc
 lOI=
X-IronPort-AV: E=Sophos;i="5.68,298,1569254400"; 
   d="scan'208";a="122839450"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2019 09:54:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAzCNy5h6Z4Z7JdEuAuHlRRfnwtCaQ6rL67V9rfyIkcJeSrSm+4E7nNfOJ6MA5g2ZglwCwfXgsItvdGgytvQx+jFB8q63SjuwYd44TZ7k8kHSRD7gixQN+9BhfvNRO/ntk642Dn/PcHZNvwwU3lfuztw2LyL4k55ns9KHCXM/BML2ZqqSZJoqIFFUF8g8p9Tk85lb+hjpPr4s6Xuhch/TEZQa+bdRZcbIcxMH5B1Qu9c8zAHq4W3ts8LdOPh+NK6fzfu9J7ceTq3GL1NgZMDyq/gXwXZuzXhy+dVvzLtv0ZCxPEMP4auHe3xjP+yAmAc/Up6Nmuy29+Nrko06bqU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM5W/rhYZ1NW2RgwAobJm5nP6I/JFSSJpODgEUpIVrk=;
 b=H7ZO9eUDGCyvgASHw5cZp8zLvd6ZmZ2yOJ79o6OL6edp/uTrdcIGtJH8aKKZ2LjRRWR+JvDheyShH/g1SQlnHV0nsSfJx1zBY/oPdEdLVYblSBHjMi+llP+q35JdZ2ZDXd77OwNG4IdbPAb+2zygrywIkBWnQXRxyQDG2Wr6UC0bc+qpRlkl6+Y5B4CRmoXrjNIvg6uXI6DZi6rKeT84thTSam8rD9EIFlZuuEErBP2lCfmPu5bk8Ow+/8V5hVDeh24JzqTc2vkuMLrCJ2/KyWKguYHE3jz0W2LihmrDzO3ar8/vg9kiAGaNi/DEmrwBc1gJ3DtC4lE7Wcgyc3QQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM5W/rhYZ1NW2RgwAobJm5nP6I/JFSSJpODgEUpIVrk=;
 b=pHQR95d+PO86hrt/OqS/SokfPA8gJEbLRaJPZnYL6YQkCVJTeff85ka3buRDQdrVG/bzfimnDoK9tfAHgLoPezABQUu6cyS0AyltI+h8XeVtJHiiVnLsYr1oklGL05LZ65bJ5TozofkBrIXED8LSV62SyI6WkgRYNNkttGTeXgY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4199.namprd04.prod.outlook.com (20.176.251.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 01:54:15 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 01:54:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Topic: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Index: AQHVlis75ysrnBQ8Tkec+aEy36lA2g==
Date:   Wed, 13 Nov 2019 01:54:14 +0000
Message-ID: <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
 <272e3542-72ab-12ff-636b-722a68a2589c@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18baf0b5-06f4-4a02-5257-08d767dc6349
x-ms-traffictypediagnostic: BYAPR04MB4199:
x-microsoft-antispam-prvs: <BYAPR04MB419959BF0ACCAEA81EA1D382E7760@BYAPR04MB4199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(256004)(8936002)(66946007)(3846002)(7696005)(14444005)(186003)(74316002)(66066001)(33656002)(71200400001)(229853002)(91956017)(446003)(71190400001)(66476007)(66556008)(64756008)(66446008)(476003)(76116006)(76176011)(6116002)(486006)(9686003)(6436002)(14454004)(81156014)(81166006)(110136005)(4326008)(102836004)(2906002)(5660300002)(99286004)(6506007)(25786009)(6246003)(86362001)(8676002)(52536014)(478600001)(55016002)(7736002)(316002)(26005)(53546011)(305945005)(2501003)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4199;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+zTsz0J7yNPzJjswm++VhM8FlA8/pVd5kJBuAtdr0j5HH8YXOF8hvNAM4bipgDeDRrOw3bVjUHpYbJHnetm5H2IIs7xcq+t1fmW4p9yoNacAkq9jb+qHOyHK4zWVclb69ogl9babaX7qePV5dKcMLwP2IReoVixMndXmR4BKb9IrkiGF4lyebva4BxGMaEfnH/iyvBykNoVfPH6faHD4lrj55Lf+tVcx+CBSa01gr2I/opxtVY3KhwlBJS+96pOep9IjNz42IJkj+Vl57NeB8FBDj7h06FI0ZAh1/umqRhsj1auvqvlBKYImFBZjmnq5TfbnJVhX0eM5+J+pUbWONmGnJOO6rpdzLNGDepM+Nj3w2QBMi8SyPr7i6cMLyXQh4N7+WwVi8dpnX7NhKMBa/VORqGssSUF+JP4A8kWmJA2QWpY2+NllccGb5sBlds9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18baf0b5-06f4-4a02-5257-08d767dc6349
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 01:54:14.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6IW838V+8AOiX0UC+Ww15uakbQtySHz7O8f1Ktx+H3vSCb4x/HMKQ70ZXEvYb4PBrIagtMuPa8d+ojggDYxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/12 23:48, Tetsuo Handa wrote:=0A=
[...]=0A=
>>> +static int blk_should_abort(struct bio *bio)=0A=
>>> +{=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	cond_resched();=0A=
>>> +	if (!fatal_signal_pending(current))=0A=
>>> +		return 0;=0A=
>>> +	ret =3D submit_bio_wait(bio);=0A=
>>=0A=
>> This will change the behavior of __blkdev_issue_discard() to a sync IO=
=0A=
>> execution instead of the current async execution since submit_bio_wait()=
=0A=
>> call is the responsibility of the caller (e.g. blkdev_issue_discard()).=
=0A=
>> Have you checked if users of __blkdev_issue_discard() are OK with that ?=
=0A=
>> f2fs, ext4, xfs, dm and nvme use this function.=0A=
> =0A=
> I'm not sure...=0A=
> =0A=
>>=0A=
>> Looking at f2fs, this does not look like it is going to work as expected=
=0A=
>> since the bio setup, including end_io callback, is done after this=0A=
>> function is called and a regular submit_bio() execution is being used.=
=0A=
> =0A=
> Then, just breaking the iteration like below?=0A=
> nvmet_bdev_execute_write_zeroes() ignores -EINTR if "*biop =3D bio;" is d=
one. Is that no problem?=0A=
> =0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -7,6 +7,7 @@=0A=
>  #include <linux/bio.h>=0A=
>  #include <linux/blkdev.h>=0A=
>  #include <linux/scatterlist.h>=0A=
> +#include <linux/sched/signal.h>=0A=
>  =0A=
>  #include "blk.h"=0A=
>  =0A=
> @@ -30,6 +31,7 @@ int __blkdev_issue_discard(struct block_device *bdev, s=
ector_t sector,=0A=
>  	struct bio *bio =3D *biop;=0A=
>  	unsigned int op;=0A=
>  	sector_t bs_mask;=0A=
> +	int ret =3D 0;=0A=
>  =0A=
>  	if (!q)=0A=
>  		return -ENXIO;=0A=
> @@ -76,10 +78,14 @@ int __blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,=0A=
>  		 * is disabled.=0A=
>  		 */=0A=
>  		cond_resched();=0A=
> +		if (fatal_signal_pending(current)) {=0A=
> +			ret =3D -EINTR;=0A=
> +			break;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> -	return 0;=0A=
> +	return ret;=0A=
=0A=
This will leak a bio as blkdev_issue_discard() executes the bio only in=0A=
the case "if (!ret && bio)". So that does not work as is, unless all=0A=
callers of __blkdev_issue_discard() are also changed. Same problem for=0A=
the other __blkdev_issue_xxx() functions.=0A=
=0A=
Looking more into this, if an error is returned here, no bio should be=0A=
returned and we need to make sure that all started bios are also=0A=
completed. So your helper blk_should_abort() did the right thing calling=0A=
submit_bio_wait(). However, I Think it would be better to fail=0A=
immediately the current loop bio instead of executing it and then=0A=
reporting the -EINTR error, unconditionally, regardless of what the=0A=
started bios completion status is.=0A=
=0A=
This could be done with the help of a function like this, very similar=0A=
to submit_bio_wait().=0A=
=0A=
void bio_chain_end_wait(struct bio *bio)=0A=
{=0A=
	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);=0A=
=0A=
	bio->bi_private =3D &done;=0A=
	bio->bi_end_io =3D submit_bio_wait_endio;=0A=
	bio->bi_opf |=3D REQ_SYNC;=0A=
	bio_endio(bio);=0A=
	wait_for_completion_io(&done);=0A=
}=0A=
=0A=
And then your helper function becomes something like this:=0A=
=0A=
static int blk_should_abort(struct bio *bio)=0A=
{=0A=
	int ret;=0A=
=0A=
	cond_resched();=0A=
	if (!fatal_signal_pending(current))=0A=
		return 0;=0A=
=0A=
	if (bio_flagged(bio, BIO_CHAIN))=0A=
		bio_chain_end_wait(bio);=0A=
	bio_put(bio);=0A=
=0A=
	return -EINTR;=0A=
}=0A=
=0A=
Thoughts ?=0A=
=0A=
=0A=
>  }=0A=
>  EXPORT_SYMBOL(__blkdev_issue_discard);=0A=
>  =0A=
> @@ -136,6 +142,7 @@ static int __blkdev_issue_write_same(struct block_dev=
ice *bdev, sector_t sector,=0A=
>  	unsigned int max_write_same_sectors;=0A=
>  	struct bio *bio =3D *biop;=0A=
>  	sector_t bs_mask;=0A=
> +	int ret =3D 0;=0A=
>  =0A=
>  	if (!q)=0A=
>  		return -ENXIO;=0A=
> @@ -172,10 +179,14 @@ static int __blkdev_issue_write_same(struct block_d=
evice *bdev, sector_t sector,=0A=
>  			nr_sects =3D 0;=0A=
>  		}=0A=
>  		cond_resched();=0A=
> +		if (fatal_signal_pending(current)) {=0A=
> +			ret =3D -EINTR;=0A=
> +			break;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> -	return 0;=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> @@ -216,6 +227,7 @@ static int __blkdev_issue_write_zeroes(struct block_d=
evice *bdev,=0A=
>  	struct bio *bio =3D *biop;=0A=
>  	unsigned int max_write_zeroes_sectors;=0A=
>  	struct request_queue *q =3D bdev_get_queue(bdev);=0A=
> +	int ret =3D 0;=0A=
>  =0A=
>  	if (!q)=0A=
>  		return -ENXIO;=0A=
> @@ -246,10 +258,14 @@ static int __blkdev_issue_write_zeroes(struct block=
_device *bdev,=0A=
>  			nr_sects =3D 0;=0A=
>  		}=0A=
>  		cond_resched();=0A=
> +		if (fatal_signal_pending(current)) {=0A=
> +			ret =3D -EINTR;=0A=
> +			break;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> -	return 0;=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -273,6 +289,7 @@ static int __blkdev_issue_zero_pages(struct block_dev=
ice *bdev,=0A=
>  	struct bio *bio =3D *biop;=0A=
>  	int bi_size =3D 0;=0A=
>  	unsigned int sz;=0A=
> +	int ret =3D 0;=0A=
>  =0A=
>  	if (!q)=0A=
>  		return -ENXIO;=0A=
> @@ -296,10 +313,14 @@ static int __blkdev_issue_zero_pages(struct block_d=
evice *bdev,=0A=
>  				break;=0A=
>  		}=0A=
>  		cond_resched();=0A=
> +		if (fatal_signal_pending(current)) {=0A=
> +			ret =3D -EINTR;=0A=
> +			break;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	*biop =3D bio;=0A=
> -	return 0;=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> =0A=
>>=0A=
>>> +	bio_put(bio);=0A=
>>> +	return ret ? ret : -EINTR;=0A=
>>> +}=0A=
>>> +=0A=
>>>  struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t=
 gfp)=0A=
>>>  {=0A=
>>>  	struct bio *new =3D bio_alloc(gfp, nr_pages);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
