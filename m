Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D86C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJCTjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJCTjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 15:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E748C92
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664825946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bt8NrIwM3fjyECcwzKDQPI25RNR/tnhtjpGaAmrolEU=;
        b=L977o8K4kRJlpFxbR2lr9hMnGnhb5NBnawJHG0P0y8YwFVmF3uRfXrA+/bM+3jq0LZLtLz
        B8XuUYmMgepKf7GWXFKAiPW5nKgohgbNP9DykmLdxcrZ6cxW+cd44cOC/2F5KjOtoIwSzM
        AKDwsqOnt+ty460TDzu6waIOe3U7Z78=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-QPMKw7qtNC-PeeSjYKP1Gg-1; Mon, 03 Oct 2022 15:39:03 -0400
X-MC-Unique: QPMKw7qtNC-PeeSjYKP1Gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD91E381A721;
        Mon,  3 Oct 2022 19:39:02 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 476C31121319;
        Mon,  3 Oct 2022 19:39:02 +0000 (UTC)
Message-ID: <67f5d0af-dbfa-291a-a596-c90860b94455@redhat.com>
Date:   Mon, 3 Oct 2022 15:39:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated by
 a sentinel node
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-2-longman@redhat.com>
 <YzsQZPONIJRgtf3o@slm.duckdns.org>
 <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
 <YzsUgY4CC0SH8Sl2@slm.duckdns.org>
 <8008933b-4a28-19e5-02db-ef1d07eaf952@redhat.com>
 <YzsdsjlMMDFwLOzR@slm.duckdns.org>
 <87e7cd70-4ab6-f33b-ce26-afe2c7c04faa@redhat.com>
In-Reply-To: <87e7cd70-4ab6-f33b-ce26-afe2c7c04faa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/3/22 13:40, Waiman Long wrote:
>
> On 10/3/22 13:36, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Oct 03, 2022 at 01:32:49PM -0400, Waiman Long wrote:
>>> What my current thinking is to make llist works with both NULL and 
>>> sentinel
>>> terminated lockless list. Users who wish to use the sentinel terminated
>>> version will have to use special sentinel version of LLIST_HEAD() 
>>> macro and
>>> llist_del_all() and __llist_del_all() functions. In this way, I 
>>> don't need
>>> to touch an existing users of llist while minimizing code 
>>> redundancy. What
>>> do you think?
>> Wouldn't that be more error-prone in the long term? I'd just bite the 
>> bullet
>> and convert the empty tests. It is a hassle to find them but given 
>> that it's
>> just the head node testing, it hopefully wouldn't be too bad.
>
> OK, I will take a further look at what changes will be needed by the 
> existing llist users.

After a further look, I think the task of making sentinel llist the 
default will be more time consuming that I initially thought. For example,

1) arch/powerpc/include/asm/kvm_book3s_64.h:
    It has its own llist iterator for_each_nest_rmap_safe.

2) kprobe use llist but not the full set of APIs and the
    various arch code put NULL in their llist_node to communicate
    with kprobe.

3) drivers/vhost/scsi.c uses llist but it doesn't use LLIST_HEAD
    nor init_llist_head to initialize the llist_head. I suspect that
    it may relies on NULL being the initial value.

There are 123 instances where llist_head is referenced in arch, driver, 
filesystem and kernel code. Going through all these to make sure that it 
will all work will be a major effort. I think it will be safer to allow 
both NULL and the sentinel node as the initializers and gradually 
convert them to use the proper llist APIs over time to complete the 
conversion. I am sorry that I can't spend that much time upfront for 
this conversion effort.

Regards,
Longman

