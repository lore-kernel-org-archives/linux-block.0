Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D120C433DF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 06:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A448206E9
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 06:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGGG5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:57:10 -0400
Received: from verein.lst.de ([213.95.11.211]:57439 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgGGG5K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jul 2020 02:57:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 24C5D68AFE; Tue,  7 Jul 2020 08:57:08 +0200 (CEST)
Date:   Tue, 7 Jul 2020 08:57:07 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "jack@suse.czi" <jack@suse.czi>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "fangguoju@gmail.com" <fangguoju@gmail.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Message-ID: <20200707065707.GA23805@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-6-chaitanya.kulkarni@wdc.com> <BYAPR04MB4965DFE805071F971DC8C71C866A0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965DFE805071F971DC8C71C866A0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 03, 2020 at 11:29:25PM +0000, Chaitanya Kulkarni wrote:
> Christoph,
> 
> On 6/29/20 4:44 PM, Chaitanya Kulkarni wrote:
> > Get rid of the wrapper for trace_block_rq_insert() and call the function
> > directly.
> > 
> > Signed-off-by: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>
> > ---
> 
> Can we re-consider adding this patch ? here are couple of reasons:-
> 
> 1. Increase in the size of the text region of the object file:-
> 
>     By adding the trace header #include <trace/events/block.h>
>     in io-scheduler where it is calling trace_block_rq_insert()
>     increases the size of the text region of the object file
>     kyber(+215) & bfq (+317) [1].

You really shouldn't have both loaded, never mind used at the same
time.  It also avoid a function call for the scheduler fast path.

> 2. Mandatory io-sched built-in kernel compilation:-
> 
>     When testing with a different io-sched KConfig options ("*" vs "M"),
>     when kyber and bfq compilation option set to "M" having this patch
>     reports error[2].

See EXPORT_TRACEPOINT_SYMBOL_GPL.
