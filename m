Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A53C83000
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 01:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BD52083B
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 01:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNt0W47d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD3B0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgD3B0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 21:26:06 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4AC035494;
        Wed, 29 Apr 2020 18:26:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w14so2933582lfk.3;
        Wed, 29 Apr 2020 18:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21hAksTDotqpkMDq5xLuGQkVLpud8HtePplRE81B5jU=;
        b=MNt0W47dVdSty8zvvSAY7gxbeSx7TmcNfNDTQ/ciWsZi62PSgPSmu1xDYVRGpuHep0
         KfH/hNEiutHmu+Rt12Q4i6BLevqW0OLXw7mOVnNxRIDzuaWqn3G7fMwMb/Y+gK/5NGfi
         TWb2vS/9Q0lcwDjzCj19/P3vlKInVVJxq+PIwTQTWlfaaxakzjYNr6WhmWIMhltCPkIs
         rD0zsS2PjN+E0POXwnZOHMzT/exL1y8+WkufyFsscNrAYryr8lz0DqyvgJtErcz105Z1
         bRtpwSzP2RMFO05gjqaYem4OcODHR/56vtSYJr2qPdOvCiEBxg8cX5Ru+YLRlA0uR75a
         rOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21hAksTDotqpkMDq5xLuGQkVLpud8HtePplRE81B5jU=;
        b=rNBGLco4vp2SvxofFIM9i+W001/9VVk56h3azjExdtrKZs4dBQ5ljRbODIG1mu6TcT
         r8iWqapp99D4c2KZoZ5KVoNotQycy2C4rkT0VEe050YsKYSGS8F7uOHLcuORYQvMV0PG
         aOFbK28/Xx4bbVQQwRMwz3e9P/DXaJwLlH2N/8eVmoTkbBSE/DUaA136/CWOQ49Q+s0v
         JtDZL6zTiWFb5GnKzUwRsz0WL48UbZKnrdZLJYk9pxB5luKuSCDXzYt7oLiWgwC5rt+b
         KgwuRoXmR55GnVc660jyvnxLsvvZJM8wzd0S3HSRzanq1UkUd6UdlbP5J6z46QDPwx24
         VjwA==
X-Gm-Message-State: AGi0PuYGmtpNagDnyVu5G2sYHhfepzXkstE9frXNsvqYRlseGUFUsgh8
        bMkWL6XeebxibHmco0ZSu3LmMIorUZZ1YfvFyrIFzXPWHLg=
X-Google-Smtp-Source: APiQypIAhL6OppU7Z8eeHJftsz8pmdrVOqiVbrzIQYKvHB2fTjgnYThkeaiKeH99qXj87xW7NANHsfWhX7P73Iwzzek=
X-Received: by 2002:ac2:58f6:: with SMTP id v22mr383803lfo.146.1588209960084;
 Wed, 29 Apr 2020 18:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200426122237.j2ah64uoivp26ioj@debian.debian-2>
In-Reply-To: <20200426122237.j2ah64uoivp26ioj@debian.debian-2>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Thu, 30 Apr 2020 09:23:52 +0800
Message-ID: <CAKq8=3JFn8D1wjd==g0cFov935cyvd=DybCzvWG1PM8NrcMUXw@mail.gmail.com>
Subject: Re: [PATCH -next] block/genhd: align title and output
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 26, 2020 at 8:22 PM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Before the patch:
>
> major minor  #blocks  name
>
>  254        0   57671680 vda
>  254        1   57670656 vda1
>
> After the patch:
>
> major minor   #blocks    name
>
> 254   0       57671680   vda
> 254   1       57670656   vda1
>
> According to LDD3,major device maximun number is 12 bit,as it has 4 char
> placeholders.minor device maximum number is 20 bit(7 char palceholders)
> and keeping 10 char palceholders for blocks tag.If want to keep
> palceholder's numbers dynamiclly, There is more tricks to do that.  So i
> keep it simple.
>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  block/genhd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 06b642b23a07..63a483cf76b9 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1151,7 +1151,7 @@ static void *show_partition_start(struct seq_file *seqf, loff_t *pos)
>
>         p = disk_seqf_start(seqf, pos);
>         if (!IS_ERR_OR_NULL(p) && !*pos)
> -               seq_puts(seqf, "major minor  #blocks  name\n\n");
> +               seq_puts(seqf, "major minor   #blocks    name\n\n");
>         return p;
>  }
>
> @@ -1172,7 +1172,7 @@ static int show_partition(struct seq_file *seqf, void *v)
>         /* show the full disk and all non-0 size partitions of it */
>         disk_part_iter_init(&piter, sgp, DISK_PITER_INCL_PART0);
>         while ((part = disk_part_iter_next(&piter)))
> -               seq_printf(seqf, "%4d  %7d %10llu %s\n",
> +               seq_printf(seqf, "%-4d  %-7d %-10llu %s\n",
>                            MAJOR(part_devt(part)), MINOR(part_devt(part)),
>                            (unsigned long long)part_nr_sects_read(part) >> 1,
>                            disk_name(sgp, part->partno, buf));
> --
> 2.11.0
>
Sorry, Ping again
