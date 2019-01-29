Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E065FC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0D52184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxWaEo3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfA2XJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:09:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35402 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfA2XJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:09:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so19517182otj.2
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pci/yXpihZ15U60SWQfbCtXuiLSK2bTLuKdoxUcVscg=;
        b=rxWaEo3RUOxi72qDev8TlBRE9Tce/Wy9dAyPrhyPpV0AQagxgo3WrQVI7LZ2Rmrqyb
         BOIX627dMLRydg67oMFXAzJsV3CAp5pHVLLSqLQVOeey5O6DKJoinm8uzHkzLh9Ro9iG
         AMh5Mhr+Rb3BMl7Rl9uHZ5dl3iF5xSczr0RumoosGrwgY710rrIFVVHrJ/XolpsEin6d
         FbCXWA1maPwA2mZQbkMa+gNtm8iWqkgL3NBo4zMXlNoLyLfPtT5RXDIeRJM2q+gWczK7
         HFOJlQAs93YR8K3fs3F+gpnnWBSDi+VJpaskdTZF9nQvvBkrDNI6Qi4EYMAbNAJF/REY
         jaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pci/yXpihZ15U60SWQfbCtXuiLSK2bTLuKdoxUcVscg=;
        b=iSFDrB+fbXNVI/j8HlstmAP34p9xdp48FkU2CN6dq5yEyh1Dd0cIakEovv9uBFKYma
         NB4PY8pLs90QIYe6XOQ/TsU4asENtJYT1+rF9WRw5b04fuGckD8TsBt8g/SADIwusMBo
         szD2CAhVXPxKQ8CC0S8rNYzpKbUlcH3pxH1Q5x52HZWfptHRYGL8oZwEwbxCk9KJi/Os
         hDnrj4pogbBcCSu7d4T8wD/zytdpyhVAvai2HXTx4yf6iz56dGEZwz3B5J7AaLisaxUj
         ZEr9d6vnSJxUJhWzq7IoXiBGxrSCtmB2YcvmoqhRIGJf2Ps1h7EFBZScuvVr4cNn8mWJ
         dMQg==
X-Gm-Message-State: AJcUukdqyJ0Pmy2xZtdDeCTXsHOCJAyPnWWGN8FWS/chinkU2YiXZGuO
        m0cFa4YKXrU+4IOd0CR4UO96JBpsfxgO+Hx/WGzb+w==
X-Google-Smtp-Source: ALg8bN5aNyio0rAjlzMSaEPzEV9qfws3BSqi/KCD112GKSDOo4aS8913o18yugemPb/+tGKNPij7yJjNCm9v/asE+E0=
X-Received: by 2002:a9d:460e:: with SMTP id y14mr21858941ote.198.1548803350847;
 Tue, 29 Jan 2019 15:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129192702.3605-1-axboe@kernel.dk> <20190129192702.3605-13-axboe@kernel.dk>
 <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com>
 <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk> <CAG48ez3x5x+P=8L1p-bHvcUnypeT1TizkXq2+Q0bCP0GdE-bog@mail.gmail.com>
 <87b25ce2-a5bc-3e81-ddba-5c932c71b40f@kernel.dk>
In-Reply-To: <87b25ce2-a5bc-3e81-ddba-5c932c71b40f@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Jan 2019 00:08:44 +0100
Message-ID: <CAG48ez1m22z0Pqi0cT=UZdsA14SCM5579T1d40cZdyD6KqBw_g@mail.gmail.com>
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 12:06 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/29/19 4:03 PM, Jann Horn wrote:
> > On Tue, Jan 29, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/29/19 3:44 PM, Jann Horn wrote:
> >>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>> If we have fixed user buffers, we can map them into the kernel when we
> >>>> setup the io_context. That avoids the need to do get_user_pages() for
> >>>> each and every IO.
> >>>>
> >>>> To utilize this feature, the application must call io_uring_register()
> >>>> after having setup an io_uring context, passing in
> >>>> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
> >>>> to an iovec array, and the nr_args should contain how many iovecs the
> >>>> application wishes to map.
> >>>>
> >>>> If successful, these buffers are now mapped into the kernel, eligible
> >>>> for IO. To use these fixed buffers, the application must use the
> >>>> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
> >>>> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
> >>>> must point to somewhere inside the indexed buffer.
> >>>>
> >>>> The application may register buffers throughout the lifetime of the
> >>>> io_uring context. It can call io_uring_register() with
> >>>> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
> >>>> buffers, and then register a new set. The application need not
> >>>> unregister buffers explicitly before shutting down the io_uring context.
> > [...]
> >>>> +       imu = &ctx->user_bufs[index];
> >>>> +       buf_addr = READ_ONCE(sqe->addr);
> >>>> +       if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
> >>>
> >>> This can wrap around if `buf_addr` or `len` is very big, right? Then
> >>> you e.g. get past the first check because `buf_addr` is sufficiently
> >>> big, and get past the second check because `buf_addr + len` wraps
> >>> around and becomes small.
> >>
> >> Good point. I wonder if we have a verification helper for something like
> >> this?
> >
> > check_add_overflow() exists, I guess that might help a bit. I don't
> > think I've seen a more specific helper for this situation.
>
> Hmm, not super appropriate. How about something ala:
>
> if (buf_addr + len < buf_addr)
>     ... overflow ...
>
> ?

Sure, sounds good.
