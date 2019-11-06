Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6BDC5DF63
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707C2178F
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 15:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfKFPBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:01:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:37268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfKFPBG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Nov 2019 10:01:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B0BCB55B;
        Wed,  6 Nov 2019 15:01:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2B0731E4353; Wed,  6 Nov 2019 16:01:05 +0100 (CET)
Date:   Wed, 6 Nov 2019 16:01:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        mgorman@suse.de, hare@suse.de
Subject: Re: elevator= kernel argument for recent kernels
Message-ID: <20191106150105.GK16085@quack2.suse.cz>
References: <20191106105340.GE16085@quack2.suse.cz>
 <1a0539a7-75c2-1ad6-aa5c-bf07a92e1eb3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0539a7-75c2-1ad6-aa5c-bf07a92e1eb3@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-11-19 07:15:35, Jens Axboe wrote:
> On 11/6/19 3:53 AM, Jan Kara wrote:
> > Hello,
> > 
> > with transition to blk-mq, the elevator= kernel argument was removed. I
> > understand the reasons for its removal but still I think this may come as a
> > surprise to some users since that argument has been there for ages and
> > although distributions generally transition to setting appropriate elevator
> > by udev rules, there are still people that use that argument with older
> > kernels and there are quite a few advices on the Internet to use it. So
> > shouldn't we at least warn loudly if someone uses elevator= argument on
> > kernels that don't support it and redirect people to sysfs? Something like
> > the attached patch? What do people think?
> 
> I'm fine with that, my objects have always been centered around trying
> to make the parameter work. A warning makes sense to point people in
> the right direction. I'll add this for 5.5.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
