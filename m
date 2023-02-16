Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77959C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBPLL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 06:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBPLL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 06:11:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9ED37736
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676545830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJhAWHr2nEDSYk8AbF0GzJo0wn08EehHZ5PTcw3V4KU=;
        b=Mdn+ERiUjjCzBZTNmKCS54/KAm+6EaRz3PM7HjfFC5P/qIjHO5p+0ShVTGCdfZNjwqG8h/
        wRdXZc0lWGi0N7gEzGd82wUdPJOqpeYtEQwlAYWjrOjGVjv4TB4DPkfa7IX+66/zn5F2OT
        sX2J4kGqqAbbpDuebz1HIFymKimALrw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-p6N9Ol8tO7ivXDcDIlAp1A-1; Thu, 16 Feb 2023 06:10:28 -0500
X-MC-Unique: p6N9Ol8tO7ivXDcDIlAp1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EB692999B39;
        Thu, 16 Feb 2023 11:10:28 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC1C62166B30;
        Thu, 16 Feb 2023 11:10:25 +0000 (UTC)
Date:   Thu, 16 Feb 2023 19:10:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] blktests/src: add mini ublk source code
Message-ID: <Y+4PHBqOfAJwSKcZ@T590>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216030134.1368607-2-ming.lei@redhat.com>
 <20230216081938.oyc6ys5zo3bayrqw@shindev>
 <Y+3wGE9IiHIEECvO@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3wGE9IiHIEECvO@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 04:58:00PM +0800, Ming Lei wrote:
> Hi Shinichiro,
> 
> Thanks for the review!
> 
> On Thu, Feb 16, 2023 at 08:19:39AM +0000, Shinichiro Kawasaki wrote:
> > Hi Ming, thanks for the patches. It sounds a good idea to extend blktests
> > coverage to ublk.
> > 
> > Regarding the commit title, I suggest this:
> > 
> >    src: add mini ublk source codes
> > 
> > The word "blktests" can be placed after the word "PATCH" as follows:
> > 
> >    [PATCH blktests] src: add mini ublk source codes
> > 
> > Please try --subject-prefix="PATCH blktests" option for git format-patch.
> 
> OK.
> 
> > 
> > On Feb 16, 2023 / 11:01, Ming Lei wrote:
> > > Prepare for adding ublk related test:
> > > 
> > > 1) ublk delete is sync removal, this way is convenient to
> > >    blkg/queue/disk instance leak issue
> > > 
> > > 2) mini ublk has two builtin target(null, loop), and loop IO is
> > > handled by io_uring, so we can use ublk to cover part of io_uring
> > > workloads
> > > 
> > > 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> > > add/delete disk dynamically, this way may cover disk plug & unplug
> > > tests
> > > 
> > > 4) ublk specific test given people starts to use it, so better to
> > > let blktest cover ublk related tests
> > > 
> > > Add mini ublk source for test purpose only, which is easy to use:
> > > 
> > > ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> > > 	 default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)
> > > 	 -t loop -f backing_file
> > > 	 -t null
> > > ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> > > 	 -a delete all devices, -n delete specified device
> > > ./miniublk list [-n dev_id] -a
> > > 	 -a list all devices, -n list specified device, default -a
> > > 
> > > ublk depends on liburing 2.2, so allow to ignore ublk build failure
> > > in case of missing liburing, and we will check if ublk program exits
> > > inside test.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  Makefile            |    2 +-
> > >  src/Makefile        |   13 +-
> > >  src/ublk/miniublk.c | 1385 +++++++++++++++++++++++++++++++++++++++++++
> > >  src/ublk/ublk_cmd.h |  278 +++++++++
> > >  4 files changed, 1674 insertions(+), 4 deletions(-)
> > >  create mode 100644 src/ublk/miniublk.c
> > >  create mode 100644 src/ublk/ublk_cmd.h
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 5a04479..b9bbade 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2,7 +2,7 @@ prefix ?= /usr/local
> > >  dest = $(DESTDIR)$(prefix)/blktests
> > >  
> > >  all:
> > > -	$(MAKE) -C src all
> > > +	$(MAKE) -i -C src all
> > 
> > This -i option to ignore errors is applied to all build targets, so it will hide
> > errors. Instead os ignoring the error, how about checking the liburing version
> > with pkg-config command? I roughly implemented it as the patch below on top of
> > your patch. It looks working.
> > 
> > diff --git a/src/Makefile b/src/Makefile
> > index 9bb8da6..c600099 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -2,6 +2,11 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
> >  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> >  		else echo "$(3)"; fi)
> >  
> > +HAVE_PACKAGE_VER = $(shell if pkg-config --atleast-version="$(2)" "$(1)"; \
> > +			then echo 1; else echo 0; fi)
> > +
> > +HAVE_LIBURING := $(call HAVE_PACKAGE_VER,liburing,2.2)
> 
> I tried this way, and it fails in case that liburing is built
> against source tree directly. And liburing2.2 is still a bit new, and even
> some distributions doesn't package it. I will think about other way
> for the check.

Looks the following way works:


diff --git a/src/Makefile b/src/Makefile
index 83e8a62..adfd27a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
 		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
 		else echo "$(3)"; fi)
 
+HAVE_C_MACRO = $(shell if echo "#include <$(1)>" | \
+		$(CC) -E - | grep $(2) > /dev/null 2>&1; then echo 1;	\
+		else echo 0; fi)
+
 C_TARGETS := \
 	loblksize \
 	loop_change_fd \
@@ -15,25 +19,30 @@ C_TARGETS := \
 
 C_MINIUBLK := ublk/miniublk
 
+HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
+
 CXX_TARGETS := \
 	discontiguous-io
 
+ifeq ($(HAVE_LIBURING), 1)
+TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
+else
 TARGETS := $(C_TARGETS) $(CXX_TARGETS)
-ALL_TARGETS := $(TARGETS) $(C_MINIUBLK)
+endif
 
 CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
 
 override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
 override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
-MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring
+MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring -Iublk
 
-all: $(ALL_TARGETS)
+all: $(TARGETS)
 
 clean:
-	rm -f $(ALL_TARGETS)
+	rm -f $(TARGETS)
 
-install: $(ALL_TARGETS)
+install: $(TARGETS)
 	install -m755 -d $(dest)
 	install $(TARGETS) $(dest)
 


Thanks, 
Ming

