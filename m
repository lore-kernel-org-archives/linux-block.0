Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35716 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1UyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Aug 2018 16:54:25 -0400
MIME-Version: 1.0
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk> <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
In-Reply-To: <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Wed, 29 Aug 2018 03:01:37 +1000
Message-ID: <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
> > On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
> >>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
> >>>>> Kernel oops when booting on Bay and Cherry Trail devices
> >>>>> such as Intel Compute Stick. Bisected as:
> >>>>>
> >>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> >>>>>
> >>>>> This patch reverts the above commit.
> >>>>
> >>>> Did I miss the posting of that oops? Just curious where this is
> >>>> going wrong. Not adverse to reverting, but I'd like to try to
> >>>> understand the issue first.
> >>>>
> >>>> --
> >>>> Jens Axboe
> >>>>
> >>>
> >>> I've not been able to capture it however manually transcribing what is
> >>> on the screen:
> >>>
> >>> mmc0: Got data interrupt 0x00000002 even though no data operation
> >>>
> >>> followed by:
> >>>
> >>> mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============
> >>>
> >>> Do you want any specific register value or should I transcribe each
> >>> (as I am working from an image taken at boot)?
> >>
> >> Just take a picture of the screen, that should be good enough.
> >>
> >> --
> >> Jens Axboe
> >>
> >
> > Attached as requested.
>
> Can you see if this patch helps?
>
> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>
> --
> Jens Axboe
>

I confirm that the above patch works with commit 6ce3dd6eec11
and removes the need for reverting it on eMMC based devices.

Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
(not affected) devices.

Many thanks,
Ian
