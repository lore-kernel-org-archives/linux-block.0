Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39663C04E87
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1999D217F5
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 17:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfEURiP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 13:38:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbfEURiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 13:38:15 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hT8iL-0006rT-1k
        for linux-block@vger.kernel.org; Tue, 21 May 2019 17:38:13 +0000
Received: by mail-wm1-f70.google.com with SMTP id g3so669572wmh.4
        for <linux-block@vger.kernel.org>; Tue, 21 May 2019 10:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcNXBZFJb+DLhnDXLU3vOO28yF5WtLq1sqqHjjzYzVE=;
        b=Bo5R/SbCh+Ai7+LoZSWw4gHrDFzPrBVxXUwExqpkLi8eHB2uvgTilgiPgWmML640xL
         Rg4pn3hW9JCu8OKelCz3aHOq/e0y/8gQz39X9iQUsvzHG1Z9DP9y4CCH/yiwNYX9h0bn
         GUZ8D6vtsQB9gIVcYO98J0JLCiwRu/A+vSsA4JIWU9aLUywt+7mEQ+gD1uNFjsMKkPvC
         tnTXQ9OUXIbTKdZumbi+VqqKjsNo8+eJe+1BL/reJUJRJ+jw8gYUoY0AaE49g3PDZc44
         R4OtwNjVCBDim1BFcb4ZDL0mY+VGQIZXqC2uqKm0CjNjp2Nx94lXYTtysQ3ZxZ9sK+yv
         wMRQ==
X-Gm-Message-State: APjAAAU9OFn6bexrVSj3eS/G+zWCsD/mNreYrXnU17rOiO6uCQFlByBP
        E+ShRZchpBDYoe33JdtVmaLGawX4UaReL3w8WCEewiIaa6a8+41hdESPKe5yDzVQ5x9Y1oHkrVV
        u+T45uhuAuMw0wOlDm80eKwbDook6TF4r3pDmWm64KNoKS9whIPG+bqh6
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr4127766wmj.127.1558460292817;
        Tue, 21 May 2019 10:38:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw81v2o+MMfWEy/WTk62q4WO4dG0iEhjtk0hLe0Eaytx5oKhO+Tt7BlfcmAgqlKnhfh6p/m/uVVK26fQg8gQI8=
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr4127752wmj.127.1558460292640;
 Tue, 21 May 2019 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <20190520220911.25192-2-gpiccoli@canonical.com> <20190521125634.GB16799@infradead.org>
 <CAHD1Q_z23AO+NRid1xYTeke_5GAe6hPianEZKBf5P30FrfZGFg@mail.gmail.com> <20190521172258.GA32702@infradead.org>
In-Reply-To: <20190521172258.GA32702@infradead.org>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 21 May 2019 14:37:36 -0300
Message-ID: <CAHD1Q_zgBxE-nD6zY4koJGJC9K53+6d6-xGpEpA6W4sudu0Pgg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 2:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 21, 2019 at 11:10:05AM -0300, Guilherme Piccoli wrote:
> > Hi Christoph, thanks for looking into this.
> > You're right, this series fixes both issues. The problem I see though
> > is that it relies
> > on legacy IO path removal - for v5.0 and beyond, all fine. But
> > backporting that to
> > v4.17-v4.20 stable series will be quite painful.
> >
> > My fixes are mostly "oneliners". If we could get both approaches upstream,
> > that'd be perfect!
>
> But they basically just fix code that otherwise gets removed.  And the way
> this patches uses the ENTERED flag from the md code looks slightly
> sketchy to me.  Maybe we want them as stable only patches.

OK, it makes sense to me, if that is a possibility. The fist one is
clearly a small
and non-intrusive fix. The 2nd indeed is more invasive heh

Please let me know how to proceed to have that added at least in stable trees;
this would help a lot the distro side of the world hehe

Cheers,


Guilherme
