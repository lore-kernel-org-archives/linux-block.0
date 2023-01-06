Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2325C3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 14:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjAFO7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 09:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAFO7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 09:59:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19C6188
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 06:59:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs20so1499918wrb.3
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2023 06:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QL9g+ITqUwgod7+qcWIxrbFMIlEBmL+TGAAa8CT/Ds=;
        b=SLiPAIqVx/1EIJu373/7b+i/J1AOgXSqu/1zwLXNJWD9bb3y1fq+z+B4fv48b6zQJf
         oFQYMyFd6t5zQXvb0R4Q3MZfMYxYFJpkV1+L0aVz+pjTXdWFX2bXfN5ZZOckG/DcBu0d
         i2OvYXFTXfdns1hOMGNiQnGygGKItm4Xk3tZdA/1xMkBCWW64S3DglRt5ExnVQdYbn1L
         oMiEs6WQ6mseB8xp8Fh7UcfUBJwqF9xhVF5l3ujZfnY6vbEY/nxhIaxYoO6GJLNoqORb
         c5kc6XbI0MW3f/qR0XWE1aHTPsr2ORnap+NpihoDcZQIxnif7sEKx3mWv8YXIsKTzaXI
         oqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QL9g+ITqUwgod7+qcWIxrbFMIlEBmL+TGAAa8CT/Ds=;
        b=jQt4tNxj+upM6LjYyv20l1RZ788LhNH0uJ+49qo+6Z615t9OxRw43q7f7nmkxmi1QG
         GntC9ITEXnnaahhgzmWpTyUkLAdJhIW57FNw0EU87hN7YuuVsKa6cSG92Z0FoC/9BCWm
         KuBbsc218z/wxowppFSTL3l7cz4c7qKP1p3HSBQ2RkHUpeOtheg+2nYfZa6/P6w1engH
         8eLFr7uTzapDAz6O1Qnk8xKW5Y8DqqwyXFP2slcSTDVgkmI9nMW/Okj7LC8LdaE0Xt7T
         7lrYZpHE+gSXSo44xHh8ym4tcC8s3d6NAxXWHrbwL7hNpRj9MW+v+9h1IvZXOw0aZlYm
         hp9Q==
X-Gm-Message-State: AFqh2koePpj40ecZS0DPRrAd5iuK1ZAX6cNrIy7Tx/KgYGOyRn7ahkef
        A5jBVOiGw7fuQ8cLlNoeCdU=
X-Google-Smtp-Source: AMrXdXvtxXHevbrd7m0KPNFsy/YHomgaZqFayUxpw/YpZmCAs/2GuqDJPhet0XOijCeyM1y5hVsZ3w==
X-Received: by 2002:adf:f402:0:b0:270:c07e:5a with SMTP id g2-20020adff402000000b00270c07e005amr36225815wro.19.1673017140243;
        Fri, 06 Jan 2023 06:59:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm1326408wrn.111.2023.01.06.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 06:58:59 -0800 (PST)
Date:   Fri, 6 Jan 2023 17:58:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     tj@kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [bug report] memcontrol: schedule throttling if we are congested
Message-ID: <Y7g3L6fntnTtOm63@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Tejun Heo,

The patch 2cf855837b89: "memcontrol: schedule throttling if we are
congested" from Jul 3, 2018, leads to the following Smatch static
checker warning:

block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context

The call tree looks like:

ioc_rqos_merge() <- disables preempt
__cgroup_throttle_swaprate() <- disables preempt
-> blkcg_schedule_throttle()

Here is one of the callers:
mm/swapfile.c
  3657          spin_lock(&swap_avail_lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Takes spin lock.

  3658          plist_for_each_entry_safe(si, next, &swap_avail_heads[nid],
  3659                                    avail_lists[nid]) {
  3660                  if (si->bdev) {
  3661                          blkcg_schedule_throttle(si->bdev->bd_disk, true);
                                ^^^^^^^^^^^^^^^^^^^^^^^
Calls blkcg_schedule_throttle().

  3662                          break;
  3663                  }
  3664          }

block/blk-cgroup.c
  1851  void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
  1852  {
  1853          struct request_queue *q = disk->queue;
  1854  
  1855          if (unlikely(current->flags & PF_KTHREAD))
  1856                  return;
  1857  
  1858          if (current->throttle_queue != q) {
  1859                  if (!blk_get_queue(q))
  1860                          return;
  1861  
  1862                  if (current->throttle_queue)
  1863                          blk_put_queue(current->throttle_queue);
                                ^^^^^^^^^^^^^^
Sleeps.

  1864                  current->throttle_queue = q;
  1865          }
  1866  
  1867          if (use_memdelay)
  1868                  current->use_memdelay = use_memdelay;
  1869          set_notify_resume(current);
  1870  }

regards,
dan carpenter
