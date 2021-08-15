Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618BAC4338F
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F146103B
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 07:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhHOHwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 03:52:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50164 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhHOHwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 03:52:55 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17F7nuE4036578;
        Sun, 15 Aug 2021 16:49:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 15 Aug 2021 16:49:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17F7nuuk036571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Aug 2021 16:49:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
Date:   Sun, 15 Aug 2021 16:49:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRi9EQJqfK6ldrZG@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/15 16:06, Greg KH wrote:
> On Sun, Aug 15, 2021 at 03:52:45PM +0900, Tetsuo Handa wrote:
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -303,9 +303,9 @@ struct gendisk *__blk_alloc_disk(int node);
>>  void blk_cleanup_disk(struct gendisk *disk);
>>  
>>  int __register_blkdev(unsigned int major, const char *name,
>> -		void (*probe)(dev_t devt));
>> +		      void (*probe)(dev_t devt), struct module *owner);
>>  #define register_blkdev(major, name) \
>> -	__register_blkdev(major, name, NULL)
>> +	__register_blkdev(major, name, NULL, NULL)
>>  void unregister_blkdev(unsigned int major, const char *name);
> 
> Do not force modules to put their own THIS_MODULE macro as a parameter,
> put it in the .h file so that it happens automagically, much like the
> usb_register() define in include/linux/usb.h is created.

Sure. We can do like below.

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13b34177cc85..70f00641fa11 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -302,10 +302,12 @@ extern void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(int node);
 void blk_cleanup_disk(struct gendisk *disk);
 
-int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+int ____register_blkdev(unsigned int major, const char *name,
+			void (*probe)(dev_t devt), struct module *owner);
+#define __register_blkdev(major, name, probe) \
+	____register_blkdev(major, name, probe, THIS_MODULE)
 #define register_blkdev(major, name) \
-	__register_blkdev(major, name, NULL)
+	____register_blkdev(major, name, NULL, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
 
 bool bdev_check_media_change(struct block_device *bdev);

> 
> If you do that, you can probably get rid of the __register_blkdev()
> direct calls as well...

I assume "automagically" implies "do not patch individual unregister_blkdev() /
__register_blkdev() callers". But "removing __register_blkdev() direct calls"
requires "patching individual __register_blkdev() callers". I didn't catch
what you suggested here.

Anyway, since this patch should be backported to 5.11+ kernels, lines changed
should be kept minimal. We can do whatever remapping after this patch.
