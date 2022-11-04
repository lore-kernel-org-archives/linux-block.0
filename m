Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F64C4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 13:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKDNKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiKDNKf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 09:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E792E6A3
        for <linux-block@vger.kernel.org>; Fri,  4 Nov 2022 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667567378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MPH7HkTo+EdGShDcB1aKfZnkizG0dH+geWqT/cE+950=;
        b=D5DNKyy0O++FNhJZF53wvhqz1tDM3qqIVFRimFuedY07c94JhBPT3JZ0aqeUAHqgeChBBe
        t0k6//0eqYzx/z2KJ62FV8YlyQqS9WKb7PxdIFS2+46rC1S9yi9gfFyVYNZRimsaOJO0NF
        zFB7RT9BcM1YXX9UqFJR+IP3bFAj578=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-Glgj8p5CMeKJbx7i99H2TQ-1; Fri, 04 Nov 2022 09:09:33 -0400
X-MC-Unique: Glgj8p5CMeKJbx7i99H2TQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D39D38339CB;
        Fri,  4 Nov 2022 13:09:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E7449BB9A;
        Fri,  4 Nov 2022 13:09:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2A4D9WZ5019732;
        Fri, 4 Nov 2022 09:09:32 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2A4D9VcB019728;
        Fri, 4 Nov 2022 09:09:31 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 4 Nov 2022 09:09:31 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Keith Busch <kbusch@kernel.org>
cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk, stefanha@redhat.com,
        ebiggers@kernel.org, me@demsh.org
Subject: Re: [PATCH 0/3] fix direct io errors on dm-crypt
In-Reply-To: <Y2Qm/yGlVbDRskkr@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <alpine.LRH.2.21.2211040908140.19553@file01.intranet.prod.int.rdu2.redhat.com>
References: <20221103152559.1909328-1-kbusch@meta.com> <alpine.LRH.2.21.2211031224060.10758@file01.intranet.prod.int.rdu2.redhat.com> <Y2Qm/yGlVbDRskkr@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Thu, 3 Nov 2022, Keith Busch wrote:

> On Thu, Nov 03, 2022 at 12:33:19PM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > The patchset seems OK - but dm-integrity also has a limitation that the 
> > bio vectors must be aligned on logical block size.
> > 
> > dm-writecache and dm-verity seem to handle unaligned bioset, but you 
> > should check them anyway.
> > 
> > I'm not sure about dm-log-writes.
> 
> Yeah, dm-integrity definitly needs it too. This is easy enough to use
> the same io_hint that I added for dm-crypt.
> 
> dm-log-writes is doing some weird things with writes that I don't think
> would work with some low level drivers without the same alignment
> constraint.
> 
> The other two appear to handle this fine, but I'll run everything
> through some focused test cases to be sure.
> 
> In the meantime, do you want to see the remaining mappers fixed in a v2,
> or are you okay if they follow after this series?

I don't care if you make a separate patch or fold it into an existing 
patch.

Mikulas

