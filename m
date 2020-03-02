Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCCC3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74548222C4
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 16:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RO+4wjvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCBQhO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:37:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46507 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCBQhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 11:37:14 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so7691333iox.13
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUwJFOHIny8Wvu7PLpqOuE2bR34bAgL0os8brnYjmf0=;
        b=RO+4wjvF0xYL0dSmTu0pBrPBX2y9kwTNQida9W505FBOq5ToUDCrKC602NKbVTFivx
         +70otg8lIjLLDnvsZwqJ0sFygw/PBIQQsG/r9jkGGnmoB1LwQSzjmiNe7Yk0fb5F25wL
         ZUzJZGEHWpurJfHOM42GL70qak7QarVwT0yKYXf/urexcTCBGnjhiRH6uj0zUyR9ymJE
         yAisRJJmsOwc6YuGN/oTsQ0mxmgyIx+blISeSMXy6AgdXazb1c+9YEv9p8AsTvHviS4R
         qs1/h4X2QC81UA+fqBrcmX1jqJyN+8br1eg1zbo7/fOsyUDDE54zptyquMXWwejTyu5y
         ux5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUwJFOHIny8Wvu7PLpqOuE2bR34bAgL0os8brnYjmf0=;
        b=lmh83FKlWxSaCIZWkF51RQPAD/D14e9JUS93aM5AmTo1BRE3zKzGcHGJcfPig9fLb1
         Ne0nJ1RZoy57eAcaujNKWZcFuqI/1HBlMibP8TDIIF36DcoJIm0Uw1QhUrU4F6X/ETaI
         F0zxkOZYxb1hm3nQtvvnqxwirxxZv2Dh21tRHoWCW7W+C8kOclz+JT2w/tqLA1KMWhlD
         jraobUbph/++lLPdb9nvgFlZ73UR6aYaEZxxZjIm0iM3uN4vDxfmqdZLx41KPowSCiME
         eqr+2pR8yTfbLOgzYSxNbZac7L3MQmBz9iIwaouv8y1toMmylPgIiTMTUv7zW+TENABh
         dCqA==
X-Gm-Message-State: ANhLgQ17J7oJbYAZze4j1klBfuXKdJ9tPaoSfNi9U6zACXHX7PG4Tv/t
        jl3E24g5xfPZXkLl7K4RZ7Vke8XpcXbZ3065gQpIpw==
X-Google-Smtp-Source: ADFU+vvE24Kbc/c8Y/XMRlL4fc7Tqkl4w/eq7idYA5x8i/8IYxALP/dHS4htvWW9fFmCaImgHdbRxswM3m8u1hmW39A=
X-Received: by 2002:a6b:6814:: with SMTP id d20mr304596ioc.71.1583167032668;
 Mon, 02 Mar 2020 08:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-16-jinpuwang@gmail.com>
 <ef4e45bf-f4fe-99eb-68de-4e4aff415c67@acm.org>
In-Reply-To: <ef4e45bf-f4fe-99eb-68de-4e4aff415c67@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 17:37:01 +0100
Message-ID: <CAMGffEmj8MihGW4+wwJNgmnyFLM96AOq8YbxRPqbDGN4gDakuA@mail.gmail.com>
Subject: Re: [PATCH v9 15/25] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 3:12 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +/**
> > + * struct rnbd_msg_hdr - header of RNBD messages
> > + * @type:    Message type, valid values see: enum rnbd_msg_types
> > + */
> > +struct rnbd_msg_hdr {
> > +     __le16          type;
> > +     __le16          __padding;
> > +};
>
> Please add a BUILD_BUG_ON() somewhere that checks the size of the
> structures that represent the wire protocol.
Ok, will do
>
> > +static inline u32 rnbd_op(u32 flags)
> > +{
> > +     return (flags & RNBD_OP_MASK);
> > +}
> > +
> > +static inline u32 rnbd_flags(u32 flags)
> > +{
> > +     return (flags & ~RNBD_OP_MASK);
> > +}
>
> No parentheses around returned values please.
will fix.
>
> Thanks,
>
> Bart.
Thanks Bart!
