Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF72C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97732146F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 22:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4jHW9Ory"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfAHWJq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:09:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47650 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHWJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 17:09:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x08M8pHP185031;
        Tue, 8 Jan 2019 22:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3508bg3QY5izjKe8FaBisSab8G2A64xuiCGbWi/zYGU=;
 b=4jHW9OryGKDQbP4WK6XTjEfJep7bqufHt1Yxi9975MGcMquB0cQ8/+N+aCdJi6DWETom
 HVeg4BARUnonozvrW+I0WBxel5Ti9oauDsTAT8u7Qkg792VOUL+yz/25o5ImAaiFSz+U
 iXVH6V7Vy/jMkhij/uaoNS1DWBe0NKpPFd0FbEqRuC1WSfnnl/JlMhYdKklJZKlKqbm+
 I5yjP61LqJgBsUJWYfG44KUwk6gRi+bnnsxspPtzJGhZsJeL1bZ9acBXmDQzFk+Uv9G+
 +HVeBHpNxNFNctHoLc5vj5MFc+4aebPJzOFeC2pfJiD771xzudjiwGhEeLs5z1Aso0n0 9g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ptj3dxf3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 22:09:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x08M9eqS027112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 22:09:40 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x08M9emZ025471;
        Tue, 8 Jan 2019 22:09:40 GMT
Received: from localhost (/10.159.140.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 14:09:39 -0800
Date:   Tue, 8 Jan 2019 14:09:38 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [patch] block: clarify documentation for blk_{start|finish}_plug
Message-ID: <20190108220938.GI21010@magnolia>
References: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080169
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 04:57:34PM -0500, Jeff Moyer wrote:
> There was some confusion about what these functions did.  Make it clear
> that this is a hint for upper layers to pass to the block layer, and
> that it does not guarantee that I/O will not be submitted between a
> start and finish plug.
> 
> Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c78042975737..f2732f106a2e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1683,6 +1683,15 @@ EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
>   * @plug:	The &struct blk_plug that needs to be initialized
>   *
>   * Description:
> + *   blk_start_plug() indicates to the block layer an intent by the caller
> + *   to submit multiple I/O requests in a batch.  The block layer may use
> + *   this hint to defer submitting I/Os from the caller until blk_finish_plug()
> + *   is called.  However, the block layer may choose to submit requests
> + *   before a call to blk_finish_plug() if the number of queued I/Os
> + *   exceeds %BLK_MAX_REQUEST_COUNT, or if the size of the I/O is larger than
> + *   %BLK_PLUG_FLUSH_SIZE.  The queued I/Os may also be submitted early if
> + *   the task schedules (see below).

Makes sense to my poor brain,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>   *   Tracking blk_plug inside the task_struct will help with auto-flushing the
>   *   pending I/O should the task end up blocking between blk_start_plug() and
>   *   blk_finish_plug(). This is important from a performance perspective, but
> @@ -1765,6 +1774,16 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  		blk_mq_flush_plug_list(plug, from_schedule);
>  }
>  
> +/**
> + * blk_finish_plug - mark the end of a batch of submitted I/O
> + * @plug:	The &struct blk_plug passed to blk_start_plug()
> + *
> + * Description:
> + * Indicate that a batch of I/O submissions is complete.  This function
> + * must be paired with an initial call to blk_start_plug().  The intent
> + * is to allow the block layer to optimize I/O submission.  See the
> + * documentation for blk_start_plug() for more information.
> + */
>  void blk_finish_plug(struct blk_plug *plug)
>  {
>  	if (plug != current->plug)
