Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA818C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 16:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiDUQk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiDUQkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 12:40:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1134888E
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 09:38:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c12so5388332plr.6
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOnbHWKnDlLtpVSTvqWk35NRB9LtEm2ypIZp064W0aA=;
        b=iQX3BuouMtra39oCJ9OZq9JSJkzeY9DiUcpgwj0nGxhRtUvttzFfdrg4/a7YaIRO36
         opUKn22VF9cFC26KUHaculx5Jc7TL9ePMtxf3fuejDfY8IGm9bNjmliMhJyHzB84Iv3m
         I+Gmor1f/7j1vkcpc+Sx2qBI0tXsgOCSFlDDviKu8cCyHiidtC3n414QV64Nz2JiVhD8
         A1ORio42v5/s7tkt4sbrwLJ1RHZR3rJ211Smoq/GCo35Ys9RCQ6dUU9icB1JQaBW7JtR
         UmsDWyXf7OZOpzMJXO7CqQgYfXI91CIXSatpstR50ExECGymzvLbz0IYZJ0ZNqtQoEib
         +u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOnbHWKnDlLtpVSTvqWk35NRB9LtEm2ypIZp064W0aA=;
        b=nTMRr1wql5XpTxEKWM2cwHy3zo7nLhAH90n7/qwLe6NWBJBLHE8RGXj4irPbNElAMm
         xDS6JWYfNaGcKRJYn2pzKo2xKFLnlzSh0JotqO9F92CCG5F1M7Tj9m0fjVRMyXY5uILr
         z0Lct/K1YmeBUk0AnG0fRKqpyvbIjCfUjRetHuJbivvwt5El8IL7MUK/7dSpYqrWoWG6
         oHMYJgna1gFeqId1IgqcR9eY5HBxGc7v0NbaGXqU9JDSm1Kqa8Ne0NJ9QIseajksvnc9
         J8YTO/SVmccvQ56Qofp6wvjK6G0cij3fD1CpjUBuLlmpsmjj/W0BlVrRwD8O1sW0+7vM
         MhCg==
X-Gm-Message-State: AOAM531ZnWvxVh4eVtaPAxjJEH9CCjRx4N4u3rAq8kipeQk/GrfS/o08
        qLCyRCrYpN08kKtD+v+3l5tKacvpyldxwIVmm763+6w8AvGbcw==
X-Google-Smtp-Source: ABdhPJxrVxIhlpXoWabQlvuQqp2e19ti6sv4kocIaYGvgpjQfACQyEgFOks9Bsohf1L/ZLP++aSdBrx1MbY/biC8dRA=
X-Received: by 2002:a17:90b:1e0e:b0:1d2:8906:cffe with SMTP id
 pg14-20020a17090b1e0e00b001d28906cffemr544353pjb.220.1650559085866; Thu, 21
 Apr 2022 09:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220421083431.2917311-1-ming.lei@redhat.com>
In-Reply-To: <20220421083431.2917311-1-ming.lei@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Apr 2022 09:37:55 -0700
Message-ID: <CAPcyv4iHgzJctq=VMNb+E1nE+ysUBLH5LK=ZnRYYDTHi0GUpKA@mail.gmail.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already present!"
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        yukuai <yukuai3@huawei.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 21, 2022 at 1:35 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> created when adding disk, and removed when releasing request queue.
>
> There is small window between releasing disk and releasing request
> queue, and during the period, one disk with same name may be created
> and added, so debugfs_create_dir() may complain with "Directory XXXXX
> with parent 'block' already present!"
>
> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> and the dir name is named with q->id from beginning, and switched to
> disk name when adding disk, and finally changed to q->id in disk_release().

Oh, I thought this was already addressed here?:

https://lore.kernel.org/all/20220415035607.1836495-1-yukuai3@huawei.com/
