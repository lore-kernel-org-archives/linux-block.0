Return-Path: <SRS0=tn0U=Z4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CEEC43603
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242B22245C
	for <linux-block@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575670510;
	bh=9JvzwEgsdxYVt8s8RLOPMbFdcSuM2dK1YoTcGfh72pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0JMpds2/M+dJJ9MwRCQLofvZFMlKcABp9uqyPtX1I42HFD9uqujhBm4NxsFcSj74b
	 qwGyl1rN3YlldSLuBD2GiR8S42fmmb3G/R96TjL5Av9BtxBq/YKMN8NVL5URc9ut8s
	 Ouzn1lqdQWztr2+ALLoa+Em7Hg8a6bBwfjoY+JI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLFWPJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:15:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43669 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLFWPG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Dec 2019 17:15:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so6382127lfq.10
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2019 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0XBsU0Zwa7k+dx/SYcO/cC8TsFqFe7ap7E70c7vInU=;
        b=bTZdKzPiqpVSRlIEKZEGDMlBYxFAfG1XtbiNaTYxkA8G285Eux5gFHDmaTnJC4iPE5
         o8N7+YD5Z1tWk70yIvruVU0BeSE3YsKa/iMNxQrsM+BsOw2M95U/kwIKkGhLzao/qQKm
         h/+JfuStPH6oZCReJIpg2utxtMnd/SwjidQvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0XBsU0Zwa7k+dx/SYcO/cC8TsFqFe7ap7E70c7vInU=;
        b=MVy5TQyNc9NZygb6x9sOj1DzHYGwMPu7GU7+47zxFKFk5bxN+FkckQlAK7JUT85nXd
         zcczoS5r+IBICCFQAGVgzlYNAjvjGfY/cVKwjoA+cl7YxDhd52mqznYprs9K5eJAhyZz
         8sRQ1i5eSzT0UndmCDpTRgjZibGklcbmpg5c4hpH4HfKmx2Gvv8tzC+qYqOV2SqbRKeC
         VkELRQELVP69pHKEZaNXgolWaYdDQA4VPxyEtWoJ6ESRtIip0+mXO0JaCdbngVESbY9k
         vH0JGN6lFn+GYVu7iAONJm0C31WEUw6YN9bRkegLXCxCmCAi84kp7pjBg5n5QrSlTVJT
         eP7Q==
X-Gm-Message-State: APjAAAWYgdYUuPBFUVjZTgDGDiZrABjhkpVGKQWEZiYqFD+em9AqFc0h
        txHYMJNCcBjiyBajBYfaj2RUnB3p2uY=
X-Google-Smtp-Source: APXvYqw0lcraW83cBW6emvTDDBhPmENZOtrPBvVftmDgtf9ZSNCpILjZjarFrdZglfRz+IecX44JaQ==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr5104741lfc.111.1575670502923;
        Fri, 06 Dec 2019 14:15:02 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id b22sm7492894lji.66.2019.12.06.14.15.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 14:15:01 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id y19so6371062lfl.9
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2019 14:15:01 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9167196lfk.52.1575670500889;
 Fri, 06 Dec 2019 14:15:00 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk> <20191206214725.GA2108@latitude>
In-Reply-To: <20191206214725.GA2108@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 14:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Message-ID: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 6, 2019 at 1:47 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> This change breaks firefox on my system. I've noticed that some pages
> doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
> start loading and than stop. Looks like firefox is waiting for some
> dynamic loading content. I've bisected to this commit, but can't revert
> because of conflicts.

Can you check the current git tree, and see if we've fixed it for you.
There are several fixes there, one being the (currently) topmost
commit 76f6777c9cc0 ("pipe: Fix iteration end check in
fuse_dev_splice_write()").

I _just_ pushed out that one, so check that you get it - it sometimes
takes a couple of minutes for the public-facing git servers to mirror
out. I doubt that's the one that would fix firefox, but still..

               Linus
