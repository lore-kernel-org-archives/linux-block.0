Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A51C11D0C
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C987F206F4
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 19:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMgtnYbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgBTTEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:04:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46925 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 14:04:30 -0500
Received: by mail-il1-f194.google.com with SMTP id t17so24537564ilm.13
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 11:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgBf5ClYEVSI/olrCLUw30EZLzZkv7eTI3bcBHOqlZU=;
        b=lMgtnYbWuDtfqtIzMW9ci9d1PF6lJWZlkB61QUlvjE3jvOnW0AhFPOK+lZtsr8OzSD
         MFMBI+ZVHiMBvFwgd7l/HadwhnNrdNmHn7NbNGjSpYI2IE1Z4cDNnhwEisZKBp2RLdqu
         lTuZLD32amVRHuB+hzJ9bN/7UPm+9USzPqqmk6z5vlBrQ7oHFtxkB4Lt7Q/7+ZfRdiV+
         5mZpwZ7eDuqMTHfMbLriht/vVa1tivVm5PMuDPaMwYLy7dSaejL/L4bMRfWYSpGDFR6p
         aFqL1TUPAy8JVyi0sU5huh53sYR5dU8vgoMjDzcs07vXaPT83TlQqbqedN0/U9aSvyuP
         XiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgBf5ClYEVSI/olrCLUw30EZLzZkv7eTI3bcBHOqlZU=;
        b=fNYcYOifY2EDnInGNJu5e0jCLj5aKKLftqPMB7/vgoCytH7sbCQdlGnwkuA1+0S/8W
         xXI75zsiSxu60/QJqlG6JaPE2klikSQvn4c6dfn/JbZmM40DO94iOl9b0EcWYzPiez/4
         Mqrc3RPsJVXR3RZPb/kqFtcuVLSaQheiKa1csSbkmyPfykwuPWWMx5FRhv9PPc1xzH2G
         Romm93DkXdjg1nB7bssEqu4vRXhp6EQ3EUOHbdWVTU+eL+Tac9X9zN93b7WeuVOGFg5H
         OvviHdFO3Uzn/C2IOBGCrNCqfxS9RNgIDA7wkDDtRqwyGeTVtsAq4Jr4IbGV9syPfSQU
         3zDA==
X-Gm-Message-State: APjAAAW2/9qIfZbF+jGjMYqvv+dIdTcoSDzYBwJotx1D1Yyu/OxRCIT2
        d11Ia8UdQgAqpm2vVO0jvxHZLkXQ2Nd8AkXRiJYRDQ==
X-Google-Smtp-Source: APXvYqyrlfPjQoMPv6IaQhJz+rxn0Ios5FP6sEUGvWNFDAwSKyznVNII1o84SuLhYrSborRzE2yv8XlO9dHZTwi5q7E=
X-Received: by 2002:a92:8441:: with SMTP id l62mr31066682ild.85.1582225468595;
 Thu, 20 Feb 2020 11:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20200220120527.15082-1-ming.lei@redhat.com> <CAJmaN=kZrE7FNPd3Fv4nxc1qYhGo=V3uZA-zyPxzqRYq6KABrg@mail.gmail.com>
In-Reply-To: <CAJmaN=kZrE7FNPd3Fv4nxc1qYhGo=V3uZA-zyPxzqRYq6KABrg@mail.gmail.com>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 20 Feb 2020 11:04:16 -0800
Message-ID: <CAKUOC8WK=XBY=uanMRXR+w8WUv+=EdnVzb0sLRdWj8JagUtVjA@mail.gmail.com>
Subject: Re: [PATCH] block: Prevent hung_check firing during long sync IO
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you for doing this.  The fix will help, but it is not a complete solution.

+1 to Jesse's comment about putting into a descriptive helper.  This
functionality might be useful elsewhere.

I'd like to reiterate that the problem is broader.  For instance, if I
hack the IOCTL path to be immune from the hung task watchdog from
firing there, the problem simply moves to another I/O that is behind
the IOCTL.  For instance if I have a dd command doing direct I/O
against the same device that has the IOCTL pending, the dd will hang
in uninterruptible sleep and eventually the hung task timer will fire.

[ 5645.712955] dd              D 634a749ef8dd8750     0  5126   4978
0x00000000 last_sleep: 5568344242277.  last_runnable: 5568342587878
[ 5645.712965]  ffff88005cfb2c00 ffff88007ab14940 ffff88007a6df080
ffff8800614a4b00
[ 5645.712973]  0000000000014940 ffff880076f77a00 ffffffffb1076a57
ffff880000000000
[ 5645.712981]  ffff8800614a4b00 7fffffffffffffff ffff880075402940
ffff880076f77a38
[ 5645.712988] Call Trace:
[ 5645.713000]  [<ffffffffb1076a57>] ? __schedule+0x37a/0x7a2
[ 5645.713005]  [<ffffffffb10766a7>] schedule+0x3f/0x75
[ 5645.713009]  [<ffffffffb1079410>] schedule_timeout+0x53/0x6af
[ 5645.713015]  [<ffffffffb1077425>] io_schedule_timeout+0x6b/0x91
[ 5645.713021]  [<ffffffffb09dd66a>] dio_await_one+0x94/0xdb
[ 5645.713025]  [<ffffffffb09dc668>] __blockdev_direct_IO+0x6d5/0x763
[ 5645.713029]  [<ffffffffb09dbde9>] ? blkdev_direct_IO+0x3b/0x3b
[ 5645.713034]  [<ffffffffb09dbde9>] ? blkdev_direct_IO+0x3b/0x3b
[ 5645.713039]  [<ffffffffb09dbde3>] blkdev_direct_IO+0x35/0x3b
[ 5645.713044]  [<ffffffffb095bf30>]
generic_file_direct_write+0xfb/0x16d
[ 5645.713050]  [<ffffffffb098c661>]
__generic_file_write_iter+0x2b0/0x3c1
[ 5645.713056]  [<ffffffffb0bffe9d>] ? write_port+0xdc/0xdc
[ 5645.713061]  [<ffffffffb0b506de>] ? __clear_user+0x41/0x66
[ 5645.713065]  [<ffffffffb09db78f>] blkdev_write_iter+0xd1/0x13e
[ 5645.713072]  [<ffffffffb0a66977>] SyS_write+0x22d/0x431
[ 5645.713077]  [<ffffffffb107b163>] entry_SYSCALL_64_fastpath+0x31/0xab

 Similarly, I am sure there are filesystem specific paths that can
potentially hang.  I suspect that the flushing code in ext4 might be
one such path.  These are just examples.
Also, my worry persists that we are creating more places for bugs to
hide by blanket immunizing I/O paths from the hung task timer.  Having
said all of that, I don't really have a significantly better in-kernel
solution.

Reviewed-by: Salman Qazi <sqazi@google.com>

On Thu, Feb 20, 2020 at 6:43 AM Jesse Barnes <jsbarnes@google.com> wrote:
>
> Yeah looks good.
>
> Reviewed-by: Jesse Barnes <jsbarnes@google.com>
>
> A further change (just for readability) might be to factor out these
> "don't trigger hangcheck" waits from here and blk_execute_rq() into a
> small helper with a descriptive name.
>
> Thanks,
> Jesse
>
> On Thu, Feb 20, 2020 at 5:05 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > submit_bio_wait() can be called from ioctl(BLKSECDISCARD), which
> > may take long time to complete, as Salman mentioned, 4K BLKSECDISCARD
> > takes up to 100 second on some devices. Also any block I/O operation
> > that occurs after the BLKSECDISCARD is submitted will also potentially
> > be affected by the hung task timeouts.
> >
> > So prevent hung_check from firing by taking same approach used
> > in blk_execute_rq(), and the wake-up interval is set as half the
> > hung_check timer period, which keeps overhead low enough.
> >
> > Cc: Salman Qazi <sqazi@google.com>
> > Cc: Jesse Barnes <jsbarnes@google.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Link: https://lkml.org/lkml/2020/2/12/1193
> > Reported-by: Salman Qazi <sqazi@google.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/bio.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 94d697217887..c9ce19a86de7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/cgroup.h>
> >  #include <linux/blk-cgroup.h>
> >  #include <linux/highmem.h>
> > +#include <linux/sched/sysctl.h>
> >
> >  #include <trace/events/block.h>
> >  #include "blk.h"
> > @@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
> >  int submit_bio_wait(struct bio *bio)
> >  {
> >         DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> > +       unsigned long hang_check;
> >
> >         bio->bi_private = &done;
> >         bio->bi_end_io = submit_bio_wait_endio;
> >         bio->bi_opf |= REQ_SYNC;
> >         submit_bio(bio);
> > -       wait_for_completion_io(&done);
> > +
> > +       /* Prevent hang_check timer from firing at us during very long I/O */
> > +       hang_check = sysctl_hung_task_timeout_secs;
> > +       if (hang_check)
> > +               while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> > +       else
> > +               wait_for_completion_io(&done);
> >
> >         return blk_status_to_errno(bio->bi_status);
> >  }
> > --
> > 2.20.1
> >
