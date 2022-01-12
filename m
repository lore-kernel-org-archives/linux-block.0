Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9206C433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbiALOA2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 09:00:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57080 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353844AbiALOA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 09:00:27 -0500
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20CE03ki085533;
        Wed, 12 Jan 2022 23:00:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Wed, 12 Jan 2022 23:00:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20CE02fF085395
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Jan 2022 23:00:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a614bffa-d2a8-60c0-a2d9-e0ad1be17939@I-love.SAKURA.ne.jp>
Date:   Wed, 12 Jan 2022 23:00:00 +0900
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
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/12 22:16, Jan Kara wrote:
> I don't think we can fully solve this race in the kernel and IMO it is
> futile to try that - depending on when exactly systemd-udev decides to
> close /dev/loop0 and how exactly mount decides to implement its loop device
> reuse, different strategies will / will not work.

Right, there is no perfect solution.
Only mitigation for less likely hitting this race window is possible.

>                                                   But there is one subtlety
> we need to solve - when __loop_clr_fd() is run outside of disk->open_mutex,
> it can happen that next lo_open() runs before __loop_clr_fd().

Yes, but the problem (I/O error) becomes visible when read() is called.
Also, __loop_clr_fd() from ioctl(LOOP_CLR_FD) runs outside of disk->open_mutex.

>                                                               Thus we can
> hand away a file descriptor to a loop device that is half torn-down and
> will be cleaned up in uncontrollable point in the future which can lead to
> interesting consequences when the device is used at that time as well.

Right, but I don't think we can solve this.

> 
> Perhaps we can fix these problems by checking lo_refcnt in __loop_clr_fd()
> once we grab lo_mutex and thus make sure the device still should be
> destroyed?

That will not help, for (even if __loop_clr_fd() from lo_release() runs
under disk->open_mutex)

                        lo_release() {
                          mutex_lock(&lo->lo_mutex);
                          // Decrements lo->lo_refcnt and finds it became 0.
                          mutex_unlock(&lo->lo_mutex);
                          __loop_clr_fd(lo, true) {
                            mutex_lock(&lo->lo_mutex);
                            // Finds lo->lo_refcnt is still 0.
                            mutex_unlock(&lo->lo_mutex);
                            // Release the backing file.
                          }
                        }
  lo_open() {
    mutex_lock(&lo->lo_mutex);
    // Increments lo->lo_refcnt.
    mutex_unlock(&lo->lo_mutex);
  }
  vfs_read() {
    // Read attempt fails because the backing file is already gone.
  }

sequence might still cause some program to fail with I/O error, and
(since __loop_clr_fd() from loop_clr_fd() does not run under disk->open_mutex)

                        loop_clr_fd() {
                          mutex_lock(&lo->lo_mutex);
                          // Finds lo->lo_refcnt is 1.
                          mutex_unlock(&lo->lo_mutex);
                          __loop_clr_fd(lo, true) {
                            mutex_lock(&lo->lo_mutex);
                            // Finds lo->lo_refcnt is still 1.
                            mutex_unlock(&lo->lo_mutex);
  lo_open() {
    mutex_lock(&lo->lo_mutex);
    // Increments lo->lo_refcnt.
    mutex_unlock(&lo->lo_mutex);
  }
                            // Release the backing file.
                          }
                        }
  vfs_read() {
    // Read attempt fails because the backing file is already gone.
  }

sequence is still possible.

We don't want to hold disk->open_mutex and/or lo->lo_mutex when
an I/O request on this loop device is issued, do we?

Do we want to hold disk->open_mutex when calling __loop_clr_fd() from
loop_clr_fd() ? That might be useful for avoiding some race situation
but is counter way to locking simplification.

