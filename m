Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52109C7EE2D
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjEYPWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbjEYPWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 11:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D7194
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685028123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bazt4DjA9+FzgFbUzBAsQKjHpUMQh4Ias6jYSKB378c=;
        b=Ggr34xmhsmvvqxUNw5aU9zSU6SRZZHGCT0EiE0h2iwkPCAG0N+Hn5M9JNlvxBthswnOSXK
        55Amnogu25qVk/V/0PnQv94mvyW9cPTxD3dZwkwOMMBYCmv0Dbj4IH/5fx/GhkLBenfCFA
        FCWMG9ogbYZ7/DpiSOdSulrB/GE3ZuM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-T4FsF4MzPd6JxOVw4M9VHw-1; Thu, 25 May 2023 11:21:57 -0400
X-MC-Unique: T4FsF4MzPd6JxOVw4M9VHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E2F129DD99B;
        Thu, 25 May 2023 15:21:57 +0000 (UTC)
Received: from [10.22.34.46] (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 830ED20296C6;
        Thu, 25 May 2023 15:21:56 +0000 (UTC)
Message-ID: <6e2da3d2-77a8-d53b-d08e-1243f8d9c688@redhat.com>
Date:   Thu, 25 May 2023 11:21:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Tejun Heo <tj@kernel.org>, Yosry Ahmed <yosryahmed@google.com>
References: <20230525043518.831721-1-ming.lei@redhat.com>
 <sqsb7wcvxjfd3nbohhpbjihbr4armrh5sr6vu5pxci62ga7for@6om7ayuncxnc>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <sqsb7wcvxjfd3nbohhpbjihbr4armrh5sr6vu5pxci62ga7for@6om7ayuncxnc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/23 10:11, Michal Koutný wrote:
> On Thu, May 25, 2023 at 12:35:18PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
>> It is less a problem if the cgroup to be destroyed also has other
>> controllers like memory that will call cgroup_rstat_flush() which will
>> clean up the reference count. If block is the only controller that uses
>> rstat, these offline blkcg and blkgs may never be freed leaking more
>> and more memory over time.
> On v2, io implies memory too.
> Do you observe the leak on the v2 system too?
>
> (Beware that (not only) dirty pages would pin offlined memcg, so the
> actual mem_cgroup_css_release and cgroup_rstat_flush would be further
> delayed.)

The memory leak isn't observed on cgroup v2 as the cgroup_rstat_flush() 
call by the memory controller will help to flush the extra references 
holding back blkcgs. It is only happening with a cgroup v1 configuration 
where blkcg is standalone in a cgroup.

>
>> To prevent this potential memory leak:
>>
>> - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
>> can be added
>>
>> - add global blkg_stat_lock for covering concurrent parent blkg stat
>> update
> It's bit unfortunate yet another lock is added :-/
>
> IIUC, even Waiman's patch (flush in blkcg_destroy_blkcfs) would need
> synchronization for different CPU replicas flushes in
> blkcg_iostat_update, right?

Right, the goal is to prevent concurrent call of blkcg_iostat_update() 
to the same blkg.

Cheers,
Longman

