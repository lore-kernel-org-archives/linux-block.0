Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:54844 "EHLO
        smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbcJEOFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2016 10:05:09 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161005131218.GB17339@redhat.com>
Date: Wed, 5 Oct 2016 16:04:55 +0200
Cc: Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <872670CC-AE1E-4AD9-8019-67EEC0EEE276@unimore.it>
References: <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it> <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com> <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org> <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it> <20161005131218.GB17339@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 05 ott 2016, alle ore 15:12, Vivek Goyal <vgoyal@redhat.com> ha scritto:
> 
> On Wed, Oct 05, 2016 at 02:37:00PM +0200, Paolo Valente wrote:
> 
> [..]
>> Anyway, to avoid going on with trying speculations and arguments, let
>> me retry with a practical proposal.  BFQ is out there, free.  Let's
>> just test, measure and check whether we have already a solution to
>> the problems you/we are still trying to solve in Linux.
> 
> Hi Paolo,
> 
> Does BFQ implementaiton scale for fast storage devices using blk-mq
> interface. We will want to make sure that locking and other overhead of
> BFQ is very minimal so that overall throughput does not suffer.
> 

Of course BFQ needs to be modified to work in blk-mq.  I'm rather sure
its overhead will then be small enough, just because I have already
collaborated to a basically equivalent port from single to multi-queue for
packet scheduling (with Luigi Rizzo and others), and our prototype can
make over 15 million scheduling decisions per second, and keep latency
low, even with tens of concurrent clients running on a multi-core,
multi-socket system.

For details, here is the paper [1], plus some slides [2].

Actually, the solution in [1] is a global scheduler, which is more
complex than the first blk-mq version of BFQ that I have in mind,
namely, partitioned scheduling, in which there should be one
independent scheduler instance per core.  But this is still investigation
territory. BTW, I would really appreciate help/feedback on this task [3].

Thanks,
Paolo

[1] http://info.iet.unipi.it/~luigi/papers/20160921-pspat.pdf
[2] http://info.iet.unipi.it/~luigi/pspat/
[3] https://marc.info/?l=linux-kernel&m=147066540916339&w=2

> Vivek
> 


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





