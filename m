Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F06FC6FA8B
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 16:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUQoT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiIUQnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 12:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5FC2708
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663778008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYbLpIk+s0QRoTZYv+GRPXaIucCZsOsuonl+E97QAvw=;
        b=aqUWeO1C9/FEIdjkadXLfRh40FZkHATMJSwxDVIaIncZazFWCbbu2f0rGPLGvT00U2Y9QC
        8vlLT5HFbGbB+ywvj1nSqYp7aFyPExdLMtkeDkSOcmeSqwnzXYbMQdHI5eIDViPDCeIrYU
        wOuPrhFDYCZMky4meZbeR4Gq2DVZAkA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-3Doo42bYNoWynYizGR15mA-1; Wed, 21 Sep 2022 12:33:27 -0400
X-MC-Unique: 3Doo42bYNoWynYizGR15mA-1
Received: by mail-pj1-f72.google.com with SMTP id 2-20020a17090a0b8200b001fdb8fd5f29so3525824pjr.8
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 09:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cYbLpIk+s0QRoTZYv+GRPXaIucCZsOsuonl+E97QAvw=;
        b=L39F8cO34lS7GKWDhGiZiw3YZZmJc5EvRph+cf9T/ycfmssOe2tcRXCtzn6v6qFAnf
         gOuvrBbEaCHQj6mA0Ul5A+oEE2Wmknethyu87Xz2c6rYOgxJBoKVBNuEn+BHP223RjcJ
         zE0UTNjigb2piX9eSjBZRbg3iJNlnxBkP7KruqaqC+WPX4rvTsjgTyEnaT/2V1Fv58L5
         EIz3Qae/ILPsFZ+DjxAPmvKsdUqL1iLFC1kBJvu/T1yBctkDvFTB1pn68f9uUwdR6kpU
         y12g2BVErzFArr0v/1BRqjTjiSENaHyGy8VDPlKeRz3YIKui+xOWYhNwGU4TI0oaFbYA
         AdcA==
X-Gm-Message-State: ACrzQf0mbqWg7U7XGOJV8hD7dfmWEVVI7Xk9J2pOTNzSihtydRDWbO3R
        VMVhyPe/uT9nu2cgqwGQ6Llq+WyxLFMjo0x1qc8qncxmnRIb4HFRveaHvS57iA0WZoyqpt+6Tns
        En4zausLlUIGP40PSYWhBLvJYjlcVWPkB+BKy4EE=
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id s8-20020a056a0008c800b0052c887dfa25mr29491046pfu.86.1663778006223;
        Wed, 21 Sep 2022 09:33:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4aXLhc+eO3heNSUyLviauCfVMVErnpcCUdhN3ButGC9QVld6Vu18Z5qDcjJ6Rg6OXmCNowJlSaalQCSTOVUJY=
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id
 s8-20020a056a0008c800b0052c887dfa25mr29491021pfu.86.1663778005956; Wed, 21
 Sep 2022 09:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721121152.4180-1-colyli@suse.de> <20220721121152.4180-6-colyli@suse.de>
In-Reply-To: <20220721121152.4180-6-colyli@suse.de>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 22 Sep 2022 00:33:14 +0800
Message-ID: <CALTww29cJe9B6qMB8OztGj7BZt_dVYEBb-XrfWV6FmbMmyCzNA@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] badblocks: improve badblocks_check() for multiple
 ranges handling
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-raid <linux-raid@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 8:12 PM Coly Li <colyli@suse.de> wrote:
>
> This patch rewrites badblocks_check() with similar coding style as
> _badblocks_set() and _badblocks_clear(). The only difference is bad
> blocks checking may handle multiple ranges in bad tables now.
>
> If a checking range covers multiple bad blocks range in bad block table,
> like the following condition (C is the checking range, E1, E2, E3 are
> three bad block ranges in bad block table),
>   +------------------------------------+
>   |                C                   |
>   +------------------------------------+
>     +----+      +----+      +----+
>     | E1 |      | E2 |      | E3 |
>     +----+      +----+      +----+
> The improved badblocks_check() algorithm will divide checking range C
> into multiple parts, and handle them in 7 runs of a while-loop,
>   +--+ +----+ +----+ +----+ +----+ +----+ +----+
>   |C1| | C2 | | C3 | | C4 | | C5 | | C6 | | C7 |
>   +--+ +----+ +----+ +----+ +----+ +----+ +----+
>        +----+        +----+        +----+
>        | E1 |        | E2 |        | E3 |
>        +----+        +----+        +----+
> And the start LBA and length of range E1 will be set as first_bad and
> bad_sectors for the caller.
>
> The return value rule is consistent for multiple ranges. For example if
> there are following bad block ranges in bad block table,
>    Index No.     Start        Len         Ack
>        0          400          20          1
>        1          500          50          1
>        2          650          20          0
> the return value, first_bad, bad_sectors by calling badblocks_set() with
> different checking range can be the following values,
>     Checking Start, Len     Return Value   first_bad    bad_sectors
>                100, 100          0           N/A           N/A
>                100, 310          1           400           10
>                100, 440          1           400           10
>                100, 540          1           400           10
>                100, 600         -1           400           10
>                100, 800         -1           400           10

The question here is that what's the usage of the return value? Now the callers
only check if the return value is 0 or not.

>
> In order to make code review easier, this patch names the improved bad
> block range checking routine as _badblocks_check() and does not change
> existing badblock_check() code yet. Later patch will delete old code of
> badblocks_check() and make it as a wrapper to call _badblocks_check().
> Then the new added code won't mess up with the old deleted code, it will
> be more clear and easier for code review.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> Cc: Xiao Ni <xni@redhat.com>
> ---
>  block/badblocks.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index d3fa53594aa7..cbc79f056f74 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -1261,6 +1261,103 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>         return rv;
>  }
>
> +/* Do the exact work to check bad blocks range from the bad block table */
> +static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
> +                           sector_t *first_bad, int *bad_sectors)
> +{
> +       int unacked_badblocks, acked_badblocks;
> +       int prev = -1, hint = -1, set = 0;
> +       struct badblocks_context bad;
> +       unsigned int seq;
> +       int len, rv;
> +       u64 *p;
> +
> +       WARN_ON(bb->shift < 0 || sectors == 0);
> +
> +       if (bb->shift > 0) {
> +               sector_t target;
> +
> +               /* round the start down, and the end up */
> +               target = s + sectors;
> +               rounddown(s, bb->shift);
> +               roundup(target, bb->shift);
> +               sectors = target - s;
> +       }
> +
> +retry:
> +       seq = read_seqbegin(&bb->lock);
> +
> +       p = bb->page;
> +       unacked_badblocks = 0;
> +       acked_badblocks = 0;
> +
> +re_check:
> +       bad.start = s;
> +       bad.len = sectors;
> +
> +       if (badblocks_empty(bb)) {
> +               len = sectors;
> +               goto update_sectors;
> +       }
> +
> +       prev = prev_badblocks(bb, &bad, hint);
> +
> +       /* start after all badblocks */
> +       if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
> +               len = sectors;
> +               goto update_sectors;
> +       }

It's same with patch 4 here about !overlap_front
> +

It doesn't check prev<0 situation here. Is it right? The prev can be -1 here.
overlap_front will check p[-1].

> +       if (overlap_front(bb, prev, &bad)) {
> +               if (BB_ACK(p[prev]))
> +                       acked_badblocks++;
> +               else
> +                       unacked_badblocks++;
> +
> +               if (BB_END(p[prev]) >= (s + sectors))
> +                       len = sectors;
> +               else
> +                       len = BB_END(p[prev]) - s;
> +
> +               if (set == 0) {
> +                       *first_bad = BB_OFFSET(p[prev]);
> +                       *bad_sectors = BB_LEN(p[prev]);
> +                       set = 1;
> +               }
> +               goto update_sectors;
> +       }
> +
> +       /* Not front overlap, but behind overlap */
> +       if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
> +               len = BB_OFFSET(p[prev + 1]) - bad.start;
> +               hint = prev + 1;
> +               goto update_sectors;
> +       }

same with patch 4 here

Regards
Xiao


> +
> +       /* not cover any badblocks range in the table */
> +       len = sectors;
> +
> +update_sectors:
> +       s += len;
> +       sectors -= len;
> +
> +       if (sectors > 0)
> +               goto re_check;
> +
> +       WARN_ON(sectors < 0);
> +
> +       if (unacked_badblocks > 0)
> +               rv = -1;
> +       else if (acked_badblocks > 0)
> +               rv = 1;
> +       else
> +               rv = 0;
> +
> +       if (read_seqretry(&bb->lock, seq))
> +               goto retry;
> +
> +       return rv;
> +}
>
>  /**
>   * badblocks_check() - check a given range for bad sectors
> --
> 2.35.3
>

