Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9DBC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782EB206D6
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 07:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgD1HCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:02:04 -0400
Received: from verein.lst.de ([213.95.11.211]:54417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgD1HCD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 03:02:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10B4D68CEC; Tue, 28 Apr 2020 09:02:01 +0200 (CEST)
Date:   Tue, 28 Apr 2020 09:02:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
Message-ID: <20200428070200.GC18754@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427170613.GA13686@lst.de> <CAB0TPYGZc_n-b5xtNsbJxEiqpLMqE=RcXGuy7C2vbY18mKZ6_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYGZc_n-b5xtNsbJxEiqpLMqE=RcXGuy7C2vbY18mKZ6_A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 10:34:35PM +0200, Martijn Coenen wrote:
> > Also maybe an explicit direct I/O flag, and maybe
> > enough padding with a future proof flags bitmap that we can easily
> > extend it for new features if they pop up?
> 
> Sounds good. I'm thinking these flags should be separate from
> LO_FLAGS_; even though there is already a LO_FLAGS_DIRECT_IO, as far
> as I can tell it can only be used to tell whether it's enabled, not to
> actually enable it. And it would just get confusing if we add more
> flags later. Maybe something like LO_FD_STATUS_FLAG_DIRECT_IO ?

I think reusing LO_FLAGS_DIRECT_IO makes sense to me - we have 32
flags in the existing flags field (at least for loop_info64), so
we might as well use the field and the flags.  Then we need flags
validation in that we don't accept new flags through the old
interface, and the new one validates that no unknown flags are passed.

E.g. in the LOOP_SET_STATUS / LOOP_SET_STATUS64 handler do:

	lo->lo_flags &= ~(LO_LEGACY_FLAGS);

and then in the main function reject anything not known.

And then maybe add something like 64 bytes of padding to the end of the
new structure, so that we can use flags to expand to it.
