Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5D9C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBB920B7C
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SpNzvQSE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uwRs35Dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfHINCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:02:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2664 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfHINCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 09:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565355721; x=1596891721;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iedNbvAMzWAUXb2YWUQcHq7HPXJJXEMy899Wn5JLAsY=;
  b=SpNzvQSEW8SQTmTGEUIDkRIAHqvWGkvpmYlNfVkG+3of5BOqKqBMLmpE
   Vku/uZnmDdSqrDWgx1zHznRvp0h0yCEV1YgmsCQd03j+5PddEABaGEZaS
   NoUmp9cvF0oH6C6elqG9HckwiJTkjYbGs/Di2ShEKwcx/vVSLIhc0z5bD
   kPEnaFWtV3W7UJA+5ACYkVNLuAetGDhU9Z+HuUT9RMlzswTyqdbwOcj9f
   eHBrwNpF2iYZ9vFyF3Me0yy48g+6vBNxsKfj0fjakjXplnNKt0YUqJabg
   VbwKDZzYPCDHtyCHm6+f6aZTQ3CZTTzVxt3L+T5J2B8x4bJE4CGCrlMZ1
   g==;
IronPort-SDR: CHSsoEBZ+13A04Ox08z+47w2ZFIUw2FQIEakzT+zJ8M+tcR6W2l0/Xo4U/dBzz/iToDi9AAPSj
 VzA6KIW+SO1XrecWNc2I4UlpqmFXRfC/Vgmgf2+bnaZ36NAe0ktL0ux+Wx/MQSOq7MkY+eE53q
 hsbyFwvcUI6KxEwe6Ffq82B1YyJd1skFPqT6V06jz7tqRNHsmkN3yyUUpF+5zdih1owWdHL4EK
 llbMF0GwP/3GNIaQYi5w2bUqmK9T5p+xniidxrtbZGlS2ynoiJUnUKh13YeNUcS/EvQOEayA7d
 kpQ=
X-IronPort-AV: E=Sophos;i="5.64,364,1559491200"; 
   d="scan'208";a="117081003"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2019 21:01:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnMKxkx010/66+gbUi6fugQqOT4CligP0skAGh+j4PJbycmzHJQV+MCq6DediFwqwUl5v62mWUKq45T8gRbAcc/zKXam0y/92Xe8hLlPpHRqTyHA+Xg+urOjxHmJwru1iD8yHjmlPVyOcBBAHrz8JxIc7v5Bwl9d5ohauFoxzwPFRMU21NADPJgQqcXPEA+Wz6EBw4iuwlMnbIqkJ9acQCDh9ZcuHWB6bvX9OcoNIrZcpqMCCNfYE+C0JV9OsadC3/i97bmP0ehBYXJmdO0WGogL77dCi6m8/US6Q43ZyfrR0wLqm/V7H3seIc6xCVZBSELY8e8GYDwkwyVevOHm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvg4TNcvYVwmLJNvBIgQiOpjpZlER2RV5yYADIkKC+c=;
 b=EwDFYo/bqWsq2CD7E1qjHBpNeV0Bc1UbuOv51Cx8WChxMY6NS8TCsPhj/eS7Hw/j4ZLZrJdbDocdnxD6NWF0KqHyFlfr8sG2UqqHYWZXDWTfF+vtzhSV6+z4Hin2Sld1tx2ZshTDsKePtbG9NMl8OBCTrmso4eKdhtIP4kE8KQCbmJIeHskrJ2RMmsOrR32FlhYdUA16TqC02FU3RbQ9vHhzrgPT/jHYZBooAj/DBMsfeOIPX6O8U3KnFvOaaoHRQTWFz8LFYDfhlpE9IwbjZYBF4tFSaJ1UPkEUa5rcgaTgt5ilXaEXMv2RVUEPhqWpd5UfZcqTDcRagIpM5faqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvg4TNcvYVwmLJNvBIgQiOpjpZlER2RV5yYADIkKC+c=;
 b=uwRs35DyANJRkGPD8ojB54ffD11ZjLFuZS1q+DXNkoCO/bIhIUx8MvvWOpusvUIsekoWOTgc7uZUKwPcGVBw3x+KlEKTlrtgrJG3JU6TrgbP9UiAZzTSJetFkMMkb0DYv6RhConaHYWe7tL3eG8mZngLEHdPKY0BOCQ7QhdVkCk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5687.namprd04.prod.outlook.com (20.179.57.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Fri, 9 Aug 2019 13:01:55 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 13:01:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
Thread-Topic: [PATCH] block: Fix __blkdev_direct_IO()
Thread-Index: AQHVSFLzGnfcCVN4LE65o4/UfXYJWQ==
Date:   Fri, 9 Aug 2019 13:01:54 +0000
Message-ID: <BYAPR04MB5816CA21355412EA7DAEA4A3E7D60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
 <8d6bb95a-3bf5-4bee-90ca-1b0110e39ff1@acm.org>
 <5b739a9f-9dc3-ea1f-82e4-d42c756bf9b7@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a96c45-1e97-4e05-09f7-08d71cc9c130
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5687;
x-ms-traffictypediagnostic: BYAPR04MB5687:
x-microsoft-antispam-prvs: <BYAPR04MB568743B434422839355DF46BE7D60@BYAPR04MB5687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(376002)(366004)(346002)(136003)(51234002)(199004)(189003)(66476007)(86362001)(71190400001)(71200400001)(76116006)(14444005)(14454004)(256004)(66556008)(64756008)(66446008)(4326008)(45080400002)(74316002)(66946007)(8676002)(30864003)(52536014)(5660300002)(478600001)(186003)(476003)(33656002)(486006)(6436002)(2501003)(102836004)(9686003)(55016002)(7696005)(229853002)(53546011)(8936002)(26005)(99286004)(446003)(76176011)(6506007)(53946003)(2906002)(53936002)(6116002)(316002)(7736002)(66066001)(305945005)(25786009)(3846002)(6246003)(81166006)(81156014)(54906003)(110136005)(559001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5687;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KzDw5Yk0NjMbNOu4m4xF45CCuz8eeDCX7t7y7sJ4cT0Hvkey+qJpc82fyCd8LHunblUNSHMBitjCl8w72zGIbXmhbo4ZwS3F+yldNlKOGRlg0M3H5HLzVY6Il8ZGl8cq57vUR4crUcxxTTbkGSHAQajdG/YGxQtVTP9tKitdzWS1ewoHdxdEk2kQeWU3I3C/gnJR6g6VFVXxdMyM6g7Jg9q5j6EK8ZKqgc+xzu5/ge/GUauxUDo1wma0qIvhUj08fPRgfKWL6RNr/Nn4JOnAC9jCGzx0iwzG8j5uBqiUv7e8jj/pzGVQp3SmW4N1BRiwW080Aa2Su452ritgmKqpCVMFcpDQx1RQHIsHdKPBoXMWkcCV6+k1GrKlcjH3M5Vq35/nlm/fs7G20rX78orBG43X0hS5niDOl9zbowV+S8A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a96c45-1e97-4e05-09f7-08d71cc9c130
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 13:01:54.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JW2AvwlmaAcPOfbQiA81D7EoTOJlPMFIsHTf6K/IYPavpbMlhR1kxol43slTQGhpTenFW0EBqvV9I0DMI5LkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5687
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/07 4:53, Jens Axboe wrote:=0A=
>> Hi Damien,=0A=
>>=0A=
>> Had you verified this patch with blktests and KASAN enabled? I think the=
=0A=
>> above patch introduced the following KASAN complaint:=0A=
> =0A=
> I posted this in another thread, can you try?=0A=
> =0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index a6f7c892cb4a..131e2e0582a6 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  	loff_t pos =3D iocb->ki_pos;=0A=
>  	blk_qc_t qc =3D BLK_QC_T_NONE;=0A=
>  	gfp_t gfp;=0A=
> -	ssize_t ret;=0A=
> +	int ret;=0A=
>  =0A=
>  	if ((pos | iov_iter_alignment(iter)) &=0A=
>  	    (bdev_logical_block_size(bdev) - 1))=0A=
> @@ -386,8 +386,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  =0A=
>  	ret =3D 0;=0A=
>  	for (;;) {=0A=
> -		int err;=0A=
> -=0A=
>  		bio_set_dev(bio, bdev);=0A=
>  		bio->bi_iter.bi_sector =3D pos >> 9;=0A=
>  		bio->bi_write_hint =3D iocb->ki_hint;=0A=
> @@ -395,10 +393,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_it=
er *iter, int nr_pages)=0A=
>  		bio->bi_end_io =3D blkdev_bio_end_io;=0A=
>  		bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
>  =0A=
> -		err =3D bio_iov_iter_get_pages(bio, iter);=0A=
> -		if (unlikely(err)) {=0A=
> -			if (!ret)=0A=
> -				ret =3D err;=0A=
> +		ret =3D bio_iov_iter_get_pages(bio, iter);=0A=
> +		if (unlikely(ret)) {=0A=
>  			bio->bi_status =3D BLK_STS_IOERR;=0A=
>  			bio_endio(bio);=0A=
>  			break;=0A=
> @@ -421,7 +417,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  		if (nowait)=0A=
>  			bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=0A=
>  =0A=
> -		dio->size +=3D bio->bi_iter.bi_size;=0A=
>  		pos +=3D bio->bi_iter.bi_size;=0A=
>  =0A=
>  		nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
> @@ -433,13 +428,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>  				polled =3D true;=0A=
>  			}=0A=
>  =0A=
> +			dio->size +=3D bio->bi_iter.bi_size;=0A=
>  			qc =3D submit_bio(bio);=0A=
>  			if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
> -				if (!ret)=0A=
> -					ret =3D -EAGAIN;=0A=
> +				dio->size -=3D bio->bi_iter.bi_size;=0A=
> +				ret =3D -EAGAIN;=0A=
>  				goto error;=0A=
>  			}=0A=
> -			ret =3D dio->size;=0A=
>  =0A=
>  			if (polled)=0A=
>  				WRITE_ONCE(iocb->ki_cookie, qc);=0A=
> @@ -460,18 +455,17 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>  			atomic_inc(&dio->ref);=0A=
>  		}=0A=
>  =0A=
> +		dio->size +=3D bio->bi_iter.bi_size;=0A=
>  		qc =3D submit_bio(bio);=0A=
>  		if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
> -			if (!ret)=0A=
> -				ret =3D -EAGAIN;=0A=
> +			dio->size -=3D bio->bi_iter.bi_size;=0A=
> +			ret =3D -EAGAIN;=0A=
>  			goto error;=0A=
>  		}=0A=
> -		ret =3D dio->size;=0A=
>  =0A=
>  		bio =3D bio_alloc(gfp, nr_pages);=0A=
>  		if (!bio) {=0A=
> -			if (!ret)=0A=
> -				ret =3D -EAGAIN;=0A=
> +			ret =3D -EAGAIN;=0A=
>  			goto error;=0A=
>  		}=0A=
>  	}=0A=
> @@ -496,6 +490,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  out:=0A=
>  	if (!ret)=0A=
>  		ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
> +	if (likely(!ret))=0A=
> +		ret =3D dio->size;=0A=
>  =0A=
>  	bio_put(&dio->bio);=0A=
>  	return ret;=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
I tested a slightly modified version of your patch. I think it is 100%=0A=
equivalent, but a little cleaner in my opinion.=0A=
=0A=
diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
index a6f7c892cb4a..343cd716c53b 100644=0A=
--- a/fs/block_dev.c=0A=
+++ b/fs/block_dev.c=0A=
@@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
        loff_t pos =3D iocb->ki_pos;=0A=
        blk_qc_t qc =3D BLK_QC_T_NONE;=0A=
        gfp_t gfp;=0A=
-       ssize_t ret;=0A=
+       ssize_t ret =3D 0;=0A=
=0A=
        if ((pos | iov_iter_alignment(iter)) &=0A=
            (bdev_logical_block_size(bdev) - 1))=0A=
@@ -386,7 +386,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
=0A=
        ret =3D 0;=0A=
        for (;;) {=0A=
-               int err;=0A=
+               unsigned int bio_size;=0A=
=0A=
                bio_set_dev(bio, bdev);=0A=
                bio->bi_iter.bi_sector =3D pos >> 9;=0A=
@@ -395,10 +395,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
                bio->bi_end_io =3D blkdev_bio_end_io;=0A=
                bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
=0A=
-               err =3D bio_iov_iter_get_pages(bio, iter);=0A=
-               if (unlikely(err)) {=0A=
-                       if (!ret)=0A=
-                               ret =3D err;=0A=
+               ret =3D bio_iov_iter_get_pages(bio, iter);=0A=
+               if (unlikely(ret)) {=0A=
                        bio->bi_status =3D BLK_STS_IOERR;=0A=
                        bio_endio(bio);=0A=
                        break;=0A=
@@ -421,7 +419,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
                if (nowait)=0A=
                        bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=
=0A=
=0A=
-               dio->size +=3D bio->bi_iter.bi_size;=0A=
+               bio_size =3D bio->bi_iter.bi_size;=0A=
+               dio->size +=3D bio_size;=0A=
                pos +=3D bio->bi_iter.bi_size;=0A=
=0A=
                nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
@@ -435,11 +434,11 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
=0A=
                        qc =3D submit_bio(bio);=0A=
                        if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
-                               if (!ret)=0A=
+                               dio->size -=3D bio_size;=0A=
+                               if (!dio->size)=0A=
                                        ret =3D -EAGAIN;=0A=
                                goto error;=0A=
                        }=0A=
-                       ret =3D dio->size;=0A=
=0A=
                        if (polled)=0A=
                                WRITE_ONCE(iocb->ki_cookie, qc);=0A=
@@ -462,18 +461,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
=0A=
                qc =3D submit_bio(bio);=0A=
                if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
-                       if (!ret)=0A=
+                       dio->size -=3D bio_size;=0A=
+                       if (!dio->size)=0A=
                                ret =3D -EAGAIN;=0A=
                        goto error;=0A=
                }=0A=
-               ret =3D dio->size;=0A=
=0A=
                bio =3D bio_alloc(gfp, nr_pages);=0A=
-               if (!bio) {=0A=
-                       if (!ret)=0A=
-                               ret =3D -EAGAIN;=0A=
+               if (!bio)=0A=
                        goto error;=0A=
-               }=0A=
        }=0A=
=0A=
        if (!is_poll)=0A=
@@ -496,6 +492,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
 out:=0A=
        if (!ret)=0A=
                ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
+       if (likely(!ret))=0A=
+               ret =3D dio->size;=0A=
=0A=
        bio_put(&dio->bio);=0A=
        return ret;=0A=
=0A=
To test and make sure that I can consistently create EAGAIN errors with=0A=
RWF_NOWAIT, I set an HDD QD to 1, its nr_requests to 4 (minimum), enable=0A=
"nomerges" and set the disk max_sectors_kb to 512 KB. With this, at most 4 =
512KB=0A=
requests can be issued at any time, meaning that for a DIO larger than=0A=
5123KBx4=3D2MB, BIO fragments issuing will likely hit EAGAIN due to the lac=
k of tags.=0A=
=0A=
With this, here is what I get for tests with 4MB direct write IOs, with all=
=0A=
cases (sync/async, nowait or not).=0A=
=0A=
## sync, wait case=0A=
4194304 4194304			<- requested size, size return by pwritev2()=0A=
0 KB read, 4096 KB writen	<- from iostat, KB amount read/written=0A=
=0A=
regular sync+wait case is OK.=0A=
=0A=
## sync, nowait case=0A=
4194304 4194304			<- KASAN use-after-free warning=0A=
0 KB read, 4608 KB writen	<- One more 512KB BIO issued than reported=0A=
=0A=
With sync+nowait, sizes are correct but iostat shows too many writes. Also =
of=0A=
note is that there was some fragments failed on submission with EAGAIN, and=
=0A=
despite that, the size returned match the size asked for instead of a small=
er size.=0A=
=0A=
## async, wait case=0A=
4194304 4194304=0A=
0 KB read, 4096 KB writen=0A=
=0A=
## async, nowait case=0A=
4194304 4194304=0A=
0 KB read, 4096 KB writen=0A=
=0A=
The 2 async cases are OK.=0A=
=0A=
Something is wrong with the sync+nowait case, but I cannot quite yet figure=
 out=0A=
what. What I gather so far is this:=0A=
- BIO_MAX_PAGES being 256, the BIO fragments are 1MB. But the disk max_sect=
or_kb=0A=
being 512KB, the BIO fragments get split into 2 512KB requests. It looks li=
ke=0A=
one of the fragment split is failed with EAGAIN, but the other split makes =
it to=0A=
the disk, showing an excess 512KB. Changing the disk max_sector_kb to 256 o=
r=0A=
128, I see the excess being exactly that every time. That said, the total s=
ize=0A=
should still be lower than the requested 4MB since the BIO fragments submis=
sion=0A=
stopped before the entire dio was processed.=0A=
=0A=
I have been playing around with the following patch on top of the previous =
one,=0A=
to make sure that BIOs are being freed (I believe the current code leaks th=
em on=0A=
EAGAIN) and the dio completed.=0A=
=0A=
diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
index 343cd716c53b..bbb694c4a8c4 100644=0A=
--- a/fs/block_dev.c=0A=
+++ b/fs/block_dev.c=0A=
@@ -295,6 +295,31 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wai=
t)=0A=
        return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);=0A=
 }=0A=
=0A=
+static void blkdev_dio_end(struct blkdev_dio *dio)=0A=
+{=0A=
+       pr_info("--- DIO done %zu B\n", dio->size);=0A=
+       if (!dio->is_sync) {=0A=
+               struct kiocb *iocb =3D dio->iocb;=0A=
+               ssize_t ret;=0A=
+=0A=
+               if (likely(!dio->bio.bi_status)) {=0A=
+                       ret =3D dio->size;=0A=
+                       iocb->ki_pos +=3D ret;=0A=
+               } else {=0A=
+                       ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
+               }=0A=
+=0A=
+               dio->iocb->ki_complete(iocb, ret, 0);=0A=
+               if (dio->multi_bio)=0A=
+                       bio_put(&dio->bio);=0A=
+       } else {=0A=
+               struct task_struct *waiter =3D dio->waiter;=0A=
+=0A=
+               WRITE_ONCE(dio->waiter, NULL);=0A=
+               blk_wake_io_task(waiter);=0A=
+       }=0A=
+}=0A=
+=0A=
 static void blkdev_bio_end_io(struct bio *bio)=0A=
 {=0A=
        struct blkdev_dio *dio =3D bio->bi_private;=0A=
@@ -303,28 +328,9 @@ static void blkdev_bio_end_io(struct bio *bio)=0A=
        if (bio->bi_status && !dio->bio.bi_status)=0A=
                dio->bio.bi_status =3D bio->bi_status;=0A=
=0A=
-       if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {=0A=
-               if (!dio->is_sync) {=0A=
-                       struct kiocb *iocb =3D dio->iocb;=0A=
-                       ssize_t ret;=0A=
-=0A=
-                       if (likely(!dio->bio.bi_status)) {=0A=
-                               ret =3D dio->size;=0A=
-                               iocb->ki_pos +=3D ret;=0A=
-                       } else {=0A=
-                               ret =3D blk_status_to_errno(dio->bio.bi_sta=
tus);=0A=
-                       }=0A=
-=0A=
-                       dio->iocb->ki_complete(iocb, ret, 0);=0A=
-                       if (dio->multi_bio)=0A=
-                               bio_put(&dio->bio);=0A=
-               } else {=0A=
-                       struct task_struct *waiter =3D dio->waiter;=0A=
-=0A=
-                       WRITE_ONCE(dio->waiter, NULL);=0A=
-                       blk_wake_io_task(waiter);=0A=
-               }=0A=
-       }=0A=
+       pr_info("--- BIO done, dio %zu B\n", dio->size);=0A=
+       if (!dio->multi_bio || atomic_dec_and_test(&dio->ref))=0A=
+               blkdev_dio_end(dio);=0A=
=0A=
        if (should_dirty) {=0A=
                bio_check_pages_dirty(bio);=0A=
@@ -351,6 +357,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
        gfp_t gfp;=0A=
        ssize_t ret =3D 0;=0A=
=0A=
+       pr_info("=3D=3D=3D=3D=3D=3D __blkdev_direct_IO =3D=3D=3D=3D=3D=3D\n=
");=0A=
+=0A=
        if ((pos | iov_iter_alignment(iter)) &=0A=
            (bdev_logical_block_size(bdev) - 1))=0A=
                return -EINVAL;=0A=
@@ -421,7 +429,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
=0A=
                bio_size =3D bio->bi_iter.bi_size;=0A=
                dio->size +=3D bio_size;=0A=
-               pos +=3D bio->bi_iter.bi_size;=0A=
+               pos +=3D bio_size;=0A=
+=0A=
+               pr_info("+++ BIO frag %u B\n", bio_size);=0A=
=0A=
                nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
                if (!nr_pages) {=0A=
@@ -435,9 +445,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
                        qc =3D submit_bio(bio);=0A=
                        if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
                                dio->size -=3D bio_size;=0A=
-                               if (!dio->size)=0A=
-                                       ret =3D -EAGAIN;=0A=
-                               goto error;=0A=
+                               ret =3D -EAGAIN;=0A=
+                               pr_info("last BIO submit eagain, dio %zu B\=
n",=0A=
dio->size);=0A=
+                               break;=0A=
                        }=0A=
=0A=
                        if (polled)=0A=
@@ -462,19 +472,53 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
                qc =3D submit_bio(bio);=0A=
                if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
                        dio->size -=3D bio_size;=0A=
-                       if (!dio->size)=0A=
-                               ret =3D -EAGAIN;=0A=
-                       goto error;=0A=
+                       pr_info("BIO submit eagain, dio %zu B\n", dio->size=
);=0A=
+                       /*=0A=
+                        * The reference on dio taken above is for the next=
=0A=
+                        * fragment, not his one.=0A=
+                        */=0A=
+                       atomic_dec(&dio->ref);=0A=
+                       ret =3D -EAGAIN;=0A=
+                       break;=0A=
                }=0A=
=0A=
                bio =3D bio_alloc(gfp, nr_pages);=0A=
-               if (!bio)=0A=
-                       goto error;=0A=
+               if (!bio) {=0A=
+                       pr_info("BIO alloc eagain, dio %zu B\n", dio->size)=
;=0A=
+                       ret =3D -EAGAIN;=0A=
+                       break;=0A=
+               }=0A=
        }=0A=
=0A=
        if (!is_poll)=0A=
                blk_finish_plug(&plug);=0A=
=0A=
+       if (ret =3D=3D -EAGAIN) {=0A=
+               WARN_ON(!nowait);=0A=
+=0A=
+               /*=0A=
+                * If no BIO could be issued in the nowait case, fail every=
thing=0A=
+                * with EAGAIN.=0A=
+                */=0A=
+               if (!dio->size)=0A=
+                       goto out;=0A=
+=0A=
+               /*=0A=
+                * A fragment of a multi-bio dio could not be issued in the=
=0A=
+                * nowait case: allow issued fragments to proceed (resultin=
g in=0A=
+                * a short dio) and ensure completion of the dio by complet=
ing=0A=
+                * the failed fragment to decrement the extra reference tak=
en=0A=
+                * on the dio and release the bio pages.=0A=
+                */=0A=
+               pr_info("DIO partial %zu B\n", dio->size);=0A=
+               WARN_ON(bio =3D=3D &dio->bio);=0A=
+               if (bio) {=0A=
+                       bio_uninit(bio);=0A=
+                       blkdev_bio_end_io(bio);=0A=
+               }=0A=
+               ret =3D 0;=0A=
+       }=0A=
+=0A=
        if (!is_sync)=0A=
                return -EIOCBQUEUED;=0A=
=0A=
@@ -497,10 +541,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
=0A=
        bio_put(&dio->bio);=0A=
        return ret;=0A=
-error:=0A=
-       if (!is_poll)=0A=
-               blk_finish_plug(&plug);=0A=
-       goto out;=0A=
 }=0A=
=0A=
 static ssize_t=0A=
=0A=
With this patch, I get a different behavior:=0A=
=0A=
## sync, wait=0A=
4194304 4194304=0A=
0 KB read, 4096 KB writen=0A=
=0A=
No change here.=0A=
=0A=
## sync, nowait=0A=
... KASAN warning and hang, no output from test application=0A=
The debug messages show this:=0A=
=0A=
[   90.142525] =3D=3D=3D=3D=3D=3D __blkdev_direct_IO =3D=3D=3D=3D=3D=3D=0A=
[   90.147503] +++ BIO frag 1048576 B=0A=
[   90.151729] +++ BIO frag 1048576 B=0A=
[   90.155256] BIO submit eagain, dio 1048576 B=0A=
[   90.159571] DIO partial 1048576 B=0A=
[   90.162914] --- BIO done, dio 1048576 B=0A=
[   90.167345] --- BIO done, dio 1048576 B=0A=
[   90.171237] --- DIO done 1048576 B=0A=
=0A=
That is, the first 1MB fragment is issued, the second 1MB fragment hits -EA=
GAIN=0A=
on submission and the DIO is completed as partial 1MB. But there are 2 frag=
ment=0A=
completion shown being processed by blkdev_bio_end_io(), while only one was=
=0A=
issued. Right after these messages, KASAN screams:=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[   90.182106] BUG: KASAN: use-after-free in blk_rq_map_sg+0x1227/0x1660=0A=
[   90.188561] Read of size 8 at addr ffff8890079b1100 by task kworker/31:1=
H/932=0A=
[   90.195725]=0A=
[   90.197235] CPU: 31 PID: 932 Comm: kworker/31:1H Not tainted 5.3.0-rc3+ =
#211=0A=
=0A=
Clearly, a BIO is being freed while being executed, likely one of the split=
 of=0A=
the large 1MB BIO that was failed with EAGAIN.=0A=
=0A=
## async, wait=0A=
4194304 4194304=0A=
0 KB read, 4096 KB writen=0A=
=0A=
No problem here, same as sync+wait case.=0A=
=0A=
## async, nowait=0A=
4194304 3145728=0A=
0 KB read, 3072 KB writen=0A=
=0A=
Here, the application return and shows a partial short write of 3MB. The de=
bug=0A=
messages show that the last fragment failed submission on EAGAIN, leading t=
o the=0A=
correctly reported 3MB short write.=0A=
=0A=
[  190.437652] =3D=3D=3D=3D=3D=3D __blkdev_direct_IO =3D=3D=3D=3D=3D=3D=0A=
[  190.442590] +++ BIO frag 1048576 B=0A=
[  190.446688] +++ BIO frag 1048576 B=0A=
[  190.450795] +++ BIO frag 1048576 B=0A=
[  190.454237] --- BIO done, dio 3145728 B=0A=
[  190.458790] +++ BIO frag 1048576 B=0A=
[  190.462297] last BIO submit eagain, dio 3145728 B=0A=
[  190.467045] DIO partial 3145728 B=0A=
[  190.470388] --- BIO done, dio 3145728 B=0A=
[  190.474288] --- BIO done, dio 3145728 B=0A=
[  190.480198] --- BIO done, dio 3145728 B=0A=
[  190.484092] --- DIO done 3145728 B=0A=
=0A=
But still getting KASAN warning and hang. The warning is the same as sync+n=
owait=0A=
case:=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[  190.494974] BUG: KASAN: use-after-free in blk_rq_map_sg+0x1227/0x1660=0A=
[  190.501433] Read of size 8 at addr ffff889050965500 by task kworker/31:1=
H/1125=0A=
=0A=
And the hang is also the same, an oops with an an infinite stream of the=0A=
following messages.=0A=
=0A=
[  190.917591] swiotlb_tbl_map_single: 4 callbacks suppressed=0A=
[  190.917596] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  190.932770] mpt3sas 0000:d8:00.0: overflow 0xffe7a3fcc18c0000+4096 of DM=
A=0A=
mask 7fffffffffffffff bus mask 0=0A=
[  190.942450] WARNING: CPU: 31 PID: 1125 at kernel/dma/direct.c:35=0A=
report_addr+0xc5/0x170=0A=
[  190.950460] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_res=
olver=0A=
nfs lockd grace fscache nf_conntrack_netbios_ns nf_conntrack_broadcast xt_C=
T=0A=
ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip6table_mangle=0A=
ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security=
=0A=
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink=0A=
ip6table_filter ip6_tables sunrpc x86_pkg_temp_thermal coretemp kvm_intel k=
vm=0A=
crc32_pclmul acpi_power_meter mpt3sas i40e nvme raid_class nvme_core skd=0A=
[  190.996072] CPU: 31 PID: 1125 Comm: kworker/31:1H Tainted: G    B=0A=
5.3.0-rc3+ #211=0A=
[  191.004598] Hardware name: Supermicro Super Server/X11DPL-i, BIOS 3.0b 0=
3/04/2019=0A=
[  191.012088] Workqueue: kblockd blk_mq_run_work_fn=0A=
[  191.016805] RIP: 0010:report_addr+0xc5/0x170=0A=
[  191.021086] Code: e1 48 c1 e9 03 80 3c 01 00 0f 85 97 00 00 00 4d 8b 24 =
24 b8=0A=
fe ff ff ff 49 39 c4 76 3a 80 3d 39 57 81 02 00 0f 84 a0 00 00 00 <0f> 0b 4=
8 b8=0A=
00 00 00 00 00 fc ff df 48 c7 04 03 00 00 00 00 48 8b=0A=
[  191.039855] RSP: 0018:ffff88904f8776e8 EFLAGS: 00010282=0A=
[  191.045091] RAX: 0000000000000000 RBX: 1ffff11209f0eede RCX: 00000000000=
00000=0A=
[  191.052230] RDX: ffffed1209f0ee84 RSI: 0000000000000000 RDI: ffffed1209f=
0eed0=0A=
[  191.059373] RBP: ffff888817606f28 R08: 000000000000005e R09: ffffed120b2=
f7689=0A=
[  191.066513] R10: ffffed120b2f7688 R11: ffff8890597bb447 R12: 7ffffffffff=
fffff=0A=
[  191.073656] R13: 7fffffffffffffff R14: ffe7a3fcc18c0fff R15: ffff8886202=
80abc=0A=
[  191.080795] FS:  0000000000000000(0000) GS:ffff889059780000(0000)=0A=
knlGS:0000000000000000=0A=
[  191.088889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[  191.094646] CR2: 00007fafc9cea000 CR3: 000000107d614003 CR4: 00000000005=
606e0=0A=
[  191.101788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=0A=
[  191.108929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400=0A=
[  191.116068] PKRU: 55555554=0A=
[  191.118781] Call Trace:=0A=
[  191.121239]  ? dma_direct_unmap_sg+0xb0/0xb0=0A=
[  191.125516]  ? swiotlb_map+0xd7/0x490=0A=
[  191.129192]  ? _raw_spin_unlock_irqrestore+0x45/0x50=0A=
[  191.134169]  dma_direct_map_page+0x23b/0x2f0=0A=
[  191.138447]  ? __kasan_report.cold+0xd/0x3e=0A=
[  191.142643]  ? report_addr+0x170/0x170=0A=
[  191.146403]  ? blk_rq_map_sg+0x1227/0x1660=0A=
[  191.150510]  ? blk_rq_map_sg+0x1118/0x1660=0A=
[  191.154623]  dma_direct_map_sg+0x108/0x1e0=0A=
[  191.158731]  scsi_dma_map+0x18e/0x290=0A=
[  191.162412]  _base_build_sg_scmd_ieee+0x134/0x1870 [mpt3sas]=0A=
[  191.168079]  ? memset+0x20/0x40=0A=
[  191.171241]  scsih_qcmd+0xfb7/0x1a20 [mpt3sas]=0A=
[  191.175701]  scsi_queue_rq+0xdb4/0x2ce0=0A=
[  191.179547]  blk_mq_dispatch_rq_list+0xbbc/0x1560=0A=
[  191.184261]  ? elv_rb_del+0x3b/0x80=0A=
[  191.187762]  ? blk_mq_get_driver_tag+0x4c0/0x4c0=0A=
[  191.192388]  ? dd_dispatch_request+0x210/0x930=0A=
[  191.196847]  blk_mq_do_dispatch_sched+0x16c/0x380=0A=
[  191.201560]  ? blk_mq_sched_mark_restart_hctx+0x60/0x60=0A=
[  191.206793]  ? __lock_acquire+0xd55/0x4560=0A=
[  191.210901]  blk_mq_sched_dispatch_requests+0x33c/0x530=0A=
[  191.216134]  ? lock_acquire+0x11d/0x2f0=0A=
[  191.219984]  ? blk_mq_sched_restart+0x70/0x70=0A=
[  191.224351]  ? process_one_work+0x677/0x1270=0A=
[  191.228635]  __blk_mq_run_hw_queue+0xeb/0x210=0A=
[  191.232999]  ? hctx_lock+0x160/0x160=0A=
[  191.236589]  ? process_one_work+0x693/0x1270=0A=
[  191.240872]  process_one_work+0x73a/0x1270=0A=
[  191.244981]  ? pwq_dec_nr_in_flight+0x2d0/0x2d0=0A=
[  191.249518]  ? do_raw_spin_lock+0x120/0x280=0A=
[  191.253718]  worker_thread+0x94/0xc70=0A=
[  191.257391]  ? __kthread_parkme+0xbd/0x1a0=0A=
[  191.261498]  ? process_one_work+0x1270/0x1270=0A=
[  191.265864]  kthread+0x2ed/0x3f0=0A=
[  191.269104]  ? kthread_park+0x130/0x130=0A=
[  191.272954]  ret_from_fork+0x24/0x30=0A=
[  191.276547] irq event stamp: 90=0A=
[  191.279695] hardirqs last  enabled at (89): [<ffffffff812bb154>]=0A=
ktime_get+0x104/0x130=0A=
[  191.287616] hardirqs last disabled at (90): [<ffffffff8282f1b4>]=0A=
_raw_spin_lock_irqsave+0x14/0x50=0A=
[  191.296491] softirqs last  enabled at (52): [<ffffffff8232df68>]=0A=
flush_backlog+0x378/0x5a0=0A=
[  191.304758] softirqs last disabled at (48): [<ffffffff8232dbf5>]=0A=
flush_backlog+0x5/0x5a0=0A=
[  191.312853] ---[ end trace f878467310c76256 ]---=0A=
[  191.317491] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.343446] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.353128] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.387552] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.397268] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.431556] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.441264] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.475552] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.485263] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.519550] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.529265] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.563542] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.573259] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.607551] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.617264] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.651549] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.661255] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.695545] mpt3sas 0000:d8:00.0: swiotlb buffer is full (sz: 4096 bytes=
),=0A=
total 0 (slots), used 0 (slots)=0A=
[  191.705256] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.739546] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.773545] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.807549] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.841553] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.875544] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.909547] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.943466] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  191.977543] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  192.011547] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  192.045550] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  192.079539] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  192.113537] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
[  192.147543] sd 10:0:0:0: scsi_dma_map failed: request for 524288 bytes!=
=0A=
=0A=
I am still digging into all this, but strongly suspecting that this is rela=
ted=0A=
to the NOWAIT flag not correctly handling cases where a BIO gets split into=
=0A=
smaller fragments and some of the fragments failing to be created with -EAG=
AIN.=0A=
Not 100% sure yet though.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
