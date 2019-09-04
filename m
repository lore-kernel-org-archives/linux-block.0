Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF6C3A5A9
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9196422CED
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 22:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567636108;
	bh=uDOuymAhR3WDG7e7vxkKlX8QlIfAIuOQLJ96dDSevFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q2pcGEirqq0on+M4M3N/fC8OH+w0zZaS4UDix90wkWkb/zgdlQK7342DL3X2Hx/TD
	 y1ubZfVr8p0Boq4b5jqfmAxKbPGAsg6L/IdYU4d2xtJCwbA1sT25GtIrmdg2Lo9D+i
	 s6Ftdx0aEqTtdlJ4hgTkO3X1ev20EX+sNUFFv5k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfIDW21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:28:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43913 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbfIDW21 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 18:28:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id q27so275291lfo.10
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2MMR8Y9nF2WKJ/GwXu7Orie3221sa5b9mT2pSMScP0=;
        b=fJ3Uw5l+iJ6RQgyGxaGpdfmIjWnE5F6x31rjDuCqfKxB8VAjbqJtmAWjWR9quPy177
         kSc2B1tiYJnm6N1rDryl38O0XT+KrCxDR5lxJB7HlM5pTNWW6oATfW3XbXy7OWukzkZ2
         g/kQFWidQUGLu16LN7J3E3MLC7X6Q8WHam9qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2MMR8Y9nF2WKJ/GwXu7Orie3221sa5b9mT2pSMScP0=;
        b=cTte3SvbsjWSDEQj3OysU73eZrj/KAMoUikZrmSk98WZD2sT0l7QCyDDjA9ky0J5de
         QDa5XpySEPAgFVfTMv/szsFjq5WAs7Zifw7uxQtCgLl3rXNLwcAQB8fZg7uqj2xIiylL
         ozpX2JmcnsReCERwfUeghteVYjQFAzSi/KoPIAoRll/gFcl11K5/GQ1SWJjdJbPMXL46
         +PfP+mdNa63u4qYplCsRgHEo1lsAva83tjj1LwDQFe78MIiSmdGGhslS9PmW6y9PBpI1
         nOeqfsnu/2JcKiCpvcVV2nklJMPEhByFuuFN+VxYDz3Lt+e2GH7CuDVYnukldAR1uqHd
         y/7A==
X-Gm-Message-State: APjAAAXHg1kbJvndjxMOQSKm2Uq4TdsA0ifM8etIlgoAXXTdzc4d1qJh
        pfnq5PAni7EnN2ngXYwUNtUeyyHT4O0=
X-Google-Smtp-Source: APXvYqzKVHNcDRmOnO9ime3b0/F/FoZ1nqiK8Ijv0DNy5i+0idhP1DyI6OSCc1Py2n4Ohjm635NvyQ==
X-Received: by 2002:a19:381a:: with SMTP id f26mr253643lfa.168.1567636104750;
        Wed, 04 Sep 2019 15:28:24 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m23sm38224lfl.62.2019.09.04.15.28.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 15:28:22 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u14so286155ljj.11
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 15:28:22 -0700 (PDT)
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr7069ljo.90.1567636101831;
 Wed, 04 Sep 2019 15:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
In-Reply-To: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 15:28:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
Message-ID: <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Keyrings, Block and USB notifications [ver #8]
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
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

On Wed, Sep 4, 2019 at 3:15 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Here's a set of patches to add a general notification queue concept and to
> add event sources such as:

Why?

I'm just going to be very blunt about this, and say that there is no
way I can merge any of this *ever*, unless other people stand up and
say that

 (a) they'll use it

and

 (b) they'll actively develop it and participate in testing and coding

Because I'm simply not willing to have the same situation that
happened with the keyring ACL stuff this merge window happen with some
other random feature some day in the future.

That change never had anybody else that showed any interest in it, it
was never really clear why it was made, and it broke booting for me.

That had better never happen again, and I'm tired of seeing
unexplained random changes to key handling that have one single author
and nobody else involved.

And there is this whole long cover letter to explain what the code
does, what you can do with it, and what the changes have been in
revisions, but AT NO POINT does it explain what the point of the
feature is at all.

Why would we want this, and what is the advantage over udev etc that
already has event handling for things like block events and USB
events?

What's the advantage of another random character device, and what's
the use? Who is asking for this, and who would use it? Why are keys
special, and why should you be able to track events on keys in the
first place? Who is co-developing and testing this, and what's the
point?

Fundamentally, I'm not even interested in seeing "Reviewed-by". New
features need actual users and explanations for what they are, over
and beyond the developer itself.

IOW, you need to have an outside person step in and say "yes, I need
this". No more of these "David makes random changes without any
external input" series.

                 Linus
