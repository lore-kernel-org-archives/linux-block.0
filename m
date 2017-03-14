Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
To: Paolo Valente <paolo.valente@linaro.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <1488848390.3125.14.camel@sandisk.com>
 <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
Cc: "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <809d4fd8-dbe1-1873-8d81-45aead275b71@kernel.dk>
Date: Tue, 14 Mar 2017 09:42:58 -0600
MIME-Version: 1.0
In-Reply-To: <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/14/2017 09:35 AM, Paolo Valente wrote:
> First, I've developed BFQ in a sort of
> first-the-problem-then-the-solution way.  That is, each time, I have
> first implemented a benchmark that enabled me to highlight the problem
> and get all relevant statistics on it, then I have worked on BFQ to
> try to solve that problem, using the benchmark as a support.  All
> those benchmarks are in the public S suite now.  In particular, by
> running one script, and waiting at most one hour, you get graphs of
> - throughput with read/write/random/sequential workloads
> - start-up times of bash, xterm, gnome terminal and libreoffice, when
> all the above combinations of workloads are executed in the background
> - frame drop rate for the playback of a movie, again with both all the
> above combinations of workloads and the recurrent start of a bash
> shell in the background
> - kernel-task execution times (compilation, merge, ...), again with
> all the above combinations of workloads in the background
> - fairness with various combinations of weights and processes
> - throughput against interleaved I/O, with a number of readers ranging
> from 2 to 9
> 
> Every time I fix a bug, add a new feature or port BFQ to a new kernel
> version, I just run that script and compare new graphs with previous
> ones.  Any regression shows up immediately.  We already have a
> similar, working script for Android too, although covering only
> throughput, responsiveness and frame drops for the moment.  Of course,
> the coverage of these scripts is limited to only the goals for which I
> have devised and tuned BFQ so far.  But I hope that it won't be too
> hard to extend them to other important use cases (e.g., dbms).

This is great, btw, and a really nice tool set to have when evaluating
new changes.

> Second, IMO BFQ is complex also because it contains a lot of features.
> We have adopted the usual approach for handling this type of
> complexity: find clean cuts to get independent pieces, and put each
> piece in a separate file, plus one header glue file.  The pieces were:
> scheduling engine, hierarchical-scheduling support (allowing the
> engine to scheduler generic nodes in the hierarchy), cgroups support.
> Yet, Tejun last year, and Jens more recently, have asked to put
> everything in one file; for other good reasons of course.  If you do
> think that turning back to multiple files may somehow help, and there
> are no strong objections from others, then I'm willing to resume this
> option and possibly find event better splits.
> 
> Third and last, a proposal: why don't we discuss this issue at LSF
> too?  In particular, we could talk about the parts of BFQ that seem
> more complex to understand, until they become clearer to you.  Then I
> could try to understand what helped make them clearer, and translate
> it into extra comments in the code or into other, more radical
> changes.

A big issue here is the lack of nicely structured code. It's one massive
file of code, 8751 lines, or almost 270K of code. It might be a lot
easier to read and understand if it was split into smaller files,
containing various parts of it.

-- 
Jens Axboe
