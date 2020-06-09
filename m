Return-Path: <SRS0=iQ6z=7W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF42C433DF
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 03:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7612E2078C
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 03:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRUS9EEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgFIDF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFIDF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 23:05:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19024C03E969
        for <linux-block@vger.kernel.org>; Mon,  8 Jun 2020 20:05:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e125so11549028lfd.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uDqUcqY+vvfx55plpgBmBrjH3sq4tW50g4IO68B6Esg=;
        b=kRUS9EEPkw692OwVygJO0VQVCZUpy9Pj6Ekprukuold1Btim3kCNhNS1BD2uZ9uZQK
         N1FpfrbxPDELwIKsYDzYCsOx817nUgU6FXu0uIjTXHIvgICyjJHjAAqruNGH/1pZ4KOY
         wkXSr97nauAa5vx3LLBS8OT6b7MXC4AK2kWmcifs05Mmd9nVTEsUZGJT9eeDDYbMxJVD
         ojMaUH/WnaEpsij8/R5CWhxv5DBOZrEFt4fotXEUAf2RksZ/p+hdi4tU+p0MoU4AkQ2W
         AENEwaTq2phKwvLjOQPa92GRpofGYqFNUR3vlKk8RB5ZmBYbRLDx5grKwLaZTxzqvyUf
         4rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uDqUcqY+vvfx55plpgBmBrjH3sq4tW50g4IO68B6Esg=;
        b=CjJIKVOs/SHS/8/kdp3mJGfHiY5YS20xz3QRzKJCN33vxKPEhz4wuRttHL7sUh7rF4
         2s1w03ps8WF9Q95K9lTsQHKKlnb9LpUd6bTu5d7IhynBAHaY7lcBOe2rYjo+5aDroidH
         9pdbsUTTkoWzrfDe57Wr1tTG+6OSJfsaLHpRP0xAAgdda5kSXbujt5IaKXlkRGKT0SxJ
         Gk4jWwMZETtcmq2v2uySXCf+h44p/zU1+govMryL4cllvY0FbJ5oOLsbWX2VVgu3dQBG
         pFY9obO/hg/qfJ0oZ+vww0ujSldRGDO2FueSM/4ygBquBTR2NyKZ9+RpMS4j92bTnf5a
         UvSQ==
X-Gm-Message-State: AOAM532JSCuy0ttlMd7HW/5BBEP3bWZpss6qIuOsB0ROhk15lUk0oLiv
        dUsuDFdgAgtK2oCu2TyqSGQx7Tk5D4XdxWdJ5it139Tz
X-Google-Smtp-Source: ABdhPJz8puIfTRW4RWNwqab1jIU5o42rbgLw7FmUG45j4EPSzzG7p9pT7fIKJOItKSjXmrnUY8al8yqW73JuNncb2q8=
X-Received: by 2002:a19:c714:: with SMTP id x20mr14190510lff.100.1591671922773;
 Mon, 08 Jun 2020 20:05:22 -0700 (PDT)
MIME-Version: 1.0
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 9 Jun 2020 12:05:11 +0900
Message-ID: <CACOAw_zf5HNDaFtaMBAFYDFQaQj6YaXADke8JGm=A7CYXiCN5w@mail.gmail.com>
Subject: Question about blkdev_issue_zeroout()
To:     linux-block@vger.kernel.org, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi guys,

When I looked into blkdev_issue_zeroout(), I found something that I
cannot understand there. In my understanding, all the submitted bio
will stay in the plug list during plugging. But, I found
submit_bio_wait() calling during the plugging. I guess the below
submit_bio_wait() might wait forever in the lower kernel version like
4.14, because of plugging. If I am wrong, plz, correct me.

     >>>  blk_start_plug(&plug); <<<
        if (try_write_zeroes) {
                ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects,
                                                  gfp_mask, &bio, flags);
        } else if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
                ret = __blkdev_issue_zero_pages(bdev, sector, nr_sects,
                                                gfp_mask, &bio);
        } else {
                /* No zeroing offload support */
                ret = -EOPNOTSUPP;
        }
        if (ret == 0 && bio) {
                ret = submit_bio_wait(bio);
                bio_put(bio);
        }
      >>> blk_finish_plug(&plug); <<<
