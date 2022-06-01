Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32EC43334
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 23:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiFAXKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiFAXKj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 19:10:39 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD6B4FC66
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 16:10:38 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id hh4so2307224qtb.10
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 16:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3BL2j27uOeKUjZvjS9fDhhPdKAKOn2fyQ3uqHAJSWmw=;
        b=1XE3XaZQnL/7BITd9IJf/mS/vZp2RjAQ9IqGFxGD6ruaTylpeJNYMB/itf7nuWirko
         gGPnAA+1JabIglg9HyOCE4QGErItgqtTHNlvtPOHWKu0zrWv47JHCkNVqe964lm3/XwL
         IwRhRPw7sBbbRMJ/77TdMa8fkDinAarHJg7O9vT3gndJmNAA5CLhgJSlCah8pTD8/MnF
         YTh8jgqYua7jMLuRP548NJiGCAb3qaDFpfPdBsg8N71abG/zHiWtfy2ygTh8Ib9Vyu1j
         4XcXhXUaFsR/P46dR+Dn6m11c3Uddb9H0doAIP2ZZoXn7g1/Sq6oA7XxClY2GUqre1Sv
         nmcA==
X-Gm-Message-State: AOAM530P2a8q3ctvatc+Cg53uB+0IZUGc4WY1C6Kp2MGYLL+lx/iZi5q
        QLFcJsKURmkFqh7QCs+cTK1O
X-Google-Smtp-Source: ABdhPJxDP8Use9lg+iACzkQhLsjrYAfgKdP6/Xd1MUjR7GEHLk4x+Yr8dJBFQe84kuV1GR8lB+i1tQ==
X-Received: by 2002:a05:622a:1452:b0:304:5453:fa43 with SMTP id v18-20020a05622a145200b003045453fa43mr1722231qtx.297.1654125037749;
        Wed, 01 Jun 2022 16:10:37 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05622a480b00b002fbf0114477sm1949883qtb.3.2022.06.01.16.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 16:10:37 -0700 (PDT)
Date:   Wed, 1 Jun 2022 19:10:36 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Sarthak Kukreti <sarthakkukreti@google.com>,
        device-mapper development <dm-devel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [git pull] device mapper fixes for 5.19-rc1
Message-ID: <Ypfx7MPYGehYdwCo@redhat.com>
References: <YpfTQgw6RsEYxSFD@redhat.com>
 <CAHk-=wjTOB7yuygFwz64xFHYthwdTOYoC=L2kM4k1GW2a80uNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTOB7yuygFwz64xFHYthwdTOYoC=L2kM4k1GW2a80uNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01 2022 at  5:43P -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jun 1, 2022 at 1:59 PM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > ----------------------------------------------------------------
> > - Fix DM core's dm_table_supports_poll to return false if no data
> >   devices.
> 
> So looking at that one (mainly because of the incomprehensible
> explanation), I do note:
> 
>  (a) the caller does
> 
>         for (i = 0; i < t->num_targets; i++) {
>                 ti = t->targets + i;
> 
>     while the callee does
> 
>         unsigned i = 0;
> 
>         while (i < dm_table_get_num_targets(t)) {
>                 ti = dm_table_get_target(t, i++);
> 
> Now, those things are entirely equivalent, but that latter form is
> likely to generate horribly bad code because those helper functions
> aren't some kind of trivial inline, they are actually normal functions
> that are defined later in that same source file.

Yes, that needs fixing.. but not urgently so.
 
> Maybe a compiler will do optimizations within that source file even
> for functions that haven't been defined yet. Traditionally not.
> 
> Whatever. Probably not a case where anybody cares about performance,
> but it does strike me that the "use abstractions" version probably not
> only generates worse code, it seems less legible too.
> 
> Very odd pattern.

OK, I can just nuke those wrappers.  But yeah, none of this setup code
is fast path.

>  (b) The commit message (which is why I started looking at this) says
> that it used to return true even if there are no data devices.
> 
>      But dm_table_supports_poll() actually _still_ returns true for at
> least one case of no data devices: if the dm_table has no targets at
> all.

Right, I'm aware.. ugly but not a case that really matters (more below).

> So I don't know. Maybe that is a "can't happen". But since I looked at
> this, I thought I'd just point out the two oddities I found while
> doing so.

It can happen that someone loads a table without any targets but it
isn't a case that matters given IO cannot be sent anywhere.  For that
to happen the DM table will have been reloaded to have targets (at
which point all will be setup properly, assuming no bugs like was
fixed here).

I do see you've since pulled the changes.

Thanks,
Mike
