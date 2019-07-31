Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD3C32750
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 01:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD96208C3
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 01:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfGaBx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:53:56 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37646 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGaBx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 21:53:56 -0400
Received: by mail-io1-f70.google.com with SMTP id v3so73576749ios.4
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 18:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=TX99kbMfX/m3l12TQEmI7QQk82kKXJBSOik9J1xd9bE=;
        b=mlgbF3WaoLx2Vlv3FkA+R8oN2e8/VsNNCUGJ4PFSx7Qr62it7BUCtMAFGYJ64zDipo
         kVwftaD73tE1KPtgmAYoaGl4u7TQ3iHV+MLTnX1rdKPrUEPAkBcbPxB1a5QGwzXLbUra
         vaoplHEEHHapjRh+99WhAqR0Bu/FvfM01eZAuQLZ/vkjLn9C6KrB+aJ41mmWDWxBcU4U
         KwMYGBDF775/KUJHJvccVVoG/CF6LrH+GUfhko3r0jAfdGjBTAtfDkQKLQqcpaplfmEI
         up0S7SncPnkyeXuzo757qBqO8bLz4bgl1/KDKuaxxSLKLZlHmbj1CflmagOxH3+F484w
         c2GA==
X-Gm-Message-State: APjAAAVuYpi2h3+CCy4gRhhqobFAZMLjxPz/PwTQDmkoHjqHo4NOkfGM
        40AszWA64ulI4Dy7kPurIgPqNxM60Vus7GrsP89Cyj08gF3d
X-Google-Smtp-Source: APXvYqx0O4vBK66a5r7mjyU/G3WJz1Z4qF63n6YHNx+fAktdRT37QL4cWn1xUGd/fdk1mnD5Crz1riR6vMusK94PZSKjhddJTcx1
MIME-Version: 1.0
X-Received: by 2002:a5d:924e:: with SMTP id e14mr100371101iol.215.1564538035705;
 Tue, 30 Jul 2019 18:53:55 -0700 (PDT)
Date:   Tue, 30 Jul 2019 18:53:55 -0700
In-Reply-To: <20190731015340.GB4822@ming.t460p>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db1e2f058ef06520@google.com>
Subject: Re: Re: [PATCH 2/2] block: Fix a race condition in submit_bio()
From:   syzbot <syzbot+ff9ab4a23afa7553@syzkaller.appspotmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     00moses.alexander00@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.com, hch@lst.de, joseph.qi@linux.alibaba.com,
        jthumshirn@suse.de, linux-block@vger.kernel.org,
        ming.lei@redhat.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Jul 30, 2019 at 11:17:57AM -0700, Bart Van Assche wrote:
>> generic_make_request_checks() needs to be protected by a
>> blk_queue_enter() / blk_queue_exit() pair because it calls
>> blkcg_bio_issue_check() and because that last function calls
>> blkg_lookup().

>> This patch fixes  
>> https://syzkaller.appspot.com/bug?id=ff9ab4a23afa7553fb79f745a92be87ba4144508.

>> This patch also fixes the following kernel warning, triggered by
>> blktests:

>> WARNING: CPU: 5 PID: 10706 at block/blk-core.c:903  
>> generic_make_request_checks+0x9c6/0xe60
>> RIP: 0010:generic_make_request_checks+0x9c6/0xe60
>> Call Trace:
>>   generic_make_request+0x7a/0x5c0
>>   submit_bio+0x92/0x280
>>   mpage_readpages+0x2b1/0x300
>>   blkdev_readpages+0x1d/0x20
>>   read_pages+0xd9/0x2c0
>>   __do_page_cache_readahead+0x2e0/0x310
>>   force_page_cache_readahead+0xfb/0x170
>>   page_cache_sync_readahead+0x28d/0x2a0
>>   generic_file_read_iter+0xc13/0x1530
>>   blkdev_read_iter+0x7d/0x90
>>   new_sync_read+0x2c5/0x3d0
>>   __vfs_read+0x7b/0x90
>>   vfs_read+0xc6/0x1f0
>>   ksys_read+0xc3/0x160
>>   __x64_sys_read+0x43/0x50
>>   do_syscall_64+0x71/0x270
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe

>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>> Cc: Alexandru Moise <00moses.alexander00@gmail.com>
>> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
>> Reported-by: syzbot+ff9ab4a23afa7553@syzkaller.appspotmail.com
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/blk-core.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)

>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index ff27c3080348..cd844c54e9f1 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1150,6 +1150,9 @@ EXPORT_SYMBOL_GPL(direct_make_request);
>>    */
>>   blk_qc_t submit_bio(struct bio *bio)
>>   {
>> +	struct request_queue *q = bio->bi_disk->queue;
>> +	blk_qc_t ret;
>> +
>>   	if (blkcg_punt_bio_submit(bio))
>>   		return BLK_QC_T_NONE;

>> @@ -1182,7 +1185,15 @@ blk_qc_t submit_bio(struct bio *bio)
>>   		}
>>   	}

>> -	return generic_make_request(bio);
>> +	if (unlikely(blk_queue_enter(q, 0) < 0)) {
>> +		bio->bi_status = BLK_STS_IOERR;
>> +		bio->bi_end_io(bio);
>> +		return BLK_QC_T_NONE;
>> +	}
>> +	ret = generic_make_request(bio);
>> +	blk_queue_exit(q);

> No, nested blk_queue_enter() is easy to cause deadlock.

> Thanks,
> Ming

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

