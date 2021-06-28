Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52481C2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 05:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327C66199B
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 05:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhF1FcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:32:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbhF1FcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 01:32:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S54PWK038736;
        Mon, 28 Jun 2021 01:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=h+vYYdelAfaPcrl9QR0DHrn9y7bgRyHx3epSGboCr+s=;
 b=s0MbF9mgYdJLHZbs+u1pCDMdscGA6oInYWIHSpi/mDapdoZ0riPYYM43xlhwfbT3rhz5
 9elm5GidUGjZcWz73FLv9a4XIlJ97Bk4mhYj/RojoFE6IBZUuzFuX5utr2PgdCFsaJ0r
 WE0Ab988QgBX1yySB70sr2aYIt2vubx+sihpvnxwdPYIhPx/ekf3xS+hvmk1StoSa1QN
 CvTGaHswNyxsdNB+5WBb16qnwAgB//ezZSO/fn2jAv6Lumn8n7xEG3IGDXIFNX2scWtg
 IoebYJ6RplgwoTCzJyBwu8UkMVQUSOex9SlhiNnH9EdhSyee5hk2TlOFHGgke8bQ9CDE Hg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f7qd8qr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 01:29:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S5RaHH018431;
        Mon, 28 Jun 2021 05:29:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 39duv8gabh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 05:29:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S5RnDP12648822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 05:27:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D0AA4068;
        Mon, 28 Jun 2021 05:29:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91C24A405F;
        Mon, 28 Jun 2021 05:29:21 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.85.88.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 05:29:21 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] block/mq-deadline: Remove a WARN_ON_ONCE() call
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20210627211112.12720-1-bvanassche@acm.org>
Date:   Mon, 28 Jun 2021 10:59:20 +0530
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79AB0A05-DFC1-4446-822A-01257D563FE1@linux.vnet.ibm.com>
References: <20210627211112.12720-1-bvanassche@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X3aAT4CdkGqE1lz1jHPBg42swRkUg7Z3
X-Proofpoint-GUID: X3aAT4CdkGqE1lz1jHPBg42swRkUg7Z3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_03:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280035
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 28-Jun-2021, at 2:41 AM, Bart Van Assche <bvanassche@acm.org> =
wrote:
>=20
> The purpose of the WARN_ON_ONCE() statement in dd_insert_request() is =
to
> verify that dd_prepare_request() cleared rq->elv.priv[0]. Since
> dd_prepare_request() is called during request initialization but not =
if a
> request is requeued, a warning is triggered if a request is requeued. =
Fix
> this by removing the WARN_ON_ONCE() statement. This patch suppresses =
the
> following kernel warning:
>=20
> WARNING: CPU: 28 PID: 432 at block/mq-deadline-main.c:740 =
dd_insert_request+0x4d4/0x5b0
> Workqueue: kblockd blk_mq_requeue_work
> Call Trace:
> dd_insert_requests+0xfa/0x130
> blk_mq_sched_insert_request+0x22c/0x240
> blk_mq_requeue_work+0x21c/0x2d0
> process_one_work+0x4c2/0xa70
> worker_thread+0x2e5/0x6d0
> kthread+0x21c/0x250
> ret_from_fork+0x1f/0x30
>=20
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

Thanks for the patch. Fixes the problem for me.

-Sachin
> block/mq-deadline-main.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> index 9db6da9ef4c6..6f612e6dc82b 100644
> --- a/block/mq-deadline-main.c
> +++ b/block/mq-deadline-main.c
> @@ -740,7 +740,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> 	dd_count(dd, inserted, prio);
> 	blkcg =3D dd_blkcg_from_bio(rq->bio);
> 	ddcg_count(blkcg, inserted, ioprio_class);
> -	WARN_ON_ONCE(rq->elv.priv[0]);
> 	rq->elv.priv[0] =3D blkcg;
>=20
> 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {

