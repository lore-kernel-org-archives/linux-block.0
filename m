Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62492C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 22:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiA0W4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbiA0W4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 17:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643324211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4ypfieO2Jyh9U46NiitKLMWIe9+KPUMGQFOBN1h1jsM=;
        b=JCm/h1GS3JWuYeDQkWhXCyqkcZ58QieecUTIhBslacYgds/ni/2XtJBNTmDh1OhFfv7ZAU
        NoogkD2stduSUY8GCPzHRWh2UYhvecyBKxJB0WTiSK7hsCRyJiMhMvChTV70m/cCSnFhgY
        qGh6oGq+tH1QixwJrwS/5ZKhpoRq2qM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-FFp5jJnwNo-Jj7Q95tHulA-1; Thu, 27 Jan 2022 17:56:50 -0500
X-MC-Unique: FFp5jJnwNo-Jj7Q95tHulA-1
Received: by mail-qv1-f70.google.com with SMTP id t2-20020ad45bc2000000b00424bc599ef3so4488207qvt.22
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 14:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ypfieO2Jyh9U46NiitKLMWIe9+KPUMGQFOBN1h1jsM=;
        b=xZY5suLXnKQ3RgdEUsXyOHkQZcei0BUDYyFFmSfrOKMIYdH8iesYPz41S8nIRCKv0n
         2YQsHWGbd8cy4wSMpWQgbD6cwUeMJc2KlQ1alzYVES0lsUT1lmN52WLqtKCZY56mHpAt
         wKbQzrRWD7LEdJhT/M/QLREC1s+4jazfYwJ4FQOW/QpJzTqiTrZAY+WfN+DO7tKTX8qN
         hYtXYRPW2hHDkxOjz5OkVoJbhiLBkShYyj7UfYk9/SHHcOZIS5UIwH+OusdhpfSIjjui
         /0st+JUmRUT6H8df5EePmtssbClVEvOCBhAFpQJNZFCKIrpQ3VqJOSIoO6wltYL8PJv8
         osQQ==
X-Gm-Message-State: AOAM533fKXHKyaCUq/FFP71jd7PTjn+De/440jIKW2QFFjo5YlZEXtD7
        VqkyECrLGgRzNBRo57GnyVfdOhv8UshnIkrXrInQ09YXtKpgD4vnMwTmCe7h5/mC2mQIUw5FQUF
        wY2AjrIG23bM+XngBX3PcHg==
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr4388378qtd.565.1643324209841;
        Thu, 27 Jan 2022 14:56:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmS1pI1ksa1bPtOtG1Lk5tKoq80e0w9eNzyrwLb/Qwj5C/dnVzsFjiOSoSy1ZOXd0q6GooYw==
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr4388368qtd.565.1643324209642;
        Thu, 27 Jan 2022 14:56:49 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m130sm1979335qke.55.2022.01.27.14.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:56:49 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 0/3] block/dm: fix bio-based DM IO accounting
Date:   Thu, 27 Jan 2022 17:56:45 -0500
Message-Id: <20220127225648.28729-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Just over 3 years ago, with commit a1e1cb72d9649 ("dm: fix redundant
IO accounting for bios that need splitting") I focused too narrowly on
fixing the reported potential for redundant accounting for IO totals.
Which, at least mentally for me, papered over how inaccurate all other
bio-based DM's IO accounting is for bios that get split.

This set fixes things up properly by allowing DM to start IO
accounting _after_ IO is submitted and a split is occurred.  The
proper start_time is still established (prior to submission), it is
passed in to a new bio_start_io_acct_time().  This eliminates the need
for any DM hack to rewind block core's excessive accounting in the
face of a split bio recursing back to block core.

All said: If you'd provide your Acked-by(s) I'm happy to send this set
to Linus for v5.17-rc (and shepherd the changes into stable@ kernels).
Or you're welcome to pickup this set to send along (I'd obviously
still do any stable@ backports). NOTE: the 3rd patch references the
linux-dm.git commit id for the 1st patch.. so that'll require tweaking
no matter who sends the changes to Linus.

Please advise, thanks.
Mike

v1 -> v2: made block changes suggested by Christoph

Mike Snitzer (3):
  block: add bio_start_io_acct_time() to control start_time
  dm: revert partial fix for redundant bio-based IO accounting
  dm: properly fix redundant bio-based IO accounting

 block/blk-core.c       | 25 +++++++++++++++++++------
 drivers/md/dm.c        | 20 +++-----------------
 include/linux/blkdev.h |  1 +
 3 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.15.0

