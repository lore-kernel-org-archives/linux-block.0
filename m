Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49327C433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 08:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01422071E
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 08:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6fiprSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHZIyk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:54:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726817AbgHZIyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 04:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598432079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56FG6teEw4RSdJiBxs3Vq6wn/n1d8Nwo2AXp7U//4Dg=;
        b=K6fiprSo0hw8TI7Q6sjgXFMN4fdNgvll/P9ld9XTA6+j1fwvIjKefRUjU9ol1KKA7berZh
        Q34R4im9Hw5SAY42g7McODOaVMCtv3b+bousl5Ib4vudYJ7IFpF3FgsSw9I7+FniOTJb4L
        s7D7zvnjBWvwdNyMVrZ9wd4W9DZTNlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-_-5nodMgObCM2vf2Hj8TQw-1; Wed, 26 Aug 2020 04:54:35 -0400
X-MC-Unique: _-5nodMgObCM2vf2Hj8TQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC9C5807332;
        Wed, 26 Aug 2020 08:54:33 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE5B119144;
        Wed, 26 Aug 2020 08:54:27 +0000 (UTC)
Date:   Wed, 26 Aug 2020 16:54:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V2 1/2] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Message-ID: <20200826085422.GB116347@T590>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200825141734.115879-2-ming.lei@redhat.com>
 <751a63a2-9185-ba27-e84a-91b7cdd33ee7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751a63a2-9185-ba27-e84a-91b7cdd33ee7@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 26, 2020 at 03:51:25PM +0800, Chao Leng wrote:
> It doesn't matter. Because the reentry of quiesce&unquiesce queue is not
> safe, must be avoided by other mechanism. otherwise, exceptions may
> occur. Introduce mq_quiesce_lock looks saving possible synchronization
> waits, but it should not happen. If really happen, we need fix it.

Sagi mentioned there may be nested queue quiesce, so I add .mq_quiesce_lock 
to make this usage easy to support, meantime avoid percpu_ref warning
in such usage.

Anyway, not see any problem with adding .mq_quiesce_lock, so I'd suggest to
move on with this way.


Thanks, 
Ming

