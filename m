Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D53C636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 07:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBHHkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBHHkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 02:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B73C2A7
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675841933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+yVtQvBMu+ddBSlzI2X+dFqNhu76LTfR7rxMLPKsYA=;
        b=EGvsOgKctBiw/Lfu6R81MCzelkACWiSggFutZXQNjOlHOd5n/Bn+zsw3iOOa8IvPS9WCic
        xnw4Vsnyu6A2GDuofjrpUynNp4rHhrHhwmGPYsrbn/EPWV6uwqP4qT1j9O2g4rCTF7x4zM
        8GvARwqyh9PTcMg7N9m/ubrTSuAQo1E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-UI1_PjXHNt2mVy3WKagZWA-1; Wed, 08 Feb 2023 02:38:49 -0500
X-MC-Unique: UI1_PjXHNt2mVy3WKagZWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 123B93811F2B;
        Wed,  8 Feb 2023 07:38:49 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFD131121315;
        Wed,  8 Feb 2023 07:38:45 +0000 (UTC)
Date:   Wed, 8 Feb 2023 15:38:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <Y+NRgI+99Gz33BvQ@T590>
References: <20230208063514.171485-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208063514.171485-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

With this way, blkcg_init_disk() could be called before q->root_blkg
is released in disk unbind & rebind use case, then memory leak?

Thanks,
Ming

