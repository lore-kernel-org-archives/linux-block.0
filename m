Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137BAC433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 06:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBBC20760
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 06:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGAGQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:16:45 -0400
Received: from verein.lst.de ([213.95.11.211]:38735 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgGAGQp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 02:16:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 380A268B02; Wed,  1 Jul 2020 08:16:41 +0200 (CEST)
Date:   Wed, 1 Jul 2020 08:16:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH 07/11] block: get rid of blk_trace_request_get_cgid()
Message-ID: <20200701061640.GA28483@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-8-chaitanya.kulkarni@wdc.com> <20200630051202.GD27033@lst.de> <BYAPR04MB49653ABB3E50A7D034BE8C68866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49653ABB3E50A7D034BE8C68866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 04:38:06AM +0000, Chaitanya Kulkarni wrote:
> On 6/29/20 10:12 PM, Christoph Hellwig wrote:
> > On Mon, Jun 29, 2020 at 04:43:10PM -0700, Chaitanya Kulkarni wrote:
> >> Now that we have done cleanup we can safely get rid of the
> >> blk_trace_request_get_cgid() and replace it with
> >> blk_trace_bio_get_cgid().
> > To me the helper actually looks useful compared to open coding the
> > check in a bunch of callers.
> > 
> 
> The helper adds an additional function call which can be avoided easily
> since blk_trace_bio_get_cgid() is written nicely, that also maintains
> the readability of the code.
> 
> Unless the cost of the function call doesn't matter and readability is
> not lost can we please not use helper ?

I think readability is lost.  I'd much rather drop the q argument
from blk_trace_request_get_cgid and keep the helper, as it pretty
clearly documents what is done.
