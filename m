Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04355C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 18:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiBBSNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiBBSNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 13:13:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84043C061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 10:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C4C61899
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 18:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7BFC340ED
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825629;
        bh=I9cUeG+o8ociheUF47gyxFEtCVrjUoyuy0FBaKgZn78=;
        h=From:Date:Subject:To:From;
        b=sVms2loOrDRXQVzMvGmXTqKRz26u2C8O8H5G3YOnmaXYUNEl4CFwoV6DizJrHBGU1
         5nNwygSomAYFfozCdFtcMNsy9wPjMbJMmzH662iBYojpXCmIXC5tbV3tA6b3E2ALEh
         MrZX+JPPQeXFAq7Jb/C65pOTAKsr0RcNPbnJ4jtzUgCRap/Q3AL3TruaEvHdFTSh5w
         Ux96uWOFRGV/ZPcu63apKzDPZIuMFkSEEsBjRqXGvZR6hQZf3O3sGOpOUsXNcDGtY/
         OpPjx51J5kixQjYB/XWydfSHcp11iezvG+p4wk0howhGPugc+EOojDePBH5zAYpBgl
         niseBD4yo32KQ==
Received: by mail-yb1-f170.google.com with SMTP id i62so1160270ybg.5
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 10:13:49 -0800 (PST)
X-Gm-Message-State: AOAM5315nGMeQgLxjS7p9h9lbvmqw4NtFqDHjxGSx2lOdKWqYnhcgefQ
        X5tneWAVBYJrgXxqd0fQv+l73WTaQAhO2LfEb4g=
X-Google-Smtp-Source: ABdhPJzQyOuK7Gtw+hbadorktGBU4AKxChQzBWOHJXLcg9FLxp6Mn0T3uTQauP2d+WLGTwEQzsQszDZ4TB+Pv4XI4OU=
X-Received: by 2002:a25:8543:: with SMTP id f3mr25451798ybn.47.1643825628566;
 Wed, 02 Feb 2022 10:13:48 -0800 (PST)
MIME-Version: 1.0
From:   Song Liu <song@kernel.org>
Date:   Wed, 2 Feb 2022 10:13:37 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6UxfwrD0qhqfCg7UFcxUnRqNpL9kscy=kMV+3P1teQ9Q@mail.gmail.com>
Message-ID: <CAPhsuW6UxfwrD0qhqfCg7UFcxUnRqNpL9kscy=kMV+3P1teQ9Q@mail.gmail.com>
Subject: What shall read() return on deleted block device?
To:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph and folks,

While debugging something else, we noticed a behavior change for the following
program:

    main()
    {
        fd = open("/dev/sdXX", O_RDWR | O_CLOEXEC);

        /* delete sdXX by echo 1 > /sys/block/sdXX/device/delete */
        sleep(10); /* to make sure delete finishes */

        ret = read(fd, buf, 4096);
        fprintf(stderr, "ret = %d errno = %d\n", ret, errno)
    }

On older kernel, we got
   ret = -1 errno = EIO;
while on newer kernel, we get
   ret = 0;

git-bisect points to [1]. However, I would not call it a bug caused by [1]. What
actually happens is:

In blkdev_read_iter(),we check
     size = bdev_nr_bytes(bdev);
     if (pos >= size)
          return 0;
     /* do the read, which may return -EIO */

Before [1], size is not set to 0 when the device is deleted.
Therefore, blkdev_read_iter
will not hit pos >= size, and return -EIO. After [1], size is set to
zero on device delete,
so blkdev_read_iter returns 0 after the delete.

I think this is not a bug, but a clear behavior change. However, no
one seems to care
after a year. So the question is, which behavior shall we keep for the
future. And, if we
want to go back to ret = -1, what's the proper fix?

Thanks,
Song

[1] commit a782483cc1f8 ("block: remove the nr_sects field in struct hd_struct")
