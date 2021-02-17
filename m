Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1A0C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 03:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60FD64DA8
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 03:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhBQDJD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhBQDI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 22:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613531253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNH5ITRF0iwB8lmxXdXfW6GsZrNoD5cb0aLw0H35nCY=;
        b=OqvJeFMytf00vAIc6x3tbSpXBRhe3a1GWJpWkHCRvfgoHcd6hwVIMctBWoSnXaqti40ibF
        vxlUai+fwdvlLyTQgo2NmBlazXjHVN/ktvM01ceeb+pwYkY1VpjFJF3xlarVbxs7yQzU3A
        sTkgvXtGpvXkJSgN2QkCXHya1Xjw7yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-qgHmBGBANbajsrIAsAC2Og-1; Tue, 16 Feb 2021 22:07:31 -0500
X-MC-Unique: qgHmBGBANbajsrIAsAC2Og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6320AC28A;
        Wed, 17 Feb 2021 03:07:30 +0000 (UTC)
Received: from T590 (ovpn-12-102.pek2.redhat.com [10.72.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BCBF6F7E8;
        Wed, 17 Feb 2021 03:07:19 +0000 (UTC)
Date:   Wed, 17 Feb 2021 11:07:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 0/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210217030714.GB259250@T590>
References: <20210205021708.1498711-1-ming.lei@redhat.com>
 <20210215040341.GA257964@T590>
 <20210216084430.GA23694@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216084430.GA23694@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 16, 2021 at 09:44:30AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 15, 2021 at 12:03:41PM +0800, Ming Lei wrote:
> > Hello,
> 
> I think this is a fundamentally bad idea.  We should not keep the
> parsed partition state around forever just to work around some buggy
> user space software.

What is the bug in userspace software?

Do you think it is correct for ioctl(BLKRRPART) to always drop/re-add
partition device node?

-- 
Ming

