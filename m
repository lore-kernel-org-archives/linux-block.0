Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6562C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 11:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiJTLo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 07:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiJTLoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 07:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936EE006
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666266259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3Mhr+6BKEIzi6QpGoY12EiebZwvogoM7Lmy0zCKqRM=;
        b=T+5mey9y2mTWYypcnJhAUHwMGrr5KqouFLGcRkmc6NxnKZY4SUbhiCjgrBgAWdwXLFFr3Z
        yRWwuMwbk2PVxS/RkSiQp1njI9mE+0JMLaecT9AGf5xGhVRF80paLd587dyNYZ2NsxfWVt
        e9lAzR1Pr/TpW0xLztPImPNtc4xcCRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-aWhIo7VfPjmGd8chKetwxw-1; Thu, 20 Oct 2022 07:44:15 -0400
X-MC-Unique: aWhIo7VfPjmGd8chKetwxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55E82101E153;
        Thu, 20 Oct 2022 11:44:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24FDC40C6EC2;
        Thu, 20 Oct 2022 11:44:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 29KBiFRG025651;
        Thu, 20 Oct 2022 07:44:15 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 29KBiEdA025647;
        Thu, 20 Oct 2022 07:44:14 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 20 Oct 2022 07:44:14 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Mike Snitzer <snitzer@redhat.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [dm-devel] [git pull] device mapper changes for 6.1
In-Reply-To: <Y1EDxZvjEi47iWUN@infradead.org>
Message-ID: <alpine.LRH.2.21.2210200731150.25125@file01.intranet.prod.int.rdu2.redhat.com>
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org> <Y0704chr07nUgx3X@redhat.com> <Y1EDxZvjEi47iWUN@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Thu, 20 Oct 2022, Christoph Hellwig wrote:

> On Tue, Oct 18, 2022 at 02:48:01PM -0400, Mike Snitzer wrote:
> > > That really does not sound like a good idea at all.  And it does not
> > > seem to have any MM or core maintainer signoffs.
> > 
> > Sorry, I should've solicited proper review more loudly.
> > 
> > But if you have a specific concern with how DM is looking to use
> > is_vmalloc_or_module_addr() please say what that is.
> 
> If I understand the patch correct it tries to use it to detect if
> a string is a string global.  Besides being nasty API abuse I can't
> see how this would even work if DM is built in.

It works for built-in DM.

You have "kfree_const" that detects if the string points to to .rodata 
with "is_kernel_rodata". Unfortunatelly, is_kernel_rodata doesn't detect 
if the string points to some modules's rodata, so we need an extra check 
for that.

So, the logic is:
if (!is_vmalloc_or_module_addr(ptr) && !is_kernel_rodata(ptr)) kfree(ptr);

I thought about modifying is_kernel_rodata to detect module's rodata as 
well, but it wouldn't work because kstrdup_const uses it and there would 
be crash possibility:
ptr = kstrdup_const(modules_rodata); unload_module(); use "ptr";

Mikulas

