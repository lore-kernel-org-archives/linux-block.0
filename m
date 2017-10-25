Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:50575 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbdJYGac (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Oct 2017 02:30:32 -0400
Received: by mail-io0-f196.google.com with SMTP id 97so26432040iok.7
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2017 23:30:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019001452.GQ21978@ZenIV.linux.org.uk>
References: <1508330318-19456-1-git-send-email-idryomov@gmail.com> <20171019001452.GQ21978@ZenIV.linux.org.uk>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 25 Oct 2017 08:30:31 +0200
Message-ID: <CAOi1vP9w=kVm-yNQSw5Lt6svRHEhF69SCAJ4vjeT3AoDZPu-cQ@mail.gmail.com>
Subject: Re: [PATCH] block: move CAP_SYS_ADMIN check in blkdev_roset()
To: Jens Axboe <axboe@fb.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 19, 2017 at 2:14 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Oct 18, 2017 at 02:38:38PM +0200, Ilya Dryomov wrote:
>> Check for CAP_SYS_ADMIN before calling into the driver, similar to
>> blkdev_flushbuf().  This is safer and can spare a check in the driver.
>>
>> (Currently BLKROSET is overridden by md and rbd, rbd is missing the
>> check.  md has the check, but it covers a lot more than BLKROSET.)
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>> Al, this appears to go back to your "[PATCH] block ioctl cleanup",
>> history commit c6973580141c.  2002 was a long time ago, but still ;)
>> Was there a reason you made BLKFLSBUF check for CAP_SYS_ADMIN before
>> ->ioctl() and BLKROSET after?
>
> It was a long time ago, indeed...  The funny part is, at the time
> there had been no ->ioctl() instances with unusual BLKROSET handling
> left; I really don't remember what had left to the override for
> those remaining and (assuming it hadn't been a plain and simple braino)
> the reasons for leaving the check to drivers that might eventually
> want to add such overrides would be in whatever discussion that
> had lead to leaving that override...
>
> There was a *lot* of patch series (semi)manual reordering/rebasing, so
> it might have easily been braindamage on conflict resolution during
> rebase.
>
> gendisk work had been literally hundreds of patches all over the
> drivers/* over the summer and autumn of 2002; I have bits and pieces of
> email archives from back then, but quick grep doesn't catch any
> discussions along those lines and they are incomplete ;-/
>
> Anyway,
>         a) I don't see any reason for drivers to relax the checks on
> BLKROSET and rbd lacking those is almost certainly a bug
>         b) Acked-by: Al Viro <viro@zeniv.linux.org.uk>
>         c) I can push it through vfs tree, but it would probably make
> more sense block one.

Jens, can you pick this up for 4.15?

Thanks,

                Ilya
