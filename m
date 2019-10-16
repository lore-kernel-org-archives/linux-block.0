Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D19FA3728
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96D420854
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571240340;
	bh=n2NOvEYEqv4lSGUyIJF666vrlhz9L9BzoevNrWqRz9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y/Gg9fFBn0euvjmtRNh22PRsxa8hBzmh5gJo14LGAz7XESgUr/huSbqsT01AGYNX8
	 1bWtYcGsBBE7Q8fbtmpCNtFboh0Q0RxVmIzU2m9okO76gSJwAX8Boum7MncCRI/SVy
	 Co2C2Nzh2YHQGYDyFbPCiGHjo5/Gq70on7tBPDFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfJPPjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:39:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36554 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJPPi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 11:38:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so5300147lfq.3
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2019 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4sUXBF9N+gOqGoXUSe/0E2VksmAjHdkiv7KSR2ftGI=;
        b=KN++Zn81C01LK7bngv2WQhecCB2pvDWa6MiPOCNK9giCb55GzPd38NprLWCi9y4Rmp
         G5JVpEFhN07gxtvQKkcodZ0c/iin5yb7op+6svXAeHTJxJPM5HZz2LuFX2hGczINIWnp
         zjAlhPJ3IIlR8ZNhwPZ4TPeH42AI6XYGcDMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4sUXBF9N+gOqGoXUSe/0E2VksmAjHdkiv7KSR2ftGI=;
        b=PwYk7QCSilfDxpfgV3huzaSkYTDHfmBFY/a7cjUax/5CpONwQtFIupJJ21uYvKWpdE
         CrXQzCxx6n82lfWT1oNDkDSL0tsVacaGRgijEJrIjFlQVlyGZYkTL85Hx2jZu60wNvYE
         qZyN//Iq16gDkkJM2dBn1SAOSIMbREQJfrJn453nddk/Ou6u8J6qlukgw/JqO5Yetr1T
         2xxywTcjZCUZbyvpyL7yM6a1YV83hrgdzM72mHLC8CmPbVWUuPrDbtXmzEoVYQAeGvLE
         nmZvKvqRcTHSbByrY2L28+Lf9eJFz87tOu20G+rU9SRjrgxgxvX1QJo0INcF2i/4P+1V
         b3hA==
X-Gm-Message-State: APjAAAUhgaVwiFbDFpDmq2GW31p3dZAbEwFH51/oAvWKnImC9XlCIZ/t
        OkQDv1LxjvQxx1Ke7d5+PAOjUs4CjeE=
X-Google-Smtp-Source: APXvYqyyKcBfqvOHayMo4qSAgOHIKCVCy3qIFuRqO3c3bMDVFUWaFGt/9GqyXqSjU5f+JxXk0CDQdw==
X-Received: by 2002:ac2:5924:: with SMTP id v4mr25231671lfi.22.1571240337540;
        Wed, 16 Oct 2019 08:38:57 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b7sm6151723lfp.23.2019.10.16.08.38.57
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:38:57 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id b20so24533686ljj.5
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2019 08:38:57 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr4189350ljf.133.1571239925218;
 Wed, 16 Oct 2019 08:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
 <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com> <6900.1571235985@warthog.procyon.org.uk>
In-Reply-To: <6900.1571235985@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Oct 2019 08:31:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMZR8TWpmRBPytGmWJX=C=-bCb5D2PsCx0LUNemAPexA@mail.gmail.com>
Message-ID: <CAHk-=wgMZR8TWpmRBPytGmWJX=C=-bCb5D2PsCx0LUNemAPexA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
To:     David Howells <dhowells@redhat.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Oct 16, 2019 at 7:26 AM David Howells <dhowells@redhat.com> wrote:
>
> Btw, is there any point in __wake_up_sync_key() taking a nr_exclusive
> argument since it clears WF_SYNC if nr_exclusive != 1 and doesn't make sense
> to be >1 anyway.

Ack, looks sane to me.

We have _very_ few users of nr_exclusive. I wonder if it's even worth
having at all, but it's definitely not worth it here.

I'd love for nr_exclusive to go away and be replaced by WF_ALL
instead. Right now it looks like there is one SGI driver that uses it,
and the sbitmap code. That was all I could find.

Oh well. You removing one case is at last a small amount of progress.

         Linus
