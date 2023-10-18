Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC86CDB482
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 03:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJRDTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 23:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRDTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 23:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC6BA
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697599144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zVoFF6aUxd9VaJA+YrLxhoeUc7CrRCl7wEDGMfXOIc=;
        b=ZZrt3FpKxrgasvDZwsuNNfbAyXf9cTix/y6LnYN8rSC+tnaJdkQS/X6M9CrOvI3LNBj+Ds
        QDLEgdoFV1jpD4+t/SoLbO2ZEoiLnJmN57PsvZ0qWzFYrh+bnvP3E+fThtpB2YubD0tStY
        IfgfjXdwcq7gQ/+yjCJycvTbhr+YepE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-YAMtSfHVPQqLcrpN2E1-AA-1; Tue, 17 Oct 2023 23:18:48 -0400
X-MC-Unique: YAMtSfHVPQqLcrpN2E1-AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96417101FA22;
        Wed, 18 Oct 2023 03:18:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19A2E1121314;
        Wed, 18 Oct 2023 03:18:42 +0000 (UTC)
Date:   Wed, 18 Oct 2023 11:18:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] block: assert that we're not holding open_mutex over
 blk_report_disk_dead
Message-ID: <ZS9OjlDuELDHJ4XM@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 17, 2023 at 08:48:22PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> blk_report_disk_dead() has the following major callers:
> 
> (1) del_gendisk()
> (2) blk_mark_disk_dead()
> 
> Since del_gendisk() acquires disk->open_mutex it's clear that all
> callers are assumed to be called without disk->open_mutex held.
> In turn, blk_report_disk_dead() is called without disk->open_mutex held
> in del_gendisk().
> 
> All callers of blk_mark_disk_dead() call it without disk->open_mutex as
> well.
> 
> Ensure that it is clear that blk_report_disk_dead() is called without
> disk->open_mutex on purpose by asserting it and a comment in the code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 4a16a424f57d4f..c9d06f72c587e8 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -559,6 +559,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
>  	struct block_device *bdev;
>  	unsigned long idx;
>  
> +	/*
> +	 * On surprise disk removal, bdev_mark_dead() may call into file
> +	 * systems below. Make it clear that we're expecting to not hold
> +	 * disk->open_mutex.
> +	 */
> +	lockdep_assert_not_held(&disk->open_mutex);
> +
>  	rcu_read_lock();
>  	xa_for_each(&disk->part_tbl, idx, bdev) {
>  		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks, 
Ming

