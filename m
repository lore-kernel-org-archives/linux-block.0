Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA3DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 19:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiF1THL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiF1THD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 15:07:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460F2AF4
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 12:07:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l6so11891985plg.11
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=5XiObti8BsP16YfB0rspVAhnTmSyUAnY3mOSBfXdw04=;
        b=OBtmNRKZgD2LedPY1HBGJ1Drqv2Xlyp3pXhqIhEQoPm6UZ41HWt5I04wAm9SWZf4/Y
         Sf1kig0VRAM8Hy78vxzpMgOjytgAvF6TqevA3/gE9KzTgM/3coJ30VhYk1VTO4TIDLKk
         GoNd1T53PHZy/ufCS2i2AAJKsoyHV1hrIPeTV1tNfwAdakgYz9gFv02LCVbF78fmELcf
         dZ+DTekMGwgSkjWs3nAgaczPqNCKfJaZSuFrdJBtyJDXVg2iUxyreGqUT8lklAzrU5SB
         Gt+W1r+dCiPPodOQChJmjMdO0l2i107rxkyNX+ikieLr11hDpGFiYbMgavDd3itRIT0P
         6Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=5XiObti8BsP16YfB0rspVAhnTmSyUAnY3mOSBfXdw04=;
        b=3cmuPkywkrEBrPPnC32PWorX/SYbZPx12dG8w9/HBBEgowJzAbZIdlOMSczHydY4fG
         UNH1JQVK0ywT4lB2p7DkCVlh5GD5EB8qycux+GAMdsxWmwt4qR+jU51HvXUVHcAymKSu
         9WFFvoF819sN/X1eXoLHuU81n4GMgAsH0Z4Wn5HGMnITD1d/teQ/1uQeHfdl33suzfT2
         GS2jFqP0THckQnT1FNdVKJSXs29GjbuizqaCQ2Sh92943qNEnqNWaOs2tScNj0l1xZXN
         ljv8rzH0JNeqOHIPOnrsh1CHi6x604g9FyM87UKJb1goeQR0VuJEkLFZ0MWK4y4jwluH
         RIWQ==
X-Gm-Message-State: AJIora8zoddabqWWlRg7z6lF39HR3WVL4SmW3NlnZ0bCasckWUBWHJDL
        tZaoxhN5eIvCvJAJ8tCO1mkF17CUlGTJGg==
X-Google-Smtp-Source: AGRyM1tteAyoM7QiQfWIK4qJ2PFQIUfh+VJ9EFe3kzq8BcNMD7Sv68D/drVHxJl18ilK8Gb3mCcQYA==
X-Received: by 2002:a17:902:d389:b0:16a:17c6:35f2 with SMTP id e9-20020a170902d38900b0016a17c635f2mr5130744pld.56.1656443220837;
        Tue, 28 Jun 2022 12:07:00 -0700 (PDT)
Received: from [127.0.1.1] ([2620:10d:c090:400::5:f46f])
        by smtp.gmail.com with ESMTPSA id jf17-20020a17090b175100b001ec86a0490csm193768pjb.32.2022.06.28.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:07:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220628171850.1313069-1-hch@lst.de>
References: <20220628171850.1313069-1-hch@lst.de>
Subject: Re: cleanup block layer sysfs handling v2
Message-Id: <165644321993.1363166.7043993410810199559.b4-ty@kernel.dk>
Date:   Tue, 28 Jun 2022 13:06:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 28 Jun 2022 19:18:44 +0200, Christoph Hellwig wrote:
> this series cleans up various loose ends in the block layer sysfs handling.
> 
> Changes since v1:
>  - trivial whitespace and spelling fixes
> 
> Diffstat:
>  block/blk-mq-sysfs.c         |   45 +++++++++++++++++++++----------------------
>  block/blk-mq.c               |    4 +--
>  block/blk-mq.h               |    7 +++---
>  block/blk-sysfs.c            |   36 ++++++++++------------------------
>  block/blk.h                  |    2 +
>  block/genhd.c                |    3 ++
>  block/partitions/core.c      |    1
>  include/linux/blk-mq.h       |    1
>  include/linux/blktrace_api.h |   10 ---------
>  kernel/trace/blktrace.c      |   11 ----------
>  10 files changed, 44 insertions(+), 76 deletions(-)
> 
> [...]

Applied, thanks!

[1/6] block: simplify blktrace sysfs attribute creation
      commit: cc5c516df028b221d94c65c47c5ae8d20f61b6f9
[2/6] block: remove a superflous queue kobject reference
      commit: 060f131e9c438837f9792e456fae424e621fb881
[3/6] block: use default groups to register the queue attributes
      commit: 4a8d14bba486cca6880062f1ef240cf1d45f3367
[4/6] block: remove the extra gendisk reference in __blk_mq_register_dev
      commit: 81f0c2ef41b02185928563899cd4d618ffc7eebf
[5/6] blk-mq: rename blk_mq_sysfs_{,un}register
      commit: eaa870f97544668025ba1f96ee267abac7b3c73c
[6/6] blk-mq: cleanup disk sysfs registration
      commit: 8682b92e5ab852b93739a0f2b261fff4c733be57

Best regards,
-- 
Jens Axboe


