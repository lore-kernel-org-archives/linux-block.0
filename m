Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D24DC2BB40
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5E4224D1
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440819AbgLNSX7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 13:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440447AbgLNSX4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 13:23:56 -0500
Date:   Tue, 15 Dec 2020 03:23:10 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607970196;
        bh=aLtAWlqqpMai/EQHG9EMlK8PS7kf3rLF+EnXcc7a4vE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=deov8Z4f7OMISPzJjDYFxx4138EbsfixY25fCp3FF5rhgvnzkfBUa0c5bCSO0PA2d
         a7I1TjltTExLmlxZpSOcS27bKpfkWy7G6H6UsFGQ2ehJkfIp25ebc+dF26ALtw3esy
         ce0L0Ij8QUfL8QKd456+J+XyuQi0vFBu9L+nbK6VMqEDHYT7F6ePh5bPuv/Mlq650v
         lvsr5jYIGEHPNlIbnXZjQW5gBrvKiAfETlk+iukWaJGcqKctff0vcKAc6Ao+VilD9N
         zQKN0LHkfwaHD2ZIeBLgl2sEiFJfLHe3Z5iOw8QvOH2sNB1yz9NpvENbZ29dB7Dd34
         UracLfNIHnymw==
From:   Keith Busch <kbusch@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201214182310.GA22725@redsun51.ssa.fujisawa.hgst.com>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
 <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
 <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
 <20201213181927.GA3909519@dhcp-10-100-145-180.wdc.com>
 <55ec2183-2b3a-7660-a7fa-3f063872845e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ec2183-2b3a-7660-a7fa-3f063872845e@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 14, 2020 at 05:58:56PM +0000, Pavel Begunkov wrote:
> On 13/12/2020 18:19, Keith Busch wrote:
> > On Fri, Dec 11, 2020 at 12:38:43PM +0000, Pavel Begunkov wrote:
> >> On 11/12/2020 03:37, Keith Busch wrote:
> >>> It sounds like the statistic is using the wrong criteria. It ought to
> >>> use the average time for the next available completion for any request
> >>> rather than the average latency of a specific IO. It might work at high
> >>> depth if the hybrid poll knew the hctx's depth when calculating the
> >>> sleep time, but that information doesn't appear to be readily available.
> >>
> >> It polls (and so sleeps) from submission of a request to its completion,
> >> not from request to request. 
> > 
> > Right, but the polling thread is responsible for completing all
> > requests, not just the most recent cookie. If the sleep timer uses the
> > round trip of a single request when you have a high queue depth, there
> > are likely to be many completions in the pipeline that aren't getting
> > polled on time. This feeds back to the mean latency, pushing the sleep
> > timer further out.
> 
> It rather polls for a particular request and completes others by the way,
> and that's the problem. Completion-to-completion would make much more
> sense if we'd have a separate from waiters poll task.
> 
> Or if the semantics would be not "poll for a request", but poll a file.
> And since io_uring IMHO that actually makes more sense even for
> non-hybrid polling.

The existing block layer polling semantics doesn't poll for a specific
request. Please see the blk_mq_ops driver API for the 'poll' function.
It takes a hardware context, which does not indicate a specific request.
See also the blk_poll() function, which doesn't consider any specific
request in order to break out of the polling loop.
