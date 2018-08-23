Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbeHWFpB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Aug 2018 01:45:01 -0400
Date: Thu, 23 Aug 2018 10:17:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org
Subject: Re: blk-mq 5-8 times slower for bmap-tools
Message-ID: <20180823021719.GA10464@ming.t460p>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
 <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
 <20180820083032.GA24522@ming.t460p>
 <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
 <526e40ca8f426252377be21f935ddcdec93cb197.camel@decadent.org.uk>
 <20180822220220.GA8846@ming.t460p>
 <f6f6d89ff6f73ccece3411615d1ef907e28e4b8d.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6f6d89ff6f73ccece3411615d1ef907e28e4b8d.camel@decadent.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 23, 2018 at 01:51:05AM +0100, Ben Hutchings wrote:
> On Thu, 2018-08-23 at 06:02 +0800, Ming Lei wrote:
> > On Wed, Aug 22, 2018 at 08:22:00PM +0100, Ben Hutchings wrote:
> > > On Mon, 2018-08-20 at 11:04 +0200, Ricardo Ribalda Delgado wrote:
> > > > Hello Ming
> > > > On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > 
> > > [...]
> > > > > One problem found from your iostat log is that looks there is ~30sec
> > > > > idle period between IO activities when blk-mq is enabled.
> > > > 
> > > > During all the test the LED on the device was blinking.
> > > > 
> > > > But a closer look to dmesg reveals a lot of this messages:
> > > > 
> > > > [  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
> > > > inflight: CMD
> > > > [  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > > 68 00 04 00 00
> > > > [  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
> > > > 2 inflight: CMD OUT
> > > > [  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
> > > > 68 00 04 00 00
> > > > [  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
> > > > 1 inflight: CMD
> > > > [  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > > 68 00 04 00 00
> > > > [  227.784312] scsi host6: uas_eh_device_reset_handler start
> > > > [  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xhci_hcd
> > > > [  227.944842] scsi host6: uas_eh_device_reset_handler success
> > > > [  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
> > > > inflight: CMD
> > > > [  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
> > > > e8 00 04 00 00
> > > > 
> > > > And they take around 30 secons (227-196)
> > > > 
> > > > 
> > > > Maybe this is a hw issue? I will bring the reader home tonight and see
> > > > if I can replicate the bug with my notebook
> > > > 
> > > > > 
> > > > > Maybe it is related with timeout, given we had big change in v4.17 timeout code,
> > > > > and we also fixed one scsi_mq timeout related issue recently, and the patch[1] has
> > > > > been merged to v4.18 release already.
> > > > 
> > > > I tried with v4.18-rc4 (latest one packaged in debian experimental)
> > > > and after 3 runs, 2 were fine (27 sec), but the last one was over a
> > > > minute.
> > > 
> > > Is it possible that this is fixed by "block: really disable runtime-pm
> > > for blk-mq"?
> > > 
> > 
> > As I mentioned, the similar issue can be triggered in both blk-mq and
> > non-blk-mq, so it shouldn't be related with runtime PM.
> > 
> > We need our UAS guys to take a look at this issue.
> 
> I saw that you found a problem with UAS in both modes, but Ricardo's
> problem seemed to be specific to blk-mq.
> 

Actually both are triggered when doing WRITE to UAS, and the error
message is same too.

So I think two problems may be same.

Thanks,
Ming
