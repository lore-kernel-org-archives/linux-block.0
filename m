Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F8FC43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CD622207
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8Hc3bO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgIKVxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKVxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 17:53:41 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F3C061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so11363434qkd.9
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to;
        bh=G04JF2pKkU3Et5jfoho48Oyq+62stIClH7lP76/hVsw=;
        b=u8Hc3bO6hTpnM+tfLZxmYjhnExEcrXozdC25ScvC2Wf1o0z4S4zouUuzyqPvjhZH+F
         //cq3am06Zz1RgVKgSN9tO1Ux96F/uVTTw/NgRWs61LNYFaMYy221II2B1ZYO7QSyFtx
         cL/ejewuR42BHBT7kb1AMWKeR6IIR8GUL1LXA1ZtX//63WzYEuqtylPlguffzwi5x4hn
         o/ioWhVbxONbPy6XSiOiDWSCF9pYTk3YcjpFdhdKHFvlZvnF+Ti3JtDKeq0QeOmFPD01
         /Dr6Xe6msSCWwfgB8ByYzLtwU7gPAj3IzLVrq9u1UzFO/sX7hiT9kFNkc+5X1uL6uEx2
         azkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to;
        bh=G04JF2pKkU3Et5jfoho48Oyq+62stIClH7lP76/hVsw=;
        b=dMGM337sdNqW8z5hhAqPYbbG19akQw5jD8TXJxb2fjZfynaJFFCwinO/epKXh4nAzH
         tS5+bERB1OQUmZF5mFVq/pnU1AQy9cKzZ556yfnzrReu+vz3gevorp5SwfI/3juv1Ti/
         8qXh9sVlVPEYBKXb0CF8D0HoiJviFDLi6M+F/jX95ZWxlA1xhnFUk28RNzFFOZamsHog
         tES3tez6B+7SeMqwRdulhSAbYQO57uZurDazgMYJQKLt2SNZBUiyEYYCgc+pv0e5hpLB
         eX9pVM8PSMpzyzUvTBVKjhUkUa+muSsL0s8gM4QJ0JK7blmU9g27tUx4sYuZIhIDxlDU
         txuA==
X-Gm-Message-State: AOAM530WA2BMGit5RFE+m5pGzg59iVnBqGdVDBUqPrMOvtLndjbOA7Ac
        7Fd7+cF+ObJV1bJ8BruF9i4=
X-Google-Smtp-Source: ABdhPJwgeLTfsIYVaPcyQ/WJS01DI4mJwHCJud4bXvtWVHuZMRNibqENkQ6mSYR4El/4hTD1wVzw8w==
X-Received: by 2002:a37:b347:: with SMTP id c68mr3462124qkf.430.1599861220463;
        Fri, 11 Sep 2020 14:53:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r42sm4488262qtk.29.2020.09.11.14.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:53:39 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 0/3] block: a few chunk_sectors fixes/improvements
Date:   Fri, 11 Sep 2020 17:53:35 -0400
Message-Id: <20200911215338.44805-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200911161344.GA28614@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Here are some changes that seem needed but that stop short of fixing the
initial report (of DM pgbench regression).  Would be nice if you could
review these block patches since they stand on their own.

I still have to look closer at how to get blk_queue_split() the info DM
has (in ti->max_io_len). Ideally a variant of blk_queue_split() could be
created that allows a 'chunk_sectors' override to be passed in, e.g.:
dm_process_bio() would call: blk_queue_split(&bio, ti->max_io_len);
And the provided ti->max_io_len would be used instead of a global (one
size fits all) q->limits.chunk_sectors.  The reason why this is
needed/ideal is due to DM's stacked nature.  Different offsets into a DM
device could yield entirely different max_io_len (or chunk_sectors)
settings.

BUT short of standing up a new variant of blk_queue_split() with per bio
override for 'chunk_sectors' (which is likely a non-starter for a few
reasons, recurssive nature of bio_split being the biggest): I'll need to
update all DM targets that call dm_set_target_max_io_len() to also do
this in each target's .io_hints hook:
  limits->chunk_sectors = lcm_not_zero(ti->max_io_len, limits->chunk_sectors);
Won't be perfect for some stacked devices (given it'll constrain
chunk_sectors to be less optimal as the IO limits are stacked) but it
should be an improvment -- and hopefully fix this pgbench regression.

Thanks,
Mike

Mike Snitzer (3):
  block: fix blk_rq_get_max_sectors() to flow more carefully
  block: use lcm_not_zero() when stacking chunk_sectors
  block: allow 'chunk_sectors' to be non-power-of-2

 block/blk-settings.c   | 22 ++++++++++++----------
 include/linux/blkdev.h | 31 ++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.15.0

