Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1713BC433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 16:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05F12070A
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 16:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UbeZiTbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgHDQ2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgHDQ2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 12:28:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC32C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 09:28:21 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t4so34711146iln.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vjL2COF7xXWan1lyFxoam8Cyr/899gSSoTGFP8WmlRA=;
        b=UbeZiTbJlL0dNWnS2mbU/oKOyWEK05GO0l55hzIEvzn3NlKk6Xf4GSuTbM0DZaBSZ8
         jc9x/CnAMrOlITbKf9Sidjx461cZF84d2/JDTwPuicTkp5PPkrbj0Z2LyN1VDoZS+cdd
         RFsavbW5zax56YhqIRE1jTIeviwODPqmC6tf37zVRUvS6PjG1KFUIQr+SfRIpCZ5ngHL
         zAVaqZxtw3SSp7f917O6UkNQQ+F7vq3l8jBD+a99hbMqruoea0BMOocBeRvUzKBaQw4i
         e5TNlUM7NDqOUY98KtTtY2D74FP0vJN7FJTB2h4j96Ck5I17rNkwdVgRmJQ88dWlj13X
         RvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vjL2COF7xXWan1lyFxoam8Cyr/899gSSoTGFP8WmlRA=;
        b=UHTZtb23t7t8qFCcIOBMiOvwx8lvuuw2NyB3fihswkeq1OrFDjxhxhMGM5aGG6WLpa
         D53Sskhofl1jAtrN0KBXObNl1TmqZMNnvUBqGjcQVEHpk28NHwZmYLLMyFDbZedGZlR3
         8MjULqsdFA393YEgKnlFVFKdbUroespdoi0h2YNWIOwumbdHx6nhGXF4MmksioNnpmX/
         96HrqTY2pdvK3bNFUmxszyKpxo9eIqQM7GT3W0YLh5hK1ZVkG31Q5/xaW700YlLZV4VA
         M7wh6eKTKUS1JfqrUzj8rXYLOoADLGFvzXU6vYGcoBwn6GfA8BYXDz0su+L8VFUTJa7L
         ZsbA==
X-Gm-Message-State: AOAM532wz03vXTPMxq/v8Woefo+PLGv6/IndP6S4zROgqWVjt4KtZrvc
        GCVQxzD8Du17+yRMWFnT01uv01GUe/Y=
X-Google-Smtp-Source: ABdhPJwUdRxCAWfqmm24TkBn03QV+xZn14fY7hByoGz30/5B6tG+tJzdvkxbtelFcZo0yt19PcysKg==
X-Received: by 2002:a92:7a07:: with SMTP id v7mr5343815ilc.122.1596558500299;
        Tue, 04 Aug 2020 09:28:20 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q23sm10951520ior.47.2020.08.04.09.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:28:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Post block bits for 5.9-rc1
Message-ID: <f165cbc1-d122-d668-4192-80dc8e8fd7cf@kernel.dk>
Date:   Tue, 4 Aug 2020 10:28:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The stacking related fixes depended on both the core block and drivers
branches, so here's a topic branch with that change. Outside of that, a
late fix from Johannes for zone revalidation.

Please pull!


The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.9/block-merge-20200804

for you to fetch changes up to 1a1206dc4cf02cee4b5cbce583ee4c22368b4c28:

  block: don't do revalidate zones on invalid devices (2020-08-03 09:24:04 -0600)

----------------------------------------------------------------
for-5.9/block-merge-20200804

----------------------------------------------------------------
Christoph Hellwig (3):
      block: inherit the zoned characteristics in blk_stack_limits
      block: remove bdev_stack_limits
      block: remove blk_queue_stack_limits

Jens Axboe (2):
      Merge branch 'for-5.9/block' into for-5.9/block-merge
      Merge branch 'for-5.9/drivers' into for-5.9/block-merge

Johannes Thumshirn (1):
      block: don't do revalidate zones on invalid devices

 block/blk-settings.c         | 37 +++----------------------------------
 block/blk-zoned.c            |  3 +++
 drivers/block/drbd/drbd_nl.c |  4 ++--
 drivers/md/dm-table.c        | 22 ++--------------------
 drivers/nvme/host/core.c     |  3 ++-
 include/linux/blkdev.h       | 12 ++++++------
 6 files changed, 18 insertions(+), 63 deletions(-)

-- 
Jens Axboe

