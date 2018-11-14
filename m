Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6268C43610
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DF0223CB
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BceZEl7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DF0223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKNMyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:54:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeKNMyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 07:54:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so13331776wmc.4;
        Tue, 13 Nov 2018 18:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQgS1oR6xmGxJOBWtnAb1dNG4I2wGhmz1XkBvuRnVg8=;
        b=BceZEl7ozpnfSPuBLdRXUVSH132FWxPeQvCC939CklD9Kfl5My6sDOtEhsvWP7wXio
         nfKsorQ05FPIUBcvYPAQr5XYn9wyBhk8DGu1qx4Rrck6f/h38r5Y35oQUQJ3uakghjWs
         XL07AtIrlE0utEXfTM3gGRc1fvmk0T61IYroDuXxvF7bmiWhlY8bW6HTbzj3Ymx5CCBe
         r3mYdQYJQNtImNr1DbVo6/tS4PceBBr02CpZZYYv6y3cckHrtBSyJKcmSRm1S998TW1L
         rn0xXwsx5e4OwfWqHVDUX2lXCnmecYa5OdtSZrCFM/5x472pinUgRVgCRICfZrsJ3xhl
         ccxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQgS1oR6xmGxJOBWtnAb1dNG4I2wGhmz1XkBvuRnVg8=;
        b=Qs5IbgRMGkBhqBoPclDaikPnp/qt3Yv7cvkIo9+LkHQ9xl4csiwn2Y+XDyV5DeZnIZ
         gQtMJb6VoJWooRQivDBC/WaozqgATjGWoMDY8lod6CHE0Zlav5gBTJuLhzp0Gnv/q+3+
         KGI/FNuD9VaMmfn1daGyBDd5iA/9ftedVSb9P+BTEYvdlnrWtnRrF+3CiGr3hykx7x19
         oYjijjarFjbH1fmU6ypzW0equ1ycXLW1hmnrvQT9aPVbsWo6sblyJkKKFNksBbsYgIvd
         gzoliURTz9HSA6QtEYLLjuWrYx5nWKXpzsdV8fWS6VEqAKdH9XRFOSXhRy+KA8ONtcdk
         /qtg==
X-Gm-Message-State: AGRZ1gIuj46+f5E9Nhd0kaaBK6b7L38MUJMg2YxIW3UiTMQt4ItTBYq5
        ep0ZpHabhDV7EL30cYxMlDM0HzcISeAr5FM39DzYwYZR2b0=
X-Google-Smtp-Source: AJdET5dZKdnKwJ/QZ05UWGg+fTVg4J51KyCZjJvmfq39JYfxxlRafLj7LcaS9ZOKl90hKRuCVXyr74AyO7h/bDgY2TE=
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr366266wmf.56.1542164002858;
 Tue, 13 Nov 2018 18:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20181113214337.20581-1-david@fromorbit.com>
In-Reply-To: <20181113214337.20581-1-david@fromorbit.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 14 Nov 2018 10:53:11 +0800
Message-ID: <CACVXFVPS8RRYw4g-UjaDFW1Mrx_tv5V6SsSyKeQ9pyBLi2zrFA@mail.gmail.com>
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
To:     Dave Chinner <david@fromorbit.com>
Cc:     "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 5:44 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
> fall into an endless loop in the discard code. The test is creating
> a device that is exactly 2^32 sectors in size to test mkfs boundary
> conditions around the 32 bit sector overflow region.
>
> mkfs issues a discard for the entire device size by default, and
> hence this throws a sector count of 2^32 into
> blkdev_issue_discard(). It takes the number of sectors to discard as
> a sector_t - a 64 bit value.
>
> The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> takes this sector count and casts it to a 32 bit value before
> comapring it against the maximum allowed discard size the device
> has. This truncates away the upper 32 bits, and so if the lower 32
> bits of the sector count is zero, it starts issuing discards of
> length 0. This causes the code to fall into an endless loop, issuing
> a zero length discards over and over again on the same sector.
>
> Fixes: ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  block/blk-lib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e8b3bb9bf375..144e156ed341 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -55,9 +55,12 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>                 return -EINVAL;
>
>         while (nr_sects) {
> -               unsigned int req_sects = min_t(unsigned int, nr_sects,
> +               sector_t req_sects = min_t(sector_t, nr_sects,
>                                 bio_allowed_max_sectors(q));

bio_allowed_max_sectors(q) is always < UINT_MAX, and 'sector_t' is only
required during the comparison, so another simpler fix might be the following,
could you test if it is workable?

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e8b3bb9bf375..6ef44f99e83f 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -55,7 +55,7 @@ int __blkdev_issue_discard(struct block_device
*bdev, sector_t sector,
                return -EINVAL;

        while (nr_sects) {
-               unsigned int req_sects = min_t(unsigned int, nr_sects,
+               unsigned int req_sects = min_t(sector_t, nr_sects,
                                bio_allowed_max_sectors(q));
>
> +               WARN_ON_ONCE(req_sects == 0);

The above line isn't necessary given 'nr_sects' can't be zero.


Thanks,
Ming Lei
