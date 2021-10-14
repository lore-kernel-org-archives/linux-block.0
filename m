Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76351C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 12:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F15E60249
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 12:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJNM7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 08:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhJNM73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 08:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634216244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLprBwzw3zdwZmIPUsgXWg/hL7f0fQH46xTlmsNLxUs=;
        b=gfxHL/DDkmmUepHZGX8UnYw75gOTY7bD27prIF/xKKS/yO406rrpvw8BDdQyMJkMiqYnZl
        gm8thlKsj/Q9HV6k5DzLCHgeUun/3MlV4VXuetj1fzaAhjbNGiCJSmgnkzuSLFVxFuVvqS
        IWarMBHK6pVIAxSn7X0qQ4pXRJdt00M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-tD5ZwdSZMFyAtD4ErJy4lw-1; Thu, 14 Oct 2021 08:57:21 -0400
X-MC-Unique: tD5ZwdSZMFyAtD4ErJy4lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0850F80365C;
        Thu, 14 Oct 2021 12:57:20 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9591E5F4E2;
        Thu, 14 Oct 2021 12:57:07 +0000 (UTC)
Date:   Thu, 14 Oct 2021 20:57:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6/5] kyber: avoid q->disk dereferences in trace points
Message-ID: <YWgpHlO8UJ+IY3lB@T590>
References: <20210929071241.934472-1-hch@lst.de>
 <20211012093301.GA27795@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012093301.GA27795@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Christoph,

On Tue, Oct 12, 2021 at 11:33:01AM +0200, Christoph Hellwig wrote:
> 
> q->disk becomes invalid after the gendisk is removed.  Work around this
> by caching the dev_t for the tracepoints.  The real fix would be to
> properly tear down the I/O schedulers with the gendisk, but that is
> a much more invasive change.

Except for kyber, blkcg code refers q->disk too.

Such as blkg_dev_name() used in showing blk cgroup files, see
tg_print_limit(), but blkcg_exit_queue() is called in queue's release
handler, so q->disk can be referred when reading blkcg file of cgroup
fs from userspace after deleting gendisk.

I think it is fine to move blkcg_exit_queue() into del_gendisk(), but
bfq_exit_queue() is still run from queue's release handler, and bfq's
blkcg policy is deactivated there. That said the referring in reading
bfq's cgroup file still can come after deleting disk, especially kernel
panic could be caused when q->disk is cleared between the check and
calling to bdi_dev_name() in blkg_dev_name().


Thanks,
Ming

