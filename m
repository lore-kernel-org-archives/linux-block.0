Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD27C433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 10:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352220AbiCYKz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCYKzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 06:55:55 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70818419B8
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 03:54:18 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22PAsGdB013656;
        Fri, 25 Mar 2022 19:54:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 25 Mar 2022 19:54:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22PAsGaj013653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 25 Mar 2022 19:54:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp>
Date:   Fri, 25 Mar 2022 19:54:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-13-hch@lst.de>
 <20220324141321.pqesnshaswwk3svk@quack3.lan>
 <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
 <20220324172335.GA28299@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220324172335.GA28299@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/25 2:23, Christoph Hellwig wrote:
> On Thu, Mar 24, 2022 at 11:24:43PM +0900, Tetsuo Handa wrote:
>> On 2022/03/24 23:13, Jan Kara wrote:
>>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>>> index b3170e8cdbe95..e1eb925d3f855 100644
>>>> --- a/drivers/block/loop.c
>>>> +++ b/drivers/block/loop.c
>>>> @@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
>>>>  	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
>>>>  	 * command to fail with EBUSY.
>>>>  	 */
>>>> -	if (atomic_read(&lo->lo_refcnt) > 1) {
>>>> +	if (disk_openers(lo->lo_disk) > 1) {
>>
>> This is sometimes "if (0) {" due to not holding disk->open_mutex.
> 
> Yes, as clearly documented in the commit log.  In fact turning it
> into an explicit if 0 (that is removing this code) might be a not
> bad idea either - the code was added to work around a
> 
> 	if (lo->lo_refcnt > 1)  /* we needed one fd for the ioctl */
> 		return -EBUSY;
> 
> that already did not make much sense to start with (but goes
> back to before git history).
> 
> But for now I'd really prefer to stop moving the goalpost further and
> further.

Then, why not kill this code?

 drivers/block/loop.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3e636a75c83a..26c8808d02d0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1205,30 +1205,15 @@ static int loop_clr_fd(struct loop_device *lo)
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
-	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_mutex);
-		return -ENXIO;
-	}
-	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
-	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_mutex);
-		return 0;
-	}
-	lo->lo_state = Lo_rundown;
+	if (lo->lo_state != Lo_bound)
+		err = -ENXIO;
+	else
+		lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo, false);
-	return 0;
+	if (!err)
+		__loop_clr_fd(lo, false);
+	return err;
 }
 
 static int
-- 
2.32.0
