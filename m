Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26121C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 11:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF40564E6F
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 11:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhBXLZx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:25:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232806AbhBXLZx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 06:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614165867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRXtKkEYqZIxw9kP5YasKs5jkH7conK07lnAjpMcxhI=;
        b=TZmm3Nbjry4yzLsOd4hZiZBzN2BH9j8knrPmszwVqHUDpGfIiECn9zgCErTOtZaGiMxpau
        b//+ko1QacGUmyvP7Edz/S7t4S05eL2a16bRDMB4RqEWzYUF7RNSZ9/Wiie69E0uE6GPz5
        m50e9SesFpFRn5h1RhyD378ZA6fYatM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-Hj0IZ2qhPbi4EKgQzqEAGA-1; Wed, 24 Feb 2021 06:24:25 -0500
X-MC-Unique: Hj0IZ2qhPbi4EKgQzqEAGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66083871804;
        Wed, 24 Feb 2021 11:24:11 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52EE719934;
        Wed, 24 Feb 2021 11:23:58 +0000 (UTC)
Date:   Wed, 24 Feb 2021 19:23:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Ewan D . Milne" <emilne@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <YDY3SqyNTeiYMdpG@T590>
References: <20210224035830.990123-1-ming.lei@redhat.com>
 <20210224081825.GA1339@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224081825.GA1339@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 09:18:25AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 24, 2021 at 11:58:26AM +0800, Ming Lei wrote:
> > Hi Guys,
> > 
> > The two patches changes block ioctl(BLKRRPART) for avoiding drop &
> > re-add partitions if partitions state isn't changed. The current
> > behavior confuses userspace because partitions can disappear anytime
> > when calling into ioctl(BLKRRPART).
> 
> Which is the f***king point of BLKRRPART and the behavior it had
> since day 1.  Please fix the application(s) that all it all the time
> instead of bloating the kernel, as said before.
> 

ioctl(BLKRRPART) can be called without changing partition table in
fdisk, cfdisk, sfdisk, systemd and blockdev at least, and it isn't only
on one single application. Even for blockdev, not sure if it can be fixed
because '--rereadpt' is simply one subcommand.

-- 
Ming

