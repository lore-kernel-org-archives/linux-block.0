Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CA6AB6
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712282682; cv=none; b=tTrhvTB4W85LHkSI31KQT4L1I0JGuOqtIn1B2872810sxS5OX9ac3MQU4xReG0bYhe6jBHEeVE2QLVhhKqb6BIWfOZewZeKp0L/CUmS3XqS7LpxE7Q3lN52AqljLKshJUtC45btjcz7zjDdnyOibX46KKjPKieiCGr5dD/KfWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712282682; c=relaxed/simple;
	bh=TbVraGea54Qc8XSQSOasf93JwevlYduRh7H51MUFWfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMEXVbTrYwxUHl0ckYRkN/vBwYIg4DxHDGliOLFYRBQmf/htIgs/uKg3GowfsZ8u4TcubemL8udndEBpNIrWWGCrA+qDmaUWWXCVSoXP2mz2vob+eEdDb8BAHzpqdnjGtYmwPo1CEvDQwlxgdqXtyT2P3UVFRwOL+mFfqGgJaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BD3VH9V3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD3VH9V3"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-430d3fcc511so100451cf.1
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2024 19:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712282679; x=1712887479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGa2BGtI6b8N/SaKuk+ytr+d2XPQ0iXts/BUxTpGdE0=;
        b=BD3VH9V3kksRUsEoEv+hXhqlJtE3nIp4DcM6NlYJnuApHEMOJnXdNDnZ7CoYVn05+U
         fpctfNYwarw2bZCQTRseqyz2M3XsnZdUxcuqJvJ1gxDeNEdAJOtKnUDtP/b1kKPvhrrS
         puTt0QiNPBaIHp3LEbzFsGPB9RSTsW43FtF+G8nhAoEBHWZaJV+kFxgQ2qNaOrodrqWQ
         bLYwncw33AFNoqP9k+cIN1n0wAUvpW8UHbyzkzmNow0lu8MmgrCcUm1s6jtDZ/WGY4eW
         j3i6tOJeYKBy/IGFEsF8HNl5wcYj1vUH9+i1YE4VoDJcLrW/x2Z2w/7WKyhvFxDK5mxl
         sZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712282679; x=1712887479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGa2BGtI6b8N/SaKuk+ytr+d2XPQ0iXts/BUxTpGdE0=;
        b=hXV73yH0CJQI68qdYG1GRtRUuD8axXtbOHGX9KzSLSgjEVQHowtjy9RKj6NIys51DI
         jfwfrJDI1dLYeIR2z9OKQEu82iv/hEsIoo6qB7qjDwzR6+hEog5ImBmiKaCnzvbVn8Fe
         Ya8ysZeI9h4nMZdKrX2FUG95NssRTvrEPAKSeejgbPOa8DmMCaOGoZ3DzioJqCrxT5eJ
         k3oaKHyuS2L1ptVkBzHnd1+tRkvVvUSCjYU8erlpYlhIxFxr1jqCX6k6ggBDf0HpJfDx
         QXU4feSz4DZm+CxKDNYhM7Mq0fOKvm49WLTcDyi3VK+ZeonQ8k6qee08kjBI0n7S+IPG
         S3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/lKcCjXNbR/vbDYBo43MEhIOiX8XqA08vgL20RSZGwe+xBVb38zlFEKmb41pBG5d4aG3VY+DuQKm0ZWF40lpfa5TMs1t4bYHvw00=
X-Gm-Message-State: AOJu0Yyb1kgEI5P9KKK49SL78sRGA1ZlfeNJndBpKT9qBUT9t+deHuvS
	oOcuYyCS4C4XL7x6gGn8m7Sq6avZ5jGrTd83TUi8HwPtofjjER8aauwSjx9JIt2WS61eo7K+c29
	71BLnUwYioxUmwAonHwkPlKeA1b3Z9mcGJcMD
X-Google-Smtp-Source: AGHT+IEfqAS8jX1x6XBBCxbPrxdrPgAvB885usMAAz2VD2ofd49C6CKXNmQwpGR80iEZevn1MKOquO7vUAfZNLqcIVs=
X-Received: by 2002:a05:622a:1b19:b0:434:36fe:6d3 with SMTP id
 bb25-20020a05622a1b1900b0043436fe06d3mr395690qtb.0.1712282679277; Thu, 04 Apr
 2024 19:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
 <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
 <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
 <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com>
 <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com> <CAP9s-SrXvm5MfhXCMBYfsEv9xKWqvkkLp2ZjndYrJ65m5x8M_w@mail.gmail.com>
 <20240308163237.GA17159@lst.de> <CAP9s-Sq7YHbcbUBMV==d+cz0yK-zB9zKzFJhVMkPWJKfV1gLpA@mail.gmail.com>
 <20240320015134.GA14267@lst.de>
In-Reply-To: <20240320015134.GA14267@lst.de>
From: Saranya Muruganandam <saranyamohan@google.com>
Date: Thu, 4 Apr 2024 19:04:26 -0700
Message-ID: <CAP9s-SrXqgWv4rF3EGRahtuwKU7yJFaoOcSROgrbFkhaWLEVsg@mail.gmail.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, sashal@kernel.org, Ming Lei <ming.lei@redhat.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,
Apologies for the delay.

Thanks a ton for your patch! Your patch solution works for me.
I sent https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@goo=
gle.com/
for the block layer patch
and https://lore.kernel.org/all/20240405015657.751659-1-saranyamohan@google=
.com/
for the blktest added.

Once I get confirmation that they look good, I have the changes for
the older LTS which I can share.
This patch doesn't cleanly apply but your idea of flagging and using
that to return errors, fixes the regression
for stable kernels like 5.10.

Thanks again.

-Saranya


On Tue, Mar 19, 2024 at 6:51=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Please try the patch below:
>
> I would also relly help to have a blktsts test case to show your
> issue and verify that it is fixed.
>
> diff --git a/block/bdev.c b/block/bdev.c
> index e7adaaf1c21927..51071d371863e0 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -645,6 +645,14 @@ static void blkdev_flush_mapping(struct block_device=
 *bdev)
>         bdev_write_inode(bdev);
>  }
>
> +static void blkdev_put_whole(struct block_device *bdev)
> +{
> +       if (atomic_dec_and_test(&bdev->bd_openers))
> +               blkdev_flush_mapping(bdev);
> +       if (bdev->bd_disk->fops->release)
> +               bdev->bd_disk->fops->release(bdev->bd_disk);
> +}
> +
>  static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
>  {
>         struct gendisk *disk =3D bdev->bd_disk;
> @@ -663,20 +671,21 @@ static int blkdev_get_whole(struct block_device *bd=
ev, blk_mode_t mode)
>
>         if (!atomic_read(&bdev->bd_openers))
>                 set_init_blocksize(bdev);
> -       if (test_bit(GD_NEED_PART_SCAN, &disk->state))
> -               bdev_disk_changed(disk, false);
>         atomic_inc(&bdev->bd_openers);
> +       if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
> +               /*
> +                * Only return scanning errors if we are called from cone=
xts
> +                * that explicitly want them, e.g. the BLKRRPART ioctl.
> +                */
> +               ret =3D bdev_disk_changed(disk, false);
> +               if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
> +                       blkdev_put_whole(bdev);
> +                       return ret;
> +               }
> +       }
>         return 0;
>  }
>
> -static void blkdev_put_whole(struct block_device *bdev)
> -{
> -       if (atomic_dec_and_test(&bdev->bd_openers))
> -               blkdev_flush_mapping(bdev);
> -       if (bdev->bd_disk->fops->release)
> -               bdev->bd_disk->fops->release(bdev->bd_disk);
> -}
> -
>  static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
>  {
>         struct gendisk *disk =3D part->bd_disk;
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 0c76137adcaaa5..128f503828cee7 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
>                         return -EACCES;
>                 if (bdev_is_partition(bdev))
>                         return -EINVAL;
> -               return disk_scan_partitions(bdev->bd_disk, mode);
> +               return disk_scan_partitions(bdev->bd_disk,
> +                               mode | BLK_OPEN_STRICT_SCAN);
>         case BLKTRACESTART:
>         case BLKTRACESTOP:
>         case BLKTRACETEARDOWN:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f9b87c39cab047..272ce42f297cfe 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
>  #define BLK_OPEN_WRITE_IOCTL   ((__force blk_mode_t)(1 << 4))
>  /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
>  #define BLK_OPEN_RESTRICT_WRITES       ((__force blk_mode_t)(1 << 5))
> +/* return partition scanning errors */
> +#define BLK_OPEN_STRICT_SCAN   ((__force blk_mode_t)(1 << 5))
>
>  struct gendisk {
>         /*
