Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526F2C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDCE206E0
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 21:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFBqaJ6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIVOv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:14:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37338 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVOv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 16:14:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id x195so7767433oix.4;
        Mon, 09 Dec 2019 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kI1cdqsohvrBZb1G7zvJRzw516Sb7QCZ7TtWVwq88mU=;
        b=tFBqaJ6Eo9qr+Sygep748UzAdEO4AKba+6RRWjkEuwQCBVnTqgqwNo/cUrtj/iOeWX
         I8bFZQypaMzklntlXxlO/YjyUMMq3d/aQCGFL0cMj5pKJBjcERHsQiDUUbQ3m5Au0EVf
         Vxa0n5Rl9aByWwLOfUCe2W1u8KojEDq01cr4X1mc8rI2ETSD/gQrFAl6A6HZgE0bP74b
         H2/I4xqbiJjh7sR4CoUVII7/+XT1iPQ9qfVT16LXgXwXrK/NQHA+jX+JFfygzdxKnjjG
         uC98WlgJM+wz+vi0BfV2oFdMFnAhNEhwq04chyPC2jlHAloXxdJs8sHSy938bey5IqNY
         YZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kI1cdqsohvrBZb1G7zvJRzw516Sb7QCZ7TtWVwq88mU=;
        b=lTPgsgUEMhqs+LbAomnAO+G6oCHLK7do9Aaa4UAybbP+1MDTZu/p1On2NPv3+d+sfN
         C6zIa62LXydUgeX5RcljppSiwqwfWlz++Q2ZfTdWWpz98d7oka2fhmfu6rD73iq1BTGx
         zakvLEEyvzKQfBYlOAnlH+bfdwx2KjKeKfkAcngtzk06Q32gmSnu2+JUhv5BUUNESRs4
         WGR+68Id+WJtzmozb7iMBQrs7pCXPn7hYi4QYHFMCa2AyHGOoT0XEgsp82hADNuwL3jx
         JLOPl5Xj9BwX9u4m5m5vty8/zdEgSV7TnUcbd/+/O3dHSLLmPeRoEFFTvcWX+4Hq/gpi
         lJ2w==
X-Gm-Message-State: APjAAAXGM9FO9OCN+jZKgsld/XI1ZRsKW4MnlyIBrnjcrHyGTAc4e9p4
        yEWK/ba/oocZdBuTKl2iX39FIKIHC+4=
X-Google-Smtp-Source: APXvYqzlMt4odPZ7cWf+kqQOZWfGPtDFYJUEA3rCViP6YFhPndf4Ihj37q8UtsN4ZJiubpAhb7h4OQ==
X-Received: by 2002:aca:8d5:: with SMTP id 204mr981154oii.141.1575926089961;
        Mon, 09 Dec 2019 13:14:49 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g19sm397100otj.81.2019.12.09.13.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 13:14:49 -0800 (PST)
Date:   Mon, 9 Dec 2019 14:14:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
Message-ID: <20191209211447.GA43622@ubuntu-m2-xlarge-x86>
References: <20191209201444.33243-1-natechancellor@gmail.com>
 <CAKwvOdmrGGn6f+XBOO3GCm-jVftLsFTUXdbhS9_iJVY03XqCjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmrGGn6f+XBOO3GCm-jVftLsFTUXdbhS9_iJVY03XqCjA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 09, 2019 at 01:07:41PM -0800, Nick Desaulniers wrote:
> On Mon, Dec 9, 2019 at 12:14 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > ../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
> > statement is not part of the previous 'if' [-Wmisleading-indentation]
> >                 nr_parts = PARTS_PER_DISK;
> >                 ^
> > ../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
> >                 if (err)
> >                 ^
> >
> > This is because there is a space at the beginning of this line; remove
> > it so that the indentation is consistent according to the Linux kernel
> > coding style and clang no longer warns.
> >
> > While we are here, the previous line has some trailing whitespace; clean
> > that up as well.
> >
> > Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/791
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/block/xen-blkfront.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > index a74d03913822..c02be06c5299 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -1113,8 +1113,8 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
> 
> While you're here, would you please also removing the single space
> before the labels in this function?
> 
> In vim:
> 
> /^ [a-zA-Z]
> 
> turns up 5 labels with this.

That should probably be a separate patch since there are only two labels
in the function I am touching here. I'll whip up a v2 if the maintainers
want it though or I'll just draft a separate patch when I am done
addressing all of the misleading indentation warnings.

Thanks for the reply!
Nathan
