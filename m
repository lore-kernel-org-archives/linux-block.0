Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D570CCA488
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 12:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiGUMHg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiGUMHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 08:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1689885FB3
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658405240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9ugx/ZqACR4HW5VcP1UFVVMLvpTmYYfpJTw+qiZB+4=;
        b=W5TR6rDRWXtYar4zIdU+6419O5NC/kDzhNxZVu0QzB73tJ9OD/Ms8fRtau7HtlbahrgS68
        4jEywpeo1y5Y1p5MFlHnRH/FtIv6OerhWhzn2a1IeMTmZQwU1fSW4sA2rznI5mbcW+igsI
        Ylwh/3qscxAs83pdejfJCUYBrlS653g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-pNulgRqlMI-BD6SbuzQ5uA-1; Thu, 21 Jul 2022 08:07:19 -0400
X-MC-Unique: pNulgRqlMI-BD6SbuzQ5uA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A54B98001EA;
        Thu, 21 Jul 2022 12:07:18 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28BE840D296B;
        Thu, 21 Jul 2022 12:07:15 +0000 (UTC)
Date:   Thu, 21 Jul 2022 20:07:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: call blk_mq_exit_queue from disk_release for
 never added disks
Message-ID: <YtlBb3qQHM1Hg0hU@T590>
References: <20220720130541.1323531-1-hch@lst.de>
 <20220720130541.1323531-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720130541.1323531-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 03:05:41PM +0200, Christoph Hellwig wrote:
> To undo the all initialization from blk_mq_init_allocated_queue in case
> of a probe failure where add_disk is never called we have to call
> blk_mq_exit_queue from put_disk.
> 
> This relies on the fact that drivers always call blk_mq_free_tag_set
> after calling put_disk in the probe error path if they have a gendisk
> at all.
> 
> We should be doing this in general, but can't do it for the normal
> teardown case (yet) as the tagset can be gone by the time the disk is
> released once it was added.  I hope to sort this out properly eventually
> but for now this isolated hack will do it.
> 
> Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

