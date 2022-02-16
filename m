Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04B0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiBPSJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:09:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiBPSJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 13:09:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF9D2A4A36
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:09:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f37so5351122lfv.8
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsoF6XbVRJnqOxLapkisfvdDBSbyOEKGfv87xWkqHBo=;
        b=H8EZzc3vbZYf96mKzjlBDBIZSlEvwXS9/cmk8gIRTNI1MAwfaOAbt22JaPzIFJh6SU
         haljNM84uLArCZw16a7/Bsg1jw9a9dpDJPFefdN6wlu3bpRuDM6rCoTBfs58oYcxVKD3
         nbRVV3036QZdC6Y3iMcylW2hsU3GnC78jLfj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsoF6XbVRJnqOxLapkisfvdDBSbyOEKGfv87xWkqHBo=;
        b=0eLh/shf3xOAMcrLh/BRF2Yusvq7sTCWsLVF63QSipYCzuBGUl3b+1o/qM+jytr5l9
         5l27W56LWGxQ7Ps830lwQFYAY0z9QQ4oPRbc83rgwF3VaSq2841WKiwtbvWogw0VhzV6
         jbpDK0O/U1rGwdFlGCJ2m2OHMEV8mxSxObOOYJ6SvPMS9J0PS7fxCWeOUiY52umhk2aY
         Fo/d2fmSg5+rQhFsPT28fCksXXqnXX81Egg7gNKUH3tZgKzyc/SAtK/VaCRrj7v/VJSy
         2tLjcfqJShGEA79Iy+yutQKG/FuG3mvUxT1LjqIoACBVg2dXgIuyzPDK/ztsxQx9gH+E
         1/uQ==
X-Gm-Message-State: AOAM531aPhzVfa/W07F3toQcJm8MLAB66Am69rObJSeOa10+oXmFACMg
        NlC+VNKGH9WNd+tbpbnqqtgODV0ghsPjXA1+z7Q=
X-Google-Smtp-Source: ABdhPJyFeDIKJqcsexuqMbDqsPtWVUe2Agt3eMnuq68C3b2piJrmDosy5kC9vY+/3ATvg1o817mHpw==
X-Received: by 2002:ac2:5389:0:b0:443:7b0e:951a with SMTP id g9-20020ac25389000000b004437b0e951amr2846846lfh.288.1645034982832;
        Wed, 16 Feb 2022 10:09:42 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id g7sm4878928ljk.83.2022.02.16.10.09.41
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:09:41 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id n24so4577154ljj.10
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:09:41 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr289887lfh.531.1645034970931; Wed, 16
 Feb 2022 10:09:30 -0800 (PST)
MIME-Version: 1.0
References: <1644984747-26706-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-3-git-send-email-byungchul.park@lge.com> <94b1cba2-0e78-bbc0-0321-8be70b2b3be2@opensource.wdc.com>
In-Reply-To: <94b1cba2-0e78-bbc0-0321-8be70b2b3be2@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Feb 2022 10:09:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
Message-ID: <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
Subject: Re: Report in ata_scsi_port_error_handler()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, linux-ide@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@lge.com, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, sj@kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, paolo.valente@linaro.org,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 10:37 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/16/22 13:16, Byungchul Park wrote:
> > [    2.051040] ===================================================
> > [    2.051406] DEPT: Circular dependency has been detected.
> > [    2.051730] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W
> > [    2.051991] ---------------------------------------------------
> > [    2.051991] summary
> > [    2.051991] ---------------------------------------------------
> > [    2.051991] *** DEADLOCK ***
> > [    2.051991]
> > [    2.051991] context A
> > [    2.051991]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
> > [    2.051991]     [W] __raw_spin_lock_irq(&host->lock:0)
> > [    2.051991]     [E] event(&(&ap->eh_wait_q)->dmap:0)
> > [    2.051991]
> > [    2.051991] context B
> > [    2.051991]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> > [    2.051991]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
> > [    2.051991]     [E] spin_unlock(&host->lock:0)
>
> Sleeping with a spinlock held would be triggering warnings already, so
> these reports seem bogus to me.

Yeah, Matthew pointed out the same thing for another use-case, where
it looks like DEPT is looking at the state at the wrong point (not at
the scheduling point, but at prepare_to_sleep()).

This ata_port_wait() is the exact same pattern, ie we have

        spin_lock_irqsave(ap->lock, flags);

        while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
                prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
                spin_unlock_irqrestore(ap->lock, flags);
                schedule();

and DEPT has incorrectly taken it to mean that 'ap->lock' is held
during the wait, when it is actually released before actually waiting.

For the spin-locks, this is all very obvious (because they'd have been
caught long ago by much simpler debug code), but the same
prepare_to_wait -> wait pattern can most definitely happen with
sleeping locks too, so they are all slightly suspect.

And yes, the detailed reports are hard to read because the locations
are given as "ata_port_wait_eh+0x52/0xc0". Running them through
scripts/decode_stacktrace.sh to turn them into filename and line
numbers - and also sort out inlining - would help a lot.

Byungchul, could you fix those two issues? Some of your reports may
well be entirely valid, but the hard-to-read hex offsets and the
knowledge that at least some of them are confused about how
prepare_to_wait -> wait actually works makes the motivation to look at
the details much less..

           Linus
