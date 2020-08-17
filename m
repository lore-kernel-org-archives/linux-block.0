Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A85C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FF22072E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 18:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NYpPA/AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390477AbgHQSMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:12:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbgHQSLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 14:11:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HI9D2e161164;
        Mon, 17 Aug 2020 18:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FkaiITckFOKT6MU6hnK/XlAmoudcjeP+m8deiH8Cc44=;
 b=NYpPA/AW48DHfwKh9ibBIVjRD59vN8vLw82MXT7DNp4CgKyRz7v5Zbo4Iz8jZoPJoyls
 f5mnTOguojbH5uN56voTUY74zrjYOThchiKWDhxF8ETP2n+2F20dF9h5xKrlVfr+eC8x
 XXE5Ms9nqRJwLERc6ay+GFO+9ciRcG9UBd1nTdKiqitXiIcQhgyJvSLIFL2SamrpQDxr
 l7LtujIlyvx7bloSAm/cpEnhTkllctrF9/Og0nyFbmDoJUN5d/zZXdooGNMlcLj20yro
 /pGpjryMVcIPWjMsjUAwNz0cssN3Rd2xGkiWIHf9f3w82L2a8RTRk2lqqn0gLRg0hofx qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32x7nm8dg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 18:11:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HHm9AW054323;
        Mon, 17 Aug 2020 18:11:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32xsfqvt4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 18:11:02 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07HIB0ON032363;
        Mon, 17 Aug 2020 18:11:00 GMT
Received: from dhcp-10-159-128-66.vpn.oracle.com (/10.159.128.66)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 11:11:00 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH v2 2/2] block: return BLK_STS_NOTSUPP if operation is not
 supported
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <20200814063731.GA26356@infradead.org>
Date:   Mon, 17 Aug 2020 11:10:59 -0700
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <C538F917-C318-4006-B2F5-100F5BA206AC@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-3-git-send-email-ritika.srivastava@oracle.com>
 <20200814063731.GA26356@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=3 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170128
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Thank you for the review.

> On Aug 13, 2020, at 11:37 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> The concept looks fine, but some of the formatting especially in the
> comments is strange.  Also we should not print the message for this
> case, but just the real error.  Updated version with my suggestions
> below.

Your suggestions look good to me.
I will include these changes in updated patch and send it for review.

>=20
> Also don't you need a third patch that makes dm-multipath stop sending
> Write Same/Zeroes command when this happens?

blk-lib takes care of not sending any further Write Zero/Same in =
blkdev_issue_zeroout().
If max_write_zeroes_sectors is set to 0 later on, no more Write =
Zero/Same will be sent.
>=20
> ---
> =46rom c056b0523173f17cd3d8ca77a8cfca4e45fe8cb7 Mon Sep 17 00:00:00 =
2001
> From: Ritika Srivastava <ritika.srivastava@oracle.com>
> Date: Wed, 29 Jul 2020 15:47:58 -0700
> Subject: block: better deal with the delayed not supported case in
> blk_cloned_rq_check_limits
>=20
> If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
> blk_cloned_rq_check_limits() will return IO error which will cause
> device-mapper to fail the paths.
>=20
> Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
> BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail the
> paths.
>=20
> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
> ---
> block/blk-core.c | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index e04ee2c8da2e95..81b830c24b5b4f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1296,10 +1296,21 @@ EXPORT_SYMBOL(submit_bio);
> static blk_status_t blk_cloned_rq_check_limits(struct request_queue =
*q,
> 				      struct request *rq)
> {
> -	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, =
req_op(rq))) {
> +	unsigned int max_sectors =3D blk_queue_get_max_sectors(q, =
req_op(rq));
> +
> +	if (blk_rq_sectors(rq) > max_sectors) {
> +		/*
> +		 * At least SCSI device do not have a good way to return =
if
> +		 * Write Same is actually supported.  So we first try to =
issue
> +		 * one and if it fails clear the max sectors value on =
failure.
> +		 * If this occurs onthe lower device we need to =
propagate the
> +		 * right error code up.
> +		 */
> +		if (max_sectors =3D=3D 0)
> +			return BLK_STS_NOTSUPP;
> +
> 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
> -			__func__, blk_rq_sectors(rq),
> -			blk_queue_get_max_sectors(q, req_op(rq)));
> +			__func__, blk_rq_sectors(rq), max_sectors);
> 		return BLK_STS_IOERR;
> 	}
>=20
> @@ -1326,8 +1337,11 @@ static blk_status_t =
blk_cloned_rq_check_limits(struct request_queue *q,
>  */
> blk_status_t blk_insert_cloned_request(struct request_queue *q, struct =
request *rq)
> {
> -	if (blk_cloned_rq_check_limits(q, rq))
> -		return BLK_STS_IOERR;
> +	blk_status_t ret;
> +
> +	ret =3D blk_cloned_rq_check_limits(q, rq);
> +	if (ret !=3D BLK_STS_OK)
> +		return ret;
>=20
> 	if (rq->rq_disk &&
> 	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
> --=20
> 2.28.0
>=20

