Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92BC433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 02:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B526A613A1
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 02:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhJECZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 22:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbhJECZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Oct 2021 22:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633400608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYdkGFNsg1XrWYpT1DFPpG2yoQQsTykXaPTXZFbd9MA=;
        b=ZNHwMOXfVDL3ue4QG6JthnldrlzzRDwY36dTbjl8rCstIobC8K4d/zhhT8btOzViWaPm2p
        uNoQxq5KzMwuBilJ+9zPUju2UzUtf/fgCgTU+Pt0oVvWGISZyX/ZG8E8gueH5XRRKxEJsJ
        Ro7aGU1wnE0ZSvgqsMvuwvpi8jTHhoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-qGAyL6GpNmuEMhpGzMw54A-1; Mon, 04 Oct 2021 22:23:25 -0400
X-MC-Unique: qGAyL6GpNmuEMhpGzMw54A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910C2180830B;
        Tue,  5 Oct 2021 02:23:24 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93CFA60657;
        Tue,  5 Oct 2021 02:23:19 +0000 (UTC)
Date:   Tue, 5 Oct 2021 10:23:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Message-ID: <YVu3EjPqT8VME/oY@T590>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Chaitanya,

On Fri, Oct 01, 2021 at 05:56:04AM +0000, Chaitanya Kulkarni wrote:
> On 9/30/2021 5:56 AM, Ming Lei wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Add two APIs for stopping and starting admin queue.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> 
> this patch looks good to me, but from the feedback I've received in past 
> we need to add the new functions in the patch where they are actually 
> used than adding it in a separate patch.

The added two APIs are exported via EXPORT_SYMBOL_GPL(), so it won't
cause any build warning. I see lots of such practise too.

It is easier for reviewing in this way since the 1st patch focuses on
API implementation, and the 2nd patch focuses on using the API,
especially there are lots of users in patch 2.

But if you really don't like this way, I am fine to merge the two since
merging is always easier than splitting, :-)


Thanks,
Ming

