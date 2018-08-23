Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37913 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeHWJ6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Aug 2018 05:58:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so3270238ljc.5
        for <linux-block@vger.kernel.org>; Wed, 22 Aug 2018 23:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
 <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
 <20180820083032.GA24522@ming.t460p> <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
 <526e40ca8f426252377be21f935ddcdec93cb197.camel@decadent.org.uk>
In-Reply-To: <526e40ca8f426252377be21f935ddcdec93cb197.camel@decadent.org.uk>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 23 Aug 2018 08:29:59 +0200
Message-ID: <CAPybu_0AChdJ-TofPVuHeSAfTjH6EiOmaiQtU62wux7UYB7Z0Q@mail.gmail.com>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
To: Ben Hutchings <ben@decadent.org.uk>
Cc: ming.lei@redhat.com, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ben
On Wed, Aug 22, 2018 at 9:22 PM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Mon, 2018-08-20 at 11:04 +0200, Ricardo Ribalda Delgado wrote:
> > Hello Ming
> > On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote:
> [...]
> > > One problem found from your iostat log is that looks there is ~30sec
> > > idle period between IO activities when blk-mq is enabled.
> >
> > During all the test the LED on the device was blinking.
> >
> > But a closer look to dmesg reveals a lot of this messages:
> >
> > [  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
> > inflight: CMD
> > [  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > 68 00 04 00 00
> > [  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
> > 2 inflight: CMD OUT
> > [  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
> > 68 00 04 00 00
> > [  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
> > 1 inflight: CMD
> > [  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > 68 00 04 00 00
> > [  227.784312] scsi host6: uas_eh_device_reset_handler start
> > [  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xhci_hcd
> > [  227.944842] scsi host6: uas_eh_device_reset_handler success
> > [  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
> > inflight: CMD
> > [  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
> > e8 00 04 00 00
> >
> > And they take around 30 secons (227-196)
> >
> >
> > Maybe this is a hw issue? I will bring the reader home tonight and see
> > if I can replicate the bug with my notebook
> >
> > >
> > > Maybe it is related with timeout, given we had big change in v4.17 timeout code,
> > > and we also fixed one scsi_mq timeout related issue recently, and the patch[1] has
> > > been merged to v4.18 release already.
> >
> > I tried with v4.18-rc4 (latest one packaged in debian experimental)
> > and after 3 runs, 2 were fine (27 sec), but the last one was over a
> > minute.
>
> Is it possible that this is fixed by "block: really disable runtime-pm
> for blk-mq"?
>
> That fix went into Debian's version 4.17.14-1, but is not yet in any
> 4.18-based package.

Just tried out
ricardo@neopili:~$ uname -a
Linux neopili 4.17.0-3-amd64 #1 SMP Debian 4.17.17-1 (2018-08-18)
x86_64 GNU/Linux

and after around 10 executions all the runtimes are similar to the
ones with non-blk-mq and I havent seen the "uas error" on dmesg

Thanks for your help.

I will keep an eye on the issue in case it triggers again

>
> Ben.
>
> --
> Ben Hutchings
> You can't have everything.  Where would you put it?
>


-- 
Ricardo Ribalda
