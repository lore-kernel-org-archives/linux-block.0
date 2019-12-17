Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F0FC2D0D1
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 20:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438A821D7D
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576614408;
	bh=ELgblhnRlUhHQhpVzXjr3fc4chVVeiMX7dNeAUHFsVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lue4c/8+a9H6AeCw9H21Ji7ks/gJiKQS4E/vfY/ydNJ0CPDcyDdn4M7GIi5j9BrNT
	 HiG/hsu3wSavKhPb4wS5VNcM71gjwYliGiRoPlNusKUKBwf4d9xFUSJZDWGMi1+Pvi
	 z5ktF9lfk4Ygkgv323rfpbtCucRQ8xK7DE3FFSzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLQU0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:26:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38213 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfLQU0q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 15:26:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so1070017ljh.5
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1T7+oLmgUY62ytPiNODIrz1cZeW8gAZnOGieJ8ZkwA=;
        b=B25Yd0xdGvGJ4bCIEr4Bgw/88tBjEJ0OPfoVc5YLKvIjM26jyP64rHYwIIEVDLTF0T
         74GwFgIu0A96nSZ33TTCFUmysZjkwE8bDL13x64JVHMOo8K7cEIepUclqLbfA2V4o+Gz
         t+TIx/86gc/llbykG0MWlhLehR8Su42SrUwv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1T7+oLmgUY62ytPiNODIrz1cZeW8gAZnOGieJ8ZkwA=;
        b=E2llVnTl2pBmokcO2DGBE/2BzS0CFZC3E2NfN7V6HPW0k2mZfOunflmJizQp5dx44X
         4eLxMPqxvse6Un0+r4RG3+lzRhBVs5tejhExQ4tj3uEsxi8P6BGCaNaFWavhvICwvRuu
         UmYtzOVLQeyTetLhgQpPp7I/CTgS3sn9aZsiyiD1t17wSe/XbiufrzUoCcUc3Gz1c1N7
         H/boX2UL47mNtDW+5qtP7MoUSm3mUxmZZwEXnK/94HOYfmi9nAiO0sHQbjxJIi1h7bQF
         6MKlQLfAGeGFqmw4yMt+Z7Z9ju02QSbCXsjtwIMVMYUexsnfanPbptyo8nputmsXW4EW
         jfHQ==
X-Gm-Message-State: APjAAAUfm9fBz+kQuxvo2vGnRPmqXKJEVR210Mf37dreFhT6K/PiYon8
        dYctY3/lkK2jQpGeDHtlAOGUBGOgE7E=
X-Google-Smtp-Source: APXvYqzf9jq0vxnyAZ5eZEkO82MpCdiVc9GEoeHIoE+LVbo3OnXtUyoMHBXR0ByxM8tOFbrMbDUHEg==
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr4578821lji.59.1576614403898;
        Tue, 17 Dec 2019 12:26:43 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v24sm16140294ljc.18.2019.12.17.12.26.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:26:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z17so12395957ljk.13
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 12:26:42 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr4707040ljg.82.1576614402189;
 Tue, 17 Dec 2019 12:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20191217143948.26380-1-axboe@kernel.dk> <20191217143948.26380-5-axboe@kernel.dk>
 <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 12:26:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
Message-ID: <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
Subject: Re: [PATCH 4/6] iomap: add struct iomap_ctx
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 17, 2019 at 11:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> 'loff_t length' is not right.

Looking around, it does seem to get used that way. Too much, though.

> > +       loff_t pos = data->pos;
> > +       loff_t length = pos + data->len;
>
> And WTH is that? "pos + data->len" is not "length", that's end. And this:
>
> >         loff_t end = pos + length, done = 0;
>
> What? Now 'end' is 'pos+length', which is 'pos+pos+data->len'.

But this is unrelated to the crazy types. That just can't bve right.

> Is there some reason for this horrible case of "let's allow 64-bit sizes?"
>
> Because even if there is, it shouldn't be "loff_t". That's an
> _offset_. Not a length.

We do seem to have a lot of these across filesystems. And a lot of
confusion. Most of the IO reoutines clearly take or return a size_t
(returning ssize_t) as the IO size. And then you have the
zeroing/truncation stuff that tends to take loff_t. Which still smells
wrong, and s64 would look like a better case, but whatever.

The "iomap_zero_range() for truncate" case really does seem to need a
64-bit value, because people do the difference of two loff_t's for it.
In fact, it almost looks like that function should take a "start ,
end" pair, which would make loff_t be the _right_ thing.

Because "length" really is just (a positive) size_t normally.

                Linus
