Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655BC00307
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E4021670
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567785210;
	bh=mpgGkKCrnRxhITt5MelQZFoxgsQdwiTo40PnPEOkVf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tBaSEim88v420zl+oDaGAPJ/WSAmnVLEqfh4if6uDjp9iA7+Nsf3ewCrynq5IQEDm
	 9+mBAO/CIga/2tzbbjPWVKZYMctYsF1UYVHzdhLgq3tQxeeXwn+4E+PtOfB84wgANW
	 oER9Ps7mrsl34wMazbP4F2qjbMMvDSxiwzw/g0oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbfIFPx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:53:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42306 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfIFPx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 11:53:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id u13so5443978lfm.9
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLIGvVtM1MWun0WWtqWDQtU9G8VMp6qsOxjP6sOjf2I=;
        b=Ia8xZ4G7EXG0h3CEDdsSAnGPbD1nnF6pet2NWhAAqHOXPjQLBhaQh07F0TSGTC2pQA
         4aORuaabR+7VQbbIPbEwZhlj4N84fOFkTe7F+AH5iR91RRW0/A+v490l9anWhBNdAZMu
         chcmmRDkVHmVtn5FD+klXo/q67grBESatc/HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLIGvVtM1MWun0WWtqWDQtU9G8VMp6qsOxjP6sOjf2I=;
        b=VUyq+jAPCh/dr+t8hIOZxnJHGtRtP3rYA4Q+D/uFrJnnj2TBUKO5l7+xJlPVCjLcVF
         EuoiqkZiQCGImQGmg0wpXMbCz5xRI+rA08aWiXqSQTrGGJgnM7ZSzo8TY8kF6DATR+nS
         EiaOETg9+sSecc8Gf+FUSmfu4ZZ6RMmEKCcNn7bJxKuBIyf3XcPVvPxr8mPDDzx959J6
         ffFCjFOgGhCOWbyvv3dgmFlwv6k7eRrLQcJOA54Yyr+es6OV0H8waZCBfirV4cycMUW5
         I8era83EebE4vkCBoy2H4mODCV6edGftbKUNlLICEmaFt4Z6QazpI3wxIzuQo/MJOVn9
         QsNw==
X-Gm-Message-State: APjAAAVHkFTtpFQI6O9VxYBH1lKkE1rUpUHim7nHac8+SfL0mdD3teQd
        Xzy0S3Sp5bAvM8GyxjFGUBB97aDA6Lo=
X-Google-Smtp-Source: APXvYqzUuaZ05c21P4Z9i3vaHriGshl+u4px4pgfkHmSSnUmDJCiX5cqIvBgEGnxwXVuOD9HwUBBFg==
X-Received: by 2002:a19:6008:: with SMTP id u8mr4126307lfb.12.1567785206789;
        Fri, 06 Sep 2019 08:53:26 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 3sm981117ljs.20.2019.09.06.08.53.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:53:25 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id l20so6478497ljj.3
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 08:53:25 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr6334227ljg.72.1567785205260;
 Fri, 06 Sep 2019 08:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk> <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
In-Reply-To: <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 08:53:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
Message-ID: <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 6, 2019 at 8:35 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is why I like pipes. You can use them today. They are simple, and
> extensible, and you don't need to come up with a new subsystem and
> some untested ad-hoc thing that nobody has actually used.

The only _real_ complexity is to make sure that events are reliably parseable.

That's where you really want to use the Linux-only "packet pipe"
thing, becasue otherwise you have to have size markers or other things
to delineate events. But if you do that, then it really becomes
trivial.

And I checked, we made it available to user space, even if the
original reason for that code was kernel-only autofs use: you just
need to make the pipe be O_DIRECT.

This overly stupid program shows off the feature:

        #define _GNU_SOURCE
        #include <fcntl.h>
        #include <unistd.h>

        int main(int argc, char **argv)
        {
                int fd[2];
                char buf[10];

                pipe2(fd, O_DIRECT | O_NONBLOCK);
                write(fd[1], "hello", 5);
                write(fd[1], "hi", 2);
                read(fd[0], buf, sizeof(buf));
                read(fd[0], buf, sizeof(buf));
                return 0;
        }

and it you strace it (because I was too lazy to add error handling or
printing of results), you'll see

    write(4, "hello", 5)                    = 5
    write(4, "hi", 2)                       = 2
    read(3, "hello", 10)                    = 5
    read(3, "hi", 10)                       = 2

note how you got packets of data on the reader side, instead of
getting the traditional "just buffer it as a stream".

So now you can even have multiple readers of the same event pipe, and
packetization is obvious and trivial. Of course, I'm not sure why
you'd want to have multiple readers, and you'd lose _ordering_, but if
all events are independent, this _might_ be a useful thing in a
threaded environment. Maybe.

(Side note: a zero-sized write will not cause a zero-sized packet. It
will just be dropped).

               Linus
