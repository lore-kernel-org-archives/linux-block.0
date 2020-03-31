Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B5BC2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A424520848
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Ks8if2Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgCaLmY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:42:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36658 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgCaLmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 07:42:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id b1so1051663ljp.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnWN8DqzuQ82SBOonEsWSdRJLlx4dvxhu0twnu0L8+8=;
        b=Ks8if2UmQWpY0KUNiEGWSp4dXTm2ToAFADuX09PCko8UU6gbSEIREaJFpP9g2vVHUs
         Pu7/KKBMZ3DOqC8CfnZI8DIIW0q6HSrHiYShE1DkbNjOQjcRSL0HrDiNMg69NXFQq06R
         giElUccqXH5JEIVNMcOqEmL2eyRg+EpVzovHb2MpyCR1lC9kUfzmzMgj3/LS4YIAKwmw
         yPBSf6Bko96tySfO1SiZz4+oDeB7G4/9PtnCTA2n+f0MS8L6ocsq5+XkkNE1558jFNpr
         Y2rBWi6y7pbxmu+4JtHGeydnH/I6TVBsCS/kHQR3ciHF9Zx8IxF2v+NcGthOEY5X82sM
         /H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnWN8DqzuQ82SBOonEsWSdRJLlx4dvxhu0twnu0L8+8=;
        b=roc+15Aoe60A87AenCNEJ7v87puliXJRuP67PSQ4/KKfQuus87e37b7sQN92kugO/F
         awD0sxLVerxzFOzXI5VOAAzL04BbwL82effsSdNjBNIUzofbnWhBLWP+U/o9dCq3G9sz
         bNENiyCJjZTK+RQF/Y2Q0Y9wtjts3Lzqr4X8nvGtf0AyVQs7QZJO9oXwKGRaEWAJuX48
         p3IwUjtxRlBU9LArCPzwkTO6cjuXECOIO81K+s9wVoNtb18AlIhbDSSyV3Aq+T8byZwv
         oVn224i9+Gopx979udqeFhxgrHmAU0aW7K+ioppjoLumnD2zS9CA0QjhOZN3l1siPkZj
         PDXQ==
X-Gm-Message-State: AGi0PuZmL8LqLa59Ja+xvJQeaW76SarcY+/96ZI8ITacnQkkk0+pOjsB
        53VmSP4Q4QUIXV0iMfDBN9EZ15tj5tfJWv7rYylGPw==
X-Google-Smtp-Source: APiQypKzJSEX4lABP1pT2ErR0/PRzLKP/j0/GkUM+1M20Kum6aliBzA4bquVT/zBPrnBj1DsvUsnaI6gvlVqrK6DOxE=
X-Received: by 2002:a2e:b4b9:: with SMTP id q25mr10348966ljm.104.1585654940277;
 Tue, 31 Mar 2020 04:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114030.21262-1-maco@android.com>
In-Reply-To: <20200331114030.21262-1-maco@android.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 31 Mar 2020 13:42:09 +0200
Message-ID: <CAB0TPYHvcayfCgHhpe4rRq5zOkn+iyJ6x9KddepnBsSC78_vZw@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apologies for the resend, will follow up with a new series.

Martijn

On Tue, Mar 31, 2020 at 1:40 PM Martijn Coenen <maco@android.com> wrote:
>
> Configuring a loop device for a filesystem that is located at an offset
> currently requires calling LOOP_SET_FD and LOOP_SET_STATUS(64)
> consecutively. This has some downsides.
>
> The most important downside is that it can be slow. Here's setting
> up ~70 regular loop devices on an x86 Android device:
>
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r /dev/block/loop$i com.android.adbd.apex; done
>     0m01.85s real     0m00.01s user     0m00.01s system
>
> Here's configuring ~70 devices in the same way, but with an offset:
>
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m03.40s real     0m00.02s user     0m00.03s system
>
> This is almost twice as slow; the main reason for this slowness is that
> LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to freeze the associated
> queue; this requires waiting for RCU synchronization, which I've
> measured can take about 15-20ms on this device on average.
>
> A more minor downside of having to do two ioctls is that on devices with
> max_part > 0, the kernel will initiate a partition scan, which is
> needless work if the image is at an offset.
>
> This change introduces a new ioctl to combine setting the backing file
> together with the offset, which avoids the above problems. Adding more
> parameters could be a consideration, but offset appears to be the only
> commonly used parameter that is required for accessing the device
> safely.
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/block/loop.c      | 25 +++++++++++++++++++------
>  include/uapi/linux/loop.h |  6 ++++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a42c49e04954..517031e1d10c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -932,8 +932,8 @@ static void loop_update_rotational(struct loop_device *lo)
>                 blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
>  }
>
> -static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> -                      struct block_device *bdev, unsigned int arg)
> +static int loop_set_fd_with_offset(struct loop_device *lo, fmode_t mode,
> +               struct block_device *bdev, unsigned int arg, loff_t offset)
>  {
>         struct file     *file;
>         struct inode    *inode;
> @@ -957,7 +957,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>          * here to avoid changing device under exclusive owner.
>          */
>         if (!(mode & FMODE_EXCL)) {
> -               claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
> +               claimed_bdev = bd_start_claiming(bdev, loop_set_fd_with_offset);
>                 if (IS_ERR(claimed_bdev)) {
>                         error = PTR_ERR(claimed_bdev);
>                         goto out_putf;
> @@ -1002,6 +1002,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>         lo->transfer = NULL;
>         lo->ioctl = NULL;
>         lo->lo_sizelimit = 0;
> +       lo->lo_offset = offset;
>         lo->old_gfp_mask = mapping_gfp_mask(mapping);
>         mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
>
> @@ -1042,14 +1043,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>         if (partscan)
>                 loop_reread_partitions(lo, bdev);
>         if (claimed_bdev)
> -               bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
> +               bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_with_offset);
>         return 0;
>
>  out_unlock:
>         mutex_unlock(&loop_ctl_mutex);
>  out_bdev:
>         if (claimed_bdev)
> -               bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
> +               bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_with_offset);
>  out_putf:
>         fput(file);
>  out:
> @@ -1601,7 +1602,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>
>         switch (cmd) {
>         case LOOP_SET_FD:
> -               return loop_set_fd(lo, mode, bdev, arg);
> +               return loop_set_fd_with_offset(lo, mode, bdev, arg, 0);
>         case LOOP_CHANGE_FD:
>                 return loop_change_fd(lo, bdev, arg);
>         case LOOP_CLR_FD:
> @@ -1624,6 +1625,17 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>                 break;
>         case LOOP_GET_STATUS64:
>                 return loop_get_status64(lo, (struct loop_info64 __user *) arg);
> +       case LOOP_SET_FD_WITH_OFFSET: {
> +               struct loop_fd_with_offset fdwo;
> +
> +               if (copy_from_user(&fdwo,
> +                               (struct loop_fd_with_offset __user *) arg,
> +                               sizeof(struct loop_fd_with_offset)))
> +                       return -EFAULT;
> +
> +               return loop_set_fd_with_offset(lo, mode, bdev, fdwo.fd,
> +                               fdwo.lo_offset);
> +       }
>         case LOOP_SET_CAPACITY:
>         case LOOP_SET_DIRECT_IO:
>         case LOOP_SET_BLOCK_SIZE:
> @@ -1774,6 +1786,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>         case LOOP_SET_CAPACITY:
>         case LOOP_CLR_FD:
>         case LOOP_GET_STATUS64:
> +       case LOOP_SET_FD_WITH_OFFSET:
>         case LOOP_SET_STATUS64:
>                 arg = (unsigned long) compat_ptr(arg);
>                 /* fall through */
> diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
> index 080a8df134ef..289829bc5abd 100644
> --- a/include/uapi/linux/loop.h
> +++ b/include/uapi/linux/loop.h
> @@ -60,6 +60,11 @@ struct loop_info64 {
>         __u64              lo_init[2];
>  };
>
> +struct loop_fd_with_offset {
> +       __u64          lo_offset;
> +       __u32          fd;
> +};
> +
>  /*
>   * Loop filter types
>   */
> @@ -90,6 +95,7 @@ struct loop_info64 {
>  #define LOOP_SET_CAPACITY      0x4C07
>  #define LOOP_SET_DIRECT_IO     0x4C08
>  #define LOOP_SET_BLOCK_SIZE    0x4C09
> +#define LOOP_SET_FD_WITH_OFFSET        0x4C0A
>
>  /* /dev/loop-control interface */
>  #define LOOP_CTL_ADD           0x4C80
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
