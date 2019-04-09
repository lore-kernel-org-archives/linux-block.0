Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39AEC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDDF2084F
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDIPTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:19:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46142 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726456AbfDIPTf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 11:19:35 -0400
Received: (qmail 3066 invoked by uid 2102); 9 Apr 2019 11:19:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Apr 2019 11:19:35 -0400
Date:   Tue, 9 Apr 2019 11:19:35 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Bollinger, Seth" <Seth.Bollinger@digi.com>,
        Jens Axboe <axboe@kernel.dk>
cc:     USB list <linux-usb@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: Re: Bug: VHCI + USB 3.0
In-Reply-To: <26C1E17D-86C3-42A9-AC21-DBB4554FB901@digi.com>
Message-ID: <Pine.LNX.4.44L0.1904091057120.1599-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 9 Apr 2019, Bollinger, Seth wrote:

> > No, that trace did not show any failure.  Did you see the corresponding 
> > error messages in the kernel log while you were collecting the trace?
> > Maybe you can try again.
> 
> Ok, I have it this time.  I must have sniffed the wrong bus last time.
> 
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 3584 L 0 ch 00000081 ep 1 fl 0
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: message repeated 2 times: [ bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0]
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: BI completion: st 0 stat -75 AL 0 ec 0 returning -75
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: message repeated 3 times: [ bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0]
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: BI completion: st 0 stat -2 AL 0 ec 0 returning -2
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: message repeated 6 times: [ BI completion: st 0 stat -2 AL 0 ec 0 returning -2]
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 13 L 0 ch 00000081 ep 0 fl 4271644
> 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: BI completion: st 0 stat -71 AL 0 ec 0 returning -71

All right, now I see the problem.  It's here:

> ffff800074057b40 1058554625 S Bo:2:098:2 -115 31 = 55534243 07010000 007e0000 80000a28 000001ff c100003f 00000000 000000
> ffff800074057b40 1058554638 C Bo:2:098:2 0 31 >
> ffff800074057cc0 1058555039 S Bi:2:098:1 -115 3584 <
> ffff800074057cc0 1058555066 C Bi:2:098:1 -75 3584 = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffff800073e0fb40 1058555113 S Bi:2:098:1 -115 4096 <
> ffff8000723f5f00 1058555129 S Bi:2:098:1 -115 4096 <
> ffff8000723f5c00 1058555148 S Bi:2:098:1 -115 4096 <
> ffff8000723f5b40 1058555202 S Bi:2:098:1 -115 4096 <
> ffff8000723f5a80 1058555224 S Bi:2:098:1 -115 4096 <
> ffff8000711d8780 1058555237 S Bi:2:098:1 -115 4096 <
> ffff800074091900 1058555255 S Bi:2:098:1 -115 4096 <
> ffff800073e0fb40 1058555769 C Bi:2:098:1 -2 4096 = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

This is a READ command asking for 63 blocks (31.5 KB) of data.  The
device sends 7 4096-byte packets followed by a 3584-byte packet, but
the kernel's scatter-gather list contains a 3584-byte buffer followed
by 7 4096-byte buffers.  Since the VHCI driver doesn't have full native
SG support, it needs each packet to be stored in a contiguous region of
memory.  In this case the first packet causes an overrun error.

The best way to fix the problem would be to improve the SG support in
VHCI.  Short of that, we would like to tell the block layer that this
device requires all scatterlist elements (except the last one) for any
single command to be multiples of 1024 bytes, in spite of the fact that
the device claims to have a block size of 512 bytes.

Jens (or anyone who knows more about the block layer than I do), what's 
the right way to do this?

Any help would be appreciated.

Alan Stern

