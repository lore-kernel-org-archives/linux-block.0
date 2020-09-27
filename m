Return-Path: <SRS0=7dNq=DE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BAC4346E
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E692399C
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 20:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjE1nwg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI0U3T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgI0U3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 16:29:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A5C0613CE
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2020 13:29:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so3094498wmh.1
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2020 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=0QuyEWm6rQMqwW2hce/ANbthK7OQhuiFstxlw742Fu0=;
        b=GjE1nwg86XQKc+qR4ZcqjX72KjglRAD09q2yX1VN9msnrMalR/wid+aBwi+poCCQqr
         ZXizdbW792FxS4QMCuDrC8dCZfTE4al3ZfdMn2O5zONE0OfUNklGRt8o+VXcB3Y8lvDh
         cFcDV2WdT+nQZxTk491D74g5ZcQJ6DIBcfAgdQ6J8nhDVK8ARWofJ9HMDpRm+BZ/Gfe0
         naJPdawKZTs7mvNp5MIB1ofnrKXiLiHLHwDuIU7JhBweYMly1gSVUenZw/vGICsqPr6a
         GXt41d/Zn1Vgpg98t2Q76zP9B8YldUiV8n5gTuuYrs/eRtLpXjy02a/qPuI5ootTh9/h
         6vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=0QuyEWm6rQMqwW2hce/ANbthK7OQhuiFstxlw742Fu0=;
        b=SoyAU1h1Slbx1BvJ559HCKHH/ae7BF+hMMVdYZ/Cl+pl1tq/LP9/WmZbdiaozYqeD4
         gy1h7mh+6O0fLDZjb78X9ISONg+W7LA4+rfkwrAZDQeX0GIyQJN7H9fzz3Rfvo7IVygg
         M1iKnu+YM4DTvTT3U/pOmR20zKnnbF3SBwFR9SfmzYmRCaVmuLCZ21K1NR5eShwDTjSD
         fuvA/U7FaJySKJ/gWV3J1UsYJ4ueGKq49gaiobFQmFlJozaP0r3r6lUKgeYX/IYenOtR
         TrDLGYn4ArHMmLrRYqaE/chJEQu2djwd2+MS8WVLJd+vtpLqVwxhmYp81eu5LK6JJw/f
         Ygew==
X-Gm-Message-State: AOAM531RLKK9kzKSDGwIy3zYCxR7OXVssiAypORLqge4veKW+gAGhe8G
        iCzrAcrsFmpMK+Fiz8850pau5xhvZfidBQ==
X-Google-Smtp-Source: ABdhPJx2IGkAo+GY/8jpSp8EfKnyNHZSjz+R9zuY4VWcSnpxEWZzmj9EXAoeHiUEFenw/kOo0uR6TQ==
X-Received: by 2002:a1c:408a:: with SMTP id n132mr7896666wma.45.1601238557360;
        Sun, 27 Sep 2020 13:29:17 -0700 (PDT)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id l19sm6363686wmi.8.2020.09.27.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 13:29:16 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Coly Li <colyli@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Evan Green <evgreen@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Xiao Ni <xni@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
Subject: [BUG] =?iso-8859-1?Q?discard=5Fgranularity_is_0_on_rk3399-gru-kevin?=
Date:   Sun, 27 Sep 2020 22:29:14 +0200
MIME-Version: 1.0
Message-ID: <2438c500-eb41-4ae2-b890-83d287ad3bcd@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
since recently the rk3399-gru-kevin is reporting the trace below.
The issue has been uncovered by
  b35fd7422c2f8e04496f5a770bd4e1a205414b3f
  block: check queue's limits.discard_granularity in=20
__blkdev_issue_discard()

Regards,
 Vicente.

WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
Hardware name: Google Kevin (DT)
pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=3D--)
pc : __blkdev_issue_discard+0x200/0x294
lr : __blkdev_issue_discard+0x54/0x294
sp : ffff800011dd3b10
x29: ffff800011dd3b10 x28: 0000000000000000=20
x27: ffff800011dd3cc4 x26: ffff800011dd3e18=20
x25: 000000000004e69b x24: 0000000000000c40=20
x23: ffff0000f1deaaf0 x22: ffff0000f2849200=20
x21: 00000000002734d8 x20: 0000000000000008=20
x19: 0000000000000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000394=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: 0000000000000000 x10: 00000000000008b0=20
x9 : ffff800011dd3cb0 x8 : 000000000004e69b=20
x7 : 0000000000000000 x6 : ffff0000f1926400=20
x5 : ffff0000f1940800 x4 : 0000000000000000=20
x3 : 0000000000000c40 x2 : 0000000000000008=20
x1 : 00000000002734d8 x0 : 0000000000000000=20
Call trace:
 __blkdev_issue_discard+0x200/0x294
 __submit_discard_cmd+0x128/0x374
 __issue_discard_cmd_orderly+0x188/0x244
 __issue_discard_cmd+0x2e8/0x33c
 issue_discard_thread+0xe8/0x2f0
 kthread+0x11c/0x120
 ret_from_fork+0x10/0x1c
---[ end trace e4c8023d33dfe77a ]---
mmcblk1p2: Error: discard_granularity is 0.
mmcblk1p2: Error: discard_granularity is 0.
<last message repeated multiple times>
