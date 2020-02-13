Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B3CC2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 18:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8331F206CC
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 18:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aKYwsRS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBMSM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:12:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgBMSM1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 13:12:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DI9ZhK142678;
        Thu, 13 Feb 2020 18:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oUjiUJ1XIAp0MJir1ku+5R1eV8EDFgLwfjQqmIKY4JY=;
 b=aKYwsRS0tnqW1+EixuRwsvHEeuuZPpq6Ny7g60jXjqvl/6PpwZLPGnQ6RhChBO+13Wjw
 Fr7+ooTqyVrqQ8PW7o3WQysyHS0ae5s10S+bbMNrjyXkcn6srrbnvbqFu0wZpjzJm3D2
 8MJYHNF01g78cUz7brTDYDo4vlAhBJMk0NbPQgjK8OT5UKDYjQDt3b36FMQciaaPi10e
 9xfqWFiDzzZvPAB4CD/Ym6O+sgcXLFK0Y2ZNhPDVLcqeXusxeTTZAmG7D8un8YdpjLCO
 ZxdUQ8wYiH1lhbxeBi8T2R8dDQk5gfaTDeokE1VFqy3Y2egvErOfjp6rDygpFXCB9mRr Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3sv69d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 18:11:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DI7QRk140027;
        Thu, 13 Feb 2020 18:11:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y4k37hvrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 18:11:50 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01DIBiLI007442;
        Thu, 13 Feb 2020 18:11:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 10:11:43 -0800
Date:   Thu, 13 Feb 2020 10:11:41 -0800
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
Subject: Re: [PATCH v7 6/6] loop: Add support for REQ_ALLOCATE
Message-ID: <20200213181141.GT6874@magnolia>
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <158157957565.111879.5952051034259419400.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158157957565.111879.5952051034259419400.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130128
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 13, 2020 at 10:39:35AM +0300, Kirill Tkhai wrote:
> Support for new modifier of REQ_OP_WRITE_ZEROES command.
> This results in allocation extents in backing file instead
> of actual blocks zeroing.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  drivers/block/loop.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 739b372a5112..0704167a5aaa 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -581,6 +581,16 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	return 0;
>  }
>  

Urgh, I meant "copy the comment directly to here", e.g.

/*
 * Convert REQ_OP_WRITE_ZEROES modifiers into fallocate mode
 *
 * If the caller requires allocation, select that mode.  If the caller
 * doesn't want deallocation, call zeroout to write zeroes the range.
 * Otherwise, punch out the blocks.
 */

The goal here is to reinforce the notion that FL_ZERO_RANGE is how we
achieve nounmap zeroing...

--D

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
> @@ -599,14 +609,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  	case REQ_OP_FLUSH:
>  		return lo_req_flush(lo, rq);
>  	case REQ_OP_WRITE_ZEROES:
> -		/*
> -		 * If the caller doesn't want deallocation, call zeroout to
> -		 * write zeroes the range.  Otherwise, punch them out.
> -		 */
>  		return lo_fallocate(lo, rq, pos,
> -			(rq->cmd_flags & REQ_NOUNMAP) ?
> -				FALLOC_FL_ZERO_RANGE :
> -				FALLOC_FL_PUNCH_HOLE);
> +			write_zeroes_to_fallocate_mode(rq->cmd_flags));
>  	case REQ_OP_DISCARD:
>  		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_WRITE:
> @@ -877,6 +881,7 @@ static void loop_config_discard(struct loop_device *lo)
>  		q->limits.discard_alignment = 0;
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
> +		blk_queue_max_allocate_sectors(q, 0);
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>  		return;
>  	}
> @@ -886,6 +891,7 @@ static void loop_config_discard(struct loop_device *lo)
>  
>  	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
>  	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> +	blk_queue_max_allocate_sectors(q, UINT_MAX >> 9);
>  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>  }
>  
> 
> 
