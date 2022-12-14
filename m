Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94430C4167B
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 16:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLNQ4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiLNQ4S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 11:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F091A3B3
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671036931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KkvyfAVh7ov91U1zVhHBRTT/9tXTJw1vQiOpy6VtBw=;
        b=Vf2w47o3tzY3UVCYNLkEXE5w8NFYFkrdN8RgdwfRcTHUDWJh2GhGFDz1hDthNztPTqQ/Cm
        1QWjrgYaio5lqIsLkyNlMAND1heBYkmt9dw/105AcKpZ8NFz+CYTnQ0xtNefMsGwlbx8rf
        7f6e8nuZYzimxEpEn7eJgWQdP8R4WY8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-sOq516BbMHiPWrTDZcFZYQ-1; Wed, 14 Dec 2022 11:55:28 -0500
X-MC-Unique: sOq516BbMHiPWrTDZcFZYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C142383278B;
        Wed, 14 Dec 2022 16:55:27 +0000 (UTC)
Received: from [10.22.9.99] (unknown [10.22.9.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA16B14171BE;
        Wed, 14 Dec 2022 16:55:26 +0000 (UTC)
Message-ID: <306d760d-fe6d-d02c-ad6c-e2467d8da4af@redhat.com>
Date:   Wed, 14 Dec 2022 11:55:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v3 1/2] bdi, blk-cgroup: Fix potential UAF of blkcg
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221213184446.50181-1-longman@redhat.com>
 <20221213184446.50181-2-longman@redhat.com>
 <Y5jSllwwBdmQ1jQz@slm.duckdns.org>
 <34a8c4a7-a58d-63fc-4599-accf1cbb6aae@redhat.com>
 <5fbaea42-14a7-27a8-cea1-3a59161ceba0@kernel.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <5fbaea42-14a7-27a8-cea1-3a59161ceba0@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/14/22 11:54, Jens Axboe wrote:
> On 12/13/22 12:53 PM, Waiman Long wrote:
>> On 12/13/22 14:29, Tejun Heo wrote:
>>> On Tue, Dec 13, 2022 at 01:44:45PM -0500, Waiman Long wrote:
>>>> Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
>>>> writeback has finished") delayed call to blkcg_destroy_blkgs() to
>>>> cgwb_release_workfn(). However, it is done after a css_put() of blkcg
>>>> which may be the final put that causes the blkcg to be freed as RCU
>>>> read lock isn't held.
>>>>
>>>> Another place where blkcg_destroy_blkgs() can be called indirectly via
>>>> blkcg_unpin_online() is from the offline_css() function called from
>>>> css_killed_work_fn(). Over there, the potentially final css_put() call
>>>> is issued after offline_css().
>>>>
>>>> By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
>>>> failure, the following stack trace was produced in a test system on
>>>> bootup.
>>> This doesn't agree with the code anymore. Otherwise
>>>
>>> Acked-by: Tejun Heo <tj@kernel.org>
>> Sorry, I overlooked the commit log in my update. I will update it if I need another version, or Jens can make the following edit:
>>
>> css_tryget() -> percpu_ref_is_zero().
> Since the other one also needs an edit, would be great if you could
> just send out a v4.
>
Sure, will do that.

Cheers,
Longman

