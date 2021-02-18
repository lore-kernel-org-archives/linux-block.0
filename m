Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69403C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2961494
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 08:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBRIDN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Feb 2021 03:03:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231287AbhBRH7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Feb 2021 02:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613635047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BwgbTD1RiX92ln5WFKH395xpEWd8VBJvefZ9GEKuK+c=;
        b=Vc3KZO1MKPZPGgenwOLARktMmZHdYSniJFKzIKKO80qhMA8W9cRrQh0exBC+De45t/DrnO
        2MVzlxwG8TW4ZqwzKp9ZnXryx36wLda2+EQ5nXyumRUnzOaTJH5R/vDBnNejZ6JPcJ39Oo
        I2gpA0rP22fMnj/ajA3Re5jwKuOZUYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-Q5JcY8imPzKIzNWdY6MVhQ-1; Thu, 18 Feb 2021 02:57:25 -0500
X-MC-Unique: Q5JcY8imPzKIzNWdY6MVhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37857100CCC1;
        Thu, 18 Feb 2021 07:57:24 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 820A22E066;
        Thu, 18 Feb 2021 07:57:13 +0000 (UTC)
Date:   Thu, 18 Feb 2021 15:57:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 0/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210218075703.GD284137@T590>
References: <20210205021708.1498711-1-ming.lei@redhat.com>
 <20210215040341.GA257964@T590>
 <20210216084430.GA23694@lst.de>
 <20210217030714.GB259250@T590>
 <20210217071629.GA15362@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217071629.GA15362@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 17, 2021 at 08:16:29AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 17, 2021 at 11:07:14AM +0800, Ming Lei wrote:
> > Do you think it is correct for ioctl(BLKRRPART) to always drop/re-add
> > partition device node?
> 
> Yes, that is what it is designed to do.  The only reason to call this
> ioctl is when userspace software has written new partition table
> information to the disk.

I am wondering how userspace can know this design or implication since
this behavior wasn't documented anywhere.

For example, 'blockdev --rereadpt' can do it simply, without updating
partition table at all.

The reality is that almost of all the main userspace consumers of
ioctl(BLKRRPART) didn't follow such 'rule', then partitions node from
'bdev' fs can disappear & re-appear anytime. I believe it is one bug
from userspace view.


Thanks,
Ming

