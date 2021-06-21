Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F202AC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50EC61289
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhFUVMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhFUVMr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 17:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35EBF6023F;
        Mon, 21 Jun 2021 21:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624309832;
        bh=WdW8ck7gzAKcCahm1hryNqR4PzBe7ZZ51Q1oRQBfTGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ty8VV+LS0DsOyM1rC/4/+sE/avkovGsXylw5j4UjZOwd00fQcRKypguFNQ8txCiXr
         VBArF8PjcJvqXcoUQLn2m4IAnPfzgOyaY4fGvEbamJwP8CwQ8+y6tFERCth2bFq3XC
         ALIS04zIHWAHJJTrPtZ75K671zUC1raBkvlOtBzcFVg33WVCfU2s0iU8XfnLzhnT0g
         nde3zth5K+35JBTUoqift18QN/kBmHYSmpRBx8yaOETwRpdLHpuZJVQM+XODcIlLKC
         +t//jZuYIsBlYdVgs+eo/mrkFcoiD0U4E6WSu+RViT+qE2O0Ov4cfPYzC4RreQw1D8
         RIo/D92p9pEZg==
Date:   Mon, 21 Jun 2021 14:10:30 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: =?utf-8?B?4p2MIEZBSUw=?= =?utf-8?Q?=3A?= Test report for kernel
 5.13.0-rc6 (block, b0740de3)
Message-ID: <20210621211030.GD1268033@dhcp-10-100-145-180.wdc.com>
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
 <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 03:00:48PM -0600, Jens Axboe wrote:
> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
> > On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
> >>
> >> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
> >>>
> >>>
> >>> Hello,
> >>>
> >>> We ran automated tests on a recent commit from this kernel tree:
> >>>
> >>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
> >>>
> >>> The results of these automated tests are provided below.
> >>>
> >>>     Overall result: FAILED (see details below)
> >>>              Merge: OK
> >>>            Compile: FAILED
> >>>
> >>
> >> Hi,
> >>
> >> the failure is introduced between this commit and d142f908ebab64955eb48e.
> >> Currently seeing if I can bisect it closer but maybe someone already has an
> >> idea what went wrong.
> >>
> > 
> > First commit failing the compilation is 7a2b0ef2a3b83733d7.
> 
> Where's the log? Adding Willy...

I think the result was from 1f26b0627b461. There's an implied header
inclusion order such that linux/fs.h must be included before
linux/fileattr.h. The reported error for fs/orangefs/inode.c had been
getting the inclusion correct by chance through:

  linux/bvec.h
   linux/mm.h
    linux/huge_mm.h
     linux/fs.h

7a2b0ef2a3b83733d7 replaced bvec.h's mm.h inclusion with mm_types.h, so
now orangefs.h doesn't have the inclusion order correct anymore.

But we usually don't like inlcusion order dependencies in kernel, so I
think linux/fileattr.h needs to directly include the files it depends
on.

---
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 9e37e063ac69..34e153172a85 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_FILEATTR_H
 #define _LINUX_FILEATTR_H
 
+#include <linux/fs.h>
+
 /* Flags shared betwen flags/xflags */
 #define FS_COMMON_FL \
 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
--
