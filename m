Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD47EC433E1
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8563F2087C
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAbY/egp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0CjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbgH0CjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 22:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598495940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMk+/OgQAe+YJ8Wk6xc8vjC2x6T2CM7SoEWLiSpeoFE=;
        b=KAbY/egpzbPG78g602/PVjf9GhLVtUSWtNS7YyssmO76QREmpOVtJtpA7hdXLHdP3RgAue
        hGfde9pYLaSmolibeN3y6dzxZZJY/FmXX8G3xrEyCUcE5QwNPDkIo/+iIGg6brnv0fqnJp
        nDdAcuvfv96apFgrjSvjkHwtMUcdSHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-kZsqP06mMLyZeifuQnm9zQ-1; Wed, 26 Aug 2020 22:38:58 -0400
X-MC-Unique: kZsqP06mMLyZeifuQnm9zQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B16B1007B00;
        Thu, 27 Aug 2020 02:38:56 +0000 (UTC)
Received: from T590 (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C69460C0F;
        Thu, 27 Aug 2020 02:38:48 +0000 (UTC)
Date:   Thu, 27 Aug 2020 10:38:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V2 1/2] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Message-ID: <20200827023844.GA129685@T590>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200825141734.115879-2-ming.lei@redhat.com>
 <751a63a2-9185-ba27-e84a-91b7cdd33ee7@huawei.com>
 <20200826085422.GB116347@T590>
 <20200826153633.GA2151118@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826153633.GA2151118@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 26, 2020 at 08:36:33AM -0700, Keith Busch wrote:
> On Wed, Aug 26, 2020 at 04:54:22PM +0800, Ming Lei wrote:
> > On Wed, Aug 26, 2020 at 03:51:25PM +0800, Chao Leng wrote:
> > > It doesn't matter. Because the reentry of quiesce&unquiesce queue is not
> > > safe, must be avoided by other mechanism. otherwise, exceptions may
> > > occur. Introduce mq_quiesce_lock looks saving possible synchronization
> > > waits, but it should not happen. If really happen, we need fix it.
> > 
> > Sagi mentioned there may be nested queue quiesce, so I add .mq_quiesce_lock 
> > to make this usage easy to support, meantime avoid percpu_ref warning
> > in such usage.
> > 
> > Anyway, not see any problem with adding .mq_quiesce_lock, so I'd suggest to
> > move on with this way.
> 
> I'm not sure there really are any nested queue quiesce paths, but if
> there are, wouldn't we need to track the "depth" like how a queue freeze
> works?

Both atomic 'depth' and .mq_quiesce_lock can work for nested queue
quiesce since we can avoid unnecessary queue quiesce with the mutex.
percpu_ref_kill() / percpu_ref_kill_and_confirm() can warn if the
percpu_ref has been killed, that is why I think Sagi's suggestion is good.

But 'depth' may cause trouble easily, such as unbalanced quiesce/unquiesce,
however no such issue with mutex, at least we don't require the two to
be paired strictly so far.


Thanks,
Ming

