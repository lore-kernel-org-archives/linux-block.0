Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 14:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiC2OvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiC2OvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 10:51:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69827149
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 07:49:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 521E268AFE; Tue, 29 Mar 2022 16:49:13 +0200 (CEST)
Date:   Tue, 29 Mar 2022 16:49:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 13/14] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220329144913.GA3666@lst.de>
References: <20220325063929.1773899-1-hch@lst.de> <20220325063929.1773899-14-hch@lst.de> <03628e13-ca56-4ed0-da5a-ee698c83f48d@I-love.SAKURA.ne.jp> <20220329065234.GA20006@lst.de> <20220329132502.GA2024@lst.de> <6a383515-e2c0-9200-85b0-067238934b10@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a383515-e2c0-9200-85b0-067238934b10@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 29, 2022 at 11:02:15PM +0900, Tetsuo Handa wrote:
> It seems that the loop driver was added in Linux 1.3.68, and
> 
>   if (lo->lo_refcnt > 1)
>     return -EBUSY;
> 
> check in loop_clr_fd() was there from the beginning. The intent of this
> check was unclear.

Yes.

> But now I think that current
> 
>   disk_openers(lo->lo_disk) > 1
> 
> form is there for three reasons.
> 
> (1) Avoid I/O errors when some process which opens and reads from this
>     loop device in response to uevent notification (e.g. systemd-udevd),
>     as described in commit a1ecac3b0656a682 ("loop: Make explicit loop
>     device destruction lazy"). This opener is short-lived because it is
>     likely that the file descriptor used by that process is closed soon.

Well.  With the the uevent supression in the current series there won't
be uevents until the capacity has been set to 0.  More importantly
anything that listens to theses kinds of uevents needs to be able to
deal with I/O errors like this.

> (2) Avoid I/O errors caused by underlying layer of stacked loop devices
>     (i.e. ioctl(some_loop_fd, LOOP_SET_FD, other_loop_fd)) being suddenly
>     disappeared. This opener is long-lived because this reference is
>     associated with not a file descriptor but lo->lo_backing_file.

Again, if you clear the FD expecting I/O errors is the logical consequence.
This is like saying we should work around seeing I/O errors when hot
removing a physical device.

> (3) Avoid I/O errors caused by underlying layer of mounted loop device
>     (i.e. mount(some_loop_device, some_mount_point)) being suddenly
>     disappeared. This opener is long-lived because this reference is
>     associated with not a file descriptor but mount.

Same I/O error story.  If you hot remove a nvme SSD you do expect
error in the file system.  This is a pretty clear action -> consequence
relation.

> While race in (1) might be acceptable, (2) and (3) should be checked
> racelessly. That is, make sure that __loop_clr_fd() will not run if
> loop_validate_file() succeeds, by doing refcount check with global lock
> held when explicit loop device destruction is requested.
> 
> As a result of no longer waiting for lo->lo_mutex after setting Lo_rundown,
> we can remove pointless BUG_ON(lo->lo_state != Lo_rundown) check.

I really do like this patch.  And I think based on your description that
we both agree that the disk_openers check is not needed for functional
correctness as a malicious userspace can do concurrent operations even
without the openers check.  You want a protection against "I/O errors"
when the FD is cleared on a live device, and with your patch we get
that with the disk_openers check.  I'm perfectly fine with that state
for this series as it keeps the status quo.  I just think this check
that goes all the way back is actually a really bad idea that just
provides some false security.  But that isn't something we need to
discuss here and now.
