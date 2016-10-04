Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:43512 "EHLO
        smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcJDTC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 15:02:56 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161004185413.GF4205@htj.duckdns.org>
Date: Tue, 4 Oct 2016 21:02:47 +0200
Cc: Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
References: <cover.1475529372.git.shli@fb.com> <20161004132805.GB28808@redhat.com> <20161004155616.GB4205@htj.duckdns.org> <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it> <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it> <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com> <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 04 ott 2016, alle ore 20:54, Tejun Heo <tj@kernel.org> ha scritto:
> 
> Hello, Paolo.
> 
> On Tue, Oct 04, 2016 at 07:43:48PM +0200, Paolo Valente wrote:
>>> I don't think IO bandwidth does not matter. The problem is bandwidth can't
>>> measure IO cost. For example, you can't say 8k IO costs 2x IO resource than 4k
>>> IO.
>> 
>> For what goal do you need to be able to say this, once you succeeded
>> in guaranteeing bandwidth and low latency to each
>> process/client/group/node/user?
> 
> For resource partitioning mostly.  It's not a single user or purpose
> use case.  The same device gets shared across unrelated workloads and
> we need to guarantee differing levels of quality of service to each
> regardless of the specifics of workload.

That's exactly what BFQ has succeeded in doing in all the tests
devised so far.  Can you give me a concrete example for which I can
try with BFQ and with any other mechanism you deem better.  If
you are right, numbers will just make your point.

Thanks,
Paolo

>  We actually need to be able
> to control IO resources.
> 


> Thanks.
> 
> -- 
> tejun


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





