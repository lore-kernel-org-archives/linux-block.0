Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF9C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE53D214F1
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 19:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WROg5CNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE53D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeKOFmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:42:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:32787 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOFmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 00:42:20 -0500
Received: by mail-it1-f195.google.com with SMTP id p11-v6so16995339itf.0
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zHw3q9Fm18/M2SA7bef7eEbM5kOwpfiMqTi4go80ac=;
        b=WROg5CNQqk0k8vo50BDdeGBQRnfqVkgHUio96SkAFPc1PcuDwklkE3YDv8aVaHoqp4
         cpNv1p3LsLPK/xDsKSESakDejv0GiP/y8k1DG5dZr5fiH/VzSZLLyCk24lQCXIvtG6+C
         hnnIOC0zMbzilmH8KlNaJIiJLqLcG+pYu9irE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zHw3q9Fm18/M2SA7bef7eEbM5kOwpfiMqTi4go80ac=;
        b=nQ60Dh9eHBGJLxvwvN8PZFaTiZ2foHVzKh5eX0gpFjPF2svu5IolzD0Oprizc6VgVg
         tA48BPVJDJkCJUfBcdZ7tKY/Zouowsxctb3kwxl3IjK6Ggu9DtpsqQziV7IZcosQzVcJ
         WVMg7NfVJlEf3KytwQoHW+NujRjTmk4Otiq2SkqW8LjXJwDIfaZb9rH7cz4H5uGm81WD
         IpLxEgHlmqhubMYeURaSUzEWC9oaLhTb6mW8q97wG1aGTGQuQnzBazkkxUq5M+h0E1qj
         RXezt7D2+cGHX4ZVJj5TMyKEBG2b8r8GOBcn6pIsJtp+dIke3znFc9zi/3b9E+a4jE0a
         ulqw==
X-Gm-Message-State: AGRZ1gJDS1xhSrEk+lt+6n2tTlGi+hFMQFPAwj7+0mrJn75/bhfHqaUj
        oJ7ey9ukgiI3LDHlGHu3IyzPcjV+vnMw14wLUSVyWWSdj5k=
X-Google-Smtp-Source: AJdET5eMJDsR4Sl8BMTj2qZEO1QXbYbfkZFehEM2GarZGKhRXr6tsqX4dPraNRW5YjLWUA9sCzpoTK9iGGpxm4at/bU=
X-Received: by 2002:a24:2c1:: with SMTP id 184-v6mr3090205itu.100.1542224266943;
 Wed, 14 Nov 2018 11:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20181109151524.50405-1-gwendal@chromium.org> <20181114182610.GB3253@vader>
In-Reply-To: <20181114182610.GB3253@vader>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 14 Nov 2018 11:37:35 -0800
Message-ID: <CAPUE2uuGz5qOZ0aFVsuATPqt3XCtmj_nSd0rE44wpihRPzkskA@mail.gmail.com>
Subject: Re: [PATCH blktests] makefile: Add install rule
To:     osandov@osandov.com
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 10:26 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Fri, Nov 09, 2018 at 07:15:24AM -0800, Gwendal Grignou wrote:
> > Add rule to install to a target directory, /usr/local/blktests by
> > default.
>
> This seems reasonale, but I'm curious, what's your use case?
I will use blktest to check chromebooks kernel. ChromeOS is using
Gentoo tool like emerge to [cros-]compile a package that is then
integrated in a [test] image.
You can see the ebuild I am currently using for building a blktest
package at https://chromium-review.googlesource.com/c/chromiumos/overlays/chromiumos-overlay/+/1329948
It needs an install rule to move the tests and common file from the
source directory to the destination directory we will use to produce
an image.

Thans,

Gwendal.
>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  Makefile     | 9 +++++++++
> >  src/Makefile | 3 +++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 38b8ad1..d7c2b74 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,9 +1,18 @@
> > +prefix ?= /usr/local
> > +dest = $(DESTDIR)$(prefix)/blktests
> > +
> >  all:
> >       $(MAKE) -C src all
> >
> >  clean:
> >       $(MAKE) -C src clean
> >
> > +install:
>
> install should be added to the .PHONY targets.
done
>
> > +     install -m755 -d $(dest)
> > +     install check $(dest)
> > +     cp -R tests common $(dest)
> > +     $(MAKE) -C src dest=$(dest) install
>
> The src programs need to be installed to $(dest)/src.
done
>
> >  # SC2119: "Use foo "$@" if function's $1 should mean script's $1". False
> >  # positives on helpers like _init_scsi_debug.
> >  SHELLCHECK_EXCLUDE := SC2119
> > diff --git a/src/Makefile b/src/Makefile
> > index 15c1022..f0ddbb5 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -20,6 +20,9 @@ all: $(TARGETS)
> >  clean:
> >       rm -f $(TARGETS)
> >
> > +install: $(TARGETS)
> > +     install $(TARGETS) $(dest)
> > +
> >  $(C_TARGETS): %: %.c
> >       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
>
> This ability to install tests could also use a mention in the README.
done
