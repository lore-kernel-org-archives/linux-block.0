Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D8EC433B4
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D3A613AE
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 00:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbhERAbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 20:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233718AbhERAbS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 20:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621297801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCtpJl5wAKagxb9hM9Z4VWmYK67Am2vQEsG/WsS00BA=;
        b=Xg1gGRs3RJH6TvL2P3KRdX8t0Y54xMlslk4/pnY7t2hBxXChzmLX0Qa8unwkihW+FD+OGn
        H2KW1WAkj+rRkFgL//2aEYrt+L5wCjaEWptMRORA5PwmCDD+BFHDjxOWCq+vk+bEeztHSE
        xTltMkpp7i3qTfFvQ9l8NvJWlgql1rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Kv5nR3XBNRWIwn1qWCLM3g-1; Mon, 17 May 2021 20:29:58 -0400
X-MC-Unique: Kv5nR3XBNRWIwn1qWCLM3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92601A8A61;
        Tue, 18 May 2021 00:29:56 +0000 (UTC)
Received: from T590 (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F99860C25;
        Tue, 18 May 2021 00:29:45 +0000 (UTC)
Date:   Tue, 18 May 2021 08:29:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, josef@toxicpanda.com, axboe@kernel.dk,
        idryomov@redhat.com, xiubli@redhat.com,
        Matteo Croce <mcroce@linux.microsoft.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
Message-ID: <YKMKdHPFCNhR1SXx@T590>
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429102828.31248-1-prasanna.kalever@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Prasanna,

On Thu, Apr 29, 2021 at 03:58:28PM +0530, Prasanna Kumar Kalever wrote:
> Problem:
> On reconfigure of device, there is no way to defend if the backend
> storage is matching with the initial backend storage.
> 
> Say, if an initial connect request for backend "pool1/image1" got
> mapped to /dev/nbd0 and the userspace process is terminated. A next
> reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> use /dev/nbd0 for a different backend "pool1/image2"
> 
> For example, an operation like below could be dangerous:

Can you explain a bit why it is dangerous?

> 
> $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
> $ sudo pkill -9 rbd-nbd
> $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"
> 
> Solution:
> Provide a way for userspace processes to keep some metadata to identify
> between the device and the backend, so that when a reconfigure request is
> made, we can compare and avoid such dangerous operations.
> 
> With this solution, as part of the initial connect request, backend
> path can be stored in the sysfs per device config, so that on a reconfigure
> request it's easy to check if the backend path matches with the initial
> connect backend path.
> 
> Please note, ioctl interface to nbd will not have these changes, as there
> won't be any reconfigure.

BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
is added for addressing this issue, what do you think of that generic
approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
for addressing this issue?

https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r

Thanks,
Ming

