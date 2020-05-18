Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A55C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623E620829
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 14:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFvTWBO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgEROLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 10:11:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55982 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727777AbgEROLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 10:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589811109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0q14dTQM4ztZToCHZyhdVy/GSWOSU63Ktzo9WgwS1bU=;
        b=KFvTWBO6zItyqYFo4eBB2xIlXkiJjbwxcTTYoWX+n4Kn2JkgVN+SRLGsemNvZHcaBo0+rg
        DWO5FwYub3GATOwWWs+5NWNXxpA+s8cQ2TiJbQg6Af7iO9LpFKqOkMcmqAWfLfAZNjn8Y9
        0TisAqJEHZhAC/UAUft3TS4DFFP4S3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-CELdJfT0N_6sphNrW7QOPQ-1; Mon, 18 May 2020 10:11:44 -0400
X-MC-Unique: CELdJfT0N_6sphNrW7QOPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D8018691E8;
        Mon, 18 May 2020 14:11:20 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC425C1B2;
        Mon, 18 May 2020 14:11:11 +0000 (UTC)
Date:   Mon, 18 May 2020 22:11:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200518141107.GA50374@T590>
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de>
 <20200518115454.GA46364@T590>
 <20200518131634.GA645@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518131634.GA645@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 03:16:34PM +0200, Christoph Hellwig wrote:
> On Mon, May 18, 2020 at 07:54:54PM +0800, Ming Lei wrote:
> > 
> > I guess I misunderstood your point, sorry for that.
> > 
> > The requirement is just that the request needs to be allocated on one online
> > CPU after INACTIVE is set, and we can use a workqueue to do that.
> 
> I've looked over the code again, and I'm really not sure why we need that.
> Presumable the CPU hotplug code ensures tasks don't get schedule on the
> CPU running the shutdown state machine, so if we just do a retry of the

percpu kthread still can be scheduled on the cpu to be online, see
is_cpu_allowed(). And bound wq has been used widely in fs code.

> tag allocation we can assume we are on a different CPU now (Thomas,
> correct me if that assumption is wrong).  So I think we can do entirely
> with the preempt_disable and the smp calls.  Something like this branch,
> which has only survived basic testing (the last patch is the pimary
> interesting one, plus maybe the last 3 before that):
> 
>     git://git.infradead.org/users/hch/block.git blk-mq-hotplug.2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.2
> 

After preempt_disable() is removed, the INACTIVE bit is set in the CPU
to be offline, and the bit can be read on all other CPUs, so other CPUs
may not get synced with the INACTIVE bit.


Thanks,
Ming

