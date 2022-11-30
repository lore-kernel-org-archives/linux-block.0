Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F885C4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiK3Ppr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiK3Ppn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 10:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F520813AB
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669823085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHWzy0FM79r3PLFfRwF2L7xXZGTYCWGH6Me/ph3/zE0=;
        b=VC1NInKXa9kXQeS3W7flxoOySMuFKmdEjAJuysJbUelqewzHvZGfzE1ZMwOukYtHxLIoo1
        VRq0NiWEknxZx6VrRuQct/rD1TBYhlqu7UCS0IjU4880Evckih9sivEqTWdumt5lX3HIRT
        oRMtwMM6Inej2rauGit5ifM3TiNM9yI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-ykxiv1TXOwGZ2tocqAhH0A-1; Wed, 30 Nov 2022 10:44:41 -0500
X-MC-Unique: ykxiv1TXOwGZ2tocqAhH0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A4F13C0F437;
        Wed, 30 Nov 2022 15:44:39 +0000 (UTC)
Received: from [10.22.17.5] (unknown [10.22.17.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DE741415119;
        Wed, 30 Nov 2022 15:44:38 +0000 (UTC)
Message-ID: <d689d6d9-9206-028e-1363-8d7d77d55e79@redhat.com>
Date:   Wed, 30 Nov 2022 10:44:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2] bdi, blk-cgroup: Fix potential UAF of blkcg
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221129203400.1456100-1-longman@redhat.com>
 <20221130151639.GE27838@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221130151639.GE27838@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/30/22 10:16, Michal Koutný wrote:
> On Tue, Nov 29, 2022 at 03:34:00PM -0500, Waiman Long <longman@redhat.com> wrote:
>> The reproducing system can no longer produce a warning with this patch.
>> All the runnable block/0* tests including block/027 were run successfully
>> without failure.
> Thanks for the test!
>
>> @@ -1088,7 +1088,15 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>   
>>   	might_sleep();
>>   
>> -	css_get(&blkcg->css);
>> +	/*
>> +	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
>> +	 * references gone and rcu_read_lock not held.
>> +	 */
>> +	if (!css_tryget(&blkcg->css)) {
>> +		WARN_ON_ONCE(!rcu_read_lock_held());
>> +		return;
>> +	}
> As I followed the previous discussion, the principle is that obtaining a
> reference or being inside an RCU read section is sufficient.
>
> Consequently, I'd expect the two situations handled equally but here the
> no-ref but RCU bails out. (Which is OK because blkg_list must be empty?)
>
> However, the might_sleep() in (non-sleepable) RCU reader section combo
> makes me wary anyway (not with the early return but tools would likely
> complain).
>
> All in all, can't the contract of blkcg_destroy_blkgs() declare that
> a caller must pass blkcg with a valid reference? (The body of
> blkcg_destroy_blkgs then wouldn't need to get neither put the inner
> reference).

You are right. I should have pushed the might_sleep down(). Will post a 
new version to fix that.

Thanks,
Longman

