Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A8C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4467610F8
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhKILKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:10:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhKILKc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Nov 2021 06:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636456065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrYyyygQC2FA/fyF5htlTTOHYjbqbyMexoHDgjkjXJQ=;
        b=abfRZ1YcPkv0d2gkf0XswLe/BOmb9UYC+25xfvVSRLmJ88lp+95bT/CrbmyxDyCnPou/pl
        AiiACeASNddCkhyLG0V7Rhky5VlG7MGGkJAUGA4HjvYKMAXtXtt7jFz9k6bc1bjyL/Zbmu
        24vXKhbfeVlhHGpEic4qNtktNk3zzP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-82O9RqiDOCOH59zhEKzMPw-1; Tue, 09 Nov 2021 06:07:42 -0500
X-MC-Unique: 82O9RqiDOCOH59zhEKzMPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD218B78BC;
        Tue,  9 Nov 2021 11:07:41 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 109BC60244;
        Tue,  9 Nov 2021 11:07:30 +0000 (UTC)
Date:   Tue, 9 Nov 2021 19:07:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Message-ID: <YYpWbnPK+K1kQ3Z4@T590>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 09, 2021 at 07:47:21PM +0900, Shin'ichiro Kawasaki wrote:
> When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cache is
> left. This patch series have two fox patches for the stale page cache. Same
> fix approach was used as blkdev_fallocate() [1].
> 
> [1] https://marc.info/?l=linux-block&m=163236463716836
> 
> Shin'ichiro Kawasaki (2):
>   block: Hold invalidate_lock in BLKDISCARD ioctl
>   block: Hold invalidate_lock in BLKZEROOUT ioctl
> 
>  block/ioctl.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Yeah, the discard ioctl needs such fixes too, seems it isn't triggered
in the test disk of my test VM when running block/009.

BTW, BLKRESETZONE may need the fix too.


Thanks,
Ming

