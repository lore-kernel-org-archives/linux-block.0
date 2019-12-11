Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3FFC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1285520836
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576095542;
	bh=jxTXPkIV/qtRanjWPb/PvvzXSS/JjpC54JLmFetXkwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZtvBcl1JXHwNgs2zx7X8cmnO6Qx/AqXrlaL+m6U5OOv5C/6ljHuu4YWZ9JkeZYKYb
	 i6ja/yswISNzVpUe9ueMNx33XwTEbO/fjwL6GZf/3JhWsoppanynX0ZNgyfhHhzrTW
	 2XDvd4KcttMpMi61PSsRUqp9UT5ZvMDH4PgkPEhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLKUTB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:19:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39340 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLKUTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:19:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so25528097ljj.6
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UjwHXfl+wSpdIy6pFsKx1jWMPt+sQscIiO9W8R2W1Y=;
        b=XtMIe7iuAOWqyQoOMNK32ZxWsoe5+aC9clZlbvlSHNeQnBL3iYqXG5cOgaShAhZu8l
         KBr+OSu1TBtcjjKLP/Z3bTH9YZpJTmNG6piE4dk0EuVKUQlYs0QuS8A3v4YnDRaXgUGn
         axHRPhHleLO8S+aMNKnrf/AwhGUa0j2Qagvqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UjwHXfl+wSpdIy6pFsKx1jWMPt+sQscIiO9W8R2W1Y=;
        b=AbJC6jD6u6+Jg/UAlL8ZlaCdAmhd7ZSc3vfo3jEb7F0EqY9Jh/1lXoQWlw+mSxRRYb
         a9WiyQDEBtHof1w2X2C2bSW0mUrSMcaJasre3H3Lvp5oIrk1h00e8/13odm8zFy9wlF8
         8SJd4IeyqYqxUmfqmd4/K11aOSEqKrJ4nwcu5kgOWe/Rs7Qvu6GNFrSf6IFUZk9d8qFi
         JC7TzvMCePGSC3B84x0ffryg2Rs9s0l5LukbO/DaxbcKG0BmKOnYUkxh5/Qb8ahnCWLd
         ETeUzp8mg0cs1spYIyK/PPi/Ep10zm86u4okvFNZXbWIHUQAwqOF+ZtSbIAqHw1bDpxR
         V00g==
X-Gm-Message-State: APjAAAWSPcsa2zbZszuCI60O1vSmerVsslKzgrm0lj5mAI4h4iUXd468
        +z+7mnBxdKmXUlhbbm5bvCKPss//Rs4=
X-Google-Smtp-Source: APXvYqzTUStw7uKY4BRbQ3ukZakiM5AIEVJmskTGIYCAWgVp3Y6ZGG3M1ABzslKtb/ui8Cje7YmvcA==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr3477524ljg.154.1576095537465;
        Wed, 11 Dec 2019 12:18:57 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id z5sm1734330lji.32.2019.12.11.12.18.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:18:56 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e10so25527970ljj.6
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 12:18:56 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3384426ljj.97.1576095535581;
 Wed, 11 Dec 2019 12:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com> <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
In-Reply-To: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 12:18:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Message-ID: <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> $ cat /proc/meminfo | grep -i active
> Active:           134136 kB
> Inactive:       28683916 kB
> Active(anon):      97064 kB
> Inactive(anon):        4 kB
> Active(file):      37072 kB
> Inactive(file): 28683912 kB

Yeah, that should not put pressure on some swap activity. We have 28
GB of basically free inactive file data, and the VM is doing something
very very bad if it then doesn't just quickly free it with no real
drama.

In fact, I don't think it should even trigger kswapd at all, it should
all be direct reclaim. Of course, some of the mm people hate that with
a passion, but this does look like a prime example of why it should
just be done.

MM people - mind giving this a look?  Jens, if you have that NOACCESS
flag in a git tree too and a trivial way to recreate your load, that
would be good for people to be able to just try things out.

                     Linus
