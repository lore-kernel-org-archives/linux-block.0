Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F1C4167B
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 01:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiLNB7w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiLNB7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 20:59:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B211153
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 17:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670983141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8Ekv64Hnz3Pzaf7wbnhuAkFb+qhBlnUSB0ADt/wreE=;
        b=bfT8ZQLvTgEoiUjCtA0VnFahrWK27w21V5hchMvghaesHrUQ6qvXGA1Z5K3BXTbwz0DuFH
        cEmXHp8CsyvFIktt8AwQcAXvsnEFymuCnmFvC9eailZENQLiCNhwlf3GX6tLFSWqdIs/Cx
        zmlrk/fgSPbCqZJHVczizf2ICk15Bz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-ilEFFrkzO3qCiPUOWk815g-1; Tue, 13 Dec 2022 20:58:57 -0500
X-MC-Unique: ilEFFrkzO3qCiPUOWk815g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AF94185A78F;
        Wed, 14 Dec 2022 01:58:57 +0000 (UTC)
Received: from [10.22.32.205] (unknown [10.22.32.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15AE02026D68;
        Wed, 14 Dec 2022 01:58:56 +0000 (UTC)
Message-ID: <72fa1665-966a-76e6-be0c-e7fb288b1610@redhat.com>
Date:   Tue, 13 Dec 2022 20:58:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v3 2/2] blk-cgroup: Flush stats at blkgs destruction
 path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221213184446.50181-1-longman@redhat.com>
 <20221213184446.50181-3-longman@redhat.com>
 <Y5jS825K7ej0jEV+@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5jS825K7ej0jEV+@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/13/22 14:30, Tejun Heo wrote:
> On Tue, Dec 13, 2022 at 01:44:46PM -0500, Waiman Long wrote:
>> +	/*
>> +	 * Flush all the non-empty percpu lockless lists so as to release
>> +	 * the blkg references held by those lists which, in turn, may
>> +	 * allow the blkgs to be freed and release their references to
>> +	 * blkcg speeding up its freeing.
>> +	 */
> Can you mention the possible deadlock explicitly? This sounds more like an
> optimization.

I am mostly thinking about the optimization aspect. Yes, deadlock in the 
sense that both blkgs and blkcg remained offline but not freed is 
possible because of the references hold in those lockless list. It is a 
problem if blkcg is the only controller in a cgroup. For cgroup that has 
both the blkcg and memory controllers, it shouldn't be a problem as the 
cgroup_rstat_flush() call in the release of memory cgroup will clear up 
blkcg too. Right, I will update the comment to mention that.

Cheers,
Longman

