Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D9C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 22:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2102C20B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560465047;
	bh=Naa1plFv5bvPkXATcVba91hYrfh+u/twZfoGoAxY3mQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nLiHR6+ekv0p2j8kw+VH07G7JRB44tDufjd+bSf2TThsVwvb5+iZZKgCbnXYxLKAD
	 fyyBu8wOxcUBg5rCh3lmtINbAdSK9q8dDP7ov4HZOW3vY75ztniGoDkvjA3heNBsuQ
	 8FK5W3h8yVEzrP9gPm6rhU9Lz4Tmky29WdwFwdc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfFMWaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:30:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45272 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFMWaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 18:30:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so111650plb.12;
        Thu, 13 Jun 2019 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/FSEzrEE6hJZZM7M82sCc2VRvQYHZHLMYblXnQey7yg=;
        b=fjf7ZuSnXC0nybbmM5spwPt8yHpbBFTw4QWXMhQI81czDbdT7++LkMknP0Ngi1uO7M
         WDzl81DCknn+yTFvfsqvS/9uq+MCpjFpjYEbJKLzD4u9Z9K3fxoZ8WGghnCYqybjOTNJ
         PtJiQ7nODL3Hz3O7P0yLMKDmURrSY0bUKfrzz+sea2AZ0V/zxlvWialTDrYPgA5lgQiM
         LMklND71Bp1gYBJfbw19Pk2AoOeUTREmHb0YWkthQrbakjs8kQVueWBpbh/JDvvY88qw
         XVwAGNTPmuAmBJ7Xhu6z/CNsXNgQrHlgUQYOymzSPlXNjwTLqYwCL1xj5EnLRbwA8PVs
         mJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/FSEzrEE6hJZZM7M82sCc2VRvQYHZHLMYblXnQey7yg=;
        b=aaj49NhP8EdwPaoB7EG8rJ5pRNEJxx2DBfAy9AJvGDJHip9ii+shJo/JVyS0iC6AVU
         kQI3SHMjyfQhqcR3Ut8NOkKcc0T+0uQfEAs40+oilXsWCwcEeH4l4ECTSAYaz41GJiIq
         +440UmJ2Ur6v1eHv6FEGv0fPJI+dJKa4MM4Ld9y7f3V23TLFAYSplyj6vY0SRzNxt5O/
         eR8fEyknVN+YdmLuBAmDbWxvuzj5sIvMdCjPqf75INwMjur/WcgSY+Oql6stYvkdKlBq
         CdVAIoK5GSry1XvPbkG7yL+hHQpLufSQFLtgaARCGkZrEg1Gqidwnqh0PhHon69zhtjn
         scAA==
X-Gm-Message-State: APjAAAV/19bFn24AF4U7jBG4YtlBmF0gx/8plxMa2rDdEcBjYGXGqdpz
        YeuDflDlre4twvg1ZtthWY8=
X-Google-Smtp-Source: APXvYqz8jluIjdrIch1aMNy7RDs/2YH5a6PI2msAhzXFQpUJRmQsuoz862Sjz0vFFxkMpMYujQN8Gw==
X-Received: by 2002:a17:902:8c83:: with SMTP id t3mr63662343plo.93.1560465045574;
        Thu, 13 Jun 2019 15:30:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id g8sm757372pgd.29.2019.06.13.15.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 15:30:44 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jbacik@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, dennis@kernel.org, jack@suse.cz
Subject: [PATCHSET block/for-linus] Assorted blkcg fixes
Date:   Thu, 13 Jun 2019 15:30:36 -0700
Message-Id: <20190613223041.606735-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patchset contains the following blkcg fixes.

 0001-blk-iolatency-clear-use_delay-when-io.latency-is-set.patch
 0002-blkcg-update-blkcg_print_stat-to-handle-larger-outpu.patch
 0003-blkcg-perpcu_ref-init-exit-should-be-done-from-blkg_.patch
 0004-blkcg-blkcg_activate_policy-should-initialize-ancest.patch
 0005-blkcg-writeback-dead-memcgs-shouldn-t-contribute-to-.patch

Please refer to each patch's description for details.  Patchset is
also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-fixes

Thanks.  diffstat follows.

 block/blk-cgroup.c    |   24 ++++++++++++------------
 block/blk-iolatency.c |    4 +++-
 fs/fs-writeback.c     |    8 +++++++-
 3 files changed, 22 insertions(+), 14 deletions(-)

--
tejun

