Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF1C47409
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBB124655
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lyle-org.20150623.gappssmtp.com header.i=@lyle-org.20150623.gappssmtp.com header.b="R+Rg4suN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWRUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:20:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45972 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWRUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 12:20:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so4049210edw.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 09:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lyle-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+vNbb4B/0sSFyFJSC8qTaKMeb1MRUXRnISXV/exbkE=;
        b=R+Rg4suNYIxYpIipdm4HoY9YSJHHPquogFhVnX+Gs01z4f3zumINx+eV5JZADGcwSt
         EygB778MYN6jVX/NBUWZxo5UXuOL7wcE2URInuZrssI3q2DQcQNQoHtUO7jr+XfCmnOI
         sOcCJVrqg7sQ4Fpd8L+xljtbL4uz/MxoXizeh3pNfDg8YJGyvnVP2vcPACgZ3rWDj4Ix
         QAEKWJgJEFfbPy2zt9OBBposLV6alsIQRqjzDqrTphq1KJevsp6qZuZjay759Yyf4P9k
         2QLyrUe+0ZvWsTrHOFhiwOGP2Ty1zATeV5rxZvv1V9k4BtQj8xodFY/7TJZbcv6t2OXO
         fZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+vNbb4B/0sSFyFJSC8qTaKMeb1MRUXRnISXV/exbkE=;
        b=DEwgJ0bNvfQcOpmJ2xwCD29M0wCjWwWkEtkBEJGunWwZ5/Qs68GNW+oXePtYas2ZxW
         sZ//8I5p5tkg4pX71ci6d9EDf3oHPCF7oh1AFeX0/CMIjpFZ1zd2vqC8qCfwRT6uZtR1
         MMv9ysn33CFAIurnTxOjXK1fa3z6XR6zPy3IalydRhQ2iqj5WrcI3kL4tRRrBl8xAkSs
         uu33bx5/q8Gpm5HNO+k3XbA3uKGtnGd2TCzBI3lOCKh1Jxj+g0Doh7l5kWq+A3l/LMMA
         7Llg4D03UfVvH54rV5yCMUYn42WyBYKfrqjwy1GXIQit48a93owAyHT6OYApvyTdUgf6
         NzEA==
X-Gm-Message-State: APjAAAWMn75qSH5snk+KDSM5a4b+EryASyvYNVF1RHOT23YKHeKpBNqV
        INw3bTdbX/P+IU0GvKr86kChbd7Va7X1Z2PuKBQQZw==
X-Google-Smtp-Source: APXvYqyFEP6AIOMjEXh1ED3DZy0t2JdN8FSZhBcCwGil9FkQFDEEb+kxCC+mAT44TIbR5MvnkAkKXLjDFBXTd80juRI=
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr7969076edv.82.1579800029952;
 Thu, 23 Jan 2020 09:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20200123170142.98974-1-colyli@suse.de> <20200123170142.98974-15-colyli@suse.de>
In-Reply-To: <20200123170142.98974-15-colyli@suse.de>
From:   Michael Lyle <mlyle@lyle.org>
Date:   Thu, 23 Jan 2020 09:19:50 -0800
Message-ID: <CAJ+L6qckUd+Kw8_jKov0dNnSiGxxvXSgc=2dPai+1ANaEdfWPQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] bcache: back to cache all readahead I/Os
To:     Coly Li <colyli@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Coly and Jens--

One concern I have with this is that it's going to wear out
limited-lifetime SSDs a -lot- faster.  Was any thought given to making
this a tunable instead of just changing the behavior?  Even if we have
an anecdote or two that it seems to have increased performance for
some workloads, I don't expect it will have increased performance in
general and it may even be costly for some workloads (it all comes
down to what is more useful in the cache-- somewhat-recently readahead
data, or the data that it is displacing).

Regards,

Mike


On Thu, Jan 23, 2020 at 9:03 AM <colyli@suse.de> wrote:
>
> From: Coly Li <colyli@suse.de>
>
> In year 2007 high performance SSD was still expensive, in order to
> save more space for real workload or meta data, the readahead I/Os
> for non-meta data was bypassed and not cached on SSD.
>
> In now days, SSD price drops a lot and people can find larger size
> SSD with more comfortable price. It is unncessary to bypass normal
> readahead I/Os to save SSD space for now.
>
> This patch removes the code which checks REQ_RAHEAD tag of bio in
> check_should_bypass(), then all readahead I/Os will be cached on SSD.
>
> NOTE: this patch still keeps the checking of "REQ_META|REQ_PRIO" in
> should_writeback(), because we still want to cache meta data I/Os
> even they are asynchronized.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Coly Li <colyli@suse.de>
> Acked-by: Eric Wheeler <bcache@linux.ewheeler.net>
> ---
>  drivers/md/bcache/request.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 73478a91a342..acc07c4f27ae 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -378,15 +378,6 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
>              op_is_write(bio_op(bio))))
>                 goto skip;
>
> -       /*
> -        * Flag for bypass if the IO is for read-ahead or background,
> -        * unless the read-ahead request is for metadata
> -        * (eg, for gfs2 or xfs).
> -        */
> -       if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
> -           !(bio->bi_opf & (REQ_META|REQ_PRIO)))
> -               goto skip;
> -
>         if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
>             bio_sectors(bio) & (c->sb.block_size - 1)) {
>                 pr_debug("skipping unaligned io");
> --
> 2.16.4
>
