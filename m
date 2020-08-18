Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9BC433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 03:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA020706
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 03:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JprIIYRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHRDnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:43:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35972 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRDny (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 23:43:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I3bbp3076245;
        Tue, 18 Aug 2020 03:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=pl8NDLuQIRm1fzSvBa9qBaJM5sY7n2uPNb+h+0YjSas=;
 b=JprIIYRjf4xkR7gBk7nAIdGZmgIsMWS8RTJHROubXn5eB1ON/dTmMUUzRHT5fRnAErOq
 yXQRrZS5wZBi1Cs+xFtFLwVws5T+g96EwP1aY/CUaY0WcdSIh3UlYDbJ4DNpespluLlL
 0S0lkcluPEade45CmFCyCVWPnM+mOrKDRfWSwq8gyyB2J4DYI4ZQ1wCyYNoxur+0bTUL
 QqwFV3x80KtUHW7lCgKpTdyuV3rY5QX3iAHGBeG7a49WRe76VHLzSv4W9Muxgsd4zvnn
 RC57WUcEKzbBX81ttWaw++UIWtYXaREXujs8RwmHdg65XAfBOWhSZOiTGLbJVUwMurCM 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32x7nma7rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 03:43:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I3ctLR035388;
        Tue, 18 Aug 2020 03:43:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32xsmwpsta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 03:43:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07I3hnWG001890;
        Tue, 18 Aug 2020 03:43:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 20:43:47 -0700
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     linux-block@vger.kernel.org, hch@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH v3 2/2] block: better deal with the delayed not
 supported case in blk_cloned_rq_check_limits
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tux0bq7e.fsf@ca-mkp.ca.oracle.com>
References: <1597699898-21157-1-git-send-email-ritika.srivastava@oracle.com>
Date:   Mon, 17 Aug 2020 23:43:45 -0400
In-Reply-To: <1597699898-21157-1-git-send-email-ritika.srivastava@oracle.com>
        (Ritika Srivastava's message of "Mon, 17 Aug 2020 14:31:38 -0700")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ritika,

> +		/*
> +		 * At least SCSI device does not have a good way to return if
> +		 * Write Same/Zero is actually supported. To detect this, first
> +		 * try to issue one and if it fails clear the max sectors value.
> +		 * If this occurs on the lower device, the right error code
> +		 * needs to be propagated to upper layers.
> +		 */
> +		if (max_sectors == 0)
> +			return BLK_STS_NOTSUPP;

Maybe we should make it more explicit in the comment that there is a
window of error where this condition can occur? Something like:

    If a device rejects a non-read/write command (discard, write same,
    etc.) the low-level device driver will set the relevant queue limit
    to 0 to prevent blk-lib from issuing more of the offending
    operations. Commands queued prior to the queue limit being reset
    need to be completed with BLK_STS_NOTSUPP to avoid I/O errors being
    propagated to upper layers.

Otherwise looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
