Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB0C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 03:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiBHDWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 22:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiBHDWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 22:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68A6C043188
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 19:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644290574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8D66kxUP00T7OoPmNKoxe+oM0iQeUNPqMyqNc9M/3Hw=;
        b=JYotRuW1H91DwlMr+gtXRZF12IhNcigHFkzUiB0C1I4UEDHwol7BnOsu2oNpBFgCCYlAFm
        yeXp9g7htHCKUwKgWFX4gIY4LhqstltHIsl9XWzbZBq0bn8/44K+3hbJZhJ6YaEX8CPi8E
        bkQ1UtJld5R7Q9P8OylYZdbJJN+fw+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-ZvWy6mf5P22AV82Zhluq6w-1; Mon, 07 Feb 2022 22:22:50 -0500
X-MC-Unique: ZvWy6mf5P22AV82Zhluq6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB88802926;
        Tue,  8 Feb 2022 03:22:49 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9265E2F4;
        Tue,  8 Feb 2022 03:22:34 +0000 (UTC)
Date:   Tue, 8 Feb 2022 11:22:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: Re: [PATCH V3] block: loop:use kstatfs.f_bsize of backing file to
 set discard granularity
Message-ID: <YgHh9C9jq++Wzk+j@T590>
References: <20220126035830.296465-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126035830.296465-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 26, 2022 at 11:58:30AM +0800, Ming Lei wrote:
> If backing file's filesystem has implemented ->fallocate(), we think the
> loop device can support discard, then pass sb->s_blocksize as
> discard_granularity. However, some underlying FS, such as overlayfs,
> doesn't set sb->s_blocksize, and causes discard_granularity to be set as
> zero, then the warning in __blkdev_issue_discard() is triggered.
> 
> Christoph suggested to pass kstatfs.f_bsize as discard granularity, and
> this way is fine because kstatfs.f_bsize means 'Optimal transfer block
> size', which still matches with definition of discard granularity.
> 
> So fix the issue by setting discard_granularity as kstatfs.f_bsize if it
> is available, otherwise claims discard isn't supported.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- following Christoph's suggestion to not claim discard support if
> 	vfs_statfs() fails 

Hi Jens,

Any chance to merge it to v5.17?


Thanks,
Ming

