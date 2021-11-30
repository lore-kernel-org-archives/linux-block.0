Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 14:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhK3OZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:25:03 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56741 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhK3OY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 09:24:59 -0500
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AUELJoF004792;
        Tue, 30 Nov 2021 23:21:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Tue, 30 Nov 2021 23:21:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AUELDY3004522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Nov 2021 23:21:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <c6a1b49b-7544-052f-7a17-2d82bb8f4148@i-love.sakura.ne.jp>
Date:   Tue, 30 Nov 2021 23:21:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] loop: replace loop_validate_mutex with
 loop_validate_spinlock
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
References: <84a861dc-6d50-81c0-8e8b-461ef59f4c01@i-love.sakura.ne.jp>
 <fffda32f-848a-712b-f50e-8a6d7d086039@i-love.sakura.ne.jp>
 <YaYgIrQYhLXQUgii@infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <YaYgIrQYhLXQUgii@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/30 21:59, Christoph Hellwig wrote:
> Please post new versions of a patch in a separate thread from the
> original one.
> 
>> +static bool loop_try_update_state_locked(struct loop_device *lo, const int old, const int new)
> 
> Pleae avoid the overly long line.

Commit bdc48fa11e46f867 ("checkpatch/coding-style: deprecate 80-column warning")
updated max length from 80 to 100, and Documentation/process/coding-style.rst says

  The preferred limit on the length of a single line is 80 columns.

  Statements longer than 80 columns should be broken into sensible chunks,
  unless exceeding 80 columns significantly increases readability and does
  not hide information.

. But this case did not increase readability?

> 
> Also passing arguments as const is a little weird.

The "const" can be added to non pointer arguments for annotating that
the corresponding argument will not change inside a function.

> 
>>  {
>> +	bool ret = false;
>>  
>> +	lockdep_assert_held(&lo->lo_mutex);
>> +	spin_lock(&loop_validate_spinlock);
>> +	if (lo->lo_state == old) {
>> +		lo->lo_state = new;
>> +		ret = true;
>>  	}
>> +	spin_unlock(&loop_validate_spinlock);
>> +	return ret;
> 
> But I really wonder what the point of this helper is.  IMHO it would be
> much easier to follow if it was open coded in the functions that update
> the state (that is without the loop_try_update_state helper as well).

The point of these helpers is to

  annotate that lo->lo_state can be updated only by these helpers

and

  make sure that appropriate locks are held for synchronization

. If there is a location doing direct "lo->lo_state = Lo_*;" assignment,
it is likely a sign of a bug.

> 
> But going one step further:  What is protected by loop_validate_spinlock
> and what is protected by lo->lo_mutex now?  Or in other words, if we
> decided the lo_state is protected by loop_validate_spinlock why do we
> even need lo_mutex here now?

loop_validate_spinlock protects lo_state of all loop devices, for
loop_validate_file() needs to traverse on remote loop devices.
By changing/checking lo_state with loop_validate_spinlock held,

  f = l->lo_backing_file;

in loop_validate_file() is guaranteed to refer to a stable file
(e.g. __loop_clr_fd() is not in progress).


Currently only __loop_clr_fd() is protected by Lo_rundown, and
loop_change_fd()/loop_configure() will be protected by Lo_binding by this patch.

Since there are functions where dedicated Lo_* is not yet used (e.g.
loop_set_status(), loop_get_status(), lo_simple_ioctl()), these helpers
for now need to also hold lo->lo_mutex for serializing against these functions.
If all functions which hold lo->lo_mutex are updated to use dedicated Lo_*,
we can remove lo->lo_mutex.

