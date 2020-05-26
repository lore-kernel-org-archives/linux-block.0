Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB64C433DF
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 11:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E604D2053B
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 11:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTQFx2m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEZL2R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgEZL2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 07:28:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5542C03E97E
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 04:28:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c71so2761187wmd.5
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vGQBL7ZRUwxInI+ytxvVK1FnJQWl/d9hD9Kyjg4lyPU=;
        b=WTQFx2m1nOYu2YurNs2ij+UMvAXPvZHl/Czn6vaVOdpDCVYPs3Z40XUfxeQjTRdBoQ
         DVlHhkcZEMljaKW3qfsHPc23ujypSASTqGiiTCj+AL18ZOAWYfzCL3hm2AMFw5sIYXc+
         /1VcxGr6TCw6jaD0SydvDq8g3LkWS8S//vp7dGKYgTxftzRRVlS03alIXlhYA2uQmLpG
         5X7XEudTPlKmUehA6DWSiKnbQzlrl0Jg48Vipofi/Sw2XcRMR2QeegxZyMWKXt83LxoE
         DeC01hU8L9gSgy6fuvaoBd8UVC7UTQm7JD/rQGI0U2v1mAejP3CHxqbLX8yqu5Y2w4xv
         EiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vGQBL7ZRUwxInI+ytxvVK1FnJQWl/d9hD9Kyjg4lyPU=;
        b=EsQx4RchpI0CoEs1dHJZ9hWZfKB0svyOWra0NtumuFGYjq3ZCydSpmpjkP39fr5vYx
         LLwQ62rWJhsOUCLZktfzGX4LpfYtk3/qTOXcDXcWFfVS30GvHx5O+e7HtIXUSDk/ehP4
         SzhjzkcW3mLNyHkiL/Ikvf5PXSdsQxjuDahzb8kUU50Rv5ZY6GOOJpF5F/AamqVOjLnV
         Exvre+mWj8clpQQScuzSsh4T0VmMKTBFb+VRQG3MVynPLccVPv+G2wi4KGttKU9eX/i6
         hee0hozA+4npq1uFnmpOINlW6JpHYKgwUWSqVuwjgUM76ralbJVfIsZFCtXsygZMx0Sp
         PGgg==
X-Gm-Message-State: AOAM530bxStk+nHRs1Uo9kLJJdf1Y8FHXCVfSGmDQx61yF5dBblAWVa2
        K4+uPEq2bGSVEZlPRPge8C+PaxGvCJmCmi4R/oHxpvc4xqM=
X-Google-Smtp-Source: ABdhPJxwjmBRRl0R1LxgTM7O4mSsAzpRfM94FdTRY5jKHyER9FN9jMaPvpUO4k6inVu2oXl2+UiS7qGQztkeYqSnTx4=
X-Received: by 2002:a1c:bc84:: with SMTP id m126mr1021901wmf.159.1590492495149;
 Tue, 26 May 2020 04:28:15 -0700 (PDT)
MIME-Version: 1.0
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Tue, 26 May 2020 19:27:34 +0800
Message-ID: <CAAJeciW0LHV5=Fsq4RSxVWBtJKu7Y3-B5Lh06nZ-yhCfzXfSCw@mail.gmail.com>
Subject: question about the usage of avg_lat in io latency controller
To:     dennisszhou@gmail.com
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi Dennis Zhou and other who are familiar with io latency controller :

i have a question about the io latency controller :
how to configure the min latency value of a blk cgroup ?
using the avg_lat value may be not right.

from the Documentation/admin-guide/cgroup-v2.rst, i know we can do
configuring work in this way:
-------------------
Use the avg_lat value as a basis for
your real setting, setting at 10-15% higher than the value in io.stat
-------------------

but when i have found  the avg_lat value is the total sum of running
average of io latency in the past time, and it can't reflect the
average time cost of per single IO request.
but whether one thread can be throttled depends on the compare result
of stat.mean and iolat->min_lat_nsec.
and stat.mean can reflect the average time cost of per single IO request.

so from above analysis, if do the configuring min io latency value
work of a blk group, use the avg_lat may not be appropriate, because
it is the total sum of running average.
why not make use of the stat.mean to do the configuring min io latency
value work ?

one experiment on my device:
cat io.stat
8:0 rbytes=586723328 wbytes=99248033792 rios=143243 wios=331782
dbytes=0 dios=0 use_delay=12 delay_nsec=0 depth=1 avg_lat=11526
win=800

so the avg_lat value 11526(ns) is so big, it can't be the average time
cost of per single IO request on our device.
so it can not be used for do the configuring min io latency value work.

Maybe I'm not familiar with the io latency controller code.
If any mistake exist in my above analysis, welcome to add your suggestions.
