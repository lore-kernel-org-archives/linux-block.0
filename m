Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB95DC352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE42215EA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 18:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfJASbs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:31:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49072 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725848AbfJASbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 14:31:47 -0400
Received: (qmail 6459 invoked by uid 2102); 1 Oct 2019 14:31:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Oct 2019 14:31:46 -0400
Date:   Tue, 1 Oct 2019 14:31:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Lockup on USB and block devices
In-Reply-To: <20191001134430.1f9c9c75@gandalf.local.home>
Message-ID: <Pine.LNX.4.44L0.1910011427110.1991-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 1 Oct 2019, Steven Rostedt wrote:

> Not sure who to blame, but my server locked up when upgraded (accessing
> volume group information), and echoing in "w" into sysrq-trigger showed
> a bit of information.
> 
> First, looking at my dmesg I see that my usb-storage is hung up, for
> whatever reason. Thus, this could be the source of all issues.
> 
> 
> [5434447.145737] INFO: task usb-storage:32246 blocked for more than 120 seconds.
> [5434447.145740]       Not tainted 5.2.4-custom #4
> 
> (BTW, I was upgrading to my 5.2.17 kernel when this happened)
> 
> [5434447.145741] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [5434447.145743] usb-storage     D    0 32246      2 0x80004000
> [5434447.145745] Call Trace:
> [5434447.145749]  ? __schedule+0x1e8/0x600
> [5434447.145752]  schedule+0x29/0x90
> [5434447.145755]  schedule_timeout+0x208/0x300
> [5434447.145765]  ? usb_hcd_submit_urb+0xbe/0xb90 [usbcore]
> [5434447.145773]  ? usb_alloc_urb+0x23/0x70 [usbcore]
> [5434447.145782]  ? usb_sg_init+0x92/0x2b0 [usbcore]
> [5434447.145791]  ? usb_hcd_submit_urb+0xbe/0xb90 [usbcore]
> [5434447.145795]  ? __switch_to_asm+0x34/0x70
> [5434447.145798]  wait_for_completion+0x111/0x180
> [5434447.145800]  ? wake_up_q+0x70/0x70
> [5434447.145809]  usb_sg_wait+0xfa/0x150 [usbcore]
> [5434447.145814]  usb_stor_bulk_transfer_sglist.part.4+0x64/0xb0 [usb_storage]
> [5434447.145818]  usb_stor_bulk_srb+0x49/0x80 [usb_storage]
> [5434447.145821]  usb_stor_Bulk_transport+0x167/0x3e0 [usb_storage]
> [5434447.145824]  ? schedule+0x29/0x90
> [5434447.145828]  ? usb_stor_disconnect+0xb0/0xb0 [usb_storage]
> [5434447.145832]  usb_stor_invoke_transport+0x3a/0x4e0 [usb_storage]
> [5434447.145835]  ? wait_for_completion_interruptible+0x12d/0x1d0
> [5434447.145837]  ? wake_up_q+0x70/0x70
> [5434447.145841]  usb_stor_control_thread+0x1c5/0x270 [usb_storage]
> [5434447.145845]  kthread+0x116/0x130
> [5434447.145847]  ? kthread_create_worker_on_cpu+0x70/0x70
> [5434447.145851]  ret_from_fork+0x35/0x40

It looks like a problem with your xHCI USB host controller.  Normally a
usb-storage transfer would be aborted after 90 seconds.  But if the
host controller (or its driver) isn't working right, and the abort
never completes, you end up with a situation like this -- usb-storage
and the higher SCSI and block layers waiting indefinitely for an event
that won't occur.

In theory, unplugging the USB mass-storage device would unblock
everything (unless xhci-hcd is too badly wedged).  But of course, doing
that is likely to mess up whatever you were working on.

Alan Stern

