Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9922EC4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiKPXHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKPXHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 18:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB9317CD
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668639980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWNz/QE0hFws1BC7T/rZzODjo9Sug+sYTjrv+WWI+bk=;
        b=Brb1a3sloUczU+r95lyoX3/7S6WV1NVpaNwUINt6YEmAjcPZRqe8pq46BV49Lvy8AcOhMT
        S6H/ewvUcaf2mfux9QCoOF0EmXXgGdbm0EwmFP+mdwe2ikb7rcxrIqxd3v8hCN34ngpBRq
        nx4Le3cIqUN1vdH0YtkGFwXko3RMZh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-Kh4_YGnwNsCefQGPtUsbUA-1; Wed, 16 Nov 2022 18:06:16 -0500
X-MC-Unique: Kh4_YGnwNsCefQGPtUsbUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED237811E67;
        Wed, 16 Nov 2022 23:06:15 +0000 (UTC)
Received: from [10.22.10.207] (unknown [10.22.10.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35079C1908A;
        Wed, 16 Nov 2022 23:06:15 +0000 (UTC)
Message-ID: <4b5142be-6a47-9dfd-a238-5b9d29b296b8@redhat.com>
Date:   Wed, 16 Nov 2022 18:06:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
References: <20221105005902.407297-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221105005902.407297-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/22 20:58, Waiman Long wrote:
>   v10:
>    - Update patch 3 to rename the rstat function to
>      cgroup_rstat_css_cpu_flush().
>
>   v9:
>    - Remove patch "llist: Allow optional sentinel node terminated lockless
>      list" for now. This will be done as a follow-up patch.
>    - Add a new lqueued field to blkg_iostat_set to store the status of
>      whether lnode is in a lockless list.
>    - Add a new patch 3 to speed up the freeing of blkcg by flushing out
>      the rstat lockless lists at blkcg offline time.
>
>   v8:
>    - Update the llist patch to make existing llist functions and macros
>      work for both NULL and sentinel terminated lockless list as much
>      as possible and leave only the initialization and removal functions
>      to have a sentinel terminated llist variants.
>
> This patch series improves blkcg_rstat_flush() performance by eliminating
> unnecessary blkg enumeration and flush operations for those blkg's and
> blkg_iostat_set's that haven't been updated since the last flush.
>
> Waiman Long (3):
>    blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
>    blk-cgroup: Optimize blkcg_rstat_flush()
>    blk-cgroup: Flush stats at blkgs destruction path
>
>   block/blk-cgroup.c     | 103 +++++++++++++++++++++++++++++++++++------
>   block/blk-cgroup.h     |  10 ++++
>   include/linux/cgroup.h |   1 +
>   kernel/cgroup/rstat.c  |  20 ++++++++
>   4 files changed, 119 insertions(+), 15 deletions(-)

Jens, do you have any further comment on this patchset? Is it possible 
to queue it for the next Linux version?

Cheers,
Longman

