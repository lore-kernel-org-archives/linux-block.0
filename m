Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:54179 "EHLO
        smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbcJFSBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 14:01:50 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161006174943.GD17335@redhat.com>
Date: Thu, 6 Oct 2016 20:01:42 +0200
Cc: Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <FE2E9F43-610D-40B7-BA08-627CC53B2F6C@unimore.it>
References: <20161004191427.GG4205@htj.duckdns.org> <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org> <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it> <20161005144946.GA26977@htj.duckdns.org> <20161005183052.GA97491@anikkar-mbp.local.dhcp.thefacebook.com> <E7D744B7-22B1-4D6B-9C42-A43517AA490F@unimore.it> <20161005204601.GB1754@anikkar-mbp.local.dhcp.thefacebook.com> <5699035C-6DC3-497A-9D7A-A4E43D17C3CD@unimore.it> <35D8ECB2-BE20-4A4E-9B93-951B0D5042C9@unimore.it> <20161006174943.GD17335@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 06 ott 2016, alle ore 19:49, Vivek Goyal <vgoyal@redhat.com> ha scritto:
> 
> On Thu, Oct 06, 2016 at 03:15:50PM +0200, Paolo Valente wrote:
> 
> [..]
>> Shaohua, I have just realized that I have unconsciously defended a
>> wrong argument.  Although all the facts that I have reported are
>> evidently true, I have argued as if the question was: "do we need to
>> throw away throttling because there is proportional, or do we need to
>> throw away proportional share because there is throttling?".  This
>> question is simply wrong, as I think consciously (sorry for my
>> dissociated behavior :) ).
> 
> I was wondering about the same. We need both and both should be able 
> to work with fast devices of today using blk-mq interfaces without
> much overhead.
> 
>> 
>> The best goal to achieve is to have both a good throttling mechanism,
>> and a good proportional share scheduler.  This goal would be valid if
>> even if there was just one important scenario for each of the two
>> approaches.  The vulnus here is that you guys are constantly, and
>> rightly, working on solutions to achieve and consolidate reasonable
>> QoS guarantees, but an apparently very good proportional-share
>> scheduler has been kept off for years.  If you (or others) have good
>> arguments to support this state of affairs, then this would probably
>> be an important point to discuss.
> 
> Paolo, CFQ is legacy now and if we can come up with a proportional
> IO mechanism which works reasonably well with fast devices using
> blk-mq interfaces, that will be much more interesting.
> 

That's absolutely true.  But, why do we pretend not to know that, for
(at least) hundreds of thousands of users Linux will go on giving bad
responsiveness, starvation, high latency and unfairness, until blk
will not be used any more (assuming that these problems will somehow
disappear will blk-mq).  Many of these users are fully aware of these
Linux long-standing problems.  We could solve these problems by just
adding a scheduler that has already been adopted, and thus extensively
tested, by thousands of users.  And more and more people are aware of
this fact too.  Are we doing the right thing?

Thanks,
Paolo


> Vivek


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





