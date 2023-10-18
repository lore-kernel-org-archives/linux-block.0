Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59401CDB483
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 09:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJRJQj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJRJQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 05:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26472111
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697620551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/qWmMyaSoOmFzIVwgqNv8CarT9NCUVK0T0yzdu7ukI=;
        b=i+kn0dpcXPPdtUhxxS4w3YK6DvQt17OicdNB10/HM+ZH6OugL9ikFLodBWvKcRlpx5O/Mk
        5fmCZEZbg8Xs5C0Hup3VHVCPc5AGBl12vL6Tke/Uss6q7ko50n6GKnleatYpBPHERlsgot
        MGiKiCDekaTmF3yLmo4pwumilEZeQCs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-34SCTa7HMEO5n_1ihoTmaQ-1; Wed, 18 Oct 2023 05:15:47 -0400
X-MC-Unique: 34SCTa7HMEO5n_1ihoTmaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A282825E8D;
        Wed, 18 Oct 2023 09:15:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C41182166B26;
        Wed, 18 Oct 2023 09:15:41 +0000 (UTC)
Date:   Wed, 18 Oct 2023 17:15:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <ZS+iOA//0ShbY7Fk@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
 <ZS9ODABLaRVcI5iy@fedora>
 <20231018064646.GA18710@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018064646.GA18710@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 18, 2023 at 08:46:46AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 18, 2023 at 11:16:28AM +0800, Ming Lei wrote:
> > On Tue, Oct 17, 2023 at 08:48:21PM +0200, Christoph Hellwig wrote:
> > > disk_check_media_change is mostly called from ->open where it makes
> > > little sense to mark the file system on the device as dead, as we
> > > are just opening it.  So instead of calling bdev_mark_dead from
> > > disk_check_media_change move it into the few callers that are not
> > > in an open instance.  This avoid calling into bdev_mark_dead and
> > > thus taking s_umount with open_mutex held.
> > 
> > ->open() is called when opening bdev every times, and there can be
> > existed openers, so not sure if it makes little sense here.
> 
> Yes. It has to be a non-exclusive open, though, and how is that going
> to help us with any general use case?  If we really want to make the
> media change notifications any useful we'd better just do the work
> straight from the workqueue that polls for it.

Given ->mark_dead() is added recently, userspace shouldn't depend on
this behavior, so this patch looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

