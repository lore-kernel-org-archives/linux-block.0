Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A9C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B49610CF
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhHROpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:45:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63579 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbhHROpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:45:15 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17IEiHUB003215;
        Wed, 18 Aug 2021 23:44:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Wed, 18 Aug 2021 23:44:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17IEiHIx003212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Aug 2021 23:44:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <YR0KySFfiDk+s7pn@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a9056084-8a9a-40b3-1a20-1052135c1ee2@i-love.sakura.ne.jp>
Date:   Wed, 18 Aug 2021 23:44:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR0KySFfiDk+s7pn@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 22:27, Greg KH wrote:
> On Wed, Aug 18, 2021 at 08:07:32PM +0900, Tetsuo Handa wrote:
>> This patch adds THIS_MODULE parameter to __register_blkdev() as with
>> usb_register(), and drops major_names_lock before calling probe function
>> by holding a reference to that module which contains that probe function.
>>
>> Since cdev uses register_chrdev() and __register_chrdev(), bdev should be
>> able to preserve register_blkdev() and __register_blkdev() naming scheme.
> 
> Note, the cdev api is anything but good, so should not be used as an
> excuse for anything.  Don't copy it unless you have a very good reason.
> 
> Also, what changed in this version?  I see no patch history here :(

Nothing but passing THIS_MODULE automagically using macro, as a response to

  > Do not force modules to put their own THIS_MODULE macro as a parameter,
  > put it in the .h file so that it happens automagically, much like the
  > usb_register() define in include/linux/usb.h is created.

suggestion. You also said

  > Why stop at 4 _ characters?
  > 
  > {sigh}
  > 
  > I think you need a new naming scheme here...

but I think current naming scheme is fine, and I even think v3 patch is fine.
Please suggest alternative candidates for register_blkdev() and __register_blkdev()...

