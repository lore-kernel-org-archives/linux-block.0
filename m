Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F4C4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 00:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiKQAtE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiKQAsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 19:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF73701A3
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668645962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLyYTR0vgDLPN4t0KFfB1sbFaXYNr5zBEhazg8jRdTg=;
        b=YA5/PL0RJD7i5zxLdjyCOd2T2cAFrXdjB3cBkrJip9/QIOL+0yAchnz34oUx1U7m8aIljL
        ZpX1NBzO1/ruWwCP0nxCsFIl3zS8lcyx0YTANVI2VxBtv1IvJG69HCruOEOmmPFswjn+0D
        3THPtBE8P/mOMpfOEZj+8k9alL7+dL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-o_RZ1q1TMTGEFSZIqGMhOQ-1; Wed, 16 Nov 2022 19:45:57 -0500
X-MC-Unique: o_RZ1q1TMTGEFSZIqGMhOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EEAA811E75;
        Thu, 17 Nov 2022 00:45:57 +0000 (UTC)
Received: from [10.22.10.207] (unknown [10.22.10.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69BC72024CC8;
        Thu, 17 Nov 2022 00:45:56 +0000 (UTC)
Message-ID: <26c4e6ab-52ca-e258-bf8d-d4beb86e9c9a@redhat.com>
Date:   Wed, 16 Nov 2022 19:45:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20221105005902.407297-1-longman@redhat.com>
 <166864313668.13217.6182708630212912209.b4-ty@kernel.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <166864313668.13217.6182708630212912209.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/22 18:58, Jens Axboe wrote:
> On Fri, 4 Nov 2022 20:58:59 -0400, Waiman Long wrote:
>>   v10:
>>    - Update patch 3 to rename the rstat function to
>>      cgroup_rstat_css_cpu_flush().
>>
>>   v9:
>>    - Remove patch "llist: Allow optional sentinel node terminated lockless
>>      list" for now. This will be done as a follow-up patch.
>>    - Add a new lqueued field to blkg_iostat_set to store the status of
>>      whether lnode is in a lockless list.
>>    - Add a new patch 3 to speed up the freeing of blkcg by flushing out
>>      the rstat lockless lists at blkcg offline time.
>>
>> [...]
> Applied, thanks!
>
> [1/3] blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
>        commit: b5a9adcbd5dc95d34d1f5fc84eff9af6fc60d284
> [2/3] blk-cgroup: Optimize blkcg_rstat_flush()
>        commit: 3b8cc6298724021da845f2f9fd7dd4b6829a6817
> [3/3] blk-cgroup: Flush stats at blkgs destruction path
>        commit: dae590a6c96c799434e0ff8156ef29b88c257e60
>
> Best regards,

Thanks a lot!

Cheers,
Longman

