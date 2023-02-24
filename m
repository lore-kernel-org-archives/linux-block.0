Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0121C677F1
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBXIq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjBXIqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 03:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0C5192A
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677228354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s81Q/Xy8xrcENhETUm07gPEWskfzeghIqz/jTp5NFiA=;
        b=Uc3K43JXFqMB3hnitCbQ6ZG9MRNop+a1Idv5lBmvyq44Usi7jnlG8Y5UxCFYXBN2rzq+A0
        do/ag17ln+gs0QR0r00IWCI8orp0UzUZ34aHS82Mno0iVyClflDOkWd6QSEiwCmJIOYhQM
        6N8ke8aMN9okE11XXgrBfaZ9rFtJZrA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-_St4ImozPdO32AZ_siDeJg-1; Fri, 24 Feb 2023 03:45:50 -0500
X-MC-Unique: _St4ImozPdO32AZ_siDeJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55CED29AA2CC;
        Fri, 24 Feb 2023 08:45:50 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8583EC15BA0;
        Fri, 24 Feb 2023 08:45:41 +0000 (UTC)
Date:   Fri, 24 Feb 2023 16:45:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Message-ID: <Y/h5MNjnzx5iywer@T590>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <b788d3b1-6a0f-83b6-1788-066640904f9b@nvidia.com>
 <Y/h4DeWfWJZu+VFi@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/h4DeWfWJZu+VFi@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 24, 2023 at 04:40:45PM +0800, Ming Lei wrote:
> Hi Chaitanya,
> 
> Thanks for the review!
> 
> On Tue, Feb 21, 2023 at 07:58:48PM +0000, Chaitanya Kulkarni wrote:
> > On 2/19/2023 7:46 PM, Ming Lei wrote:
> > > Prepare for adding ublk related test:
> > > 
> > > 1) ublk delete is sync removal, this way is convenient to
> > >     blkg/queue/disk instance leak issue
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
> > > ./miniublk del [-n dev_id] -a
> > > 	 -a delete all devices, -n delete specified device
> > > ./miniublk list [-n dev_id] -a
> > > 	 -a list all devices, -n list specified device, default -a
> > > 
> > > miniublk depends on liburing 2.2, adds HAVE_LIBURING for checking if
> > > liburing 2.2 exists; also add HAVE_UBLK_HEADER for checking ublk kernel
> > > UAPI header exists. If either of two dependencies can't be met, simply
> > > ignore miniublk target.
> > > 
> > > Also v6.0 is the 1st linux kernel release with ublk.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >   src/.gitignore |    1 +
> > >   src/Makefile   |   18 +
> > >   src/miniublk.c | 1376 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 1395 insertions(+)
> > >   create mode 100644 src/miniublk.c
> > > 
> > > diff --git a/src/.gitignore b/src/.gitignore
> > > index 355bed3..df7aff5 100644
> > > --- a/src/.gitignore
> > > +++ b/src/.gitignore
> > > @@ -8,3 +8,4 @@
> > >   /sg/dxfer-from-dev
> > >   /sg/syzkaller1
> > >   /zbdioctl
> > > +/miniublk
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 3b587f6..81c6541 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
> > >   		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> > >   		else echo "$(3)"; fi)
> > >   
> > > +HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
> > > +		$(CC) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
> > > +		then echo 1;else echo 0; fi)
> > > +
> > >   C_TARGETS := \
> > >   	loblksize \
> > >   	loop_change_fd \
> > > @@ -13,16 +17,27 @@ C_TARGETS := \
> > >   	sg/syzkaller1 \
> > >   	zbdioctl
> > >   
> > > +C_MINIUBLK := miniublk
> > > +
> > > +HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
> > > +HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
> > > +
> > >   CXX_TARGETS := \
> > >   	discontiguous-io
> > >   
> > > +ifeq ($(HAVE_LIBURING)$(HAVE_UBLK_HEADER), 11)
> > > +TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
> > > +else
> > > +$(info Skip $(C_MINIUBLK) build due to missing kernel header(v6.0+) or liburing(2.2+))
> > >   TARGETS := $(C_TARGETS) $(CXX_TARGETS)
> > > +endif
> > >   
> > >   CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
> > >   
> > >   override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
> > >   override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
> > >   		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
> > > +MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring
> > >   
> > >   all: $(TARGETS)
> > >   
> > > @@ -39,4 +54,7 @@ $(C_TARGETS): %: %.c
> > >   $(CXX_TARGETS): %: %.cpp
> > >   	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
> > >   
> > > +$(C_MINIUBLK): %: miniublk.c
> > > +	$(CC) $(CFLAGS) $(MINIUBLK_FLAGS) -o $@ miniublk.c
> > > +
> > >   .PHONY: all clean install
> > > diff --git a/src/miniublk.c b/src/miniublk.c
> > > new file mode 100644
> > > index 0000000..e84ba41
> > > --- /dev/null
> > > +++ b/src/miniublk.c
> > > @@ -0,0 +1,1376 @@
> > > +// SPDX-License-Identifier: GPL-3.0+
> > > +// Copyright (C) 2023 Ming Lei
> > > +
> > > +/*
> > > + * io_uring based mini ublk implementation with null/loop target,
> > > + * for test purpose only.
> > > + *
> > > + * So please keep it clean & simple & reliable.
> > > + */
> > > +
> > > +#include <unistd.h>
> > > +#include <stdlib.h>
> > > +#include <assert.h>
> > > +#include <stdio.h>
> > > +#include <stdarg.h>
> > > +#include <string.h>
> > > +#include <pthread.h>
> > > +#include <getopt.h>
> > > +#include <limits.h>
> > > +#include <sys/syscall.h>
> > > +#include <sys/mman.h>
> > > +#include <sys/ioctl.h>
> > > +#include <liburing.h>
> > > +#include <linux/ublk_cmd.h>
> > > +
> > > +#define CTRL_DEV		"/dev/ublk-control"
> > > +#define UBLKC_DEV		"/dev/ublkc"
> > > +#define UBLK_CTRL_RING_DEPTH            32
> > > +
> > > +/* queue idle timeout */
> > > +#define UBLKSRV_IO_IDLE_SECS		20
> > > +
> > > +#define UBLK_IO_MAX_BYTES               65536
> > > +#define UBLK_MAX_QUEUES                 4
> > > +#define UBLK_QUEUE_DEPTH                128
> > > +
> > > +#define UBLK_DBG_DEV            (1U << 0)
> > > +#define UBLK_DBG_QUEUE          (1U << 1)
> > > +#define UBLK_DBG_IO_CMD         (1U << 2)
> > > +#define UBLK_DBG_IO             (1U << 3)
> > > +#define UBLK_DBG_CTRL_CMD       (1U << 4)
> > > +#define UBLK_LOG		(1U << 5)
> > > +
> > > +struct ublk_dev;
> > > +struct ublk_queue;
> > > +
> > > +struct ublk_ctrl_cmd_data {
> > > +	unsigned short cmd_op;
> > 
> > perhaps use enum type to avoid any type mismatach errors in future..
> 
> Sounds good.

oops, here the command op is actually defined in uapi header, which
can't be changed to enum any more, but still better to align the type
with uring_cmd type(u32).

Thanks,
Ming

