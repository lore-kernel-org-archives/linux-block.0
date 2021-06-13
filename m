Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C62C48BCF
	for <linux-block@archiver.kernel.org>; Sun, 13 Jun 2021 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9787961159
	for <linux-block@archiver.kernel.org>; Sun, 13 Jun 2021 11:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhFMLEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Jun 2021 07:04:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58764 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhFMLEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Jun 2021 07:04:11 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15DB29ku027230;
        Sun, 13 Jun 2021 20:02:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Sun, 13 Jun 2021 20:02:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15DB20Ff027052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Jun 2021 20:02:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
 <CA+CK2bDWb2=bsoacY-eqZExObBpXuZE0a3Mr18_FXmGZTC5GnQ@mail.gmail.com>
 <CA+CK2bBe5muuGbHgfK7JjbzRE5ogf1oeD1iYeY6eJB046p9_ZQ@mail.gmail.com>
 <f76628cc-8f05-56dd-fec5-b1103aedd504@i-love.sakura.ne.jp>
 <b817de92-668a-de29-0a81-eecc4124130b@i-love.sakura.ne.jp>
Message-ID: <c18d05a0-335f-260b-67ac-1ba28814f703@i-love.sakura.ne.jp>
Date:   Sun, 13 Jun 2021 20:01:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b817de92-668a-de29-0a81-eecc4124130b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/12 11:35, Tetsuo Handa wrote:
> On 2021/06/12 0:49, Tetsuo Handa wrote:
>> On 2021/06/12 0:18, Pavel Tatashin wrote:
>>>>> Well, I made commit 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")
>>>>> because per device lock was not sufficient. Did commit 6cc8e7430801fa23 ("loop: scale loop
>>>>> device by introducing per device lock") take this problem into account?
>>>>
>>>> This was my intention when I wrote 6cc8e7430801fa23 ("loop: scale loop
>>>> device by introducing per device lock"). This is why this change does
>>>> not simply revert 310ca162d779efee ("block/loop: Use global lock for
>>>> ioctl() operation."), but keeps loop_ctl_mutex to protect the global
>>>> accesses.  loop_control_ioctl() is still locked by global
>>>> loop_ctl_mutex.
>>
>> No, loop_control_ioctl() (i.e. /dev/loop-control) is irrelevant here.
>> What 310ca162d779efee addressed but (I worry) 6cc8e7430801fa23 broke is
>> lo_ioctl() (i.e. /dev/loop$num).
>>
>> syzbot was reporting NULL pointer dereference which is caused by
>> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
>> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
>> loop devices at loop_validate_file() without holding corresponding
>> lo->lo_mutex lock.
> 
> Here is a reproducer and a race window widening patch.
> Since loop_validate_file() traverses on other loop devices,
> changing fd of loop device needs to be protected using a global lock.
> 

At least LOOP_SET_FD, LOOP_CONFIGURE, LOOP_CHANGE_FD, LOOP_CLR_FD needs to be
serialized using a global lock because loop_validate_file() traverses on other
loop devices which can cause NULL pointer dereference like syzbot has reported
in the past.

And I think LOOP_SET_CAPACITY, LOOP_SET_DIRECT_IO, LOOP_SET_BLOCK_SIZE also
needs to be serialized using a global lock because loop_change_fd() checks
capacity and dio state of other loop device which is not serialized.

I'd like to apply

  [PATCH] loop: drop loop_ctl_mutex around del_gendisk() in loop_remove()

as soon as possible because it is current top crasher (crashing on every 39 seconds).

I suggest simply reverting commit 6cc8e7430801fa23 ("loop: scale loop device by
introducing per device lock") for now. Do you want to revert 6cc8e7430801fa23
before my patch? If yes, I'll update my patch. If no, I'll just ask Jens to send
my patch to Linus.
