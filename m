Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC6CC10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3220663
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syCOdCZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCLNVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:21:41 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37466 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLNVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:21:41 -0400
Received: by mail-pf1-f169.google.com with SMTP id p14so3274183pfn.4
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JtJ+m5XcMi4mlopxHtcIgWKlDTuWNdA0nlpFNyB+qGk=;
        b=syCOdCZusmRj84dGc/P28KTaKKNRIuwhP7pDXusLZuriCB7ZKe0jaJ2F1fcbEzSPI4
         7IMYFIcbOm5JcJz3gQ1xNoY7JIcBPA4kF/zmDCoioKTCI0+QfcJ1JdgOqezNFEx1C6Yq
         BeSpF3uhxg3BsqWqHolhBqZrEWEsogC7UX0X9igw5LLXrOoG4pdIcgUcIeh1W4hsx57Q
         /Ufz7WbbBo0QbZAvt5qy48GfNQhlaJvjqoeo1/cYEr9Nvc1DHr0oAnn+eldsGzgddDzW
         6jKHS/QNoRaEHmy4oAgUAEGy6a2ZRHYneYzDlezECpPv9nl2X7nKyR5Yg//bJihqguny
         97Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JtJ+m5XcMi4mlopxHtcIgWKlDTuWNdA0nlpFNyB+qGk=;
        b=PuK8yeOUHZf2wVhCs5kREAiNqz9UhBXAwws06OfokQkyyMPyhXVXOVdGV+DkhnKPev
         W0iMiKgcFjl6kg4eKbYXDqZ7bq9OeDWLPPD53vPwodfNJ2Jdx868KrBq7kuXbYR75hHQ
         GCtj/z6oGXn70dybdMoz/ZNw8rxAEUzJMGJXwhiB23sGut3JJTlAFvhC7LwQhpcuTux+
         DEqzn3K7hHtv+bCjRFnYtzCI8z6csUrBCI/DXWYLEZHyT6TFMyu1iOnS5hnAcR/M+Xm0
         ZwZUu1DWCro2zSqbP8hOQI/jdDIfNgO0VzzlljIHcBDBw8T6qGbPD+aH7XiD4qb+H/83
         Tikw==
X-Gm-Message-State: ANhLgQ0AHtivzWm2JWwss1mLSPi6UhclE2c5jhMglVSFQJIjiBQWIV1P
        LeFXuCXhlUOUkOuwfq2Cr/U+LPqmhN3TX4BGJaxuXebJnIZ5zQ==
X-Google-Smtp-Source: ADFU+vvKxGruO0ZymwAj9DWysTZunRNvNTUs1l8q4hJevISUH1a2TjKz22rLq4I5wSCQxrKHmcsTWrAM0D1edh1MvX8=
X-Received: by 2002:a65:68d9:: with SMTP id k25mr7571093pgt.89.1584019299880;
 Thu, 12 Mar 2020 06:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p>
In-Reply-To: <20200312123415.GA7660@ming.t460p>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Thu, 12 Mar 2020 21:21:11 +0800
Message-ID: <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,
Thanks.
I have tested kernel '5.4.0-rc6+', which includes 07173c3ec276.
But the virtio is still be filled with single page by page.

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8812=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 12, 2020 at 07:13:28PM +0800, Feng Li wrote:
> > Hi experts,
> >
> > May I ask a question about block layer?
> > When running fio in guest os, I find a 256k IO is split into the page
> > by page in bio, saved in bvecs.
> > And virtio-blk just put the bio_vec one by one in the available
> > descriptor table.
> >
> > So if my backend device does not support iovector
> > opertion(preadv/pwritev), then IO is issued to a low layer page by
> > page.
> > My question is: why doesn't the bio save multi-pages in one bio_vec?
>
> We start multipage bvec since v5.1, especially since 07173c3ec276
> ("block: enable multipage bvecs").
>
> Thanks,
> Ming
>
