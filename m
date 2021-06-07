Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7EC4743E
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 00:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9DD613C8
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 00:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFGANS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhFGANS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Jun 2021 20:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623024687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fDP2maVPmzsGuozqXFpsK6C2uAMCKTA9vT6K9r3ZBa4=;
        b=A1JAmZGtXZJb7zJIBuOg1ngkdnLJQuCc6UEHDZUsNbduSHwjvafPXwO1GoT0nGaUxubp+D
        o2bhxTwQUegI9szReSjGIzmmbtvMvLwpyHEMTa2ao7tXGGC4HvRb58rEgi1w6wqE4jCQOk
        vnnBPyOSEWG3phL+1OQlDjTuYcfcRa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-QhGvJ5_ZPTeWLMp66CRpmQ-1; Sun, 06 Jun 2021 20:11:26 -0400
X-MC-Unique: QhGvJ5_ZPTeWLMp66CRpmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C80800D55;
        Mon,  7 Jun 2021 00:11:25 +0000 (UTC)
Received: from T590 (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6B760C04;
        Mon,  7 Jun 2021 00:11:17 +0000 (UTC)
Date:   Mon, 7 Jun 2021 08:11:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, pasha.tatashin@soleen.com,
        linux-block@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] block: loop: fix deadlock between open and remove
Message-ID: <YL1kIY6F7wZ86vU6@T590>
References: <20210605140950.5800-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605140950.5800-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 05, 2021 at 05:09:50PM +0300, Christoph Hellwig wrote:
> Commit c76f48eb5c08 ("block: take bd_mutex around delete_partitions in
> del_gendisk") adds disk->part0->bd_mutex in del_gendisk(), this way
> causes the following AB/BA deadlock between removing loop and opening
> loop:
> 
>  1) loop_control_ioctl(LOOP_CTL_REMOVE)
>      -> mutex_lock(&loop_ctl_mutex)
>      -> del_gendisk
>          -> mutex_lock(&disk->part0->bd_mutex)
> 
>  2) blkdev_get_by_dev
>      -> mutex_lock(&disk->part0->bd_mutex)
>      -> lo_open
>          -> mutex_lock(&loop_ctl_mutex)
> 
> Add a new Lo_deleting state to remove the need for clearing
> ->private_data and thus holding loop_ctl_mutex in the ioctl
> LOOP_CTL_REMOVE path.
> 
> Based on an analysis and earlier patch from
> Ming Lei <ming.lei@redhat.com>.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

