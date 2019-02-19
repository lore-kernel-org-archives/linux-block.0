Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254AC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E657B21736
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FgbAiY5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfBSOko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:40:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfBSOko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 09:40:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1JEdMc8176614;
        Tue, 19 Feb 2019 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=u4LSbmZRd3YfmKn1kmc/Km3VA780RbI0ABcNQMGZT0M=;
 b=FgbAiY5byL5X2Jml9RBfdE2VBMTVtIs24ujkddp4CZdYOsr1Rp4hZ9M0jbynOB5rJYRY
 qvSgs3b17EpVnwLAspcbGlU6qn+G33rUbwM6WQkGMAjc/WXqYOr/nUpztuH68xv0eXUW
 VXN8XQVNg41wS3OO5Do99QBctb6eoDMn0IkYmnZAe4Q1gLL7s2pL9moF9IkHBxQzaNen
 ZZgQEsEyFXyDivaFc9sALI+iuc22VKd3cstMwmlhsUH98GOosi8v8y4JDVy78vTW+nJS
 qEWpMqchcL6u1jXULsLLDZbHBfRQuWwNWkleRYVxb/e9KQPi1G/KRaQsvbb/zdgHxIqh CA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qp9xtuk14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 14:40:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1JEecp7001905
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 14:40:39 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1JEec1m015774;
        Tue, 19 Feb 2019 14:40:38 GMT
Received: from kadam (/197.157.0.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 06:40:38 -0800
Date:   Tue, 19 Feb 2019 17:40:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] block: don't dereference a potential null bio
 pointer until is has been null checked
Message-ID: <20190219144030.GL17104@kadam>
References: <20190219143702.11926-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219143702.11926-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 02:37:02PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The bio pointer is being null checked hence it can be potentially null,
> however earlier it is being derefefenced on the assignment of front_seg_size.
> Avoid the dereference issue by only assigning front_seg_size after bios has
> been null sanity checked.
> 
> Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: remove front_seg_size assignment when it is declared
> 
> ---
>  block/blk-merge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bed065904677..096947413ea9 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -363,7 +363,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>  	struct bio_vec bv, bvprv = { NULL };
>  	int prev = 0;
>  	unsigned int seg_size, nr_phys_segs;
> -	unsigned front_seg_size = bio->bi_seg_front_size;
> +	unsigned front_seg_size;

Smatch says bio is non-NULL but I didn't verify by hand.

regards,
dan carpenter

