Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158EBC433E0
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 09:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A5B2310B
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 09:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbhAFJJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbhAFJJk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jan 2021 04:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609924094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYCgHYELd+dDiRR1ixtSQ94sasM6azspHhx1cz4I6fA=;
        b=XOpqjykzQkxstxtBML1OzliJzaKmzfbWULPgCnk2MaIY+B2AkCw2w1rLZ0LKGvmDQs3JoT
        UEZ9xJxJ4SJMtWu5lUbZitd9A1TfkMOr5Kai3mkc4T7NcGkaSXo9s/fsmTxDEPCYJcKTLV
        //MjkUtxlmwzDOnrysYMB+nWCgeHYcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-om6WL-F3OhqV57fsaIrV2A-1; Wed, 06 Jan 2021 04:08:10 -0500
X-MC-Unique: om6WL-F3OhqV57fsaIrV2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5DF7107ACE4;
        Wed,  6 Jan 2021 09:08:09 +0000 (UTC)
Received: from T590 (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B46EB7771A;
        Wed,  6 Jan 2021 09:08:03 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:07:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Subject: Re: [PATCH v2] loop: fix I/O error on fsync() in detached loop
 devices
Message-ID: <20210106090758.GB3845805@T590>
References: <20210105135419.68715-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105135419.68715-1-mfo@canonical.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 05, 2021 at 10:54:19AM -0300, Mauricio Faria de Oliveira wrote:
> There's an I/O error on fsync() in a detached loop device
> if it has been previously attached.
> 
> The issue is write cache is enabled in the attach path in
> loop_configure() but it isn't disabled in the detach path;
> thus it remains enabled in the block device regardless of
> whether it is attached or not.
> 
> Now fsync() can get an I/O request that will just be failed
> later in loop_queue_rq() as device's state is not 'Lo_bound'.
> 
> So, disable write cache in the detach path.
> 
> Test-case:
> 
>     # DEV=/dev/loop7
> 
>     # IMG=/tmp/image
>     # truncate --size 1M $IMG
> 
>     # losetup $DEV $IMG
>     # losetup -d $DEV
> 
> Before:
> 
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = -1 EIO (Input/output error)
>     Warning: Error fsyncing/closing /dev/loop7: Input/output error
>     [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> 
> After:
> 
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = 0

But IO on detached loop should have been failed, right? The magic is
that submit_bio_checks() filters FLUSH request for queues which doesn't
support writeback cache, and always fake a normal completion.

I understand that the issue is that user becomes confused with this observation
because no such failure if they run 'parted -s /dev/loop0 print' on one detached
loop disk if it is never attached.


Thanks, 
Ming

