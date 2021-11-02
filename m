Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688AC433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 00:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B38560EE3
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 00:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhKBA3L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhKBA3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Nov 2021 20:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635812796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/iG4UfnOzpRX++zCnwAK8pPSjk1Qgs5k+asw8ejvyI=;
        b=EJG43X1/GA8pTAMRqfgfHfk4BU3CPKD2qewbjLAMtz8kwKWkbR81TQqfxufjbx3pPk+T0g
        zxkGInQynsKwoR2eYCsUD202xq8/hWddKUq0MrBLPH26X4llgctavk9kABzxkUYnHEFPdy
        gb9kqNuaArV6kFnqrNadaoeH7WuI+VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-jzTa7Hl-NkqOep9IpjG_TA-1; Mon, 01 Nov 2021 20:26:33 -0400
X-MC-Unique: jzTa7Hl-NkqOep9IpjG_TA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8048E80572F;
        Tue,  2 Nov 2021 00:26:32 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41DF71980E;
        Tue,  2 Nov 2021 00:26:27 +0000 (UTC)
Date:   Tue, 2 Nov 2021 08:26:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: replace always false argument with 'false'
Message-ID: <YYCFr6mjciIwqT2W@T590>
References: <7d6a5cde-1a98-55ef-4094-d9286d51fecd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6a5cde-1a98-55ef-4094-d9286d51fecd@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 01, 2021 at 01:42:16PM -0600, Jens Axboe wrote:
> A previous commit fixed up the condition for doing direct issue, but that
> left the 'from_schedule' argument dead inside the branch. Replace it with
> 'false'.
> 
> Fixes: ff1552232b36 ("blk-mq: don't issue request directly in case that current is to be blocked")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4787d5b74aa3..8aed6cea3a34 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2227,7 +2227,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	plug->rq_count = 0;
>  
>  	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
> -		blk_mq_plug_issue_direct(plug, from_schedule);
> +		blk_mq_plug_issue_direct(plug, false);
>  		if (rq_list_empty(plug->mq_list))
>  			return;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

