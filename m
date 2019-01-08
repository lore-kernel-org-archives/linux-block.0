Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20072C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 07:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5C2087F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 07:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFIQnkDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAHHGi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:06:38 -0500
Received: from mail-vk1-f182.google.com ([209.85.221.182]:33667 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfAHHGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 02:06:38 -0500
Received: by mail-vk1-f182.google.com with SMTP id d201so664406vka.0;
        Mon, 07 Jan 2019 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQM6khskQIeEmRfxZTuTbZZte1lnAveX0wU/7msS24Y=;
        b=DFIQnkDDkwKxUgn3G2RScT7rNXiUnpxFhDp6+HuqOaEj5KSHX1ftp4B9SvILv5JAG6
         vUTSQJ3cwjNfIYrRdXOIxc2Ij9qzKFWf2CXWHEpH8WMEPP7oXws6qaSAy7CmAmeTcpvA
         +CCJqEKfsQT8yAXdzowoAE0KvwE1JZCx6D+ytG6fJKz89Bz8/BWw/Ej666cBcP4iTGA5
         XP6kwLmIzfp/iebgmfSicSnkXZjarZ7V5HOZuuBWnWalFB/249uPDY0PG1mgr0NLoIg8
         lnms+34364eA1HzBkfFCSep1vTjMc0awW1IcYulFJny0Wm9t3NeFuBsq9GyMXRGJxNEZ
         PfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQM6khskQIeEmRfxZTuTbZZte1lnAveX0wU/7msS24Y=;
        b=D5dOg1xtOwIUoqOvH2LsFlEQKX+dJDvnZPwUDkXy3UT4X+UAqtfgZkgXs6up2Sg+3Y
         lAabEk1VouVkdxLW1wtWgncInH8vR1d7IOc7BZj212BdB7gixw5ig0UI61r6Mowxc98R
         AomBQM8HhNDd39zh4Ksn67yEjvgeq//IeMVtCR1Pb5RzfK3Iv/1dAY5QbsajhsMVxov7
         9bLBiiVta/0Ow+/MyxuFdGRgg0aECWbhZ/SLtXdcDGyk+FTtfQU+9b71fEF3419EWQjW
         hrhTMXm/rX41mwd0T660MDgMNu6SFIMXLk6l3Q6df95lu9bKM5/nXuktG6DTthWjcA8v
         Z/kw==
X-Gm-Message-State: AJcUukfiXEKgVviSLx0u71YhKvlg+cHc04Tqmg4Y+c2D3S4np1Wcwwzx
        jwA17cnduoz3tV5pXm4rgT2NhGy6ZkTbvMPXZe4=
X-Google-Smtp-Source: ALg8bN40agLBMdpNYWQoF9UYR75/JrPQd38npPO4W3EXwBJWLj5lNRLANbWnG6CVNk8LR6GiCYN6Zb5WRb+BGpHjp7s=
X-Received: by 2002:a1f:6b14:: with SMTP id g20mr203794vkc.47.1546931196460;
 Mon, 07 Jan 2019 23:06:36 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
 <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
 <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com>
 <1546548458.24199.2.camel@redhat.com> <CALjAwxhOb_HLD1Adux-n0LUienLK_FhrOnyBw=UMLj49aN6_5A@mail.gmail.com>
 <1546555220.2666.1.camel@redhat.com> <CALjAwxgtCGLEJkV3xw4Amp4gdkuacgmTVkYn=w8ZHucJ6ffDew@mail.gmail.com>
 <4c231a3e-1ae3-c872-f6f8-06b19ddfd20b@suse.de> <CALjAwxiaVRpqgxs4rtjxDM4J5YDnrKAyCwn79h5tdhxwZX8iTA@mail.gmail.com>
 <b7ab94d7-8282-425a-3dcd-38a538a44d24@suse.de>
In-Reply-To: <b7ab94d7-8282-425a-3dcd-38a538a44d24@suse.de>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Tue, 8 Jan 2019 07:06:10 +0000
Message-ID: <CALjAwxjaffzBMSEC=R1ftW1upb2LZWuYinOxORGGUU9THm4vbA@mail.gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     Hannes Reinecke <hare@suse.de>
Cc:     Laurence Oberman <loberman@redhat.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 7 Jan 2019 at 08:46, Hannes Reinecke <hare@suse.de> wrote:
>
> On 1/7/19 8:41 AM, Sitsofe Wheeler wrote:
> > On Mon, 7 Jan 2019 at 07:17, Hannes Reinecke <hare@suse.de> wrote:
> >>
> >> On 1/4/19 8:33 AM, Sitsofe Wheeler wrote:
> >>> Blimey Laurence - you're really pushing the boat out on this one!
> >>>
> >> [ .. ]
> >>> I've yet to attach the disk directly to the mobo. It's a bit fiddly as
> >>> the most accessible port is meant for the DVD drive and I think it's
> >>> speed is slower than the others.
> >>>
> >>> The speed of the ATA ports is lower than you might expect (this
> >>> machine is fairly old):
> >>>
> >> [ .. ]
> >>> [    3.242623] ata2.00: FORCE: horkage modified (noncq)
> >>> [    3.242683] ata2.00: supports DRM functions and may not be fully accessible
> >>> [    3.242686] ata2.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT01B6Q,
> >>> max UDMA/133
> >>> [    3.242689] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (not used)
> >>> [    3.245518] ata2.00: supports DRM functions and may not be fully accessible
> >>> [    3.247611] ata2.00: configured for UDMA/133
> >>
> >> 'slower' is an understatement.
> >
> > Are you surprised that there would be such a dramatic difference in
> > the speeds between the two SSDs (Samsung 860 EVO, Crucial MX500) on
> > that particular workload in that same machine?
> >
> Not at all.

Fair enough :-) My understanding is that both SSDs (when unloaded and
mostly empty etc) would be far faster than what this particular
machine could do but I stand corrected.

> >> That adapter can't do NCQ, hence 'WRITE FPDMA QUEUED' (which _is_ an NCQ
> >> command) will never be issued.
> >> So I'd be _very_ surprised if you still see this problem there ...
> >
> > I'm curious, why would using the libata.force=2.00:noncq kernel
> > command line (only mentioned in my very first mail) make using that
> > drive more stable if the adapter could never accept that command
> > anyway? Shouldn't the sending of that command have been disabled if
> > anything along the way can't actually accept it?
> >
> 'WRITE FPDMA QUEUED' will ever be issued if the drive _and_ adapter can
> do NCQ. As this is the offending command it's not surprising that
> switching off NCQ (and hence the use of that command) will make the
> machine more stable.
>
> Although I'd be curious about the 'more' bit in 'more stable'.
> I would have thought that the machine would be stable after disabling
> NCQ; do you still see issues after disabling NCQ?

I was inaccurate when I said "more": it has been totally stable since
disabling NCQ on that port.

> As for the NCQ issues: it might be that the adapter has issues with NCQ
> (quite some older adapters do).
> It might also be a problem with the _previous_ command which failed; can
> you enable libata tracing to figure out the command flow?

OK I'll see if I can get around to this one tomorrow.

Cheers!

-- 
Sitsofe | http://sucs.org/~sits/
