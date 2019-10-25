Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32430CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E3E21D71
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bj9aU8RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409242AbfJYKQ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:16:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406959AbfJYKQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 06:16:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so1649646wrm.8
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NP2Oouc7q1f33SRB3lHPUh+PTnPTT6dHPVBMKG6sPiU=;
        b=bj9aU8RCRgfOVopITop5T+/S7+KhRLClYo637JC469jcCDxsyhi7R7ikwq1cpJxUPA
         dlL/pvGGk0ohBWtJiL9fXWDv+nw9Uo6Z13Pwte/z0s6tXFdg6qjIgFGH/86a+YX/BiGV
         4Djt72clRVeBDRAkAzTZ9nSHbmKMQ1wJC8cU/1uG/UrT/T/JoesqptzOPoYiJeYKo45R
         zoztkaJre2osrvBkTZDYGVf8GI/puig6CLMB+Imo8jHopE+zv27hMiGNe20mQCVnN7MJ
         SESL7Hn0UPiiufI2wbXz/4z5cHGH87Hw1Qd/oZl/zj6GmWNSKF/F98/vwnXfmImQDL7m
         crRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NP2Oouc7q1f33SRB3lHPUh+PTnPTT6dHPVBMKG6sPiU=;
        b=s1K4wO8NjZH5sX0vPtkt79KrEyDGb4YQIp+X4zmbvW8uzloBpwTBkfaTRUB5RJBax5
         zX0z40pASNx7PYlJLZzKi1/FMWHpmFRye+liTw9uwzm27wEejFGnE/xWHDiQqUxagfwR
         9rCA0DFHT9XWlQlKdIn/rtJShYpQ4pNwJTxJicsRgbpzZxbV6idHRu2haBWoXRVX83Cl
         oafjNhk/pXwrVWl9KNx46zQptjdX1sg9r7HEcZZtEcFPPmDLvxiq8M6OFMRwIb3tyjko
         6iuK3YNrEi/jYtiTHpofYGrO5Im6SLDspvULWYSp8r7AdVoBAh2qs6LVch10LSgHWhPl
         hYMA==
X-Gm-Message-State: APjAAAWQwrFh3rTnTGPB6ZBCivFNr27nuGubJgRoOnviLX8f0XnB1pFf
        s7lbzVVZkb8/wB9R/JOWmTKpyCTlwCVvRGm9
X-Google-Smtp-Source: APXvYqyQmDbEw04RVn2bj6bG5HpjBc5PMzPUHuWj3daUsWSfNOQ0apCRK9QUZmbPG1dd/cOcivlT2g==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr2281953wrv.92.1571998586903;
        Fri, 25 Oct 2019 03:16:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id r19sm1732999wrr.47.2019.10.25.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 03:16:26 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:16:24 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     elsk@google.com, dvander@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: dm-snapshot for system updates in Android
Message-ID: <20191025101624.GA61225@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello everyone!

I hope you will appreciate knowing that we are currently evaluating the use of
dm-snapshot to implement a mechanism to obtain revertible, space-efficient
system upgrades in Android.  More specifically, we are using
dm-snapshot-persistent to test the updated device after reboot, then issue a
merge in case of success, otherwise, destroy the snapshot.
This new update mechanism is still under evaluation, but its development is
openly done in AOSP.

At the current stage, we have a prototype we are happy with, both in terms of
space consumption overhead (for the COW device) and benchmarking results for
read-write and merge operations.

I would be glad if you could provide some feedback on a few points that I don't
have completely clear.


-- Interface stability

To obtain an initial, empty COW device as quick as possible, we force to 0 only
its first 32 bit (magic field). This solution looks clear from the kernel code,
but can we rely on that for all the kernels with SNAPSHOT_DISK_VERSION == 1?
Would you appreciate it if a similar statement is added as part of
/Documentation, making this solution more stable? Or maybe I can think of
adding an initialization flag to the dm-snapshot table to explicitly request
the COW initialization within the kernel?

Another issue we are facing is to be able to know in advance what the minimum
COW device size would be for a given update to be able to allocate the right
size for the COW device in advance.  To do so, we rely on the current COW
structure that seems to have kept the same stable shape in the last decade, and
compute the total COW size by knowing the number of modified chunks. The
formula would be something like that:

  table_line_bytes      = 64 * 2 / 8;
  exceptions_per_chunk  = chunk_size_bytes / table_line_bytes;
  total_cow_size_chunks = 1 + 1 + modified_chunks
                        + modified_chunks / exceptions_per_chunk;

This formula seems to be valid for all the recent kernels we checked. Again,
can we assume it to be valid for all the kernels for which
SNAPSHOT_DISK_VERSION == 1?


-- Alignment

Our approach follows the solution proposed by Mikulas [1].
Being the block alignment of file extents automatically managed by the
filesystem, using FIEMAP should have no alignment-related performance issue.
But in our implementation we hit a misalignment [2] branch which leads to
dmwarning messages [3, 4].

I have a limited experience with the block layer and dm, so I'm still
struggling in finding the root cause for this, either in user space or kernel
space.
But our benchmarks seems to be good, so we were thinking as last option to
rate-limit or directly remove that warning from our kernels as a temporary
solution, but we prefer to avoid diverging from mainline. Rate-limiting is a
solution that would make sense also to be proposed in the list, but completely
removing the warning doesn't seem the right thing to do. Maybe we are
benchmarking something else? What do you think?

Many thanks for taking the time to read this, feedbacks would be highly
appreciated.

Regards.
Alessio

[1] https://www.redhat.com/archives/dm-devel/2018-October/msg00363.html
[2] https://elixir.bootlin.com/linux/v5.3/source/block/blk-settings.c#L540
[3] https://elixir.bootlin.com/linux/v5.3/source/drivers/md/dm-table.c#L484
[4] https://elixir.bootlin.com/linux/v5.3/source/drivers/md/dm-table.c#L1558

