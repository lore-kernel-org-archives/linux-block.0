Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64488C4727E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ADD2311B
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZptJvB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgIXQQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgIXQQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 12:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600964191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EfF16bCe0njopv3EGBmqLVMqnHunaWFKN8Yz67AbYg=;
        b=SZptJvB+pQlcd8YjUUqMlwenVsqSUxMuO+75CO6TJJPp2HagDGhNzOWU1FSlXs0AGN9WOg
        0BDFZEPuLr8eEAs3qh0GKUaT5+Ad/wYr4my5antAmLTmrC4hDU/VQfDwv9F3DmFV4QMO3C
        WapHhgOXl4rQ9xypYuGnHQ2RmZF+8oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-lKHT9NflMrW8m7cD-KYijw-1; Thu, 24 Sep 2020 12:16:29 -0400
X-MC-Unique: lKHT9NflMrW8m7cD-KYijw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D521100746C;
        Thu, 24 Sep 2020 16:16:28 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA2C455785;
        Thu, 24 Sep 2020 16:16:24 +0000 (UTC)
Date:   Thu, 24 Sep 2020 12:16:24 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924161624.GC14369@redhat.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200922003255.GC32959@sol.localdomain>
 <20200924011438.GD10500@redhat.com>
 <20200924071721.GA1883346@google.com>
 <20200924134649.GB13849@redhat.com>
 <20200924154550.GA1266@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924154550.GA1266@sol.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 24 2020 at 11:45am -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> On Thu, Sep 24, 2020 at 09:46:49AM -0400, Mike Snitzer wrote:
> > > > Can you help me better understand the expected consumer of this code?
> > > > If you have something _real_ please be explicit.  It makes justifying
> > > > supporting niche code like this more tolerable.
> > >
> > > So the motivation for this code was that Android currently uses a device
> > > mapper target on top of a phone's disk for user data. On many phones,
> > > that disk has inline encryption support, and it'd be great to be able to
> > > make use of that. The DM device configuration isn't changed at runtime.
> > 
> > OK, which device mapper target is used?
> 
> There are several device-mapper targets that Android can require for the
> "userdata" partition -- potentially in a stack of more than one:
> 
> dm-linear: required for Dynamic System Updates
> (https://developer.android.com/topic/dsu)
> 
> dm-bow: required for User Data Checkpoints on ext4
> (https://source.android.com/devices/tech/ota/user-data-checkpoint)
> (https://patchwork.kernel.org/patch/10838743/)
> 
> dm-default-key: required for metadata encryption
> (https://source.android.com/security/encryption/metadata)

Please work with all google stakeholders to post the latest code for the
dm-bow and dm-default-key targets and I'll work through them.

I think the more code we have to inform DM core's implementation the
better off we'll be in the long run.  Could also help improve these
targets as a side-effect of additional review.

I know I largely ignored dm-bow before but that was more to do with
competing tasks, etc.  I'll try my best...

> We're already carrying this patchset in the Android common kernels since late
> last year, as it's required for inline encryption to work when any of the above
> is used.  So this is something that is needed and is already being used.
> 
> Now, you don't have to "count" dm-bow and dm-default-key since they aren't
> upstream; that leaves dm-linear.  But hopefully the others at least show that
> architecturally, dm-linear is just the initial use case, and this patchset also
> makes it easy to pass through inline crypto on any other target that can support
> it (basically, anything that doesn't change the data itself as it goes through).

Sure, that context really helps.

About "basically, anything that doesn't change the data itself as it
goes through": could you be a bit more precise?  Very few DM targets
actually change the data as associated bios are remapped.

I'm just wondering if your definition of "doesn't change the data"
includes things more subtle than the data itself?

Thanks,
Mike

