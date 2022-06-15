Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45257C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiFOG4i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiFOG4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B119237A16
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655276195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRlRkelPeqOCdoUlDc20pp9W6haS3weBk7iLOhjm1QI=;
        b=doYBoFyMHO7dmyad64KQwR65xV/sJdwAJ7az3+f6cLgcWy0KfCYtz8QEKmx7GYbceUIL+u
        Zh9uRlZDfrZEZMKA8KB/UQOtr/HJYZ9gSHMOoCzyU6w2D/cySaaqarQo5FjWW7V24jJOqj
        QgpIXplKEfQARVsiAAlXEWsCNR7VzJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-dqBivJW-OzW-ZhIVcUAnlg-1; Wed, 15 Jun 2022 02:56:30 -0400
X-MC-Unique: dqBivJW-OzW-ZhIVcUAnlg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36B9D85A581;
        Wed, 15 Jun 2022 06:56:30 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07CE8401E68;
        Wed, 15 Jun 2022 06:56:26 +0000 (UTC)
Date:   Wed, 15 Jun 2022 14:56:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2 2/3] blk-mq: avoid to touch q->elevator without any
 protection
Message-ID: <YqmClQiasYgxpurq@T590>
References: <20220615064826.773067-1-ming.lei@redhat.com>
 <20220615064826.773067-3-ming.lei@redhat.com>
 <20220615065034.GA23449@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615065034.GA23449@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 08:50:34AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 02:48:25PM +0800, Ming Lei wrote:
> > q->elevator is referred in blk_mq_has_sqsched() without any protection,
> > no .q_usage_counter is held, no queue srcu and rcu read lock is held,
> > so potential use-after-free may be triggered.
> > 
> > Fix the issue by adding one queue flag for checking if the elevator
> > uses single queue style dispatch. Meantime the elevator feature flag
> > of ELEVATOR_F_MQ_AWARE isn't needed any more.
> 
> We still need to clear the flag when switching elevators.

Indeed, or it can be cleared in initializing none and kyber. 

Thanks,
Ming

