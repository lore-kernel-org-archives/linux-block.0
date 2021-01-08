Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C8C433E0
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 00:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21822368A
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 00:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbhAHAZh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 19:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728416AbhAHAZh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jan 2021 19:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610065451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iEbDAuTbYcbN/K+lxoyO0bntO+Q5viqond5goyhv0w0=;
        b=G399Aym4BAtqqh3SNOO2k2/qI9BuCGFkxFIMIc4FuypCjkHFhA7MsYBxgme+QJXPnRMjzy
        2VjBIukhVfJMe4pcCxLPdWHKcaJ9rzD/xHPNH3L+a7Km9e8rp7gx6qjNd/cx2n5O+hJSva
        v9roaTRYea2ogtf8TFFY2FYC1cVjEPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-p-gQ302nMGS6q0r-b1PM6Q-1; Thu, 07 Jan 2021 19:24:09 -0500
X-MC-Unique: p-gQ302nMGS6q0r-b1PM6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B791DDE0;
        Fri,  8 Jan 2021 00:24:07 +0000 (UTC)
Received: from T590 (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 525776E523;
        Fri,  8 Jan 2021 00:24:00 +0000 (UTC)
Date:   Fri, 8 Jan 2021 08:23:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Subject: Re: [PATCH v3] loop: fix I/O error on fsync() in detached loop
 devices
Message-ID: <20210108002356.GA3924144@T590>
References: <20210107181734.128296-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107181734.128296-1-mfo@canonical.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 07, 2021 at 03:17:34PM -0300, Mauricio Faria de Oliveira wrote:
> There's an I/O error on fsync() in a detached loop device
> if it has been previously attached.
> 
> The issue is write cache is enabled in the attach path in
> loop_configure() but it isn't disabled in the detach path;
> thus it remains enabled in the block device regardless of
> whether it is attached or not.
> 
> Now fsync() can get an I/O request that will just be failed
> later in loop_queue_rq() as device's state is not 'Lo_bound'.
> 
> So, disable write cache in the detach path.
> 
> Do so based on the queue flag, not the loop device flag for
> read-only (used to enable) as the queue flag can be changed
> via sysfs even on read-only loop devices (e.g., losetup -r.)
> 
> Test-case:
> 
>     # DEV=/dev/loop7
> 
>     # IMG=/tmp/image
>     # truncate --size 1M $IMG
> 
>     # losetup $DEV $IMG
>     # losetup -d $DEV
> 
> Before:
> 
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = -1 EIO (Input/output error)
>     Warning: Error fsyncing/closing /dev/loop7: Input/output error
>     [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> 
> After:
> 
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = 0
> 
> Co-developed-by: Eric Desrochers <eric.desrochers@canonical.com>
> Signed-off-by: Eric Desrochers <eric.desrochers@canonical.com>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Tested-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  drivers/block/loop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> v3:
> - Disable write cache based on QUEUE_FLAG_WC, not just
>   !LO_FLAGS_READ_ONLY, as the former can be enabled in
>   sysfs even for LO_FLAGS_READ_ONLY, thus not disabled
>   later. Mention that in commit message. (thanks, Ming)
> v2:
> - Fix ordering of Co-developed-by:/Signed-off-by: tags.
>   (thanks, Krisman)
> - Add Tested-by: tag. (likewise.)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index e5ff328f0917..e94a11dbb5bd 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1212,6 +1212,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  		goto out_unlock;
>  	}
>  
> +	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
> +		blk_queue_write_cache(lo->lo_queue, false, false);
> +
>  	/* freeze request queue during the transition */
>  	blk_mq_freeze_queue(lo->lo_queue);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

