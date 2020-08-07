Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B5C433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 20:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC3522CB3
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGChyWMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHGUkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:40:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727050AbgHGUkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 16:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596832830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/uBji6wCVYsJwjqLVTeMkUOxFAJLI6meIhMywxPJMA=;
        b=TGChyWMp+XPcKxlaIGjESbLAdgf7rolaPf7ge7EGyJVRknCC0qWmKiBpWlvRbMXUKX/qwj
        eArAyg363pAYdmieA0WGqe3kJdHFJ9QyOPzwZ7CixduJ4n/kqOVW7k9Go9xoeT1PVKxwx1
        Ka0qSHH2tuyNVKlHUC/M73tEb/n669w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-zbZ_F5eJORiQ_W9-bNn9Gw-1; Fri, 07 Aug 2020 16:40:26 -0400
X-MC-Unique: zbZ_F5eJORiQ_W9-bNn9Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FE8110059A9;
        Fri,  7 Aug 2020 20:40:25 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AFCE1001B2C;
        Fri,  7 Aug 2020 20:40:16 +0000 (UTC)
Date:   Fri, 7 Aug 2020 16:40:15 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Dorminy <jdorminy@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [git pull] device mapper changes for 5.9
Message-ID: <20200807204015.GA2178@redhat.com>
References: <20200807160327.GA977@redhat.com>
 <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 07 2020 at  4:11pm -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Aug 7, 2020 at 9:03 AM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > - DM crypt improvement to optionally avoid async processing via
> >   workqueues for reads and/or writes -- via "no_read_workqueue" and
> >   "no_write_workqueue" features.  This more direct IO processing
> >   improves latency and throughput with faster storage.  Avoiding
> >   workqueue IO submission for writes (DM_CRYPT_NO_WRITE_WORKQUEUE) is
> >   a requirement for adding zoned block device support to DM crypt.
> 
> Is there a reason the async workqueue isn't removed entirely if it's not a win?
> 
> Or at least made to not be the default.

I haven't assessed it yet.

There are things like rbtree sorting that is also hooked off async, but
that is more meaningful for rotational storage.

> Now it seems to be just optionally disabled, which seems the wrong way
> around to me.
> 
> I do not believe async crypto has ever worked or been worth it.
> Off-loaded crypto in the IO path, yes. Async using a workqueue? Naah.
> 
> Or do I misunderstand?

No, you've got it.

My thinking was to introduce the ability to avoid the workqueue code via
opt-in and then we can evaluate the difference it has on different
classes of storage.

More conservative approach that also allows me to not know the end from
the beginning... this was work driven by others so on this point I
rolled with what was proposed since I personally don't have the answer
(yet) on whether workqueue is actually helpful.  Best to _really_ know
that before removing it.

I'll make a point to try to get more eyes on this to see if it makes
sense to just eliminate the workqueue code entirely (or invert the
default).  Will keep you updated.

Mike

