Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3304EC4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 20:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKDUWv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKDUWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 16:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074EC4B9AC
        for <linux-block@vger.kernel.org>; Fri,  4 Nov 2022 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667593315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQUjE5P5kUgI2AUaH5ZmnOzKErlp1CyVjP3BJnMtrps=;
        b=a0YcI4wtKHzwteErgnOI8ADswEw9txW+BP06YXr5JJFEXZITDAlLtIegjcKv9Ps3Q/WJmh
        WuohBr1HzIL056wGRRxySM36g3PidPnJ8dKMzcbOinci1V6O8nGc4CZWe7Q9Qo6C/+aijY
        YeQMYj6lOCJ0Kfqry99rruhQgwxRCGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-9szmCA8SObOfyjqqGkz10A-1; Fri, 04 Nov 2022 16:21:52 -0400
X-MC-Unique: 9szmCA8SObOfyjqqGkz10A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7006C101A52A;
        Fri,  4 Nov 2022 20:21:51 +0000 (UTC)
Received: from [10.22.34.155] (unknown [10.22.34.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAFB540C835A;
        Fri,  4 Nov 2022 20:21:50 +0000 (UTC)
Message-ID: <17047545-2993-f59b-2dbe-ccc997599ea1@redhat.com>
Date:   Fri, 4 Nov 2022 16:21:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v9 3/3] blk-cgroup: Flush stats at blkgs destruction path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
References: <20221104182050.342908-1-longman@redhat.com>
 <20221104182050.342908-4-longman@redhat.com>
 <Y2VvboMSxgF0pYpX@slm.duckdns.org>
 <84fd6656-d133-b9df-c39e-fbb3a1f4a873@redhat.com>
 <Y2VyWDvtwOsMBcKB@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y2VyWDvtwOsMBcKB@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/4/22 16:13, Tejun Heo wrote:
> On Fri, Nov 04, 2022 at 04:12:05PM -0400, Waiman Long wrote:
>> I should have named the function cgroup_rstat_css_cpu_flush() to indicate
>> that the cpu is a needed parameter. We can have a cgroup_rstat_css_flush()
>> in the future if the need arises.
>>
>> It is an optimization to call this function only if the corresponding cpu
>> has a pending lockless list. I could do cpu iteration here and call the
>> flushing function for all the CPUs. It is less optimized this way. Since it
>> is a slow path, I guess performance is not that critical. So I can go either
>> way. Please let me know your preference.
> Yeah, cpu_flush is fine. Let's leave it that way.
>
Will do.

Cheers,
Longman

