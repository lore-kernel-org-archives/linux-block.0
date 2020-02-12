Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ABEC2BA83
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD1920714
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s6ijZ8/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBLRCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:02:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43286 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLRCc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 12:02:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CGtOZ5090167;
        Wed, 12 Feb 2020 17:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7s0m/1sYeBI/+vchBYy8OeGvEA8ElclRpe4VFJlYtRs=;
 b=s6ijZ8/PSRngDXXp4An0Ea7lLxLhzcltwszddVxsTwUBtw6MrDdz1hve8ifgJ3++EMb0
 BAGIoUBR1gKJ1KEjeM92rFUy6CGL7qLyCyWvN9DX6g4fkKd5U2SvM7T6n46UGAndPQRb
 x8Px9x+SB1ZInrOToYA/oNrkW9KrgvaeO+F1fcDpY9d6RKOc65O2Q675pRcFMO+9opqM
 Dj891S/NrR8/SMPtJERzMMrG2jOmGbeI86ODU2L1J7evr5076ZjVP1Kn032APx8BgpA/
 +HXotkDxpan0+g6V0EcLeqVG1S/WatwxVLXTgejCiJ0iKvXQAHApRWiBmEUnCMrH7sMO AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y2jx6chpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 17:02:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CGvFWA009091;
        Wed, 12 Feb 2020 17:02:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y4k9g18f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 17:02:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CH1x7Z005685;
        Wed, 12 Feb 2020 17:01:59 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 09:01:59 -0800
Date:   Wed, 12 Feb 2020 09:01:56 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] loop: Add support for REQ_ALLOCATE
Message-ID: <20200212170156.GM6874@magnolia>
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
 <158132724397.239613.16927024926439560344.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158132724397.239613.16927024926439560344.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120128
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 10, 2020 at 12:34:04PM +0300, Kirill Tkhai wrote:
> Support for new modifier of REQ_OP_WRITE_ZEROES command.
> This results in allocation extents in backing file instead
> of actual blocks zeroing.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> ---
>  drivers/block/loop.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 739b372a5112..bfe76d9adf09 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -581,6 +581,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	return 0;
>  }
>  
> +static unsigned int write_zeroes_to_fallocate_mode(unsigned int flags)
> +{
> +	if (flags & REQ_ALLOCATE)
> +		return 0;
> +	if (flags & REQ_NOUNMAP)
> +		return FALLOC_FL_ZERO_RANGE;
> +	return FALLOC_FL_PUNCH_HOLE;
> +}
> +
>  static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  {
>  	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
> @@ -604,9 +613,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  		 * write zeroes the range.  Otherwise, punch them out.
>  		 */

Please update this comment to reflect the new REQ_ALLOCATE mode, and
move it to where you define write_zeroes_to_fallocate_mode().

With that fixed,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  		return lo_fallocate(lo, rq, pos,
> -			(rq->cmd_flags & REQ_NOUNMAP) ?
> -				FALLOC_FL_ZERO_RANGE :
> -				FALLOC_FL_PUNCH_HOLE);
> +			write_zeroes_to_fallocate_mode(rq->cmd_flags));
>  	case REQ_OP_DISCARD:
>  		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_WRITE:
> @@ -877,6 +884,7 @@ static void loop_config_discard(struct loop_device *lo)
>  		q->limits.discard_alignment = 0;
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
> +		blk_queue_max_allocate_sectors(q, 0);
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>  		return;
>  	}
> @@ -886,6 +894,7 @@ static void loop_config_discard(struct loop_device *lo)
>  
>  	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
>  	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> +	blk_queue_max_allocate_sectors(q, UINT_MAX >> 9);
>  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>  }
>  
> 
> 
