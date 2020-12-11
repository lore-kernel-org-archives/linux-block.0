Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CCC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 03:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D32623B31
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 03:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395157AbgLKDiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390897AbgLKDiH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 22:38:07 -0500
Date:   Fri, 11 Dec 2020 12:37:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607657846;
        bh=fMWfrvE8L5lvE34El2UejN5tiskCdVYaV7wrU3SOZrI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+Sw9NwANz355XJp6a2ACeY2gnYiaPS0wWhY+/CStXI7p/EqG1RkdcX8G6yTNoJbW
         JliiHqGPKqSVMM+8s7jDCvDcsM83lzaSJRV2OzHyv643I6Y7rMY7xhzVj8Ew8vihEe
         1TDoMkpAX76w96KeaLJZQTfDET0W5V6x/fx/vQ4e6nGcABFb5j+EV53xJMIkaRC108
         PAA5+hb2Q3CGEEQggDhQH0YOKgIIVHeRJSx1FlGE0djqUF8bTlbYNvaEm4aYI7DVSI
         cbTgNqDfTTvdG4xzkjxdrz40Q88XQDosJ9J/4fhJioQl4ll4pM4TA7guGZ6QB//X+D
         8WSYu6IjXLk7A==
From:   Keith Busch <kbusch@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 11, 2020 at 01:44:38AM +0000, Pavel Begunkov wrote:
> On 11/12/2020 01:19, Andres Freund wrote:
> > On 2020-12-10 23:15:15 +0000, Pavel Begunkov wrote:
> >> On 10/12/2020 23:12, Pavel Begunkov wrote:
> >>> On 10/12/2020 20:51, Andres Freund wrote:
> >>>> Hi,
> >>>>
> >>>> When using hybrid polling (i.e echo 0 >
> >>>> /sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
> >>>> an iodepth > 1. Sometimes fio hangs, other times the performance is
> >>>> really poor. I reproduced this with SSDs from different vendors.
> >>>
> >>> Can you get poll stats from debugfs while running with hybrid?
> >>> For both iodepth=1 and 32.
> >>
> >> Even better if for 32 you would show it in dynamic, i.e. cat it several
> >> times while running it.
> > 
> > Should read all email before responding...
> > 
> > This is a loop of grepping for 4k writes (only type I am doing), with 1s
> > interval. I started it before the fio run (after one with
> > iodepth=1). Once the iodepth 32 run finished (--timeout 10, but took
> > 42s0, I started a --iodepth 1 run.
> 
> Thanks! Your mean grows to more than 30s, so it'll sleep for 15s for each
> IO. Yep, the sleep time calculation is clearly broken for you.
> 
> In general the current hybrid polling doesn't work well with high QD,
> that's because statistics it based on are not very resilient to all sorts
> of problems. And it might be a problem I described long ago
> 
> https://www.spinics.net/lists/linux-block/msg61479.html
> https://lkml.org/lkml/2019/4/30/120

It sounds like the statistic is using the wrong criteria. It ought to
use the average time for the next available completion for any request
rather than the average latency of a specific IO. It might work at high
depth if the hybrid poll knew the hctx's depth when calculating the
sleep time, but that information doesn't appear to be readily available.
