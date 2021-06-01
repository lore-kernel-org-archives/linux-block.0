Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3DC47080
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA69613C1
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 13:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhFAN1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233584AbhFAN1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Jun 2021 09:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622553964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TuMZN1E0lbaQ4+hZI+BzEhy4hL1Tvu8HZ6jA5gQoCo=;
        b=BimEqlFAjj6lg0oLtWaP3eUKyX38iWPVHy48cG8K0x/8z8tiD1G2H8YqsZlCcRAX/TktFB
        BvN+yy2eTNHYFgh/rI1l2EV/yBuu6V+scr6m6vl2mTb5cSn18ZB9I1XSF3dsDNk1ZHnkEW
        slP1xOV1TdtJAkmZa484EiuLPHeTmk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-K2HIVmKNP-izGpM3ukrxfQ-1; Tue, 01 Jun 2021 09:26:03 -0400
X-MC-Unique: K2HIVmKNP-izGpM3ukrxfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26CB6107ACC7;
        Tue,  1 Jun 2021 13:26:01 +0000 (UTC)
Received: from T590 (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED749936;
        Tue,  1 Jun 2021 13:25:55 +0000 (UTC)
Date:   Tue, 1 Jun 2021 21:25:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/genhd: use atomic_t for disk_event->block
Message-ID: <YLY1V/dTMeo3RGZd@T590>
References: <20210601110145.113365-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601110145.113365-1-hare@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 01, 2021 at 01:01:45PM +0200, Hannes Reinecke wrote:
> __disk_unblock_events() will call queue_delayed_work() with a '0' argument
> under a spin lock. This might cause the queue_work item to be executed
> immediately, and run into a deadlock in disk_check_events() waiting for
> the lock to be released.

Do you have lockdep warning on this 'deadlock'?

Executed immediately doesn't mean the work fn is run in the current
task context, and it is actually run in one wq worker(task) context, so
__queue_work() usually wakes up one wq worker for running the work fn,
then there shouldn't be the 'deadlock' you mentioned.

Thanks, 
Ming

