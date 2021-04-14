Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED94C43460
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767DD613CD
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 08:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhDNIkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:40:42 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33838 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350186AbhDNIit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 04:38:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVX9aPU_1618389505;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UVX9aPU_1618389505)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 16:38:26 +0800
Subject: Re: [PATCH V5 11/12] block: add poll_capable method to support
 bio-based IO polling
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-12-ming.lei@redhat.com>
 <20210412093856.GA978201@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <a6d46979-810e-bc53-bc19-8acd449e3718@linux.alibaba.com>
Date:   Wed, 14 Apr 2021 16:38:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412093856.GA978201@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/12/21 5:38 PM, Christoph Hellwig wrote:
> On Thu, Apr 01, 2021 at 10:19:26AM +0800, Ming Lei wrote:
>> From: Jeffle Xu <jefflexu@linux.alibaba.com>
>>
>> This method can be used to check if bio-based device supports IO polling
>> or not. For mq devices, checking for hw queue in polling mode is
>> adequate, while the sanity check shall be implementation specific for
>> bio-based devices. For example, dm device needs to check if all
>> underlying devices are capable of IO polling.
>>
>> Though bio-based device may have done the sanity check during the
>> device initialization phase, cacheing the result of this sanity check
>> (such as by cacheing in the queue_flags) may not work. Because for dm
>> devices, users could change the state of the underlying devices through
>> '/sys/block/<dev>/io_poll', bypassing the dm device above. In this case,
>> the cached result of the very beginning sanity check could be
>> out-of-date. Thus the sanity check needs to be done every time 'io_poll'
>> is to be modified.
> 
> I really don't think thi should be a method, and I really do dislike
> how we have all this "if (is_mq)" junk.  Why can't we have a flag on
> the gendisk that signals if the device can support polling that
> is autoamtically set for blk-mq and as-needed by bio based drivers?

That would consume one more bit of queue->queue_flags.

Besides, DM/MD is somehow special here that when one of the underlying
devices is disabled polling through '/sys/block/<dev>/io_poll',
currently there's no mechanism notifying the above MD/DM to clear the
previously set queue_flags. Thus the outdated queue_flags still
indicates this DM/MD is capable of polling, while in fact one of the
underlying device has been disabled for polling.

Mike had ever suggested that we can trust the queue_flag, and clear the
outdated queue_flags when later the IO submission or polling routine
finally finds that the device is not capable of polling. Currently
submit_bio_checks() will silently clear the REQ_HIPRI flag and still
submit the bio when the device is actually not capable of polling. To
fix the issue, could we break the submission and return an error code in
submit_bio_checks() if the device is not capable of polling when
submitting HIPRI bio?


> And please move everything that significantly hanges things for the
> mq based path to separate prep patches early in th series.
> 



-- 
Thanks,
Jeffle
