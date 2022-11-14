Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D29CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 11:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiKNLcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 06:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiKNLcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 06:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF63B92
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 03:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668425501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnnWYWYI7dFaj5KtBqG0kHqgTQYW9D1P7isI3/GaYGU=;
        b=bWuBt+GGezut99E/niGHA9Pk1FadahsCbev73/VKL8OjuQsDLFWsW4WjMC3ffJI04UtRS/
        CVubu8YswkiNYRuSuxWQTkudFs2RNHtUYXJDQwPthPOR9CWyH5ejepj1UrhQmjKnmqIi4G
        jMNYQhOuvy6N+t+zQ/g9IhcTr2Is5Rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-vNs0dXefN4yN-K7NmV_Obw-1; Mon, 14 Nov 2022 06:31:37 -0500
X-MC-Unique: vNs0dXefN4yN-K7NmV_Obw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 637B685A59D;
        Mon, 14 Nov 2022 11:31:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2895C477F55;
        Mon, 14 Nov 2022 11:31:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2AEBVb7h028036;
        Mon, 14 Nov 2022 06:31:37 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2AEBVa9L028032;
        Mon, 14 Nov 2022 06:31:36 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 14 Nov 2022 06:31:36 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Keith Busch <kbusch@kernel.org>
cc:     Mike Snitzer <snitzer@redhat.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org
Subject: Re: [PATCHv2 0/5] fix direct io device mapper errors
In-Reply-To: <Y26U91eH7NcXTlbj@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <alpine.LRH.2.21.2211140627080.25281@file01.intranet.prod.int.rdu2.redhat.com>
References: <20221110184501.2451620-1-kbusch@meta.com> <Y26PSYu2nY/AE5Xh@redhat.com> <Y26U91eH7NcXTlbj@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Fri, 11 Nov 2022, Keith Busch wrote:

> > There are other DM targets that override logical_block_size in their
> > .io_hints hook (writecache, ebs, zoned). Have you reasoned through why
> > those do _not_ need updating too?
> 
> Yeah, that's a good question. The ones that have a problem all make
> assumptions about a bio's bv_offset being logical block size aligned,
> and each of those is accounted for here. Everything else looks fine with
> respect to handling offsets.

Unaligned bv_offset should work - because XFS is sending such bios. If you 
compile the kernel with memory debugging, kmalloc returns unaligned 
memory. XFS will allocate a buffer with kmalloc, test if it crosses a page 
boundary, if not, use the buffer, if yes, free the buffer and allocate a 
full page.

There have been device mapper problems about unaligned bv_offset in the 
past and I have fixed them.

Unaligned bv_length is a problem for the affected targets.

Mikulas

