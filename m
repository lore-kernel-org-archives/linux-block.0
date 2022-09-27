Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F2C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 14:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiI0OKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiI0OJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 10:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE541BB208
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664287750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tlq6KytqDkkCH2AcL9sJWLCE2qu1CAjKYDtYJcgOZY0=;
        b=L5LdSLfXFULvmoheY30Ben3WcyOsxL2fJlOeffyONbXMXKH3lB3SiQqOPWFfR0RsgB3m9d
        u2aVGU2PLX4822btejJz14e9IaHyvw+GlJtyTs9H2hpaG+F/mFx71vsQwYvAUsEX/GMpo6
        I97w7aM7ZwRfg/4i8iaWrqEG1fXnDTo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-jyCTnOceO1yJkjFpMOktTg-1; Tue, 27 Sep 2022 10:09:07 -0400
X-MC-Unique: jyCTnOceO1yJkjFpMOktTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 109341C09C85;
        Tue, 27 Sep 2022 14:09:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B033A42220;
        Tue, 27 Sep 2022 14:09:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28RE96AL029742;
        Tue, 27 Sep 2022 10:09:06 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28RE94Kb029738;
        Tue, 27 Sep 2022 10:09:04 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 27 Sep 2022 10:09:04 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 0/4] brd: implement discard
In-Reply-To: <YyqfHfadJvxbB/JC@B-P7TQMD6M-0146.local>
Message-ID: <alpine.LRH.2.02.2209271006590.28431@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com> <YyqfHfadJvxbB/JC@B-P7TQMD6M-0146.local>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Wed, 21 Sep 2022, Gao Xiang wrote:

> On Tue, Sep 20, 2022 at 01:52:38PM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > Here I'm sending second version of the brd discard patches.
> 
> That is quite interesting.
> 
> btw, something out of topic, I once had some preliminary attempt
> to add DAX support to brd since brd works as ramdisk and brd-dax
> could have the following benefits:
> 
>  - DAX can be tested without PMEM devices;
>  - ramdisk fses can be accessed without double page cache;
>  - initrd use cases then can work well without extra page cache
>    and maybe it can perform better than initramfs (without unpack
>    process).
> 
> I wrote some hack stuff but don't have more time working on it...
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/initrd-fsdax
> 
> I'm not sure if others are interested in topic though.
> 
> It would be helpful to get rid of all brd page->index use cases
> first.
> 
> Thanks,
> Gao Xiang

Hi

Ramdisk DAX was there in the past, but it was removed in the kernel 4.15.

Mikulas

