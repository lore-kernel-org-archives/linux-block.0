Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE2CC63798
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D5124655
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ0kWKR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKQQL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727294AbgKQQL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 11:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605629515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7anUssMJG4yNzSlKEM7vyAKJMjKwRcmCGNkXVclRfVM=;
        b=OQ0kWKR75ChzL1q7/reMhKsCQLZ8+ZoPDghg0pQCr+3Q2crepVYP+LXnsK1yauVTVFdnfO
        3OSC3vmKHNO/kN6bj+YycElQkHPlxCLZ4VYR/Tl5OikbEy3lN39rRqhzvoAtCre3bwm6qP
        cG51udWUfCaucMKEKd8051C2qn0YvxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-5bveCS-tMWqh-7PKi8CK9w-1; Tue, 17 Nov 2020 11:11:50 -0500
X-MC-Unique: 5bveCS-tMWqh-7PKi8CK9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAB648042A0;
        Tue, 17 Nov 2020 16:11:49 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8073C5D9CC;
        Tue, 17 Nov 2020 16:11:46 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:11:45 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/6] dm: remove the block_device reference in struct
 mapped_device
Message-ID: <20201117161145.GB27209@redhat.com>
References: <20201116212020.1099154-1-hch@lst.de>
 <20201116212020.1099154-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116212020.1099154-7-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 16 2020 at  4:20pm -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Get rid of the long-lasting struct block_device reference in
> struct mapped_device.  The only remaining user is the freeze code,
> where we can trivially look up the block device at freeze time
> and release the reference at thaw time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

