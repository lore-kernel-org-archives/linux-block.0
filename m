Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678DECDB474
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 02:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJRChl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJRChk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 22:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C1FF
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 19:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697596610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RV682s6nNPGRHlqZgk5Xv8DjWX7mCN9z9Iln0uNl9DY=;
        b=AKL6rV9ziwORLhiQTozeWEKhE9qfq08aq+QtDXciL5Z4JaJJ48GXft1Sn43jpyUFlypcgc
        i8MvP1On0uYX5Buhr1m3drMEtV4Q2sn1QQyO9b3mesq22VoaoOLfwUXxXnpExW4mpaeQM0
        A8tNfnv06ojemMoNs7774y8XyMxch4s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-pD8srjfNMri8P_deMHG4-w-1; Tue, 17 Oct 2023 22:36:45 -0400
X-MC-Unique: pD8srjfNMri8P_deMHG4-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA07229AB3F7;
        Wed, 18 Oct 2023 02:36:44 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFAF4492BFA;
        Wed, 18 Oct 2023 02:36:39 +0000 (UTC)
Date:   Wed, 18 Oct 2023 10:36:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] block: WARN_ON_ONCE() when we remove active
 partitions
Message-ID: <ZS9EsurQEXbR7IlS@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 17, 2023 at 08:48:20PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> The logic for disk->open_partitions is:
> 
> blkdev_get_by_*()
> -> bdev_is_partition()
>    -> blkdev_get_part()
>       -> blkdev_get_whole() // bdev_whole->bd_openers++
>       -> if (part->bd_openers == 0)
>                  disk->open_partitions++
>          part->bd_openers
> 
> In other words, when we first claim/open a partition we increment
> disk->open_partitions and only when all part->bd_openers are closed will
> disk->open_partitions be zero. That should mean that
> disk->open_partitions is always > 0 as long as there's anyone that
> has an open partition.
> 
> So the check for disk->open_partitions should meand that we can never
> remove an active partition that has a holder and holder ops set. Assert
> that in the code. The main disk isn't removed so that check doesn't work
> for disk->part0 which is what we want. After all we only care about
> partition not about the main disk.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

inc/dec(part->bd_openers) is always done with ->open_mutex held, so this
change is correct.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

