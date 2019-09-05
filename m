Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707ACC43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE820828
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567704019;
	bh=EDI78DfE79jtMzHbcDiogan53CnxHKKFzcCNjHaz6wI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N31kHn3UE7uLfurWO4QuMoXMwQK6Ad0A2extpQl7rgOWjHfZkCB3fhkY7BJw6s7CN
	 L8nvfnbeTOx3NQN2CEnApUlsorIfaxFUUrWbpXoY0ca1EzrD/Y38TkfhLUAHFMcn8h
	 SXybj+AUkInqNFM2z4RUgiukI7zrnJbV+purD5zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfIERUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:20:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34948 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbfIERUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 13:20:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so2711893lfl.2
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KYTdnyfvsSaF6SRrjqwQi9Gt/hCAHZIxAtXY6aZZJ0=;
        b=JGdKASNkgFHvBA05jXqdXX7Gpi6+9NL4cvo+gcNYqUSvjqoKuIvNGkviDlPZtR6WeE
         TlbHiadWjxZKtu9iPHXIVgBm9c/Q2iEzthUZRUK4NhHiCU4gT3Zrwu7Fj6GF8TOr2PYi
         RUy/jSH90pSu65c5M/A/XF8yr8GznFTNLI8nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KYTdnyfvsSaF6SRrjqwQi9Gt/hCAHZIxAtXY6aZZJ0=;
        b=XCPz6XTFVRaZMSTO+ZCy4kwpMSFOhuHkStoT7elMb6g/WKSoRHtzRnOZiSa+kFTNrU
         2y4DnDiIKbJ1joc9xAOI2Ih3Or2dfc8AMZ5J/e43Fa/wX8fgWdSc0jRlu9U7s5VqgMPh
         FLUsyGCu8DhRMkcsvYhp6396af/w5bKwgjCreWx0A3gmAN0fZVwWCml8NPoeu4mX3tHF
         TAUPWdZFjplXtE+rbujgY1Mm3N/7/50kAdU0s91ZEm0bssdr4AQt1K1F5bEQkqdyE7WR
         B2CEdxM/S+P1fdTc7z0ZEGhJluHN8aAsJEQor3LfLV+MnDioYzfHAOCTtNVLh8tqI6XK
         jV2g==
X-Gm-Message-State: APjAAAUcvJ/nFzQxlARUo2I3BFcBs0rchmW4u7wfxVJyWaAbiiAbS3Ne
        K5REjgKKjojK9Zx2P6fryzBxcVidVV4=
X-Google-Smtp-Source: APXvYqxWm1Z2gVMWDCIwTdko6vWP7cKK4eCqygmgA5iuk+VFPiuyJyNaqAOi5gq4zakrtP0PC3FR5Q==
X-Received: by 2002:a19:48c3:: with SMTP id v186mr3184531lfa.141.1567704014937;
        Thu, 05 Sep 2019 10:20:14 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d14sm546395lfi.14.2019.09.05.10.20.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:20:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u29so2683307lfk.7
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 10:20:11 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr3118360lfn.52.1567704010099;
 Thu, 05 Sep 2019 10:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com> <17703.1567702907@warthog.procyon.org.uk>
In-Reply-To: <17703.1567702907@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 10:19:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
Message-ID: <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rstrode@redhat.com, swhiteho@redhat.com,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 5, 2019 at 10:01 AM David Howells <dhowells@redhat.com> wrote:
> >
> > I'm just going to be very blunt about this, and say that there is no
> > way I can merge any of this *ever*, unless other people stand up and
> > say that
> >
> >  (a) they'll use it
> >
> > and
> >
> >  (b) they'll actively develop it and participate in testing and coding
>
> Besides the core notification buffer which ties this together, there are a
> number of sources that I've implemented, not all of which are in this patch
> series:

You've at least now answered part of the "Why", but you didn't
actually answer the whole "another developer" part.

I really don't like how nobody else than you seems to even look at any
of the key handling patches. Because nobody else seems to care.

This seems to be another new subsystem / driver that has the same
pattern. If it's all just you, I don't want to merge it, because I
really want more than just other developers doing "Reviewed-by" after
looking at somebody elses code that they don't actually use or really
care about.

See what I'm saying?

New features that go into the kernel should have multiple users. Not a
single developer who pushes both the kernel feature and the single use
of that feature.

This very much comes from me reverting the key ACL pull. Not only did
I revert it, ABSOLUTELY NOBODY even reacted to the revert. Nobody
stepped up and said they they want that new ACL code, and pushed for a
fix. There was some very little murmuring about it when Mimi at least
figured out _why_ it broke, but other than that all the noise I saw
about the revert was Eric Biggers pointing out it broke other things
too, and that it had actually broken some test suites. But since it
hadn't even been in linux-next, that too had been noticed much too
late.

See what I'm saying? This whole "David Howells does his own features
that nobody else uses" needs to stop. You need to have a champion. I
just don't feel safe pulling these kinds of changes from you, because
I get the feeling that ABSOLUTELY NOBODY ELSE ever really looked at it
or really cared.

Most of the patches has nobody else even Cc'd, and even the patches
that do have some "Reviewed-by" feel more like somebody else went "ok,
the change looks fine to me", without any other real attachment to the
code.

New kernel features and interfaces really need to have a higher
barrier of entry than one developer working on his or her own thing.

Is that a change from 25 years ago? Or yes it is. We can point to lots
of "single developer did a thing" from years past. But things have
changed. And once bitten, twice shy: I really am a _lot_ more nervous
about all these key changes now.

                    Linus
