Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4845CDB474
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 02:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjJRCeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRCeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 22:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB568AB
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697596429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+c7XWwfI5su+KU5JFMXH8S0BZEAJVg6AFCq5tfYLl9A=;
        b=EObSsv1NEQHDTTLVeBp5HP/blewOlrdnfjKk3YuLwejuZMpLF4WjYqei4ysfr2D4OnhUnr
        LT2mjcOF6lGwQXA7JrpZDIRJNFHMlwqQGYgUdk65i9NdNF4mBkFiXoCRIi/9lDjP8NR5IC
        ZJi5ViEh1ipNUrRvb433Iq+L2bTDjrQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-EXWTGxTeMoudEzIsDeXLoQ-1; Tue, 17 Oct 2023 22:33:38 -0400
X-MC-Unique: EXWTGxTeMoudEzIsDeXLoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C7EF10201E5;
        Wed, 18 Oct 2023 02:33:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6698440C6CA3;
        Wed, 18 Oct 2023 02:33:33 +0000 (UTC)
Date:   Wed, 18 Oct 2023 10:33:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] block: simplify bdev_del_partition()
Message-ID: <ZS9D+LDJGHnP6BKi@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 17, 2023 at 08:48:19PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> BLKPG_DEL_PARTITION refuses to delete partitions that still have
> openers, i.e., that has an elevated @bdev->bd_openers count. If a device
> is claimed by setting @bdev->bd_holder and @bdev->bd_holder_ops
> @bdev->bd_openers and @bdev->bd_holders are incremented.
> @bdev->bd_openers is effectively guaranteed to be >= @bdev->bd_holders.
> So as long as @bdev->bd_openers isn't zero we know that this partition
> is still in active use and that there might still be @bdev->bd_holder
> and @bdev->bd_holder_ops set.
> 
> The only current example is @fs_holder_ops for filesystems. But that
> means bdev_mark_dead() which calls into
> bdev->bd_holder_ops->mark_dead::fs_bdev_mark_dead() is a nop. As long as
> there's an elevated @bdev->bd_openers count we can't delete the
> partition and if there isn't an elevated @bdev->bd_openers count then
> there's no @bdev->bd_holder or @bdev->bd_holder_ops.
> 
> So simply open-code what we need to do. This gets rid of one more
> instance where we acquire s_umount under @disk->open_mutex.
> 
> Link: https://lore.kernel.org/r/20231016-fototermin-umriss-59f1ea6c1fe6@brauner
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

inc/dec(part->bd_openers) is always done with ->open_mutex held, so this
change is correct.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

