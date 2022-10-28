Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D17ECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiJ1JMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1JMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 05:12:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D377541
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 02:12:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f9so4337590pgj.2
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aIUp+FdiwOxHNi2DOn6hMYUc4/9shjGitU8is1hvRw=;
        b=BV5wRz4gCqTrm9hm83RNDap6PvHOmpK8sUR9Dctpk90Bo583D3T0Xz+GTsQ3oxhlBR
         W+LVNHstqY5ORhVY3gh2Ktv4JgzKcuD24u8k1qcpwmTjqxNNTU3S/zNXfowzQtn+yts3
         rnCVl8JD7wwD4bNTVUpygL+SzE1UQIXWRhmKEcd7rW6GwHFfZ4mrQj50R8DqLE4+lV5C
         KJVWTIZQOmKf2J4FqB+WkHyToKFQwzAds/HFYrUqBslXhQ8jEUzFsf6tIZCa+o+DQ1LQ
         g4QeY++5lj6HPmXiNDFNzT0X6yLp4AOo4ivwanMDJoPaETlWQWKMn5yOXbhO1Mga31eH
         9gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aIUp+FdiwOxHNi2DOn6hMYUc4/9shjGitU8is1hvRw=;
        b=edAK4cMMjZSrHENhKcVwYpgUStzWORWxmfTrNrwU1aDm0h0YzPS9HcS06CoM/9shG8
         00YZM9jYKCFW2t7sxWX4tjezppl0wcd8Pc8LRy+c1mpPLy48u2z9IScsmEQkdFgnjMx7
         gGRGn9upriiitbyjhFyecQa2osb8Ts3fwWBPXFb+541BqyWiSffx05fyGhFLqxrEr85b
         p8Vi2Wwotb7l3DpLyLL9ww7clkGDCmmAOB5cNMsTMF+o9ifZ5/DDmAmQBlvL0anIwLi5
         IzzNUFTDEj8KZ889zhLnaiXtzBQa113NTGpXVdkj+p6xx9c/Lrpu5DuEiblmxyn4w/og
         0wgA==
X-Gm-Message-State: ACrzQf2iUj9KZpDIafd06Fos4ioMMk+Ng2CsWeOvFVwudZPJVth3lqNY
        ShbFnHOtJdaN5pesNQgxmu+Hge7X4B78RgeaxHdjkrhpoXx6
X-Google-Smtp-Source: AMsMyM6CuwdQic8eywspk1czic6qMNm88JFhFjyw459oXW/A/sa7zf3GEwGNKpw50kvkgqE0unscPbPn1UwflhKy8tI=
X-Received: by 2002:a63:f452:0:b0:46f:6d7b:3fc9 with SMTP id
 p18-20020a63f452000000b0046f6d7b3fc9mr2201462pgk.472.1666948332175; Fri, 28
 Oct 2022 02:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJGKYO62pEsXgZtRvyHjdZD7FOm2m792DgTHSeKsa4T1XvKQEg@mail.gmail.com>
In-Reply-To: <CAJGKYO62pEsXgZtRvyHjdZD7FOm2m792DgTHSeKsa4T1XvKQEg@mail.gmail.com>
From:   "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Date:   Fri, 28 Oct 2022 11:11:35 +0200
Message-ID: <CAJGKYO6Lk7-Y1A-nR1tAVTK-ZP0iFAV=qpuGVrQXCRWDnK5EbQ@mail.gmail.com>
Subject: Fwd: blk_mq_init_sq_queue (deprecated) on 5.13 does not have any
 effect, why?
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

 Could you help me, please?

 Thank, R-
