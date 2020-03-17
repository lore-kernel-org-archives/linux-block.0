Return-Path: <SRS0=EH6z=5C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7451AC2BB1D
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB420658
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 10:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8PgzCdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQK1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:27:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48211 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgCQK1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 06:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584440829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7TwxBhJbK/6t1z07IsEb2SVAvOI34lv7qpUcHPUU9I=;
        b=W8PgzCddL/FOGXzZpPjJbXcK0YNx8VUEntFhUqTIiOiCSrNDnqSU+7hGo0EQDzbaakZsYC
        VMKrlde5Fp7bVQQlaUxav96SbvPUuaQmunBzMqzZSjGuYgN6TKVJ5dCU/c3gKBytwksWdf
        jChS6YLWTwGXsnpiD535PVDcX3umNPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-4mIfnvJVMMuVXr6SwNLg_w-1; Tue, 17 Mar 2020 06:26:55 -0400
X-MC-Unique: 4mIfnvJVMMuVXr6SwNLg_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 159121804578;
        Tue, 17 Mar 2020 10:26:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6248E8B74D;
        Tue, 17 Mar 2020 10:26:48 +0000 (UTC)
Date:   Tue, 17 Mar 2020 18:26:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Feng Li <lifeng1519@gmail.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
Message-ID: <20200317102643.GA8721@ming.t460p>
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p>
 <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p>
 <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
 <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
 <CAEK8JBCKH8-tiUj1W6CB_wAx2xF4osDLXG3GNzuAySrgsqp=yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEK8JBCKH8-tiUj1W6CB_wAx2xF4osDLXG3GNzuAySrgsqp=yQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 17, 2020 at 04:19:44PM +0800, Feng Li wrote:
> Thanks.
> Sometimes when I observe multipage bvec on 5.3.7-301.fc31.x86_64.
> This log is from Qemu virtio-blk.
> 
> ========= size: 262144, iovcnt: 2
>       0: size: 229376 addr: 0x7fff6a7c8000
>       1: size: 32768 addr: 0x7fff64c00000
> ========= size: 262144, iovcnt: 2
>       0: size: 229376 addr: 0x7fff6a7c8000
>       1: size: 32768 addr: 0x7fff64c00000

Then it is working.

> 
> I also tested on 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64.
> And observe 64 iovcnt.
> ========= size: 262144, iovcnt: 64
>       0: size: 4096 addr: 0x7fffb5ece000
>       1: size: 4096 addr: 0x7fffb5ecd000
> ...
>       63: size: 4096 addr: 0x7fff8baec000
> 
> So I think this is a common issue of the upstream kernel, from 5.3 to 5.6.

As I mentioned before, it is because the pages aren't contiguous
physically.

If you enable hugepage, you will see lot of pages in one single bvec.

> 
> BTW, I have used your script on 5.3.7-301.fc31.x86_64, it works well.
> However, when updating to kernel 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64.
> It complains:
> 
> root@192.168.19.239 16:57:23 ~ $ ./bvec_avg_pages.py
> In file included from /virtual/main.c:2:
> In file included from
> /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/uapi/linux/ptrace.h:142:
> In file included from
> /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/include/asm/ptrace.h:5:
> /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/x86/include/asm/segment.h:266:2:
> error: expected '(' after 'asm'
>         alternative_io ("lsl %[seg],%[p]",

It can be workaround by commenting the following line in 
/lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include/generated/autoconf.h:

#define CONFIG_CC_HAS_ASM_INLINE 1


Thanks, 
Ming

