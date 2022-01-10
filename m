Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5818C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 11:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiAJL3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 06:29:30 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58200 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244737AbiAJL3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 06:29:03 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20ABScsk029261;
        Mon, 10 Jan 2022 20:28:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 10 Jan 2022 20:28:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20ABSX0X028931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jan 2022 20:28:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
Date:   Mon, 10 Jan 2022 20:28:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220110103057.h775jv2br2xr2l5k@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/10 19:30, Jan Kara wrote:
> Eek, I agree that the patch may improve the situation but is the complexity
> and ugliness really worth it?

If we are clear about

  Now your patch will fix this lockdep complaint but we
  still would wait for the write to complete through blk_mq_freeze_queue()
  (just lockdep is not clever enough to detect this). So IHMO if there was a
  deadlock before, it will be still there with your changes.

in https://lkml.kernel.org/r/20211223134050.GD19129@quack2.suse.cz ,
we can go with the revert approach.

I want to call blk_mq_freeze_queue() without disk->open_mutex held.
But currently lo_release() is calling blk_mq_freeze_queue() with
disk->open_mutex held. My patch is going towards doing locklessly
where possible.

>                               I mean using task work in
> loop_schedule_rundown() makes a lot of sense because the loop
> 
> while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> 
> will not fail because of dangling work in the workqueue after umount ->
> __loop_clr_fd().

Using task work from lo_release() is for handling close() => umount() sequence.
Using task work in lo_open() is for handling close() => open() sequence.
The mount in

  while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

fails unless lo_open() waits for __loop_clr_fd() to complete.

>                  But when other processes like systemd-udevd start to mess
> with the loop device, then you have no control whether the following mount
> will see isofs.iso busy or not - it depends on when systemd-udevd decides
> to close the loop device.

Right. But regarding that part the main problem is that the script is not checking
for errors. What we are expected to do is to restore barrier which existed before
commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous").

>                           What your waiting in lo_open() achieves is only
> that if __loop_clr_fd() from systemd-udevd happens to run at the same time
> as lo_open() from mount, then we won't see EBUSY.

My waiting in lo_open() is to fix a regression that

  while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

started to fail.

>                                                   But IMO that is not worth
> the complexity in lo_open() because if systemd-udevd happens to close the
> loop device a millisecond later, you will get EBUSY anyway (and you would
> get it even in the past) Or am I missing something?

Excuse me, but lo_open() does not return EBUSY?
What operation are you talking about?

If lo_open() from /bin/mount happened earlier than close() from systemd-udevd
happens, __loop_clr_fd() from systemd-udevd does not happen because lo_open()
incremented lo->lo_refcnt, and autoclear will not happen until /bin/mount
calls close().

If you are talking about close() => umount() sequence, do_umount() can fail
with EBUSY if /bin/umount happened earlier than close() from systemd-udevd
happens. But that is out of scope for use of task work in lo_open().

