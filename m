Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D00C433DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Feb 2021 04:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E150664E29
	for <linux-block@archiver.kernel.org>; Mon, 15 Feb 2021 04:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBOEFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhBOEFW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 23:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613361835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCto3KUpwXFxwoednmXXEKQgbQd1P3MF48qpfH2u8IE=;
        b=Day63ZwE3IKhmc0Cp8yeLbVLtyVgBWu/LTixwr6CKWfdV8MOX4isxrkD0GHhrRNIiIkVam
        Ff+N8UPW34na5gANxuiZgUp/fNLZGL6YIoNexDaM7kM5CD3qhUfDl8lUXoLspBMXtP9SUv
        pC0T5LWjBa/Vxj63RbwHZwn3iwwq4D0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-tUl8xXvKOxeZFKsCuGbBmg-1; Sun, 14 Feb 2021 23:03:52 -0500
X-MC-Unique: tUl8xXvKOxeZFKsCuGbBmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6762A1005501;
        Mon, 15 Feb 2021 04:03:51 +0000 (UTC)
Received: from T590 (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 757351002391;
        Mon, 15 Feb 2021 04:03:44 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:03:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 0/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210215040341.GA257964@T590>
References: <20210205021708.1498711-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205021708.1498711-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 05, 2021 at 10:17:06AM +0800, Ming Lei wrote:
> Hi Guys,
> 
> The two patches changes block ioctl(BLKRRPART) for avoiding drop &
> re-add partitions if partitions state isn't changed. The current
> behavior confuses userspace because partitions can disappear anytime
> when ioctl(BLKRRPART).
> 
> Ming Lei (2):
>   block: move partitions check code into single helper
>   block: avoid to drop & re-add partitions if partitions aren't changed
> 
>  block/genhd.c            |   2 +
>  block/partitions/check.h |   2 +
>  block/partitions/core.c  | 101 ++++++++++++++++++++++++++++++++-------
>  fs/block_dev.c           |  28 +++++++++--
>  include/linux/genhd.h    |   4 ++
>  5 files changed, 118 insertions(+), 19 deletions(-)
> 
> Cc: Ewan D. Milne <emilne@redhat.com>
> -- 
> 2.29.2
> 

Hello,

Ping...

-- 
Ming

