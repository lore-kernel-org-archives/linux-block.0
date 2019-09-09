Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4AC4360D
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9F4218AC
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g5DJfx2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfIICWY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:22:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732582AbfIICWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Sep 2019 22:22:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892ECU6057448;
        Mon, 9 Sep 2019 02:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=xLab5lamKsGFf666j4F7UQaBA6m/n6xltiyHHlsEAo8=;
 b=g5DJfx2ukxm0P213vHrVVCiGHmNtCf1ExGzZOYJFLnm9ihpgVdH7Rtx9y4NJzPzQK3XT
 3frsyblD2XIS6GkCNOszsh+I+eY3juw8jA5Djznx2XNdvxMVQgv7zfp/mC2ajTT2M7px
 vbQOIQ/gBb04agqEuL0ItIkcILUmCCna/6u6MpGChon2reRl0e8eoe4AxJhx37BhlI5M
 6NS5HcPGzID8dq3IJF8yBny0f8gTEISmAX1iqc6xMi9ABS0cXr/i9YvPucscPEOjE9rd
 cmj1HhfJeTgGZ+4yEb+sOhDP6BQPue6BIiDSSZlihO5A8dQIrTX1spnJEeSLXcEX2RFY bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jxs77h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Sep 2019 02:22:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892J6YR087456;
        Mon, 9 Sep 2019 02:22:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uv4d15p3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Sep 2019 02:22:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x892LsqO013967;
        Mon, 9 Sep 2019 02:21:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Sep 2019 19:21:54 -0700
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block layer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
Date:   Sun, 08 Sep 2019 22:21:51 -0400
In-Reply-To: <1567956405-5585-1-git-send-email-maxg@mellanox.com> (Max
        Gurtovoy's message of "Sun, 8 Sep 2019 18:26:43 +0300")
Message-ID: <yq1mufei4zk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909090023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909090023
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Max!

> @@ -309,7 +308,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
>  {
>  	struct scsi_disk *sdkp = to_scsi_disk(dev);
>  
> -	return sprintf(buf, "%u\n", sdkp->protection_type);
> +	return sprintf(buf, "%u\n", sdkp->disk->protection_type);

I'm fine with moving the prepare/complete logic to the block layer. But
the block layer should always be using information from the integrity
profile. sdkp->protection_type is a SCSI disk property which is used to
pick the right integrity profile when a device is discovered and
registered.

 - sdkp->protection_type is the type the disk is formatted with. This
   may or may not be the same as the metadata format used by DIX and the
   block layer.

 - The DIX protection type (which is what matters for protection
   information preparation) is encapsulated in the integrity profile
   registered for the block device. The profile describes an abstract
   protection format and can (at least in theory) carry non-T10 PI
   protection information.

Linux currently uses the Type 1 block layer integrity profile for
devices formatted with T10 PI Types 0, 1, and 2. And the Type 3 block
layer integrity profile for devices formatted with T10 PI Type 3. This
profile is what we should be keying off of in t10-pi.c, not the
protection_type (the fact that protection_type is even there is because
the code was lifted out from sd.c).

I would prefer to introduce .prepare_fn and .complete_fn for the Type 1
profile to match the existing .generate_fn and verify_fn. And then adapt
t10_pi_prepare() / t10_pi_complete() to plug into these new
callbacks. The need for protection_type and Type 3 matching goes away in
that case since the callbacks would only be set for the Type 1 profile.

>  static inline unsigned short
> +blk_integrity_interval_shift(struct request_queue *q)
> +{
> +	return q->limits.logical_block_shift;
> +}
> +

Why not use bio_integrity_intervals() or bi->interval_exp?

Note that for T10 PI Type 2, the protection interval is not necessarily
the logical block size.

-- 
Martin K. Petersen	Oracle Linux Engineering
