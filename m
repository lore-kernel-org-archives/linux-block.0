Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A0C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 15:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C376D60FD9
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 15:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhHKP5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 11:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbhHKP5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 11:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628697439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvyHhawaRzRMFx4I0d/1C6dsA+Cy0FuldCgc1kqA1Cw=;
        b=TTYoD7I11Rn0xlMkvRlADCSvlccjCmBfuA/Mh1AbUhQbLBBQGzKvCH8IaXMEHxxQhB7DW4
        v5Gcoc3zkRr5jSWuQLu4qjcNizkRV18PJcC49xcKIZeQPI2zPrGqnv3Rh0vHti1Fp7m0bw
        UKbJYbVvDdnAiqt7Nd1jtJY/xf8gEXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-O_R_k4HJOziua5LqGKLZMw-1; Wed, 11 Aug 2021 11:57:17 -0400
X-MC-Unique: O_R_k4HJOziua5LqGKLZMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C471853028;
        Wed, 11 Aug 2021 15:57:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A57B77701;
        Wed, 11 Aug 2021 15:57:15 +0000 (UTC)
Date:   Wed, 11 Aug 2021 10:57:13 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 6/6] nbd: reduce the nbd_index_mutex scope
Message-ID: <20210811155713.ym4duw4va7vo3yrc@redhat.com>
References: <20210811124428.2368491-1-hch@lst.de>
 <20210811124428.2368491-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811124428.2368491-7-hch@lst.de>
User-Agent: NeoMutt/20210205-687-0ed190
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 02:44:28PM +0200, Christoph Hellwig wrote:
> nbd_index_mutex is currently held over add_disk and inside ->open, which
> leads to lock order reversals.  Refactor the device creation code path
> so that nbd_dev_add is called without nbd_index_mutex lock held and
> only takes it for the IDR insertation.

insertion

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/nbd.c | 55 +++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

