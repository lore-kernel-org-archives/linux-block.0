Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE741C433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6082610E9
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhIJLz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:55:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59910 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 07:55:27 -0400
Received: from [192.168.1.122] (unknown [171.61.210.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id 987EA20B6C51;
        Fri, 10 Sep 2021 04:54:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 987EA20B6C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1631274856;
        bh=ziAi+qptclA5i6MG+SvCqXYYgrSpzSGk6DytVmGYMVk=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=noc5AuY4HfjaZXzU8JME4Z6ZzLjw1G4ZHoAyqD/iAbkXv02whq5PXyUzMOK2t+TLR
         hATJdajSdxAEDTQe1UnF87v6SvotGAgScIXUV0qvlbRH8/L6FtCHrBldv7ynyVchPl
         IX+hWfFB86ychqvoe2EFEmSNpfNaJd7/y1JV0q3A=
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, lalita.muppana@microsoft.com,
        schakrabarti@linux.microsoft.com,
        Michael Kelley <mikelley@microsoft.com>, longli@microsoft.com,
        KY Srinivasan <kys@microsoft.com>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <YTmgEAEx69PR/RMy@infradead.org>
Message-ID: <fa6012fa-ea5a-e292-12b3-c457a212a52c@linux.microsoft.com>
Date:   Fri, 10 Sep 2021 17:24:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTmgEAEx69PR/RMy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09-09-2021 11:18, Christoph Hellwig wrote:
> On Thu, Sep 09, 2021 at 11:06:53AM +0530, Praveen Kumar wrote:
>> There are use-cases like replication where need to hook the blk I/O
>> operations for devices and perform specific operation and fallback to
>> its original I/O operations.
>> Prior to v5.9 there was make_request_fn and then blk_mq_submit_bio
>> exported apis, which provided infrastructure to drivers to develop these
>> features. However in v5.10-rc1 with below commit the API was removed
>> from the export list.
>>
>> Previous commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.10-rc1&id=681cc5e8667e8579a2da8fa4090c48a2d73fc3bb
>>
>> This patch exports the blk_mq_submit_bio symbol to provide flexibility
>> to the drivers.
> 
> Please send your users of this "feature" to this list for inclusion
> and we'll help you to massage them into a non-broken version.
> 

Thank you for the response and appreciate your help. Providing a bit of
details below.

The disk replication solution which I mentioned, hooks all the block i/o
operation using make_request_fn for specific device request queue and do
some massaging and then call the standard block operations.
The flow is something like below :

replication_func_init (struct block_device *bdev)
... orig_queue = bdev_get_queue(bdev)		// save the original state
... orig_request_fn = orig_queue->request_fn;
... orig_queue->make_request_fn = custom_function(say "replicate_request_func")


replicate_request_func(...) {
... does some driver specific massaging
... // calls original
    if (orig_queue->make_request_fn)
	orig_queue->make_request_fn(...)
    else
	blk_mq_make_request(...)
...

Now, the current implementation have make_request_fn moved to submit_bio, one
probable approach is to somehow, update the original submit_bio to custom
"replicate_submit_bio_func" and then handle the case likewise as done in
"replicate_request_func". But, "blk_mq_submit_bio" is not exported symbol..

Second, "submit_bio_noacct" is the next approach which we thought can be used
for submit the bio, but, for case where original submit_bio is NULL, we will
end calling recursively the new submit_bio, and panic. 

replicate_submit_bio_func
... does some driver specific massaging
... // calls exported symbol
   submit_bio_noacct
    __submit_bio_noacct(bio)
       __submit_bio
        disk->fops->submit_bio(bio) -> updated API
         replicate_submit_bio_func
           submit_bio_noacct

Hope, the provided information helps understanding the problem. If not, please
do let us know, we will try to provide more details accordingly.  Also, please
do provide your thoughts and suggestions how can we achieve the above kind of
functionality on latest kernel version.


Further, we were trying to understand the history over the removal of make_request_fn
in the queue within blk_mq_init_allocated_queue API, but didn't find much. Can you
please provide any information regarding the same. Also, is there a possibility of have
similar kind of implemenation for submit_bio ?

...
-	q->make_request_fn = blk_mq_make_request;
...
Patch : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-mq.c?h=v5.14&id=8cf7961dab42c9177a556b719c15f5b9449c24d1 

Regards,

~Praveen.
