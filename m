Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD869C433F5
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiEOTZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEOTZS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 15:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F0325E95
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652642713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tgm7FkhgZMI1Knq5BCXmzxRNBZ0f9T8FBbOE8N4Q1k=;
        b=F29WF6BWni1hLstxrT13hr0DnInDSSk0pS4CpWLBUBmoxHA6cgsUVCM76YWaBdh+B1F8F9
        TTJRnvd6KuUDZxLtLUHjHyX8soRKkGdwRxQZJI6qAFPI8u3oJMg6/poVjNdlE5GdNb7VXi
        ZboWYlKltORtNP3SzgfK2QrIP7aOhts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-JWgn8x6QO-yE8dxgjrf9sg-1; Sun, 15 May 2022 15:25:11 -0400
X-MC-Unique: JWgn8x6QO-yE8dxgjrf9sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9477F801E80;
        Sun, 15 May 2022 19:25:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56ADD111E411;
        Sun, 15 May 2022 19:25:06 +0000 (UTC)
Date:   Sun, 15 May 2022 20:25:05 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     libguestfs@redhat.com, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [Libguestfs] Communication issues between NBD driver and NBDKit
 server
Message-ID: <20220515192505.GJ1127@redhat.com>
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
 <20220515180525.GF8021@redhat.com>
 <87czgelidg.fsf@vostro.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czgelidg.fsf@vostro.rath.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 15, 2022 at 08:12:59PM +0100, Nikolaus Rath wrote:
> Do you see any way for this to happen?

I think it's impossible.  A more likely explanation follows.

If you look at the kernel code, the NBD_CMD_INFLIGHT command flag is
cleared when a command times out:

  https://github.com/torvalds/linux/blob/0cdd776ec92c0fec768c7079331804d3e52d4b27/drivers/block/nbd.c#L407

That's the place where it would have printed the "Possible stuck
request" message.

Some time later, nbdkit actually replies to the message (for the first
and only time) and in that code the flag is checked and found to be
clear already, causing the "Suspicious reply" message to be printed:

  https://github.com/torvalds/linux/blob/0cdd776ec92c0fec768c7079331804d3e52d4b27/drivers/block/nbd.c#L749

I'd say you need to increase the timeout and/or work out why the S3
plugin is taking so long to respond.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

