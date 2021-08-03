Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49824C4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D726056B
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhHCHSR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233966AbhHCHSR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Aug 2021 03:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627975086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uh6lA63ZLrHCQ4dRlre02ZtHznJi3cHOJJxWi5JPs8=;
        b=Mva8T5ocjzTMRm9N81xlW62jyKIqOASmke5U+5ZaCqPsr7QTz4q2/qYpxlHHSink/xZrOG
        o8eYecrRC7cY58g7CCcu0yVHuUW0+zVgG3hAr0OCUVf7iPgXJ96CNwKWxGLJdPuB93Z3Vu
        ySD/irM/b9RKIMTTHpAcSxhT93/3aZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-HU_W_7XcOnOrbPKt4uWQ_g-1; Tue, 03 Aug 2021 03:18:05 -0400
X-MC-Unique: HU_W_7XcOnOrbPKt4uWQ_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A0AD801B3D;
        Tue,  3 Aug 2021 07:18:03 +0000 (UTC)
Received: from T590 (ovpn-13-115.pek2.redhat.com [10.72.13.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB51C5D6AD;
        Tue,  3 Aug 2021 07:17:55 +0000 (UTC)
Date:   Tue, 3 Aug 2021 15:18:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH 1/2] loop: Prevent that an I/O scheduler is assigned
Message-ID: <YQjtq/QVhZX9jsQU@T590>
References: <20210803000200.4125318-1-bvanassche@acm.org>
 <20210803000200.4125318-2-bvanassche@acm.org>
 <YQihyvnN3msaNyDW@T590>
 <07388685-bb67-3fc9-83e2-32a4a37fec4d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07388685-bb67-3fc9-83e2-32a4a37fec4d@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 02, 2021 at 10:23:56PM -0700, Bart Van Assche wrote:
> On 8/2/21 6:54 PM, Ming Lei wrote:
> > On Mon, Aug 02, 2021 at 05:01:59PM -0700, Bart Van Assche wrote:
> >> Loop devices have a single hardware queue. Hence, the block layer function
> >> elevator_get_default() selects the mq-deadline scheduler for loop devices.
> >> Using the mq-deadline scheduler or any other I/O scheduler for loop devices
> >> incurs unnecessary overhead. Make the loop driver pass the flag
> >> BLK_MQ_F_NOSCHED to the block layer core such that no I/O scheduler can be
> >> associated with block devices. This approach has an advantage compared to
> >> letting udevd change the loop I/O scheduler to none, namely that
> >> synchronize_rcu() does not get called.
> >>
> >> It is intentional that the flag BLK_MQ_F_SHOULD_MERGE is preserved.
> >>
> >> This patch reduces the Android boot time on my test setup with 0.5 seconds.
> > 
> > Can you investigate why none reduces Android boot time? Or reproduce &
> > understand it by a fio simulation on your setting?
> 
> Hi Ming,
> 
> The software process called apexd creates multiple loop devices while
> the device is booting. Using BLK_MQ_F_NO_SCHED is faster than letting
> apexd change the I/O scheduler from mq-deadline into 'none' since the
> latter involves calling synchronize_rcu() once per loop device.

OK, but why does apexd switch to none during booting? Does none perform
better than deadline during booting in the Android setting?


Thanks,
Ming

