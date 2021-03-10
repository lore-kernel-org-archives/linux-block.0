Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DFC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 22:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6340664E86
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhCJWxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhCJWwp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 17:52:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A57D64FAD;
        Wed, 10 Mar 2021 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615416765;
        bh=MkCN1VAfUgADubYsZbTmw2H9+u5F7zEXUUWpNKMGZNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSGF1V+ne/C/fthu1GGCeyHir1chRImToauZkZl9ZaYFfij1PdPFJ+xHCz4mohPdr
         +XehbGV4BFsEYxRoZsgL2bTAMUrww8F4CINhBjeEn9sdiFGk4mLe7VI0CykAPBEDBq
         5n8g2ZEssQu5Yl9tJ8Sx6fpEw3Omik02t2L9E1H9C/B78J9qzJN77u2dUwjx6OL+nW
         lS/zru8KCKk97jSG7K9Ix67urj18Eg4uvnflTe5xlkGUTPTRdw+plcKKbe54ZreFDL
         EkrOK0L7i/Q/H4ZXGWBS5cFUD6S9C1J+kGO1AUkCtsx8P5Pl8XCN5TAbfdXhYU663o
         emVEZHnZpAUtQ==
Date:   Wed, 10 Mar 2021 15:52:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: -Walign-mismatch in block/blk-mq.c
Message-ID: <20210310225240.4epj2mdmzt4vurr3@archlinux-ax161>
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
 <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
 <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
 <e43dba61-8c74-757d-862d-99d23559cf50@kernel.dk>
 <20210310205250.hpe4wcgn4yh3rjqz@archlinux-ax161>
 <9834f7fc-f4d2-2230-7e1f-9b607ea782de@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9834f7fc-f4d2-2230-7e1f-9b607ea782de@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 10, 2021 at 02:03:56PM -0700, Jens Axboe wrote:
> On 3/10/21 1:52 PM, Nathan Chancellor wrote:
> > On Wed, Mar 10, 2021 at 01:40:25PM -0700, Jens Axboe wrote:
> >> On 3/10/21 1:33 PM, Nathan Chancellor wrote:
> >>> On Wed, Mar 10, 2021 at 01:21:52PM -0700, Jens Axboe wrote:
> >>>> On 3/10/21 11:23 AM, Nathan Chancellor wrote:
> >>>>> Hi Jens,
> >>>>>
> >>>>> There is a new clang warning added in the development branch,
> >>>>> -Walign-mismatch, which shows an instance in block/blk-mq.c:
> >>>>>
> >>>>> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
> >>>>> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
> >>>>> result in an unaligned pointer access [-Walign-mismatch]
> >>>>>                 smp_call_function_single_async(cpu, &rq->csd);
> >>>>>                                                     ^
> >>>>> 1 warning generated.
> >>>>>
> >>>>> There appears to be some history here as I can see that this member was
> >>>>> purposefully unaligned in commit 4ccafe032005 ("block: unalign
> >>>>> call_single_data in struct request"). However, I later see a change in
> >>>>> commit 7c3fb70f0341 ("block: rearrange a few request fields for better
> >>>>> cache layout") that seems somewhat related. Is it possible to get back
> >>>>> the alignment by rearranging the structure again? This seems to be the
> >>>>> only solution for the warning aside from just outright disabling it,
> >>>>> which would be a shame since it seems like it could be useful for
> >>>>> architectures that cannot handle unaligned accesses well, unless I am
> >>>>> missing something obvious :)
> >>>>
> >>>> It should not be hard to ensure that alignment without re-introducing
> >>>> the bloat. Is there some background on why 32-byte alignment is
> >>>> required?
> >>>>
> >>>
> >>> This alignment requirement was introduced in commit 966a967116e6 ("smp:
> >>> Avoid using two cache lines for struct call_single_data") and it looks
> >>> like there was a thread between you and Peter Zijlstra that has some
> >>> more information on this:
> >>> https://lore.kernel.org/r/a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk/
> >>
> >> Ah now I remember - so it's not that it _needs_ to be 32-byte aligned,
> >> it's just a handy way to ensure that it doesn't straddle two cachelines.
> >> In fact, there's no real alignment concern, outside of performance
> >> reasons we don't want it touching two cachelines.
> >>
> >> So... what exactly is your concern? Just silencing that warning? Because
> > 
> > Yes, dealing with the warning in some way is my only motivation. My
> > apologies, I should have led with that. I had assumed that this would
> > potentially be an issue due to the warning's text and that rearranging
> > the structure might allow the alignment to be added back but if there is
> > not actually a problem, then the warning should be silenced in some way.
> 
> Right, that's what I was getting at, but I needed to page that context
> back in, it had long since been purged :-)
> 
> > I am not sure if there is a preferred way to silence it (CFLAGS_... or
> > some of the __diag() infrastructure in include/linux/compiler_types.h).
> 
> That's a good question, I'm not sure what the best approach here would
> be. Funnily enough, on my build, it just so happens to be 32-byte
> aligned anyway, but that's by mere chance.

As far as I can tell, there are two options.

1. Objectively smallest option is to just disable -Walign-mismatch for
   the whole translation unit. The benefit of this route is one small
   and simple patch. The downside is that if there are any more
   instances of this added in the future, they won't be caught. May or
   may not actually happen or be a big deal.

diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..432d0329fb58 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
+CFLAGS_blk-mq.o := $(call cc-disable-warning, align-mismatch)
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o

2. Use the __diag() infrastructure, which would allow us to locally
   disable the warning while adding a comment. The benefit of this
   approach is that the warning is only disabled for the problematic
   line so other instances can be caught. The downside is there is a
   little churn as it will involve a patch for the initial __diag()
   support for clang (as it has not needed it yet) and a few more lines
   in block/blk-mq.c. Additionally, the reason for the warning can be
   documented (the comment can obviously be improved).

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..2781c04d06bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -627,7 +627,10 @@ static void blk_mq_complete_send_ipi(struct request *rq)
 	list = &per_cpu(blk_cpu_done, cpu);
 	if (llist_add(&rq->ipi_list, list)) {
 		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
+		__diag_push();
+		__diag_ignore(clang, 13, "-Walign-mismatch", "There is no issue with misalignment here");
 		smp_call_function_single_async(cpu, &rq->csd);
+		__diag_pop();
 	}
 }
 
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 04c0a5a717f7..0a20fddc1c30 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -55,3 +55,25 @@
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
+
+/*
+ *  * Turn individual warnings and errors on and off locally, depending
+ *   * on version.
+ *    */
+#define __diag_clang(version, severity, s) \
+		__diag_clang_ ## version(__diag_clang_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_clang_ignore	ignored
+#define __diag_clang_warn	warning
+#define __diag_clang_error	error
+
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
+
+#if CONFIG_CLANG_VERSION >= 130000
+#define __diag_clang_13(s)		__diag(s)
+#else
+#define __diag_clang_13(s)
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e5dd5a4ae946..a505d8a4302d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -328,6 +328,10 @@ struct ftrace_likely_data {
 #define __diag(string)
 #endif
 
+#ifndef __diag_clang
+#define __diag_clang(version, severity, string)
+#endif
+
 #ifndef __diag_GCC
 #define __diag_GCC(version, severity, string)
 #endif

I would say the preference is ultimately up to the maintainer, unless my
fellow ClangBuiltLinux maintainers/contributors have any further
comments/objections.

Cheers,
Nathan
