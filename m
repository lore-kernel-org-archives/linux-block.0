Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FB9C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA892075A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfBUPlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:41:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36748 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBUPlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:41:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so31123194wrw.3
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 07:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8mDJx9g/qlmj++P8v3FAxpgn+QJN/WUsf2YY7Rl714=;
        b=dAB9akl+OcLN6IeDUq/gQUuFMbbjZY7MbbD08E6oh9jLuFqC9jSnbtmuoeYBfluXzf
         jHhfqtM/KAniuQcl1fC2QBSBws3WLcZ/3SBP+SFtooop7IvwNCZC5amj1FWrugg3RFKU
         zWkOR4sZuvK9yet8wLOw1qaQtWvYt2iL0PnXIejrA76scPLQ5rrT2pkd4UcPyYoLEgAH
         Q6+xpaTvexJPTYBL6ow72enJc+FFVQcaN2ATZhp33ce/kIOlvi/R2v+sRcQliJLiPGc/
         iUpBnNiOHc1pntOLkCdohY0SXGiraqb5LVseMHGdqdNzR1Iu+mZ1FMgUPTYmtpXYVSTI
         fS/w==
X-Gm-Message-State: AHQUAubnDB4oCPLRYw5mmxb1fXNbzVhUH+72NvSj0WumcnI3DrF+uqr2
        oW4lri2lNMVzeCf0rDIY1nd5PX1onOUTrzaQzMhxbhY0CHw=
X-Google-Smtp-Source: AHgI3IajQtX0Jk9BHXViUuTWU4pZuUe3b1W8Qq1teghYTSDWLyagiNE+sC0Qdng6K9XND403Gy8/u37XHY7hMzszTIQ=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr27612379wrp.150.1550763681617;
 Thu, 21 Feb 2019 07:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20190220220633.GA98019@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190220220633.GA98019@dennisz-mbp.dhcp.thefacebook.com>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Thu, 21 Feb 2019 10:41:10 -0500
Message-ID: <CAHhmqcSWJFtrduXD1kPFXz1hBQWQpyWSFo8ycVnLfkLq_emDfw@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] A little TLC for Discard
To:     Dennis Zhou <dennis@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 5:06 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> Hi everyone,
>
> Ric proposed a similar topic already [1], but I'd like to just add a
> little more to that discussion with a broader proposal for discussing
> discard.
>
> Proposal:
> Discard is a topic that seems to need a little bit of TLC from the
> kernel side. The two main approaches with discard are either to enable
> it as a mount option or to periodically run fstrim. At Facebook, we've
> seen performance wins with both enabling discard and disabling discard
> in favor of fstrim. I would like to find a middle ground where we don't
> have to have application developers performance tune for the hardware.
>
> XFS has had async discard support, but it has been problematic for our
> fleet. We were seeing bursts of large discard requests caused by async
> discard in XFS. This resulted in degraded drive performance increasing
> latency for dependent services.
>
> An alternative to discard is a filesystem level choice of reusing
> blocks. Rather than immediately issuing a discard, we can choose to
> reuse a block which will cause the underlying FTL to invalidate a block
> that we would have discarded. This saves the work done by the initial
> discard. There will have to be a balance here though with saving discard
> with hopes of reusing it and eventually issuing the discards.
>
> Another issue is each drive has its own proprietary FTL which introduces
> a wide variability of performance with discard. Some drives don't need
> discard to perform well and others need discard enabled. There is also a
> class of drives where discard is so not performant that it locks up the
> drive. I would like to discuss how we can quantify this and help tune
> discard within the kernel.
>
> In summary, I'd like to explore discard more and understand how we can
> build a more balanced discard experience where end users don't have to
> be super cognizant of the implications on their applications.
>
> [1] https://lore.kernel.org/linux-fsdevel/92ab41f7-35bc-0f56-056f-ed88526b8ea4@gmail.com/
>
> Thanks,
> Dennis

Hi Dennis,

For your example of "bursts of large discard requests" on XFS, that
sounds almost like the "eofblocks trims" that occur after a large file
copy.  This was addressed by the following patch:

commit 13b86fc33718c6b504baa472437ae14a33abc138
Date:   Wed May 9 08:45:04 2018 -0700
    xfs: skip online discard during eofblocks trims

...which should be in Linux 4.17.  I remember this patch, because I
reported seeing a 4 GB batch of discards after a write of a couple of
32 GB files.  I noticed it from the discard counters in VDO, and then
confirmed it with blktrace / seekwatcher.

There's the potential that what you're seeing might be something else,
but out of curiosity, did the systems exhibiting the bursts of
discards have a kernel that was older than 4.17?


Thanks,

Bryan
