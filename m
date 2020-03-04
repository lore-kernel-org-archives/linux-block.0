Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A9C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91D821739
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZacFb+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDTXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:23:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbgCDTXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 14:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583349823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJQ2D1olvriwzmbW9AcTpxSB6j5LQtONyiKHbIDvTEM=;
        b=WZacFb+9hx8MyHo1oVDapyIY3XFeb5jerXN6fNgnKFG5PkkUgk7wdlqH5v6FMu1VoNCE6B
        AAPVQ2bUPnaO1jP2H/a8aQmhXK5Fj5qr4iH9XYjVExBRGv5vovN//+FNujk2xtuQFLVfHb
        61wKGfWBkq+0KjTEy+Ae8/lAGg3Phjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-sWWyhWEDNVmk-CAplh5WmQ-1; Wed, 04 Mar 2020 14:23:41 -0500
X-MC-Unique: sWWyhWEDNVmk-CAplh5WmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B735818B9FC1;
        Wed,  4 Mar 2020 19:23:39 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98A8F91D68;
        Wed,  4 Mar 2020 19:23:36 +0000 (UTC)
Date:   Wed, 4 Mar 2020 14:23:35 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [git pull] device mapper fixes for 5.6-rc5
Message-ID: <20200304192335.GA24296@redhat.com>
References: <20200304150257.GA19885@redhat.com>
 <CAHk-=wgP=q648JXn8Hd9q7DuNaOEpLmxQp2W3RO3vkaD2CS_9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgP=q648JXn8Hd9q7DuNaOEpLmxQp2W3RO3vkaD2CS_9g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 04 2020 at  2:06pm -0500,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Mar 4, 2020 at 9:03 AM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > - Bump the minor version for DM core and all target versions that have
> >   seen interface changes or important fixes during the 5.6 cycle.
> 
> Can we please remove these pointless version markers entirely?
> 
> They make no sense. The kernel doesn't allow backwards incompatible
> changes anyway, so the whole point of using some kind of interface
> versioning is entirely bogus.
> 
> The way you test if a new feature exists or not is to just use it, and
> if you're running on an old kernel that doesn't support that
> operation, then it should return an error.

These versions are for userspace's benefit (be it lvm2, cryptsetup,
multipath-tools, etc).  But yes, these versions are bogus even for
that -- primarily because it requires userspace to know when a
particular feature/fix it cares about was introduced.  In addition: if
fixes, that also bump version, are marked for stable@ then we're quickly
in versioning hell -- which is why I always try to decouple version
bumps from fixes.

Others have suggested setting feature flags.  I expect you'd hate those
too.  I suspect I quickly would too given flag bits are finite and
really tedious to deal with.

I'll think further about this issue and consult with userspace
developers and see what we might do.

Thanks (for the needed kick in the ass).
Mike

