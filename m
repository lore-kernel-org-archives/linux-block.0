Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18467C28B2E
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062AD60F9D
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346108AbhIUCRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbhIUB4t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:56:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84EC0313CE
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:50:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v19so13143308pjh.2
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIoT3CHcF6Ui6SUKTLSeS0m12Ndh8eiq7ywYH+1sD+8=;
        b=XrS/I4JfqWkCKG8V0E5V7TUsfi4r56XeofNU3jWswDlz+IdF93Kj/PTaFLuvC7QgK9
         DUBwWm+2vL7riPfws29ww+AwWsypwgSIm8sz4IX8C4bJVp3lWDJFORZFHFjbwPn5mxYR
         Br5U/2fRwRcLcjWl3onWZ4KgpuNH0IWRLVD4IL4QdWCAK2Pp73dzL/+NSxCQVOe7wlRQ
         LLOTdy/m78Ii2ccdfTWWpUr31N0HME/kAKd7VOAXaPY2vB5C7w00QbP8P81wjPnQofGn
         l/G3WVeRF+GTgDOwEtOjLyErYWnL840cltdtInJuw3AvhiJiMUyx8b2PIdbGrj1DOhQ1
         NXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIoT3CHcF6Ui6SUKTLSeS0m12Ndh8eiq7ywYH+1sD+8=;
        b=UkMloLxeAtqpfHQrH370S9SyCry3ckcCzXTqq9me3jh+nEKls/nyThKftgR93pgXw1
         +0sjEXFsbIxaXIWkqdukgHDB6U62fxaVudEqZQVGc2PULpdIrprtBHU+JspRffEi24gF
         U5bLsmMWRbSuedTIgVjEalkMLz04sDA3sTaC/avD5ongr2Kc33CIniJKGHhNVf8B13y2
         SurCSQBvnyAVMS/j9/l39KJJDUR2r7NGonJhAXNXZGk6k+JYcmVSUHigQ8ZaYUHD9+yY
         1HIr+bsfn2frf8dsxDCOwWhU6xctffXzSIiMCB+MwNkP7mrAgGOaOFWARZ6XAKk68fek
         YKCg==
X-Gm-Message-State: AOAM531H1BpmgbegGrxuRmmw6DHCutqm7AJ6tcuc4/Q+6LWEOWpXq1iv
        z5FX6zdPocSWMyBCkCar7W1koguxG4gh3Msd2fduLvp6dZU=
X-Google-Smtp-Source: ABdhPJwiPF8vZVbVc35Iub4ypV+u11zyGNfpowHKQKuKj6XlQ+gogtNtDHMHWMfKf9ZJPTPqzwoOIQXgvVfgvCvtytI=
X-Received: by 2002:a17:902:cec8:b0:13b:9ce1:b3ef with SMTP id
 d8-20020a170902cec800b0013b9ce1b3efmr24874704plg.4.1632181814749; Mon, 20 Sep
 2021 16:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072726.1159572-1-hch@lst.de> <20210920072726.1159572-4-hch@lst.de>
In-Reply-To: <20210920072726.1159572-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 16:50:03 -0700
Message-ID: <CAPcyv4iVL7bevm_MeFnkRK12SkwO4k5aR3-4KOAGMxThmJwOuA@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: warn if ->groups is set when calling add_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 12:30 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The proper API is to pass the groups to device_add_disk, but the code
> used to also allow groups being set before calling *add_disk.  Warn
> about that but keep the group pointer intact for now so that it can
> be removed again after a grace period.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixes: 52b85909f85d ("block: fold register_disk into device_add_disk")
> ---
>  block/genhd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 7b6e5e1cf9564..409cf608cc5bd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -439,7 +439,8 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
>         dev_set_uevent_suppress(ddev, 1);
>
>         ddev->parent = parent;
> -       ddev->groups = groups;
> +       if (!WARN_ON_ONCE(ddev->groups))
> +               ddev->groups = groups;

That feels too compact to me, and dev_WARN_ONCE() might save someone a
git blame to look up the reason for the warning:

    dev_WARN_ONCE(parent, ddev->groups, "unexpected pre-populated
attribute group\n");
    if (!ddev->groups)
        ddev->groups = groups;

...but not a deal breaker. Either way you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Jens, I'm ok for the final spin of this series to go through block.git
since the referenced commits in Fixes: went that route, just let me
know if you want me to take them.
