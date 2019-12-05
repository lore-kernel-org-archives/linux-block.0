Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B83C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CCC24671
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 20:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575577639;
	bh=HBx+Fd/NT+SDbzqqeb4YRELFUwI5g02zAAe+CpFWWPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GUfq+OgOb/G0ZQcDlG3JY9RijI3qUgY+nuJDiyjnUpUc2bsKJhfz+Ayto3FAB35F5
	 YwT1zmFss9izmskR4odbBra47y5Wj9afw5aCEVZYtmCgG+PRBGStfaMh4ntxIqLLOV
	 d1qSBzlo82AVxLw3+XQvJZ/UGU3Uc+BeBRqnP37k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfLEU1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:27:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41926 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfLEU1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 15:27:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so3481373lfp.8
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2nboj5xrRkV1yqHjA0Aj2mbWgmjh4x0SrJcMaszVtA=;
        b=TY6MoxQFBEklRwMxXtPk7pq3Wq5Rwa2J/YtugYsq/w1lH9+ERuu6f1+z8+8JuKIiKx
         YDkuPczmV+9Qf+ENZhlePKKmJs1rLUEQ7rx1SKksdo9OxMTgxyWfNyX7ZM9ZSUbccBnx
         JYw40/VtEd257BEbFslSJIyKBygobO7WiYq+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2nboj5xrRkV1yqHjA0Aj2mbWgmjh4x0SrJcMaszVtA=;
        b=o7GVL17IhNwxOn22FK4kpI76SMYO7BoVGt0YgehB0+xF7TgmRfwGRXsw4NfP+fyPEb
         JiDFRTeBYp1ra3jExqQKRP8w7LIe3G7wPBtuogUEMGkgqUX1OhWKG3R32uz4xEMQ3Ivj
         QM6hK5IbaUW3qaCDqufsBfZv6oiPKJJDdxQ6dQ9JG/8CKGT1MJwLQJD1guspBkOZdAnX
         odLdhlBQZKEUsOn0tr+4ArpQeY5VcE7oM1RGj3m6/PC6emHlfcD+uTdkYZk91qBAQlJi
         gqNkVrwVXBiWZxKEZzUr/WrbDII9MMCE18sg7626QK9wzM5YROjx/HxQIwhG6kvQIJuy
         Y+Lg==
X-Gm-Message-State: APjAAAXRlh5sCIBBRzg76fxrNpW1Hm6sJUt2CVOG2580b4P/tPWZ6vm5
        BqZFKoD6GsUrnREpUridn6GaYvzqzVk=
X-Google-Smtp-Source: APXvYqy23Q8drbzhdmKIL5WWg6RvMi+ds5e/ikSXzUbi+aVfX+aoMOL13/bKZcZj/BlTaNLM5a/Yjg==
X-Received: by 2002:a19:f514:: with SMTP id j20mr5752743lfb.31.1575577630936;
        Thu, 05 Dec 2019 12:27:10 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m10sm5572474lfa.46.2019.12.05.12.27.09
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:27:09 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id s22so5086483ljs.7
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 12:27:09 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4294750ljn.48.1575577628995;
 Thu, 05 Dec 2019 12:27:08 -0800 (PST)
MIME-Version: 1.0
References: <31555.1574810303@warthog.procyon.org.uk>
In-Reply-To: <31555.1574810303@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 12:26:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+_n63ps_-Rvwgo4S7rd2eLAVcJwbZee7iHZaO+1hvYQ@mail.gmail.com>
Message-ID: <CAHk-=wj+_n63ps_-Rvwgo4S7rd2eLAVcJwbZee7iHZaO+1hvYQ@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: General notification queue
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
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

On Tue, Nov 26, 2019 at 3:18 PM David Howells <dhowells@redhat.com> wrote:
>
> Can you consider pulling my general notification queue patchset after
> you've pulled the preparatory pipework patchset?  Or should it be deferred
> to the next window?

So it's perhaps obvious by now, but I had delayed this pull request
because I was waiting to see if there were any reports of issues with
the core pipe changes.

And considering that there clearly _is_ something going on with the
pipe changes, I'm not going to pull this for this merge window.

I'm obviously hoping that we'll figure out what the btrfs-test issue
is asap, but even if we do, it's too late to pull stuff on top of our
current situation right now.

I suspect this is what you expected anyway (considering your own query
about the next merge window), but I thought I'd reply to it explicitly
since I had kept this pull request in my "maybe" queue, but with the
pipe thread from this morning it's dropped from that.

            Linus
