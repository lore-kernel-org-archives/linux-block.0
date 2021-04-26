Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B577C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14050611CE
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 06:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhDZGne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbhDZGnd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 02:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619419339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NM6lOOxPG/ArlLl9ZqV4gZFwO27+A1GwYsbYUuqYRHk=;
        b=J6opyF8kGMe/3Rou0TSwI4MxkBmhdZb/nOqfL9ScJkUxQfsL7/hMO5r5kzbad6UN7vO3FV
        qbsiFkA6C2I3NC7EjZvQ0jJ6tmLMKjVtQoVYrwRSfEnpkRTxzusNXersgemNs4jMwPHJO1
        xmQIp6fvuY34cesFSJvXuWUau7pODCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-90JESyrnMHOkhKYAiY-u-w-1; Mon, 26 Apr 2021 02:42:17 -0400
X-MC-Unique: 90JESyrnMHOkhKYAiY-u-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456031009619;
        Mon, 26 Apr 2021 06:42:16 +0000 (UTC)
Received: from T590 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F13FB646D6;
        Mon, 26 Apr 2021 06:42:11 +0000 (UTC)
Date:   Mon, 26 Apr 2021 14:42:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 3/5] block: return errors from blk_execute_rq()
Message-ID: <YIZgyY0mMj/LIpVh@T590>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-4-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 03:05:56PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the errno from the
> dispatch status.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c       | 6 ++++--
>  include/linux/blkdev.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index b960ad187ba5..4e8e6fe20956 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
>  {
>  	struct completion *waiting = rq->end_io_data;
>  
> -	rq->end_io_data = NULL;
> +	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
>  
>  	/*
>  	 * complete last, if this is a stack request the process (and thus
> @@ -77,8 +77,9 @@ static bool blk_rq_is_poll(struct request *rq)
>   * Description:
>   *    Insert a fully prepared request at the back of the I/O scheduler queue
>   *    for execution and wait for completion.
> + * Return: The errno value of the blk_status_t provided to blk_mq_end_request().
>   */
> -void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
> +int blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  {
>  	DECLARE_COMPLETION_ONSTACK(wait);
>  	unsigned long hang_check;
> @@ -97,5 +98,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
>  	else
>  		wait_for_completion_io(&wait);
> +	return PTR_ERR_OR_ZERO(rq->end_io_data);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

