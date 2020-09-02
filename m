Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB2C433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C4120767
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIBPR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgIBPRT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 11:17:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBD2BAD4A;
        Wed,  2 Sep 2020 15:17:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E4311E12D1; Wed,  2 Sep 2020 17:17:17 +0200 (CEST)
Date:   Wed, 2 Sep 2020 17:17:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] bfq: Use only idle IO periods for think time
 calculations
Message-ID: <20200902151717.GA4736@quack2.suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-3-jack@suse.cz>
 <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
 <20200611143912.GC19132@quack2.suse.cz>
 <7BE4BFD7-F8C1-49DE-A318-9E038B9A19BC@linaro.org>
 <20200727073515.GA23179@quack2.suse.cz>
 <20200826135419.GF15126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826135419.GF15126@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-08-20 15:54:19, Jan Kara wrote:
> On Mon 27-07-20 09:35:15, Jan Kara wrote:
> > On Wed 22-07-20 11:13:28, Paolo Valente wrote:
> > > > a) I don't think adding these samples to statistics helps in any way (you
> > > > cannot improve the prediction power of the statistics by including in it
> > > > some samples that are not directly related to the thing you try to
> > > > predict). And think time is used to predict the answer to the question: If
> > > > bfq queue becomes idle, how long will it take for new request to arrive? So
> > > > second and further requests are simply irrelevant.
> > > > 
> > > 
> > > Yes, you are super right in theory.
> > > 
> > > Unfortunately this may not mean that your patch will do only good, for
> > > the concerns in my previous email. 
> > > 
> > > So, here is a proposal to move forward:
> > > 1) I test your patch on my typical set of
> > >    latency/guaranteed-bandwidth/total-throughput benchmarks
> > > 2) You test your patch on a significant set of benchmarks in mmtests
> > > 
> > > What do you think?
> > 
> > Sure, I will queue runs for the patches with mmtests :).
> 
> Sorry it took so long but I've hit a couple of technical snags when running
> these tests (plus I was on vacation). So I've run the tests on 4 machines.
> 2 with rotational disks with NCQ, 2 with SATA SSD. Results are mostly
> neutral, details are below.
> 
> For dbench, it seems to be generally neutral but the patches do fix
> occasional weird outlier which are IMO caused exactly by bugs in the
> heuristics I'm fixing. Things like (see the outlier for 4 clients
> with vanilla kernel):
> 
> 		vanilla			bfq-waker-fixes
> Amean 	1 	32.57	( 0.00%)	32.10	( 1.46%)
> Amean 	2 	34.73	( 0.00%)	34.68	( 0.15%)
> Amean 	4 	199.74	( 0.00%)	45.76	( 77.09%)
> Amean 	8 	65.41	( 0.00%)	65.47	( -0.10%)
> Amean 	16	95.46	( 0.00%)	96.61	( -1.21%)
> Amean 	32	148.07	( 0.00%)	147.66	( 0.27%)
> Amean	64	291.17	( 0.00%)	289.44	( 0.59%)
> 
> For pgbench and bonnie, patches are neutral for all the machines.
> 
> For reaim disk workload, patches are mostly neutral, just on one machine
> with SSD they seem to improve XFS results and worsen ext4 results. But
> results look rather noisy on that machine so it may be just a noise...
> 
> For parallel dd(1) processes reading from multiple files, results are also
> neutral all machines.
> 
> For parallel dd(1) processes reading from a common file, results are also
> neutral except for one machine with SSD on XFS (ext4 was fine) where there
> seems to be consistent regression for 4 and more processes:
> 
> 		vanilla			bfq-waker-fixes
> Amean 	1 	393.30	( 0.00%)	391.02	( 0.58%)
> Amean 	4 	443.88	( 0.00%)	517.16	( -16.51%)
> Amean 	7 	599.60	( 0.00%)	748.68	( -24.86%)
> Amean 	12	1134.26	( 0.00%)	1255.62	( -10.70%)
> Amean 	21	1940.50	( 0.00%)	2206.29	( -13.70%)
> Amean 	30	2381.08	( 0.00%)	2735.69	( -14.89%)
> Amean 	48	2754.36	( 0.00%)	3258.93	( -18.32%)
> 
> I'll try to reproduce this regression and check what's happening...
> 
> So what do you think, are you fine with merging my patches now?

Paolo, any results from running your tests for these patches? I'd like to
get these mostly obvious things merged so that we can move on...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
