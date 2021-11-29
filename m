Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 29 Nov 2021 02:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhK2CZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 21:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233842AbhK2CXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 21:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638152389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWxmmyxUjhWzJRMEAq97sAVYD/f5h1k5bCVMd0F7KVQ=;
        b=PMSQUVvFUAtgf0RCRb8bZGOL78g6DeoM+t8tpep8/jE2yNNLpUvvsdYVYV4L3GipMTjcTr
        oH/1AG3AkgrlOgbjwoXrOj1ymii/DSXASmm/IM0eLC1m2OD8Pjh2eQKymYFa4bJKxTSJLB
        wYE832w4DlU3/tJZdEBT9FBlxXi8jbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-Xmtua7hhMrG0k6Ij0g-1Dw-1; Sun, 28 Nov 2021 21:19:46 -0500
X-MC-Unique: Xmtua7hhMrG0k6Ij0g-1Dw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21874363A4;
        Mon, 29 Nov 2021 02:19:45 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71255196E5;
        Mon, 29 Nov 2021 02:19:28 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:19:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH RFT 3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter()
 for shared tags
Message-ID: <YaQ4rBwwmQhV23ET@T590>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <1635852455-39935-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635852455-39935-4-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 02, 2021 at 07:27:35PM +0800, John Garry wrote:
> Kashyap reports high CPU usage in blk_mq_queue_tag_busy_iter() and callees
> using megaraid SAS RAID card since moving to shared tags [0].
> 
> Previously, when shared tags was shared sbitmap, this function was less
> than optimum since we would iter through all tags for all hctx's,
> yet only ever match upto tagset depth number of rqs.
> 
> Since the change to shared tags, things are even less efficient if we have
> parallel callers of blk_mq_queue_tag_busy_iter(). This is because in
> bt_iter() -> blk_mq_find_and_get_req() there would be more contention on
> accessing each request ref and tags->lock since they are now shared among
> all HW queues.
> 
> Optimise by having separate calls to bt_for_each() for when we're using
> shared tags. In this case no longer pass a hctx, as it is no longer
> relevant, and teach bt_iter() about this.
> 
> Ming suggested something along the lines of this change, apart from a
> different implementation.
> 
> [0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

