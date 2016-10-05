Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34809 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbcJEOtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2016 10:49:49 -0400
Date: Wed, 5 Oct 2016 10:49:46 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161005144946.GA26977@htj.duckdns.org>
References: <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
 <20161004202754.GJ4205@htj.duckdns.org>
 <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Wed, Oct 05, 2016 at 02:37:00PM +0200, Paolo Valente wrote:
> In this respect, for your generic, unpredictable scenario to make
> sense, there must exist at least one real system that meets the
> requirements of such a scenario.  Or, if such a real system does not
> yet exist, it must be possible to emulate it.  If it is impossible to
> achieve this last goal either, then I miss the usefulness
> of looking for solutions for such a scenario.
> 
> That said, let's define the instance(s) of the scenario that you find
> most representative, and let's test BFQ on it/them.  Numbers will give
> us the answers.  For example, what about all or part of the following
> groups:
> . one cyclically doing random I/O for some second and then sequential I/O
> for the next seconds
> . one doing, say, quasi-sequential I/O in ON/OFF cycles
> . one starting an application cyclically
> . one playing back or streaming a movie
> 
> For each group, we could then measure the time needed to complete each
> phase of I/O in each cycle, plus the responsiveness in the group
> starting an application, plus the frame drop in the group streaming
> the movie.  In addition, we can measure the bandwidth/iops enjoyed by
> each group, plus, of course, the aggregate throughput of the whole
> system.  In particular we could compare results with throttling, BFQ,
> and CFQ.
> 
> Then we could write resulting numbers on the stone, and stick to them
> until something proves them wrong.
> 
> What do you (or others) think about it?

That sounds great and yeah it's lame that we didn't start with that.
Shaohua, would it be difficult to compare how bfq performs against
blk-throttle?

Thanks.

-- 
tejun
