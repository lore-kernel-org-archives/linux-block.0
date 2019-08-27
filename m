Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F79C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2EE206BF
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 15:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="figx/Q98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfH0PXN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:23:13 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:40259 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbfH0PXM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 11:23:12 -0400
Received: by mail-io1-f49.google.com with SMTP id t6so47227780ios.7
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EialagdAgnBtYjzH6H0eO9CyoHJZ48U2U5aIVIJeUoo=;
        b=figx/Q98kEpCBkqo3lxQ6atjRtKnOZ/vizqGhR6ya8V3vn3+aFl2oTLswEK1VjnEMg
         An75CIk3RkB52JqKH80uhifoZiBjBgP+rPZNgE/8ipmRd77Ok9Xb6Y+4IeWDeVn8lmKd
         ySMOZk1uc2qMWNtBcJuL843WNs9SFPe/F1JQBw+7MCJe3UdkDKvttcuwKgwAi9oppUSI
         vRtaD9Uy56A0NEqyv6qNzLxcz1F6B3uV/Dp3f7ve6N1FqXtz+1EzyKNRy7GFif41nKI3
         nQoC9QQViIIaBRegMiHx06KhObDFDXWzNvmgR56X0UTpzB2kBNE2KFkzbQ9//Alh90Yc
         O4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EialagdAgnBtYjzH6H0eO9CyoHJZ48U2U5aIVIJeUoo=;
        b=VPTKqgAN4L6m7kg/3fd5uBWVA6KyNnrOva3APDsAiBDihErcBZQYlLHZPrPJYTR6BV
         eeKfmgcP5JLyRIEtldU1Deg3/5T9oDPA9ltpAu5zs/xzA1yVmGGo1+qOcjrgixiy2Ojo
         HdqozEt7V1MFe8UPcEoHavAbaqrr7lqPmFJWLphp4g6znCkWtkT3JK+UH0YT2D1eDoLN
         wkxOQUhI8oCNv2gQYNHqCvJGKL+vNW/NOYHspTD399keRbML23ZnS4VFDaOZZWEWwwlf
         03+o+L/JMR747nKZlYz6xJnvnZk3r3Vf5rF+Doxj9Awp9chGLllxBv1z2xW5B9l3B2rN
         dsGA==
X-Gm-Message-State: APjAAAU2OyfU+fUY/gYZWpGid97qvaWSDiWxgsj/rZX8xDvNsOmztHTj
        DroTfpOrd3w9zJLh1rueRTRyVg==
X-Google-Smtp-Source: APXvYqzTjEDUFcepnEf1WEiRSh5mor0Y5ZzBDG+MemPieFRR8sXBVkJz4+O2iILrDrCaJ4x8THmZFQ==
X-Received: by 2002:a6b:3943:: with SMTP id g64mr24044809ioa.225.1566919391746;
        Tue, 27 Aug 2019 08:23:11 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u24sm13275659iot.38.2019.08.27.08.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:23:10 -0700 (PDT)
Subject: Re: [PATCHSET v3] writeback, memcg: Implement foreign inode flushing
To:     Tejun Heo <tj@kernel.org>, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
References: <20190826160656.870307-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15a5a6e8-90bf-726b-f68c-db91f1afc651@kernel.dk>
Date:   Tue, 27 Aug 2019 09:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826160656.870307-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/19 10:06 AM, Tejun Heo wrote:
> Hello,
> 
> Changes from v1[1]:
> 
> * More comments explaining the parameters.
> 
> * 0003-writeback-Separate-out-wb_get_lookup-from-wb_get_create.patch
>    added and avoid spuriously creating missing wbs for foreign
>    flushing.
> 
> Changes from v2[2]:
> 
> * Added livelock avoidance and applied other smaller changes suggested
>    by Jan.
> 
> There's an inherent mismatch between memcg and writeback.  The former
> trackes ownership per-page while the latter per-inode.  This was a
> deliberate design decision because honoring per-page ownership in the
> writeback path is complicated, may lead to higher CPU and IO overheads
> and deemed unnecessary given that write-sharing an inode across
> different cgroups isn't a common use-case.
> 
> Combined with inode majority-writer ownership switching, this works
> well enough in most cases but there are some pathological cases.  For
> example, let's say there are two cgroups A and B which keep writing to
> different but confined parts of the same inode.  B owns the inode and
> A's memory is limited far below B's.  A's dirty ratio can rise enough
> to trigger balance_dirty_pages() sleeps but B's can be low enough to
> avoid triggering background writeback.  A will be slowed down without
> a way to make writeback of the dirty pages happen.
> 
> This patchset implements foreign dirty recording and foreign mechanism
> so that when a memcg encounters a condition as above it can trigger
> flushes on bdi_writebacks which can clean its pages.  Please see the
> last patch for more details.
> 
> This patchset contains the following four patches.
> 
>   0001-writeback-Generalize-and-expose-wb_completion.patch
>   0002-bdi-Add-bdi-id.patch
>   0003-writeback-Separate-out-wb_get_lookup-from-wb_get_create.patch
>   0004-writeback-memcg-Implement-cgroup_writeback_by_id.patch
>   0005-writeback-memcg-Implement-foreign-dirty-flushing.patch
> 
> 0001-0004 are prep patches which expose wb_completion and implement
> bdi->id and flushing by bdi and memcg IDs.
> 
> 0005 implements foreign inode flushing.
> 
> Thanks.  diffstat follows.
> 
>   fs/fs-writeback.c                |  130 ++++++++++++++++++++++++++++---------
>   include/linux/backing-dev-defs.h |   23 ++++++
>   include/linux/backing-dev.h      |    5 +
>   include/linux/memcontrol.h       |   39 +++++++++++
>   include/linux/writeback.h        |    2
>   mm/backing-dev.c                 |  120 +++++++++++++++++++++++++++++-----
>   mm/memcontrol.c                  |  134 +++++++++++++++++++++++++++++++++++++++
>   mm/page-writeback.c              |    4 +
>   8 files changed, 404 insertions(+), 53 deletions(-)

Applied for 5.4, thanks Tejun.

-- 
Jens Axboe

