Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF06ECA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDAA20862
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572720840;
	bh=EiUQFbd4eCzqoWiWRCkqn8pp6zL45XyarvpaXrgunXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GLr1eq89iayqI+lLcKSp0GC+hejZNdPXnf9vm2fbegZAwz93/u/gZOBGPkvJVq7rg
	 ZyONxA9n3S/RUwVoeAMuSFiK20MI4j7byiu4dzexk0izY/1u117bmaEYYIvNVtOQvz
	 HY8Wi1KpnIlSwRdTkoobl89h/mCJC6zWCpaKcY6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKBSyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 14:54:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42503 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBSx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 14:53:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id z12so9440397lfj.9
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFZsrTxHj8UNSOV0MW3iX+ZNPh241BxYI9RJCfbRj4I=;
        b=fwWi36Cjm33TVpJsMKyyeNJuPa+EzO/w2jcz8N5ivZnB2LBgFElTwve7u7JUY1CQlk
         LBP3NYhj8mwMGDKFLZC3aAKJjtxEeb837zFLkONBVlInZ3n9BYz2CiSK5BYhQEqMplN+
         cxbruKuD+a9IFTjckV4CYWfQYTCffHao0G3wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFZsrTxHj8UNSOV0MW3iX+ZNPh241BxYI9RJCfbRj4I=;
        b=CEa4naHZIf7TTYkhNaawXyJWb0E/uxG0kmuCqi/sM+TaffF0gtXUg6HHN/vgINHaUf
         VQqxkFYwdKGzIvzTWnDHuid1s2VTO8slo0ArOFh5jtnsfFtOAGlrdRYwflB+wZxHX5Yx
         ZgjtV7KHw70ZbjrTx2ky66cJ/bUeLhxQU1Cq3GIJBfckK1jorVtoB1U80/wzeTOZkaoM
         AETdvUHQXFmTKnizQ3WIWnIyidlvqq3M8bFqzCrdd1POVQRr9t1ZE2XoSvmCqhx/Rytd
         X+5O2rBNcbZ37r9ABQ2RsO0SMg2ndwng5+8D6AY/qD4yTh+EJY8jHetXuaubQe/kESb7
         hQKw==
X-Gm-Message-State: APjAAAUp+S6C45o9aIMwSPoXLjBWBMQsfhBQjx84wL9ehYLpLkVjeaUF
        CEmOGXPz/vWkWi2dGCIWsj1PJQwdkVE=
X-Google-Smtp-Source: APXvYqwfTVP7mU6pA7xsfuu6Ek2GgRnEo379c6CdMknjNd+CPBcNF1XoKeDzT2GzKHVJ4UDxc4BgnA==
X-Received: by 2002:ac2:508b:: with SMTP id f11mr11188008lfm.116.1572720837244;
        Sat, 02 Nov 2019 11:53:57 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r75sm4421293lff.93.2019.11.02.11.53.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 11:53:54 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j5so9431635lfh.10
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 11:53:54 -0700 (PDT)
X-Received: by 2002:ac2:4c86:: with SMTP id d6mr11465241lfl.106.1572720834124;
 Sat, 02 Nov 2019 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk> <c6e044cc-5596-90b7-4418-6ad7009d6d79@yandex-team.ru>
 <17311.1572534953@warthog.procyon.org.uk>
In-Reply-To: <17311.1572534953@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 11:53:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_X_7JSYT-a3qHrzvuWGMyffDWtQ4n7adBp_fe5w0BsA@mail.gmail.com>
Message-ID: <CAHk-=wg_X_7JSYT-a3qHrzvuWGMyffDWtQ4n7adBp_fe5w0BsA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
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

On Thu, Oct 31, 2019 at 8:16 AM David Howells <dhowells@redhat.com> wrote:
>
> Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
>
> > Similar synchronization is required for reusing memory after vmsplice()?
> > I don't see other way how sender could safely change these pages.
>
> Sounds like a point - if you have multiple parallel contributors to the pipe
> via vmsplice(), then FIONREAD is of no use.  To use use FIONREAD, you have to
> let the pipe become empty before you can be sure.

Well, the rules for vmsplice is simply to not change the source pages.
It's zero-copy, after all.

If you want to change the source pages, you need to just use write() instead.

That said, even then the right model isn't fsync(). If you really want
to have something like "notify me when this buffer has been used", it
should be some kind of sequence count thing, not a "wait for empty".

Which might be useful in theory, but would be something quite
different (and honestly, I wouldn't expect it to find all that
widespread use)

             Linus
