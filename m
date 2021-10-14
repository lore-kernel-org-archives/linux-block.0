Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 03:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F53F60184
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 03:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJNDcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 23:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJNDco (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 23:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634182240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w/3XuZuSvuo/i8kmE8DOSRgqFYlanTPPpIGVFXArkA=;
        b=RHb3YVcEHfdXZx1QZj8dEYZ2cKTZX30o3KePQZDFi5kNeWOctNIg5WX6Xfm6fk1RioiAO9
        lonGWysLv8SX6UxDh8LUllhwNfE4ImJ98VKQ1l5UjGJEGRliV74S+nmN0grMKXgl77Dfa0
        lK09U4aPQjXHlfyWEgoPZQU7lNhcZto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-5ASnNkblMIGLcG6kRpG5NA-1; Wed, 13 Oct 2021 23:30:38 -0400
X-MC-Unique: 5ASnNkblMIGLcG6kRpG5NA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 533AC362F8;
        Thu, 14 Oct 2021 03:30:37 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D040E5F4EA;
        Thu, 14 Oct 2021 03:29:58 +0000 (UTC)
Date:   Thu, 14 Oct 2021 11:29:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: remove plug based merging
Message-ID: <YWekMiP1+dqlwEYd@T590>
References: <fb4e2033-24fb-cd47-5e8d-557c8431097f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4e2033-24fb-cd47-5e8d-557c8431097f@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

On Wed, Oct 13, 2021 at 02:00:35PM -0600, Jens Axboe wrote:
> It's expensive to browse the whole plug list for merge opportunities at
> the IOPS rates that modern storage can do. For sequential IO, the one-hit
> cached merge should suffice on fast drives, and for rotational storage the
> IO scheduler will do a more exhaustive lookup based merge anyway.
> 
> Just remove the plug based O(N) traversal merging.

This way looks too aggressive, is there any performance data with the plug
merge which is supposed to be fast since it is totally lockless?

Maybe we can simply check if the incoming bio can be merged to the last or 1st
request in the plug list?

> 
> With that, there's really no difference between the two plug cases that
> we have. Unify them.

IMO, there are differences between the two:

1) blk_attempt_plug_merge() is lockless, and no request allocation is
involved for merging incoming sequential bio.

2) after plug merge is killed, the merge is delayed until request is
allocated & added to plug list: a) for elevator, the merge requires lock
when running blk_mq_sched_insert_requests() b) for none, there isn't
merge any more, and small IO is always sent to driver because blk_mq_insert_requests
doesn't merge requests.


Thanks, 
Ming

