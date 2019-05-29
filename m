Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F177C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2357A24109
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUV/TH24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfE2Tr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 15:47:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35224 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE2Tr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 15:47:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id n14so3300400otk.2
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=po7nNPdV4b+/ItlBB/fXRxecISnzmHJt6X6owiL7qm8=;
        b=VUV/TH24+FRJuxJNnyr+AjmyvKUjz4FEshfH/A28h+3XyiKxlYhHN/o4simuvwTVH6
         5bNqwjBV+8LwHKZZC/4SRV/Ugc01Y1q6MWeb/zq2+kMx0FXlEVZjMkZWCMxJBCV4RuvN
         u28lWCrKlPI727QqkPdJM0aRgKlpau+iaJC/i7cDC5oCNmvgDmo+gDAklAliZYJ3v5zt
         2wlwNmFjqmpi4fs09d95lyjqQXuU8HsP2W/Q838wVXJZoEax5KHBX//ZDEsU03IjFtcb
         gjk1HiImcD96DT/3dznxGeJd2FuflT1V/E/a+Ef54vPbKJpILqYnd7EWWc5+O5BCt4S3
         aw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=po7nNPdV4b+/ItlBB/fXRxecISnzmHJt6X6owiL7qm8=;
        b=gjnNdx/NRu6pBMa50PrbeV7ePvEigeSNyWCrgRoXF5M83pGHemZW6Jz5oGHdbqkb84
         U2aks170IYV2UxcK2Q1rIpWOUuZuqp8gSy2jlFadwba+U8kdTeyXAxw5+ww6dvV3sjnD
         FyRD6NE5fAqR7k8B3lovIyTdU1yxIeo4NCl2icabxxF4P0mzhekckZwXSPG7w07CJGAa
         kIBXOdnq9AfTsoMvHkQ6xb6ZYTEuD1Go0SH7UH9au/M3d57Bf9eB1ZM07+Brpaf1OQgP
         06zloezXfZV/Dbrkj+fIV08xzAzmgoqeojdIu0YkOM5FYdC3Vy7k00lBcayAxNQ/5tCK
         H0Aw==
X-Gm-Message-State: APjAAAWm4g67Tm8IVGeedky2nSqPx+sO6igZXvqZWRH55xeNbwAc3l70
        xna0BwFPrYbexjEdlr+A9v7p9MOH7DG2SHkHFpeBog==
X-Google-Smtp-Source: APXvYqxbsVRKe9lyZnKmrRME8/o+NSuf6H78hum/ejTHCvM3Xt5ZTKrdg8WXWMD1bfhyz3HdJN4rPpWo9Wtka4SjK7k=
X-Received: by 2002:a05:6830:1283:: with SMTP id z3mr413216otp.228.1559159247777;
 Wed, 29 May 2019 12:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk> <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
 <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net> <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
 <CAG48ez2S+i2wxpWXVGpEAprgY9gtjxyejLfbZtrqu5YOkQ81Nw@mail.gmail.com> <0cd823ca-4733-19ef-c13e-ed5ac8c63a0f@schaufler-ca.com>
In-Reply-To: <0cd823ca-4733-19ef-c13e-ed5ac8c63a0f@schaufler-ca.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 21:47:01 +0200
Message-ID: <CAG48ez0X7rKw-qfZm9i+8OLq7YccBRtV3aF-7hkQsfWaiTbuXg@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 9:28 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/29/2019 11:11 AM, Jann Horn wrote:
> > On Wed, May 29, 2019 at 7:46 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
> >>>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>> On 5/29/2019 4:00 AM, David Howells wrote:
> >>>>> Jann Horn <jannh@google.com> wrote:
> >>>>>
> >>>>>>> +void post_mount_notification(struct mount *changed,
> >>>>>>> +                            struct mount_notification *notify)
> >>>>>>> +{
> >>>>>>> +       const struct cred *cred = current_cred();
> >>>>>> This current_cred() looks bogus to me. Can't mount topology changes
> >>>>>> come from all sorts of places? For example, umount_mnt() from
> >>>>>> umount_tree() from dissolve_on_fput() from __fput(), which could
> >>>>>> happen pretty much anywhere depending on where the last reference gets
> >>>>>> dropped?
> >>>>> IIRC, that's what Casey argued is the right thing to do from a security PoV.
> >>>>> Casey?
> >>>> You need to identify the credential of the subject that triggered
> >>>> the event. If it isn't current_cred(), the cred needs to be passed
> >>>> in to post_mount_notification(), or derived by some other means.
> >>> Taking a step back, why do we care who triggered the event?  It seems to me that we should care whether the event happened and whether the *receiver* is permitted to know that.
> >> There are two filesystems, "dot" and "dash". I am not allowed
> >> to communicate with Fred on the system, and all precautions have
> >> been taken to ensure I cannot. Fred asks for notifications on
> >> all mount activity. I perform actions that result in notifications
> >> on "dot" and "dash". Fred receives notifications and interprets
> >> them using Morse code. This is not OK. If Wilma, who *is* allowed
> >> to communicate with Fred, does the same actions, he should be
> >> allowed to get the messages via Morse.
> > In other words, a classic covert channel. You can't really prevent two
> > cooperating processes from communicating through a covert channel on a
> > modern computer.
>
> That doesn't give you permission to design them in.
> Plus, the LSMs that implement mandatory access controls
> are going to want to intervene. No unclassified user
> should see notifications caused by Top Secret users.

But that's probably because they're worried about *side* channels, not
covert channels?

Talking about this in the context of (small) side channels: The
notification types introduced in this patch are mostly things that a
user would be able to observe anyway if they polled /proc/self/mounts,
right? It might make sense to align access controls based on that - if
you don't want it to be possible to observe events happening on some
mount points through this API, you should probably lock down
/proc/*/mounts equivalently, by introducing an LSM hook for "is @cred
allowed to see @mnt" or something like that - and if you want to
compare two cred structures, you could record the cred structure that
is responsible for the creation of the mount point, or something like
that.

For some of the other patches, I guess things get more tricky because
the notification exposes new information that wasn't really available
before.

> >  You can transmit information through the scheduler,
> > through hyperthread resource sharing, through CPU data caches, through
> > disk contention, through page cache state, through RAM contention, and
> > probably dozens of other ways that I can't think of right now.
>
> Yeah, and there's been a lot of activity to reduce those,
> which are hard to exploit, as opposed to this, which would
> be trivial and obvious.
>
> > There
> > have been plenty of papers that demonstrated things like an SSH
> > connection between two virtual machines without network access running
> > on the same physical host (<https://gruss.cc/files/hello.pdf>),
> > communication between a VM and a browser running on the host system,
> > and so on.
>
> So you're saying we shouldn't have mode bits on files because
> spectre/meltdown makes them pointless?

spectre/meltdown are vulnerabilities that are being mitigated.
Microarchitectural covert channels are an accepted fact and I haven't
heard of anyone seriously considering trying to get rid of them all.
