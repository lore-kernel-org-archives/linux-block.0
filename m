Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03D8C05027
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 03:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBTDO1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Feb 2023 22:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBTDO1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2023 22:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29461AD0B
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2023 19:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676862819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Mxwu/zbQsbDnGFnJFtbYLkrRv1T2sYZ60ME9YwmeHY=;
        b=TXjP9tehRTKs4fgymCoxxCZD0wph+WSOw5MLtRBkkwYeKmWiiZSMuq4y9SYlqFNzcHU8wG
        RHYUE4iOSxOgiFTpSDEJVzGqhSOfCNAmQy3rAk3HFcUNu2a4Qf5raWmi1Yq0PsoPEhEApN
        XGDLltN6jkkwSnRYkkqxaA7mhbsKPbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-G8psGz9qMR6b7OUh9dfhxw-1; Sun, 19 Feb 2023 22:13:35 -0500
X-MC-Unique: G8psGz9qMR6b7OUh9dfhxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E902101A521;
        Mon, 20 Feb 2023 03:13:35 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C6A140EBF4;
        Mon, 20 Feb 2023 03:13:31 +0000 (UTC)
Date:   Mon, 20 Feb 2023 11:13:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 1/2] src: add mini ublk source code
Message-ID: <Y/LlVTrVfMHc4+mN@T590>
References: <20230217013851.1402864-1-ming.lei@redhat.com>
 <20230217013851.1402864-2-ming.lei@redhat.com>
 <20230217140547.qvpdniixeeurc5im@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217140547.qvpdniixeeurc5im@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17, 2023 at 02:05:48PM +0000, Shinichiro Kawasaki wrote:
> Hi Ming, thanks for the v2 series. Please find my comments in line.
> 
> On Feb 17, 2023 / 09:38, Ming Lei wrote:
> > Prepare for adding ublk related test:
> > 
> > 1) ublk delete is sync removal, this way is convenient to
> >    blkg/queue/disk instance leak issue
> > 
> > 2) mini ublk has two builtin target(null, loop), and loop IO is
> > handled by io_uring, so we can use ublk to cover part of io_uring
> > workloads
> > 
> > 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> > add/delete disk dynamically, this way may cover disk plug & unplug
> > tests
> > 
> > 4) ublk specific test given people starts to use it, so better to
> > let blktest cover ublk related tests
> > 
> > Add mini ublk source for test purpose only, which is easy to use:
> > 
> > ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> > 	 default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)
> > 	 -t loop -f backing_file
> > 	 -t null
> > ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> > 	 -a delete all devices, -d delete device by disk path,
> > 	 -n delete specified device
> > ./miniublk list [-n dev_id] -a
> > 	 -a list all devices, -n list specified device, default -a
> > 
> > ublk depends on liburing 2.2, so allow to ignore ublk build failure
> > in case of missing liburing, and we will check if ublk program exits
> > inside test. Also v6.0 is the 1st linux kernel release with ublk.
> 
> This v2 patch prevents the ublk build failure. Could you rewrite this paragraph?

Sure.

> 
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  Makefile            |    2 +-
> >  src/Makefile        |   18 +
> >  src/ublk/miniublk.c | 1376 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1395 insertions(+), 1 deletion(-)
> >  create mode 100644 src/ublk/miniublk.c
> > 
> > diff --git a/Makefile b/Makefile
> > index 5a04479..b9bbade 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2,7 +2,7 @@ prefix ?= /usr/local
> >  dest = $(DESTDIR)$(prefix)/blktests
> >  
> >  all:
> > -	$(MAKE) -C src all
> > +	$(MAKE) -i -C src all
> 
> As you pointed out in another e-mail, -i is no longer required.
> 
> >  
> >  clean:
> >  	$(MAKE) -C src clean
> > diff --git a/src/Makefile b/src/Makefile
> > index 3b587f6..eae52db 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
> >  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> >  		else echo "$(3)"; fi)
> >  
> > +HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
> > +		$(CC) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
> > +		then echo 1;else echo 0; fi)
> > +
> >  C_TARGETS := \
> >  	loblksize \
> >  	loop_change_fd \
> > @@ -13,16 +17,27 @@ C_TARGETS := \
> >  	sg/syzkaller1 \
> >  	zbdioctl
> >  
> > +C_MINIUBLK := ublk/miniublk
> > +
> > +HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
> > +HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
> > +
> >  CXX_TARGETS := \
> >  	discontiguous-io
> >  
> > +ifeq ($(HAVE_LIBURING)$(HAVE_UBLK_HEADER), 11)
> > +TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
> > +else
> > +$(info Skip $(C_MINIUBLK) build due to missing kernel header(v6.0+) or liburing(2.2+))
> >  TARGETS := $(C_TARGETS) $(CXX_TARGETS)
> > +endif
> >  
> >  CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
> >  
> >  override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
> >  override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
> >  		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
> > +MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring
> >  
> >  all: $(TARGETS)
> >  
> > @@ -39,4 +54,7 @@ $(C_TARGETS): %: %.c
> >  $(CXX_TARGETS): %: %.cpp
> >  	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
> >  
> > +$(C_MINIUBLK): %: ublk/miniublk.c
> > +	$(CC) $(CFLAGS) $(MINIUBLK_FLAGS) -o $@ ublk/miniublk.c
> > +
> >  .PHONY: all clean install
> > diff --git a/src/ublk/miniublk.c b/src/ublk/miniublk.c
> > new file mode 100644
> > index 0000000..e84ba41
> > --- /dev/null
> > +++ b/src/ublk/miniublk.c
> 
> Do you plan to add more programs in the ublk/ directory? If not, I suggest to
> place miniublk.c in just under src/.

Sounds good.

> 
> Also, could you add miniublk to src/.gitignore?

OK.

Thanks,
Ming

