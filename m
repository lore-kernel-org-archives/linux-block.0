Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B9C38A29
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 02:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315D92076C
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 02:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCFUfL8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbgDPCbs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:31:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387815AbgDPCbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 22:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587004306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MvV/kU/pFrjkbAJ+eW/cY6VL5dwLgz9Jc5F00dhkTB0=;
        b=TCFUfL8VmU4pgAuynaRGA1B4g6UyhBHNZmlDNyYyy5xBVfWe3tTEmo+tocerAxLTQjS8bH
        SKU1i1q9AfqKYV7eOwR/mmgRfYzXhdTz9amwyj9Sma6oLykAtcUPVhuLcou7FCEf/+Xoos
        3F4kmaPu8Q/M6uuHv+rLNi1AYimrsoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-fZPwCsSMMmSAl1giz5QxOw-1; Wed, 15 Apr 2020 22:31:42 -0400
X-MC-Unique: fZPwCsSMMmSAl1giz5QxOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADBBC1005509;
        Thu, 16 Apr 2020 02:31:39 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 947DA272A1;
        Thu, 16 Apr 2020 02:31:27 +0000 (UTC)
Date:   Thu, 16 Apr 2020 10:31:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200416023122.GB2717677@T590>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-4-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 14, 2020 at 04:19:00AM +0000, Luis Chamberlain wrote:
> Ensure that the request_queue is refcounted during its full
> ioctl cycle. This avoids possible races against removal, given
> blk_get_queue() also checks to ensure the queue is not dying.
> 
> This small race is possible if you defer removal of the request_queue
> and userspace fires off an ioctl for the device in the meantime.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: yu kuai <yukuai3@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/trace/blktrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 15086227592f..17e144d15779 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -701,6 +701,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>  	if (!q)
>  		return -ENXIO;
>  
> +	if (!blk_get_queue(q))
> +		return -ENXIO;
> +
>  	mutex_lock(&q->blk_trace_mutex);
>  
>  	switch (cmd) {
> @@ -729,6 +732,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>  	}
>  
>  	mutex_unlock(&q->blk_trace_mutex);
> +
> +	blk_put_queue(q);
> +
>  	return ret;
>  }

Actually when bdev is opened, one extra refcount is held on gendisk, so
gendisk won't go away. And __device_add_disk() does grab one extra
refcount on request queue, so request queue shouldn't go away when ioctl
is running.

Can you describe a bit more what the issue is to be addressed by this
patch?

Thanks,
Ming

