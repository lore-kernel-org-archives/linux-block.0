Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF42C2D0C9
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 22:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEA122527
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 22:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576189107;
	bh=ppW53ZG+nBfsl61Gq8yucwWvxoD4t5bDoVTGmT1oBD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=08mLXHdnMuKO8DY8TBBTAR5MbiZmoDQTlUKFjYuGtKgIeCGsfO5gVfTMxFTEpXU2P
	 RNP4+iSnk1wGaAlserGngtLJeA5U0S79MdTdobGTKoAelXcQo6yB8FbJwDDRfBZkg3
	 bCJ5Fy0XVOkKlPVLcLI7VM8lDT5YK+f/0AdJPQ6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfLLWS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:18:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44652 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfLLWS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 17:18:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so373875lji.11
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 14:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibmYe5dmY9qFVLAgJoCojAZp2sCL8vXGU5XsSLw7St8=;
        b=dSlXNntYZVPGXn3lcC2vbzXF6WipSUsta1btx41YmoTh6VEKRpX2b7fs4TxKEw1Y2K
         UUZW0j/AAeXCmzGIAkJ4aunSCoZhgKx4W43dwuoHYpIAgug4033pSgKiZUT1ThtmS8ic
         OMRV4vbDWMBE++REQi15KrlEQuhlW3+R9WzL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibmYe5dmY9qFVLAgJoCojAZp2sCL8vXGU5XsSLw7St8=;
        b=Rkyng6JdlIKbfkKZgbxkbq3Z3ilIU95+EV5f90fVL+CmIzNTJeZJV4qCBwddZ3xPSc
         Bnmke5kOSPDkuyU7bysA6TunJfMXXD41ogDREQSr0hROnYqj2aPkiifxty8mMhpaSOtD
         XQjfNhLK0lJABx1YdvukXtb+Vn2YqEVAeF69WffYIapTgEAnmq/gi2gCJz/BIoVZ4kXk
         Fz+pLCjHO+kVXP+7sKZczUWF/rYPYgZI7YSJ3dC/8J0F+nbs3s4J1XJpfRrL5ouDHXEv
         pilgvXaKBFDAP9IafKz1yQM8H/IDiq3ej+xKWZe+b+A4DEZaWNwDjKNUYpbpCtfhPRH/
         5Cwg==
X-Gm-Message-State: APjAAAXm7TBuTfiOlbkiUolRmiY3Ie5u8E/Q0MEmvocw40/pzcPKruE3
        fwlLALqN2Z7UJenn6LBRme2Gwvjrk0M=
X-Google-Smtp-Source: APXvYqy19OSkXX5J4l10yfHLILo8Mk5CWu8WzmDJyW4CYApUlouLiXnmJ17eVWnwGYui1G2zkx0/aw==
X-Received: by 2002:a2e:90c8:: with SMTP id o8mr7601483ljg.4.1576189103614;
        Thu, 12 Dec 2019 14:18:23 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c12sm3558329lfp.58.2019.12.12.14.18.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 14:18:22 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id y1so453476lfb.6
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 14:18:22 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr6996151lfm.29.1576189102141;
 Thu, 12 Dec 2019 14:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <63049728.ylUViGSH3C@merkaba>
 <7bf74660-874e-6fd7-7a41-f908ccab694e@kernel.dk>
In-Reply-To: <7bf74660-874e-6fd7-7a41-f908ccab694e@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 14:18:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAdtXUzqFNfZKm+AEh9Oxd5ZvNx_sZZi-RXSFhtf5V+Q@mail.gmail.com>
Message-ID: <CAHk-=wgAdtXUzqFNfZKm+AEh9Oxd5ZvNx_sZZi-RXSFhtf5V+Q@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 7:16 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I don't know the nocache tool, but I'm guessing it just does the writes
> (or reads) and then uses FADV_DONTNEED to drop behind those pages?
> That's fine for slower use cases, it won't work very well for fast IO.
> The write side currently works pretty much like that internally, whereas
> the read side doesn't use the page cache at all.

Well, I think that if we have this RWF/IOC_UNCACHED flag, maybe we
should make FADV_NOREUSE file descriptors just use it even for regular
read/write..

Right now FADV_NOREUSE is a no-op for the kernel, I think, because we
historically didn't have the facility.

But FADV_DONTNEED is different. That's for dropping pages after use
(ie invalidate_mapping_pages())

               Linus
