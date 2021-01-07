Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06CFC433DB
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5626F23101
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 07:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAGHMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAGHMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jan 2021 02:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610003471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzTZnQ9+T2I2w5hDhpjlR9ds0jT9ucs1opY1L7Giz0Q=;
        b=bRfWVtEdaeNz3BRQCe2wVX/4y8ZDotCawtJ017VGSR1hYxNKx+KXScE/3FzBpa2Ea+GY5K
        jc+289vOlQJkcK2oqNn7U7eOkIAIbYJXfOuOU3KwopcCqsUO7hErFqfZO0uQLUq/Z61O35
        JnBhoKtje6AWqPTCJcDpKQ/Qz/NXe38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-p3hlNXLoPBCVKdcRGL00yw-1; Thu, 07 Jan 2021 02:11:08 -0500
X-MC-Unique: p3hlNXLoPBCVKdcRGL00yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 879C91800D42;
        Thu,  7 Jan 2021 07:11:07 +0000 (UTC)
Received: from T590 (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B8271CB8;
        Thu,  7 Jan 2021 07:11:00 +0000 (UTC)
Date:   Thu, 7 Jan 2021 15:10:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Subject: Re: [PATCH v2] loop: fix I/O error on fsync() in detached loop
 devices
Message-ID: <20210107071055.GA3900112@T590>
References: <20210105135419.68715-1-mfo@canonical.com>
 <20210106090758.GB3845805@T590>
 <CAO9xwp0ad6Hs2AJOLKUn-oVSp+kwHKM67saxdwv0JsrSza+C7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp0ad6Hs2AJOLKUn-oVSp+kwHKM67saxdwv0JsrSza+C7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 06, 2021 at 08:33:50PM -0300, Mauricio Faria de Oliveira wrote:
> On Wed, Jan 6, 2021 at 6:08 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Jan 05, 2021 at 10:54:19AM -0300, Mauricio Faria de Oliveira wrote:
> > > There's an I/O error on fsync() in a detached loop device
> > > if it has been previously attached.
> > >
> > > The issue is write cache is enabled in the attach path in
> > > loop_configure() but it isn't disabled in the detach path;
> > > thus it remains enabled in the block device regardless of
> > > whether it is attached or not.
> > >
> > > Now fsync() can get an I/O request that will just be failed
> > > later in loop_queue_rq() as device's state is not 'Lo_bound'.
> > >
> > > So, disable write cache in the detach path.
> > >
> > > Test-case:
> > >
> > >     # DEV=/dev/loop7
> > >
> > >     # IMG=/tmp/image
> > >     # truncate --size 1M $IMG
> > >
> > >     # losetup $DEV $IMG
> > >     # losetup -d $DEV
> > >
> > > Before:
> > >
> > >     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
> > >     fsync(3)                                = -1 EIO (Input/output error)
> > >     Warning: Error fsyncing/closing /dev/loop7: Input/output error
> > >     [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> > >
> > > After:
> > >
> > >     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
> > >     fsync(3)                                = 0
> >
> > But IO on detached loop should have been failed, right? The magic is
> > that submit_bio_checks() filters FLUSH request for queues which doesn't
> > support writeback cache, and always fake a normal completion.
> >
> 
> Hey Ming, thanks for taking a look at this.
> 
> Well, it depends -- currently read() works (without I/O errors) and
> write() fails (ENOSPC).
> Example tests are provided below.

read() actually returns 0 because of the following code in blkdev_read_iter():

        if (pos >= size)
                return 0;

> 
> And that's consistent before and after attach/detach; so, I thought
> fsync() should follow.
> 
> > I understand that the issue is that user becomes confused with this observation
> > because no such failure if they run 'parted -s /dev/loop0 print' on one detached
> > loop disk if it is never attached.
> >
> 
> That is indeed one of the issues. There's also a monitoring/alerting
> perspective that
> would benefit; e.g., sosreport runs parted, it's run on data
> collection for support cases.
> Now, that I/O error message is thrown in the logs, and some mon/alert
> tools might not
> yet have filters to ignore (detached) loop devices, and alert. It'd be
> nice to deflect that.

IMO, if loop is detached, any IO should have been failed. However,
read/flush is just a bit special:

- blkdev_read_iter() always return 0 if the read is beyond the device
size(0)

- submit_bio(FLUSH) return successfully if the queue doesn't support
writeback cache.

> 
> It's not a common issue, to be honest; but the consistency point
> seemed fair to me,
> as essentially the current code doesn't deinitialize something it
> previously initialized,
> and the block device is left running with that enabled regardless.

OK, looks it is fine to disable writeback cache in __loop_clr_fd().

BTW, just wondering why don't you disable WC unconditionally in
__loop_clr_fd() or clear it in the following way because WC can be
changed via sysfs?

	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
		blk_queue_write_cache(q, false, false);

Thanks, 
Ming

