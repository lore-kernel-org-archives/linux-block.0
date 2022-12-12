Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F2C4167B
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 22:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiLLWRv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiLLWRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 17:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF231ADA4
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670883409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jEJGlD5zSDTeu+llNmFOn5ERqJjpd9o8G/piU1li3s=;
        b=K9m0r0dmaYxqLqrpXmr8X/ZIhGKOoCiHYTE2UxTGsYI+CQtTDWSR3FYHmdWLiwMqlJsRKZ
        NuHaWeC2mPuu03zBYn3mC5bZYZ9Y8Dg8d8zUNQmSme4j5AzapiRy1ZGzWAchv+MraAgtlt
        gT4aCO5nwb5KtjP3pZaMru5aHbLFJCc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-n_HS5SIrPuyy6RT0CSoQag-1; Mon, 12 Dec 2022 17:16:44 -0500
X-MC-Unique: n_HS5SIrPuyy6RT0CSoQag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62A631C05192;
        Mon, 12 Dec 2022 22:16:43 +0000 (UTC)
Received: from [10.22.11.98] (unknown [10.22.11.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFD8CC15BA0;
        Mon, 12 Dec 2022 22:16:42 +0000 (UTC)
Message-ID: <b60f19c9-1e40-d621-dae5-f42bf99d6e90@redhat.com>
Date:   Mon, 12 Dec 2022 17:16:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2 1/3] bdi, blk-cgroup: Fix potential UAF of blkcg
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-2-longman@redhat.com>
 <Y5enmzQM7BIiEv9n@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5enmzQM7BIiEv9n@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/12/22 17:13, Tejun Heo wrote:
> On Sun, Dec 11, 2022 at 05:20:56PM -0500, Waiman Long wrote:
>>   static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>   {
>> +	/*
>> +	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
>> +	 * references gone.
>> +	 */
>> +	if (WARN_ON_ONCE(!css_tryget(&blkcg->css)))
>> +		return;
> Wouldn't it make more sense to use percpu_ref_is_zero()? It's not like the
> obtained extra reference does anything, right?

Yes, that makes sense. Will incorporate the change in the next version.

Thanks,
Longman

