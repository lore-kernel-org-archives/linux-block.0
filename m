Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932982AbcJFScS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 14:32:18 -0400
Date: Thu, 6 Oct 2016 14:32:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161006183216.GE17335@redhat.com>
References: <20161004202754.GJ4205@htj.duckdns.org>
 <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
 <20161005144946.GA26977@htj.duckdns.org>
 <20161005183052.GA97491@anikkar-mbp.local.dhcp.thefacebook.com>
 <E7D744B7-22B1-4D6B-9C42-A43517AA490F@unimore.it>
 <20161005204601.GB1754@anikkar-mbp.local.dhcp.thefacebook.com>
 <5699035C-6DC3-497A-9D7A-A4E43D17C3CD@unimore.it>
 <35D8ECB2-BE20-4A4E-9B93-951B0D5042C9@unimore.it>
 <20161006174943.GD17335@redhat.com>
 <FE2E9F43-610D-40B7-BA08-627CC53B2F6C@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FE2E9F43-610D-40B7-BA08-627CC53B2F6C@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 08:01:42PM +0200, Paolo Valente wrote:
> 
> > Il giorno 06 ott 2016, alle ore 19:49, Vivek Goyal <vgoyal@redhat.com> ha scritto:
> > 
> > On Thu, Oct 06, 2016 at 03:15:50PM +0200, Paolo Valente wrote:
> > 
> > [..]
> >> Shaohua, I have just realized that I have unconsciously defended a
> >> wrong argument.  Although all the facts that I have reported are
> >> evidently true, I have argued as if the question was: "do we need to
> >> throw away throttling because there is proportional, or do we need to
> >> throw away proportional share because there is throttling?".  This
> >> question is simply wrong, as I think consciously (sorry for my
> >> dissociated behavior :) ).
> > 
> > I was wondering about the same. We need both and both should be able 
> > to work with fast devices of today using blk-mq interfaces without
> > much overhead.
> > 
> >> 
> >> The best goal to achieve is to have both a good throttling mechanism,
> >> and a good proportional share scheduler.  This goal would be valid if
> >> even if there was just one important scenario for each of the two
> >> approaches.  The vulnus here is that you guys are constantly, and
> >> rightly, working on solutions to achieve and consolidate reasonable
> >> QoS guarantees, but an apparently very good proportional-share
> >> scheduler has been kept off for years.  If you (or others) have good
> >> arguments to support this state of affairs, then this would probably
> >> be an important point to discuss.
> > 
> > Paolo, CFQ is legacy now and if we can come up with a proportional
> > IO mechanism which works reasonably well with fast devices using
> > blk-mq interfaces, that will be much more interesting.
> > 
> 
> That's absolutely true.  But, why do we pretend not to know that, for
> (at least) hundreds of thousands of users Linux will go on giving bad
> responsiveness, starvation, high latency and unfairness, until blk
> will not be used any more (assuming that these problems will somehow
> disappear will blk-mq).  Many of these users are fully aware of these
> Linux long-standing problems.  We could solve these problems by just
> adding a scheduler that has already been adopted, and thus extensively
> tested, by thousands of users.  And more and more people are aware of
> this fact too.  Are we doing the right thing?

Hi Paolo,

People have been using CFQ for many years. I am not sure if benefits 
offered by BFQ over CFQ are significant enough to justify taking a
completely new code and get rid of CFQ. Or are the benfits significant
enough that one feels like putting time and effort into this and
take chances wiht new code.

At this point of time replacing CFQ with something better is not a
priority for me. But if something better and stable goes upstream, I
will gladly use it.

Vivek
