Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D1BC32767
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B6022522
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 13:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="LQRQAmBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgACNsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:48:32 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37417 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACNsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 08:48:31 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so36656331iln.4
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brJF48acVIn09S80jTAugk6vGORuwUBAX9ZKkVlOqpU=;
        b=LQRQAmBOU7DbboCvaXBo2qSYVsnWD14POaS5Gv2sHfauatHmMgMxJvz6EnU8fyMXGt
         vqJEk/lCbh5CaA8TmRVj+MC+3+6j6TSK6qzR4Uxg4CgdNcFH/hCDI75QRlYzY0Ir60Pu
         6VYPWmrP4mqZ+hY6fZRKux2lcIxQN74zZ/deMPKxtgemc3JqQQxIyG/Ecs9bdqInTle2
         6wZz1+3GTsBkbB8KkM1OO6YQg0MV1dcP4ocl7IVJUFmf0bAads8HF8WgSiDaRM8pEWwN
         sPfPRZaEkYsmbUgeGnOicOmULHLDkD/vtCQixmalAdbTcneV/zbrlqWkuVqSB0FIsyyX
         3zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brJF48acVIn09S80jTAugk6vGORuwUBAX9ZKkVlOqpU=;
        b=mETUz+5aPjjlRUsnXT18kqoFmUW94YBcNVD/Nbr/wOdC//0Ltd5fRD+NQTLwqpwtqv
         RVCXgw8oZ4OM1IEXGGsCsZx9ytYFBhCuo9ljoQZ9lqFJa5mMSj6HLKnXSQ65C/Gb4Iok
         a/ydF0PWrII2Qz6Bh/j33apuUnebUTOCJ5YCmn0rbzBGw5JG8v2bdnJBTrS0JyK06hoz
         /d43O8a+/StQH89njgjtRZOl3F83kspq5voiZ5OYsGZ+MDDeoN48WB0QEUl9Zhoa9Yqe
         EjHvzhOOHVUT8/G9pzwtNPTZ234pNg66UtlaPzoeEyDgLmvhEiRnf56n7+cCBZy4hYU+
         iUjA==
X-Gm-Message-State: APjAAAUwbZDMA8c2hJX7x9+2WuO6zMWeUtHoL4YumYUdtoXwTKUoR5QQ
        gTdhH7O6SEJtz/2jdwU/7aym2rTSRgdAaUIb0k+BuA==
X-Google-Smtp-Source: APXvYqzEsQsKE7Qbdio3PFMbLvcS+pfYAkKuNtkG/e2h8EVfV4KzhcweVJaQAO6sOBUWZUcDGTU81PjP4LFYDu1QTfs=
X-Received: by 2002:a92:1090:: with SMTP id 16mr72461527ilq.298.1578059310892;
 Fri, 03 Jan 2020 05:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-4-jinpuwang@gmail.com>
 <1f826dca-86c7-41ab-eef8-0e15f723e993@acm.org>
In-Reply-To: <1f826dca-86c7-41ab-eef8-0e15f723e993@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 14:48:20 +0100
Message-ID: <CAMGffEkar0UtPZizacOBz86fOy=m2_u1+bYfkDX4CwZ4c7cDKg@mail.gmail.com>
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > +static inline u32 rtrs_to_io_rsp_imm(u32 msg_id, int errno, bool w_inval)
> > +{
> > +     enum rtrs_imm_type type;
> > +     u32 payload;
> > +
> > +     /* 9 bits for errno, 19 bits for msg_id */
> > +     payload = (abs(errno) & 0x1ff) << 19 | (msg_id & 0x7ffff);
> > +     type = (w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM);
> > +
> > +     return rtrs_to_imm(type, payload);
> > +}
> > +
> > +static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
> > +{
> > +     /* 9 bits for errno, 19 bits for msg_id */
> > +     *msg_id = (payload & 0x7ffff);
> > +     *errno = -(int)((payload >> 19) & 0x1ff);
> > +}
>
> The above comments mention that 19 bits are used for msg_id. The 0x7ffff
> mask however has 23 bits set. Did I see that correctly? If so, does that
> mean that the errno and msg_id bitfields overlap partially?
Double checked with calculator 0x7ffff is 19 bits set, not 23 bits :)
>
> Thanks,
>
> Bart.
