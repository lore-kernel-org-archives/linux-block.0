Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DB1C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DA461507
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 08:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhJEIGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232793AbhJEIGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Oct 2021 04:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633421060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vtULx88xAOp/JsicdkATYnwFMV/hB6VPvYC999jApo8=;
        b=gFzTspHhC2bk/Wbc+oD/AqwlgTsgf0GNC4xiMvRHU2d44ihuSN7ZV3FJF4K1weH+IZvvRO
        R+5Zuob35ljVJAxQuFgDv0gGZnpT826mIGSXKc1dti4vRxg1PkegN/ZDo9KK1GG2qXAcoJ
        1mGiym8/IzrdXqaZ75ndF23xHZlmn4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-8fu__61VMtOhSr-PMRLRiw-1; Tue, 05 Oct 2021 04:04:16 -0400
X-MC-Unique: 8fu__61VMtOhSr-PMRLRiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 140611842158;
        Tue,  5 Oct 2021 08:04:15 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F88E60C17;
        Tue,  5 Oct 2021 08:04:10 +0000 (UTC)
Date:   Tue, 5 Oct 2021 16:04:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Message-ID: <YVwG9qjNUNrE5duR@T590>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com>
 <YVu3EjPqT8VME/oY@T590>
 <79efb733-4904-d27f-b336-d5d97d3ca261@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79efb733-4904-d27f-b336-d5d97d3ca261@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 05, 2021 at 03:38:18AM +0000, Chaitanya Kulkarni wrote:
> On 10/4/21 19:23, Ming Lei wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hello Chaitanya,
> > 
> > On Fri, Oct 01, 2021 at 05:56:04AM +0000, Chaitanya Kulkarni wrote:
> >> On 9/30/2021 5:56 AM, Ming Lei wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> Add two APIs for stopping and starting admin queue.
> >>>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>
> >>
> >> this patch looks good to me, but from the feedback I've received in past
> >> we need to add the new functions in the patch where they are actually
> >> used than adding it in a separate patch.
> > 
> > The added two APIs are exported via EXPORT_SYMBOL_GPL(), so it won't
> > cause any build warning. I see lots of such practise too.
> > 
> 
> the comment was not related to any build or warning.
> 
> > It is easier for reviewing in this way since the 1st patch focuses on
> > API implementation, and the 2nd patch focuses on using the API,
> > especially there are lots of users in patch 2.
> > 
> 
> I am aware of that, just sharing what I got the comments in the past.
> 
> > But if you really don't like this way, I am fine to merge the two since
> > merging is always easier than splitting, :-)
> > 
> 
> it will be good if we can keep the consistency ... nothing else ..

OK, got it, and the latest such nvme patch is the following one, which
introduced an API in one standalone patch.

commit dda3248e7fc306e0ce3612ae96bdd9a36e2ab04f
Author: Chao Leng <lengchao@huawei.com>
Date:   Thu Feb 4 08:55:11 2021 +0100

    nvme: introduce a nvme_host_path_error helper



Thanks 
Ming

