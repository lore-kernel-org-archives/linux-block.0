Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8DAC05027
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 05:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBJFGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 00:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBJFGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 00:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011855E43
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 21:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676005525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwHX/8RJ480gQAUfQ+77LArNcL1Sxr8CpcwuptEWzr8=;
        b=CrtRLIIQtEt+8zEm7rmzKEsMHiePx4KQ3Hv0FlfUPbjRcWZu0yRXpFYwPIlawmZ++/wuZs
        +znDQxjKhl2yez/rMawG/J3/xzu4I22ik7FBQwp11yfJ29smD9/5w/nMrfY/dnsacrZKGg
        qeTn+olIjFkobFj9OOe4HK0KfPXcTZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-9HV0kWXHPmOz8xVW-FdXpA-1; Fri, 10 Feb 2023 00:05:20 -0500
X-MC-Unique: 9HV0kWXHPmOz8xVW-FdXpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6B578027EB;
        Fri, 10 Feb 2023 05:05:19 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB43D4043840;
        Fri, 10 Feb 2023 05:05:16 +0000 (UTC)
Date:   Fri, 10 Feb 2023 13:05:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <Y+XQh3zMHMIX2+jr@T590>
References: <20230208063514.171485-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208063514.171485-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 08, 2023 at 07:35:14AM +0100, Christoph Hellwig wrote:
> While del_gendisk ensures there is no outstanding I/O on the queue,
> it can't prevent block layer users from building new I/O.
> 
> This leads to a NULL ->root_blkg reference in bio_associate_blkg when
> allocating a new bio on a shut down file system.  Delay freeing the
> blk-cgroup subsystems from del_gendisk until disk_release to make
> sure the blkg and throttle information is still avaіlable for bio
> submitters, even if those bios will immediately fail.
> 
> This now can cause a case where disk_release is called on a disk
> that hasn't been added.  That's mostly harmless, except for a case
> in blk_throttl_exit that now needs to check for a NULL ->td pointer.
> 
> Fixes: 178fa7d49815 ("blk-cgroup: delay blk-cgroup initialization until add_disk")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

hammmmmm, this patch actually causes bigger trouble.

After commit 84d7d462b16d ("blk-cgroup: pin the gendisk in struct blkcg_gq"),
blkcg_gq instance grabs disk's reference, so moving blkcg_exit_disk
into disk_release() just causes reference cross-dependency, both are
leaked.

Thanks,
Ming

