Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFFC32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13B206B8
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 19:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfIHDkgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGaTnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:43:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35751 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfGaTnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 15:43:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so50185747qke.2;
        Wed, 31 Jul 2019 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecd6W3R0njrZioVOViuV3qXfRmYn4ujysQP/38uUwIs=;
        b=HfIHDkguJb3ZRYwzgBkmFRZLtuaEDVZSijTkkU6OU5dA6nj+YNI+LeXUmXqJiO78VY
         Ozj1zpqa1qocj3+wrJzu7iOYZDWOXxdUfXSepdWdV8691/mjHWoTrkywANkfWlOnlTqB
         fcUSGd8E/Tic7myXmw/SnXWzMM6Qvt23V+CUPjg71jsS6ibbBh/0kiIhvxuR8V5aGVPs
         oZyn2gv4qWkuCPRMeoTrG4lRt/m+mAVczt7We+Zmg9qdcdIpNfXdAXbs3aKH2qmYvY2m
         J8A7CVRBLGDlkuyl1DjgnroR0+yW6aRKiaHml7hS1QSr/fSF6UP3OJiFY9PBm92Rlz7X
         eIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecd6W3R0njrZioVOViuV3qXfRmYn4ujysQP/38uUwIs=;
        b=G4nfq4v7EQJfihQvuDg+TF2wdfETibveleVF/59yIq6YdnCYJsKQ+MWWW5kdlJsZNM
         N1JIMJXu3gEjIlJ3AA7cN8eHHeePgW/qXu5hmM7ncaNNNM8a9b4EJs0+iyQ2HyDPM9qH
         d/nBQY0BhPl4V/vYqjs4ZXzFGO2B/efSsqwlCLZHYLuZpZhDYSnxloEZdJ8bb0kHvAOp
         fC0ssgN/fqBN4AfeS1+5E8E1PDe42ptT8ndZkk4M+NJ3osxJyBFL3DZViF004zeHYZ4U
         HL0zu0sgEMnjv7DAItRCZYT1QBTaAOZOVnEfvazM4k8mCrTdo6sXTB31Nv4aaorqLLWw
         aHCg==
X-Gm-Message-State: APjAAAWGZPhfLWy9NgVS6X5dWYS8h1zT4W6uPwKAAYDOBrCXPh4ycYwI
        uqFCR+WvPSJIeZKnZUckTIwbhKZt56wfoLst3Cv3IQ==
X-Google-Smtp-Source: APXvYqzJlHprzYhgXCO8ToMunyG6J6KTS71kSqu69XXhwF0MPxdW19nGEvyN0u77PMCkV2eG+onE1l5N7+OHsoGXOsA=
X-Received: by 2002:a37:a854:: with SMTP id r81mr83164982qke.378.1564602194417;
 Wed, 31 Jul 2019 12:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190729203135.12934-1-gpiccoli@canonical.com> <20190729203135.12934-2-gpiccoli@canonical.com>
In-Reply-To: <20190729203135.12934-2-gpiccoli@canonical.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 12:43:03 -0700
Message-ID: <CAPhsuW5n9TCZjVT3QnFhHkbfPTvh7ifFiNXypOHouL5ByZS7+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for raid0
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 29, 2019 at 1:33 PM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> Currently if a md/raid0 array gets one or more members removed while
> being mounted, kernel keeps showing state 'clean' in the 'array_state'
> sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
> cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.
>
> Nothing else hints that something is wrong (except that the removed devices
> don't show properly in the output of 'mdadm detail' command). There is no
> other property to be checked, and if user is not performing reads/writes
> to the array, even kernel log is quiet and doesn't give a clue about the
> missing member.
>
> This patch changes this behavior; when 'array_state' is read we introduce
> a non-expensive check (only for raid0) that relies in the comparison of
> the total number of disks when array was assembled with gendisk flags of
> those devices to validate if all members are available and functional.
> A new array state 'broken' was added: it mimics the state 'clean' in every
> aspect, being useful only to distinguish if such array has some member
> missing. Also, we show a rate-limited warning in kernel log in such case.
>
> This patch has no proper functional change other than adding a 'clean'-like
> state; it was tested with ext4 and xfs filesystems. It requires a 'mdadm'
> counterpart to handle the 'broken' state.
>
> Cc: NeilBrown <neilb@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
>
[...]
> @@ -4315,6 +4329,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>                 break;
>         case write_pending:
>         case active_idle:
> +       case broken:
>                 /* these cannot be set */
>                 break;
>         }

Maybe it is useful to set "broken" state? When user space found some issues
with the drive?

Thanks,
Song


> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 41552e615c4c..e7b42b75701a 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -590,6 +590,8 @@ struct md_personality
>         int (*congested)(struct mddev *mddev, int bits);
>         /* Changes the consistency policy of an active array. */
>         int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
> +       /* Check if there is any missing/failed members - RAID0 only for now. */
> +       bool (*is_missing_dev)(struct mddev *mddev);
>  };
>
>  struct md_sysfs_entry {
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index 58a9cc5193bf..79618a6ae31a 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -455,6 +455,31 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
>         }
>  }
>
> +bool raid0_is_missing_dev(struct mddev *mddev)
> +{
> +       struct md_rdev *rdev;
> +       static int already_missing;
> +       int def_disks, work_disks = 0;
> +       struct r0conf *conf = mddev->private;
> +
> +       def_disks = conf->strip_zone[0].nb_dev;
> +       rdev_for_each(rdev, mddev)
> +               if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
> +                       work_disks++;
> +
> +       if (unlikely(def_disks - work_disks)) {
> +               if (!already_missing) {
> +                       already_missing = 1;
> +                       pr_warn("md: %s: raid0 array has %d missing/failed members\n",
> +                               mdname(mddev), (def_disks - work_disks));
> +               }
> +               return true;
> +       }
> +
> +       already_missing = 0;
> +       return false;
> +}
> +
>  static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>  {
>         struct r0conf *conf = mddev->private;
> @@ -789,6 +814,7 @@ static struct md_personality raid0_personality=
>         .takeover       = raid0_takeover,
>         .quiesce        = raid0_quiesce,
>         .congested      = raid0_congested,
> +       .is_missing_dev = raid0_is_missing_dev,
>  };
>
>  static int __init raid0_init (void)
> --
> 2.22.0
>
