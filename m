Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F1EC61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 03:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBBD1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 22:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBBD1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 22:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B575789
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 19:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675308414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SomATYxJ25mjdEUM/kMCsDAyR8EdHP8aHoITCDKVtgQ=;
        b=et9gJv1NXlBXkJ2H6Sez3YeKCrQiXjpuhTd4b2B7iqMuAo3/8WqgG1EXEiScUv7c8x28bN
        aVnuf7C9R4/w21cmewM17MdWqOFqFg0t8cVnB8iFz78vQycsMiN5g1wu4w7LcmxYsH+F2V
        btVhtmhSixU2umT7VpqCYUvVqEsOTiQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-CSEqgLmZP6GHOFnI3P5FfA-1; Wed, 01 Feb 2023 22:26:47 -0500
X-MC-Unique: CSEqgLmZP6GHOFnI3P5FfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE14C29AA2C5;
        Thu,  2 Feb 2023 03:26:46 +0000 (UTC)
Received: from [10.22.32.115] (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CCE62166B33;
        Thu,  2 Feb 2023 03:26:46 +0000 (UTC)
Message-ID: <4db0b257-4c8b-6e30-0c72-b581198d4a68@redhat.com>
Date:   Wed, 1 Feb 2023 22:26:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/2] blk-cgroup: Fix potential UAF & flush rstat at
 blkgs destruction path
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221215033132.230023-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221215033132.230023-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/14/22 22:31, Waiman Long wrote:
>   v4:
>    - Update comment and commit logs for both patches.
>
>   v3:
>    - Drop v2 patch 2 as it may not be needed.
>    - Replace css_tryget() with percpu_ref_is_zero() in patch 1 as
>      suggested by Tejun.
>    - Expand comment on patch 2 to elaborate the reason for this patch.
>
>   v2:
>    - Remove unnecessary rcu_read_{lock|unlock} from
>      cgroup_rstat_css_cpu_flush() in patch 3.
>
> It was found that blkcg_destroy_blkgs() may be called with all blkcg
> references gone. This may potentially cause user-after-free and so should
> be fixed. The second patch flushes rstat when calling blkcg_destroy_blkgs().
>
> Waiman Long (2):
>    bdi, blk-cgroup: Fix potential UAF of blkcg
>    blk-cgroup: Flush stats at blkgs destruction path
>
>   block/blk-cgroup.c     | 23 +++++++++++++++++++++++
>   include/linux/cgroup.h |  1 +
>   kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
>   mm/backing-dev.c       |  8 ++++++--
>   4 files changed, 48 insertions(+), 2 deletions(-)
>
Ping!

Any comments on these patches.

Thanks,
Longman

