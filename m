Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBAECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 08:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJ1Ij6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJ1Ij5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 04:39:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD03E765
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:39:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m2so4117039pjr.3
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ix/2sFES1XDrth8Mc5WsCC3xq14DhDgLbPRqVZ7CjnE=;
        b=EB4SjPdP8jIAESzlr3p18eJASGseDuWp9CgGNv789JeTaSEon+ysczWfOdbUKXNJM5
         /fQXkeR1vIGQCmP3SuMTLTk3aci9VjrDyPk9TPQHG+k7Aa2jPC2yqc9cRcHaSJ6/VTVL
         D+cCCtUeUtItOs0LjsWx8jFO/3BeMtDeCX64IxrkHlTxs9ufiMhCsLZlzW4Q/1IqCYbf
         jW0rUHxqX/WvuVnKd69mpgKKnwvtbgeJLtDEFuwt+mEEJMZy+nkFOWVSlvMXWk+q8WBB
         V/mfZ/EjNBlv4lfCyN131ozJKt9HTZnWWmxpy7X+jGwnO2o086o5XMMTc4aqM+kqhMrw
         YvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ix/2sFES1XDrth8Mc5WsCC3xq14DhDgLbPRqVZ7CjnE=;
        b=cHv8kUP3+DshK8mCCNMiLBOXr+kqEjR4Faqz1hUfyOiAz4cS+aUTD3CkahqKiYwPK9
         U3ginoldkYbH39Ih57BfAT3yAaVhFhZvv+jnIkmnAma8uOHmPqshiEKZCW2CdyCbqAqr
         3EQgAQhDcV6MSN/ihwnOmU0zsmlTR1G416pPBwWP6ai22R1craLUQemm8earyzviIlWh
         z+ewmHtpe2xr+W+OvP9nmgDIVx+0Mix0TCwkETEUSmFkZHShF7osSEjIMbvPfsi9LKsB
         ybLOl6bInhvLL8BL/J4NFxbKt4SsCpekWWU4DKqkZ4nGxQsDJx/n6sQMjNgJGtjoX/zc
         Obpw==
X-Gm-Message-State: ACrzQf2Zqx3xKuttEsWkj6Zqo95ihRha/DQd/L+gQZCyeSsSR6iuIAGd
        Hk82U5RTwqNhlQVTZ3o4vGKeP6Q4KncO2ROPLqynpU/neV5PD4A=
X-Google-Smtp-Source: AMsMyM5pt7Kl2yis7OkvV+sDsj4LbySL4NuxYqbGBsjhHMh/A9LoszD5gHbSo6+qjPNMl/yVCmwyswTHvKhzRgP84DE=
X-Received: by 2002:a17:902:e546:b0:186:cf80:978b with SMTP id
 n6-20020a170902e54600b00186cf80978bmr15600791plf.167.1666946396031; Fri, 28
 Oct 2022 01:39:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Date:   Fri, 28 Oct 2022 10:39:19 +0200
Message-ID: <CAJGKYO62pEsXgZtRvyHjdZD7FOm2m792DgTHSeKsa4T1XvKQEg@mail.gmail.com>
Subject: blk_mq_init_sq_queue (deprecated) on 5.13 does not have any effect, why?
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

 I am doing an experiment on kernel 5.13 with raid_blk_init_sq_queue()
which is a deprecated function but this is not a problem for my needs.

* https://elixir.bootlin.com/linux/v5.13/source/block/blk-mq.c#L3074

 My goal is to install a request handler which would have priority to
the bio handler. The target is drivers/md/md.c and in particular the
md_alloc() function:

* https://elixir.bootlin.com/linux/v5.13/source/drivers/md/md.c#L5651

 At line 5714 the blk_alloc_queue() is replaced with raid_blk_init_sq_queue()

- mddev->queue = blk_alloc_queue(NUMA_NO_NODE);
+ mddev->queue = md_blk_init_sq_queue(mddev);

where the md_blk_init_sq_queue() is defined as following

static struct blk_mq_ops mq_ops = {
        .queue_rq = make_request,
};

static int md_blk_init_sq_queue(struct mddev *mddev)
{
        struct blk_mq_tag_set *tag_set;

        tag_set = kmalloc(sizeof(struct blk_mq_tag_set), GFP_KERNEL);
        if(!tag_set)
                return NULL;

        mddev->queue = blk_mq_init_sq_queue(tag_set, &mq_ops, 128,
               BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING);
        if (mddev->queue == NULL)
                return NULL;

        blk_queue_logical_block_size(mddev->queue, SECTOR_SIZE);
        mddev->queue->tag_set = tag_set;

        return mddev->queue;
}

 The request handler make_request() is never called and I wonder why.
Could you help me, plase? Thank, R-
