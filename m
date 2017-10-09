Return-Path: <linux-block-owner@vger.kernel.org>
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:59303 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750828AbdJIKCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Oct 2017 06:02:15 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 5E9621C2763
        for <linux-block@vger.kernel.org>; Mon,  9 Oct 2017 11:02:14 +0100 (IST)
Date: Mon, 9 Oct 2017 11:02:13 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        DANIELE TOSCHI <187580@studenti.unimore.it>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@linaro.org>
Subject: Re: fio-based responsiveness test for MMTests
Message-ID: <20171009100213.lyhqmjk4ipu64b7n@techsingularity.net>
References: <A89EA513-DC34-4096-B20D-2AB5B2C2B695@linaro.org>
 <20171009084513.gkk5s3iag463s5sq@techsingularity.net>
 <58BD1F31-627A-4789-8878-CFFBDB383642@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <58BD1F31-627A-4789-8878-CFFBDB383642@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 09, 2017 at 11:39:13AM +0200, Paolo Valente wrote:
> > Also agreed. However, in general I only rely on those fio configurations to
> > detect major problems in the IO scheduler. There are too many boot-to-boot
> > variances in the throughput and iops figures to make accurate conclusions
> > on the headline figures. For the most part, if I'm looking at those
> > configurations then I'm looking at the iostats to see if there are anomalies
> > in await times, queue sizes, merges, major starvations etc.
> > 
> 
> Ok, probably this is the piece of information that I stretched too much,
> looking at it through my "responsiveness glasses".
> 

Completely understandable. We all have our biases :)

> > However, I'm not aware of a reliable
> > synthetic representation of such workloads. I also am not aware of a
> > synthetic methodology that can simulate both the IO pattern itself, the
> > think time of the application and crucially link the "think time" to when
> > IO is initiated but it's also been a long time since I looked.
> 
> That's exactly the contribution I would like to provide.  In the past
> 10 years, we have analyzed probably thousands of traces of workloads
> generated exactly by applications starting.
> 
> > About the
> > closest I had in the past was generating patterns like you suggest and then
> > timing how long it took an X window to appear once an application started
> > and this was years ago. The effort was abandoned because the time for the
> > window to appear was irrelevant. What mattered was how long it took the
> > application to be ready for use. Evolution was a particular example that
> > eventually caused me to abandon the effort (that and IO performance was not
> > my primary concern at the time). Evolution displaed a window relatively
> > quickly but then had a tendency to freeze while opening inboxes which I
> > didn't find a means of automatically detecting that would scale.
> > 
> 
> I do remember this concern of yours.  My reply was mainly that,
> unfortunately, you looked at one of the most difficult (if ever
> possible) applications to benchmark automatically. Fortunately, there
> are other, as popular applications, which are naturally suitable to
> automatic measurement of their start-up time.  The simplest and
> probably most popular example is any terminal: it stops doing I/O
> right after its window is displayed, i.e., right after it is ready for
> user input.  To be more precise, the amount of I/O the terminal still
> does after its window appears is below 1% of the total amount of I/O
> it does from the beginning of its startup.  Another popular and very
> easy to benchmark application is libreoffice.
> 
> For these applications, we have a detailed database of their I/O:
> size, position and inter-arrival time (thinktime) of every I/O
> request, measured on different storage devices and CPU/memory
> platforms.
> 
> The idea is then to write a set of tests in which (some of) these
> workloads are replayed, together with varying, additional background
> workloads.  The total time needed to serve each workload under test
> will be equal to the start-up time, in exactly the same conditions, of
> the application it mimics, except for a very low tolerance.  We will
> write this information in the documentation of the test.
> 
> If you have no further concerns, we will get back in touch when we
> have something ready.
> 

I have no further concerns. What you propose is ambitious but it would
be extremely valuable if it existed.

-- 
Mel Gorman
SUSE Labs
