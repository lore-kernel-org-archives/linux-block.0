Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE944C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 12:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMMOS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 07:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjBMMOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 07:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7B3A252
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNqQ9bXDgnnpNFNLGb68QXM6v2J1h53ebKftG058Huc=;
        b=EfHYRmaFIIhHzMQaz7YjMOYdMLzw4y77wuoQP6b91HynnQ8x169E9zFESaCtrn3IpyI4gB
        IzsE9HecAktrEeDP1eblp7OGrO9Nqncq3RgS5lAiaW0O9IW0MYkBeoTUvwUdfzD8YXl0eD
        CgO6IBGdU2W3L72L1Wzop9tEvY5QfoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-NSzQ04ndMlucMFWpQUBP1w-1; Mon, 13 Feb 2023 07:11:46 -0500
X-MC-Unique: NSzQ04ndMlucMFWpQUBP1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 109AE811E6E;
        Mon, 13 Feb 2023 12:11:46 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD5E3140EBF6;
        Mon, 13 Feb 2023 12:11:41 +0000 (UTC)
Date:   Mon, 13 Feb 2023 20:11:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 3/3] blk-cgroup: only grab an inode reference to the disk
 for each blkg
Message-ID: <Y+oo+P0MIZK8QMDZ@T590>
References: <20230213104134.475204-1-hch@lst.de>
 <20230213104134.475204-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213104134.475204-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 13, 2023 at 11:41:34AM +0100, Christoph Hellwig wrote:
> To avoid a circular reference, do not grab a device model reference
> to the gendisk for each blkg, but just the lower level inode reference
> preventing the memory from beeing freed.

It might not be enough to just prevent gendisk memory from being freed,
anywhere queue reference via disk->queue could become not safe given
disk->queue can be released after disk_release() is called.

thanks,
Ming

