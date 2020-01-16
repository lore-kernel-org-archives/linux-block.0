Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCCC32771
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 03:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AB7214AF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 03:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3XbcqKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgAPDDA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:03:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37802 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729130AbgAPDDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 22:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579143779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKB6cubuZyTK4B0tcOW27FAZSUbMfcEslrhqcszTbO0=;
        b=E3XbcqKCS85Xj4TowspqcfEWS9khz2JfJ2ZvzwhmwBgVhONxcXapfHjep7T+8xj5CyIz8E
        OpJxDm1pIVaJ4gWnpNg5Rvz+4dOl6CZJX/HYOE1hdGfWR4u4j4ZY7En7eyn8hzKp5weGoB
        N0I0+PpLX+Pcq/hw1rriGTyj2Hm2GeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-eeaZHo8RNfCN__ZmNfe9UQ-1; Wed, 15 Jan 2020 22:02:58 -0500
X-MC-Unique: eeaZHo8RNfCN__ZmNfe9UQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B87F800D5E;
        Thu, 16 Jan 2020 03:02:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70E83390;
        Thu, 16 Jan 2020 03:02:48 +0000 (UTC)
Date:   Thu, 16 Jan 2020 11:02:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>
Subject: Re: [PATCH] block: fix an integer overflow in logical block size
Message-ID: <20200116030244.GB24105@ming.t460p>
References: <alpine.LRH.2.02.2001150833180.31494@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2001150833180.31494@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 15, 2020 at 08:35:25AM -0500, Mikulas Patocka wrote:
> Logical block size has type unsigned short. That means that it can be at
> most 32768. However, there are architectures that can run with 64k pages
> (for example arm64) and on these architectures, it may be possible to
> create block devices with 64k block size.

The patch looks fine, and other drivers(loop, nbd, virtio_blk, ...) allow
user to pass customized logical block size, and the passed size can be > 32k.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

