Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB70C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53FB208CB
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ll0TdX2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfF1UKQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:10:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfF1UKQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:10:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SK951Y181711;
        Fri, 28 Jun 2019 20:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=DVwAqIkGr1upMtLGtMooVAUzuHjmCR33sYeWaNbQnFE=;
 b=Ll0TdX2HrkSqUNhd4UPPNKjunBCzkqkIZIXdhP3coJCQXhC3rveEjbz6mzNVQlfdnmSp
 1siueCFzjhoL6eeiVIfa/IqodGrQB+zy2uAy62gtqvGRJeJW6cFyEaRLTJLZnCd1Ptth
 pI28HCZFgcEp0CSopshPXzk7G0X4enKpezja10DlUS89utraYi9ycXMZBthAnsRAj1TP
 kqbvHXIdu+iybpZTWTg0l6X7TgpMFvER78upQiTxKG8f44QsnQfpBNsLFEurVNmVndMs
 JVe+1lzHUL+90oF4vA28OyP7bsZGsOBkomuKcHES6ToWTyPxmQUJkRN1VnCxaBZMrMN9 BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqy9f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:09:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SK9drb093260;
        Fri, 28 Jun 2019 20:09:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9ace0mcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:09:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SK9TNh003063;
        Fri, 28 Jun 2019 20:09:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 13:09:28 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: Rename hd_struct.policy into hd_struct.read_only
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190628195615.201990-1-bvanassche@acm.org>
Date:   Fri, 28 Jun 2019 16:09:26 -0400
In-Reply-To: <20190628195615.201990-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Fri, 28 Jun 2019 12:56:15 -0700")
Message-ID: <yq1y31lh3pl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=812
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280230
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=867 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280230
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> Since nobody knows what "policy" means, rename the field to "read_only"
> for clarity. Martin Petersen proposed this earlier - see also his patch
> "scsi: sd: block: Fix regressions in read-only block device handling"
> (https://www.spinics.net/lists/linux-scsi/msg129146.html). This patch
> is an extension of a subset of Martin's patch.

I'd rather we just get this one merged:

	https://patchwork.kernel.org/patch/10967367/

It even comes with a shiny blktest.

-- 
Martin K. Petersen	Oracle Linux Engineering
