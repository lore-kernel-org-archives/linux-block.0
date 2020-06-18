Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98341C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 12:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC6B2073E
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 12:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgFRMEu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:04:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgFRMEt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 08:04:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 045A2ACA7;
        Thu, 18 Jun 2020 12:04:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2A1B1E12A6; Thu, 18 Jun 2020 14:04:46 +0200 (CEST)
Date:   Thu, 18 Jun 2020 14:04:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Message-ID: <20200618120446.GA9664@quack2.suse.cz>
References: <20200617135823.980-1-jack@suse.cz>
 <BYAPR04MB496500B1315D577596F07724869A0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496500B1315D577596F07724869A0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed 17-06-20 17:41:36, Chaitanya Kulkarni wrote:
> On 6/17/20 7:03 AM, Jan Kara wrote:
> > Currently blk-mq does not report any event when two requests get merged
> > in the elevator. This then results in difficult to understand sequence
> > of events like:
> > 
> > ...
> >    8,0   34     1579     0.608765271  2718  I  WS 215023504 + 40 [dbench]
> >    8,0   34     1584     0.609184613  2719  A  WS 215023544 + 56 <- (8,4) 2160568
> >    8,0   34     1585     0.609184850  2719  Q  WS 215023544 + 56 [dbench]
> >    8,0   34     1586     0.609188524  2719  G  WS 215023544 + 56 [dbench]
> >    8,0    3      602     0.609684162   773  D  WS 215023504 + 96 [kworker/3:1H]
> >    8,0   34     1591     0.609843593     0  C  WS 215023504 + 96 [0]
> > 
> > and you can only guess (after quite some headscratching since the above
> > excerpt is intermixed with a lot of other IO) that request 215023544+56
> > got merged to request 215023504+40. Provide proper event for request
> > merging like we used to do in the legacy block layer.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> The attempt_merge function is also responsible for the discard merging 
> which doesn't have any direction specified in ELEVATOR_XXX identifiers.
> In this patch we care unconditionally generating back merge event
> irrespective of the req_op.
> 
> Do we need to either generate event iff ELEVATOR_BACK_MERGE true case or
> add another trace point for discard ? given that it may lead to
> confusion since elevator flags for the discard doesn't specify the 
> direction.

attempt_merge() is always called so that 'req' is always the request with
the lower sector, 'next' is the request with a higher sector, and 'next' is
discarded and 'req' is updated. So attempt_merge() always performs only one
direction of a merge and I don't think it makes any sence to distinguish
back merges and forward merges in this case. So discards don't need any
special treatment either AFAICT.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
