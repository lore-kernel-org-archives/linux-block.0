Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B237C433DF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0004220738
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 07:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG0HfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgG0HfR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 03:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D538AC59;
        Mon, 27 Jul 2020 07:35:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B86141E12C5; Mon, 27 Jul 2020 09:35:15 +0200 (CEST)
Date:   Mon, 27 Jul 2020 09:35:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] bfq: Use only idle IO periods for think time
 calculations
Message-ID: <20200727073515.GA23179@quack2.suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-3-jack@suse.cz>
 <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
 <20200611143912.GC19132@quack2.suse.cz>
 <7BE4BFD7-F8C1-49DE-A318-9E038B9A19BC@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BE4BFD7-F8C1-49DE-A318-9E038B9A19BC@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 22-07-20 11:13:28, Paolo Valente wrote:
> > a) I don't think adding these samples to statistics helps in any way (you
> > cannot improve the prediction power of the statistics by including in it
> > some samples that are not directly related to the thing you try to
> > predict). And think time is used to predict the answer to the question: If
> > bfq queue becomes idle, how long will it take for new request to arrive? So
> > second and further requests are simply irrelevant.
> > 
> 
> Yes, you are super right in theory.
> 
> Unfortunately this may not mean that your patch will do only good, for
> the concerns in my previous email. 
> 
> So, here is a proposal to move forward:
> 1) I test your patch on my typical set of
>    latency/guaranteed-bandwidth/total-throughput benchmarks
> 2) You test your patch on a significant set of benchmarks in mmtests
> 
> What do you think?

Sure, I will queue runs for the patches with mmtests :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
