Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3776DC433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE9420760
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 06:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGAGTC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:19:02 -0400
Received: from verein.lst.de ([213.95.11.211]:38754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgGAGTC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 02:19:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AC9A68B02; Wed,  1 Jul 2020 08:18:59 +0200 (CEST)
Date:   Wed, 1 Jul 2020 08:18:58 +0200
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
Subject: Re: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Message-ID: <20200701061858.GB28483@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-11-chaitanya.kulkarni@wdc.com> <20200630051332.GG27033@lst.de> <BYAPR04MB4965E849D99120B59011CEF5866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965E849D99120B59011CEF5866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 04:45:03AM +0000, Chaitanya Kulkarni wrote:
> On 6/29/20 10:13 PM, Christoph Hellwig wrote:
> > On Mon, Jun 29, 2020 at 04:43:13PM -0700, Chaitanya Kulkarni wrote:
> >> The only difference in block_get_rq and block_bio was the last param
> >> passed  __entry->nr_sector & bio->bi_iter.bi_size respectively. Since
> >> that is not the case anymore replace block_get_rq class with block_bio
> >> for block_getrq and block_sleeprq events, also adjust the code to handle
> >> null bio case in block_bio.
> > To me it seems like keeping the NULL bio case separate actually is a
> > little simpler..
> > 
> > 
> 
> Keeping it separate will have an extra event class and related
> event(s) for only handling null bio case.
> 
> Also the block_get_rq class uses 4 comparisons with ?:.
> This patch reduces it to only one comparison in fast path.
> 
> With above explanation does it make sense to get rid of the
> blk_get_rq ?

Without this we don't need the request_queue argument to the bio
class, as we can derive it from the bio, and don't have any
conditionals at all.  I'd rather keep the special case with a 
queue and an optional bio separate.
