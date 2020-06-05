Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5DC433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FFE2053B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 15:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgFEPAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:00:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:45472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgFEPAh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 11:00:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7E33B230;
        Fri,  5 Jun 2020 15:00:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 043D41E1281; Fri,  5 Jun 2020 17:00:36 +0200 (CEST)
Date:   Fri, 5 Jun 2020 17:00:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2 0/4] blktrace: fix sparse warnings
Message-ID: <20200605150035.GC13248@quack2.suse.cz>
References: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
 <46bee113-ee17-15a9-f383-ef0bc8b404b8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46bee113-ee17-15a9-f383-ef0bc8b404b8@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 04-06-20 21:24:30, Jens Axboe wrote:
> On 6/4/20 1:13 AM, Chaitanya Kulkarni wrote:
> > Hi,
> > 
> > This is a small patch-series which fixes various sparse warnings.
> > 
> > Regards,
> > Chaitanya
> > 
> > * Changes from V1:-
> > 
> > 1. Get rid of the first patch since Jan already posted similar
> >    patch.
> 
> Applied 1-3 (there seems to be no number 4 anymore, regardless of subject
> in this cover letter).
> 
> Jan, are you re-sending the final one?

OK, I've sent you [1] my patch together with the Luis' one it depends on -
that one stands on its own and was already reviewed so I think its simplest
this way...

								Honza

[1] https://lore.kernel.org/linux-block/20200605145349.18454-1-jack@suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
