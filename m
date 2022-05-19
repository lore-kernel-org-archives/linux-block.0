Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0797C433FE
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 16:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiESQSV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiESQST (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 12:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 270F8D0294
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652977097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQ4TAecysw3frLTieko5gaC4+WCFvM/+zlynN1OI/6E=;
        b=UKPVymN4AuI+YWeUh9OqGVkHQEnXxBYgsPirsiGc2D60bzscQjxRu2CePcd9Rc7MYehwhQ
        YnTrwW+fwz1lMSDM6Z0QaUPFv/535Z6rWLFpW96y42JoQ89tndlGSg7vDUYVHdwvoaYJLn
        A7Eiixe8JM4ZXhy5EtfwDEE84cZeL1o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-GKcxtYjvMG-1jXDdGssjlw-1; Thu, 19 May 2022 12:18:15 -0400
X-MC-Unique: GKcxtYjvMG-1jXDdGssjlw-1
Received: by mail-qv1-f71.google.com with SMTP id t15-20020ad45bcf000000b0045a8cfef66bso4661625qvt.11
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 09:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQ4TAecysw3frLTieko5gaC4+WCFvM/+zlynN1OI/6E=;
        b=C3lcILW73vIHgofRv8ItEdwoLPyQO1iCNJpykuTqYD1s5qKs/8sKRrkR9FW47mpTaA
         Ko/heRqxPcrjhO0HNhw+I5MVxoydHAphSHHOvejWANluObzXoGK7cVF8tHJrfUlFkeoG
         /m6hiBHLyMGLjUHgQ2wbpPkDlmQEGL/nq3c55JqZQtHHrI5etluSi7np6e9quqPuKs3C
         5ozRtJ5pgYx5yFhlPiqCbxbITHfgoC8oHvfPSrkrlrS08fGJ7xh0NayOJQD+qItQB+hw
         eJ106LwmCZQYjk/XHJXK1T9TuqpEpLdz5YROaCDjbVYAyP4DBdlZl/jvIBUzT/B3qvdB
         m+EQ==
X-Gm-Message-State: AOAM530dEsaohzCRb+iGf8yrrsl32aXLhpcHA+JKSJN5tEFFwL5C/vch
        RZ5sD1DwAzJ64ANl6LoQhEZfNpQC83rmG7CsESVMkAO4A4574BcaD2oA4xeDQfXHIyuhSwVBIeU
        1Hef5jx8u/Kj/yXOdL1fU3sc=
X-Received: by 2002:ad4:596e:0:b0:45a:b06d:d8cb with SMTP id eq14-20020ad4596e000000b0045ab06dd8cbmr4758598qvb.97.1652977094263;
        Thu, 19 May 2022 09:18:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeLGV6/LkUYXKivXPcYSBWBx1uVmdx2hjoZWFSCBvPbX3xQ5DHzi1s8OpzAPYwufChEpSN7A==
X-Received: by 2002:ad4:596e:0:b0:45a:b06d:d8cb with SMTP id eq14-20020ad4596e000000b0045ab06dd8cbmr4758566qvb.97.1652977093914;
        Thu, 19 May 2022 09:18:13 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a3-20020ac844a3000000b002f39b99f6b3sm1464880qto.77.2022.05.19.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:18:13 -0700 (PDT)
Date:   Fri, 20 May 2022 00:18:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220519161803.2qkd5qj747q4srel@zlang-mailbox>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519075805.GU2306852@dread.disaster.area>
 <CAOQ4uxi-A2iErkbBBaewmoKa8OGWXaUzaZqwygQxKzzEZcsCXQ@mail.gmail.com>
 <YoZj4nHX42AOn8+F@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZj4nHX42AOn8+F@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 11:36:02AM -0400, Josef Bacik wrote:
> On Thu, May 19, 2022 at 12:20:28PM +0300, Amir Goldstein wrote:
> > On Thu, May 19, 2022 at 10:58 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Thu, May 19, 2022 at 09:36:41AM +0300, Amir Goldstein wrote:
> > > > [adding fstests and Zorro]
> > > >
> > > > On Thu, May 19, 2022 at 6:07 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > >
> > > > > I've been promoting the idea that running fstests once is nice,
> > > > > but things get interesting if you try to run fstests multiple
> > > > > times until a failure is found. It turns out at least kdevops has
> > > > > found tests which fail with a failure rate of typically 1/2 to
> > > > > 1/30 average failure rate. That is 1/2 means a failure can happen
> > > > > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > > > > failure.
> > > > >
> > > > > I have tried my best to annotate failure rates when I know what
> > > > > they might be on the test expunge list, as an example:
> > > > >
> > > > > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> > > > >
> > > > > The term "failure rate 1/15" is 16 characters long, so I'd like
> > > > > to propose to standardize a way to represent this. How about
> > > > >
> > > > > generic/530 # F:1/15
> > > > >
> > > >
> > > > I am not fond of the 1/15 annotation at all, because the only fact that you
> > > > are able to document is that the test failed after 15 runs.
> > > > Suggesting that this means failure rate of 1/15 is a very big step.
> > > >
> > > > > Then we could extend the definition. F being current estimate, and this
> > > > > can be just how long it took to find the first failure. A more valuable
> > > > > figure would be failure rate avarage, so running the test multiple
> > > > > times, say 10, to see what the failure rate is and then averaging the
> > > > > failure out. So this could be a more accurate representation. For this
> > > > > how about:
> > > > >
> > > > > generic/530 # FA:1/15
> > > > >
> > > > > This would mean on average there failure rate has been found to be about
> > > > > 1/15, and this was determined based on 10 runs.
> > >
> > > These tests are run on multiple different filesystems. What happens
> > > if you run xfs, ext4, btrfs, overlay in sequence? We now have 4
> > > tests results, and 1 failure.
> > >
> > > Does that make it FA: 1/4, or does it make it 1/1,0/1,0/1,0/1?
> > >
> > > What happens if we run, say, XFS w/ defaults, rmapbt=1, v4, quotas?
> > >
> > > Does that make it FA: 1/4, or does it make it 0/1,1/1,0/1,0/1?
> > >
> > > In each case above, 1/4 tells us nothing useful. OTOH, the 0/1 vs
> > > 1/1 breakdown is useful information, because it tells us whihc
> > > filesystem failed the test, or which specific config failed the
> > > test.
> > >
> > > Hence I think the ability for us to draw useful conclusions from a
> > > number like this is large dependent on the specific data set it is
> > > drawn from...
> > >
> > > > > We should also go extend check for fstests/blktests to run a test
> > > > > until a failure is found and report back the number of successes.
> > > > >
> > > > > Thoughts?
> > >
> > > Who is the expected consumer of this information?
> > >
> > > I'm not sure it will be meaningful for anyone developing new code
> > > and needing to run every test every time they run fstests.
> > >
> > > OTOH, for a QA environment where you have a fixed progression of the
> > > kernel releases you are testing, it's likely valuable and already
> > > being tracked in various distro QE management tools and
> > > dashboards....
> > >
> > > > I have had a discussion about those tests with Zorro.
> > > >
> > > > Those tests that some people refer to as "flaky" are valuable,
> > > > but they are not deterministic, they are stochastic.
> > >
> > > Extremely valuable. Worth their weight in gold to developers like
> > > me.
> > >
> > > The recoveryloop group tests are a good example of this. The name of
> > > the group indicates how we use it. I typically set it up to run with
> > > an loop iteration like "-I 100" knowing that is will likely fail a
> > > random test in the group within 10 iterations.
> > >
> > > Those one-off failures are almost always a real bug, and they are
> > > often unique and difficult to reproduce exactly. Post-mortem needs
> > > to be performed immediately because it may well be a unique on-off
> > > failure and running another test after the failure destroys the
> > > state needed to perform a post-mortem.
> > >
> > > Hence having a test farm running these multiple times and then
> > > reporting "failed once in 15 runs" isn't really useful to me as a
> > > developer - it doesn't tell us anything new, nor does it help us
> > > find the bugs that are being tripped over.
> > >
> > > Less obvious stochastic tests exist, too. There are many tests that
> > > use fstress as a workload that runs while some other operation is
> > > performed - freeze, grow, ENOSPC, error injections, etc. They will
> > > never be deterministic, any again any failure tends to be a real
> > > bug, too.
> > >
> > > However, I think these should be run by QE environments all the time
> > > as they require long term, frequent execution across different
> > > configs in different environments to find the deep dark corners
> > > where the bugs may lie dormant. These are the tests that find things
> > > like subtle timing races no other tests ever exercise.
> > >
> > > I suspect that tests that alter their behaviour via LOAD_FACTOR or
> > > TIME_FACTOR will fall into this category.
> > >
> > > > I think MTBF is the standard way to describe reliability
> > > > of such tests, but I am having a hard time imagining how
> > > > the community can manage to document accurate annotations
> > > > of this sort, so I would stick with documenting the facts
> > > > (i.e. the test fails after N runs).
> > >
> > > I'm unsure of what "reliablity of such tests" means in this context.
> > > The tests are trying to exercise and measure the reliability of the
> > > kernel code - if the *test is unreliable* then that says to me the
> > > test needs fixing. If the test is reliable, then any failures that
> > > occur indicate that the filesystem/kernel/fs tools are unreliable,
> > > not the test....
> > >
> > > "test reliability" and "reliability of filesystem under test" are
> > > different things with similar names. The latter is what I think we
> > > are talking about measuring and reporting here, right?
> > >
> > > > OTOH, we do have deterministic tests, maybe even the majority of
> > > > fstests are deterministic(?)
> > >
> > > Very likely. As a generalisation, I'd say that anything that has a
> > > fixed, single step at a time recipe and a very well defined golden
> > > output or exact output comparison match is likely deterministic.
> > >
> > > We use things like 'within tolerance' so that slight variations in
> > > test results don't cause spurious failures and hence make the test
> > > more deterministic.  Hence any test that uses 'within_tolerance' is
> > > probably a test that is expecting deterministic behaviour....
> > >
> > > > Considering that every auto test loop takes ~2 hours on our rig and that
> > > > I have been running over 100 loops over the past two weeks, if half
> > > > of fstests are deterministic, that is a lot of wait time and a lot of carbon
> > > > emission gone to waste.
> > > >
> > > > It would have been nice if I was able to exclude a "deterministic" group.
> > > > The problem is - can a developer ever tag a test as being "deterministic"?
> > >
> > > fstests allows private exclude lists to be used - perhaps these
> > > could be used to start building such a group for your test
> > > environment. Building a list from the tests you never see fail in
> > > your environment could be a good way to seed such a group...
> > >
> > > Maybe you have all the raw results from those hundreds of tests
> > > sitting around - what does crunching that data look like? Who else
> > > has large sets of consistent historic data sitting around? I don't
> > > because I pollute my results archive by frequently running varied
> > > and badly broken kernels through fstests, but people who just run
> > > released or stable kernels may have data sets that could be used....
> > >
> > 
> > I have no historic data of that sort and I have never stayed on the
> > same test system long enough to collect this sort of data.
> > 
> > Josef has told us in LPC 2021 about his btrfs fstests dashboard
> > where he started to collect historical data a while ago.
> > 
> 
> I'm clearly biased, but I think this is the best way to go for *developers*.  We
> want to know all the things, so we just need to have a clear way to see what's
> failing and have a historical view of what has failed.  If you look at our

I agree the "historical view" is needed, but it can't be provided by mainline
fstests, due to it might be used to test many different filesystems with different
sysytem software and hardware environment, and there're lots of downstream project,
they have their own variation, the "upstream mainline linux historical view"
isn't referential for all of them. Some of "downstream historical view" isn't
referential either.

The "historical view" is worthy for each project(or project group) itself, but
might be not universal for others. If someone would like to help to test someone
project, likes someone Ubuntu LTS version, or Debian, or CentOS, or someone LTS
kernel... that might be better to ask if related people have their "historical
view" data to help to get start, better than asking if fstests has that for all
different known/unknown projects.

I just replied Ted, I think his idea makes more sense. fstests can provide
some meaningful interfaces to help the testers use their historical data, or
help to summarize their historical data for each specific user/project. But
fstests doesn't store/provide those one-sided data directly.

Thanks,
Zorro

> dashboard at toxicpanda.com you can click on the tests and see their runs and
> failures on different configs.  This has been insanely valuable to me, and
> helped me narrow down test cases that needed to be adjusted for compression.
> 
> > Collaborating on expunge lists of different fs and different
> > kernel/config/distro
> > is one of the goals behind Luis's kdevops project.
> > 
> 
> I think this is also hugely valuable from the "Willy usecase" perspective.
> Willy doesn't care about failure rates or interpreting the tea leaves of what
> our format is, he wants to make sure he didn't break anything.  We should strive
> to have 0 failures for this use case, so having expunge lists in place to get
> rid of any flakey results are going to make it easier for non-experts to get a
> solid grasp on wether they introduced a regression or not.
> 
> There's room for both use cases.  I want the expunge lists for newbies, I want
> good reporting for the developers who know what they're doing.  We can provide
> documentation for both
> 
> - If Willy, run 'make fstests-clean'
> - If Josef, run 'mkame fstests'
> 
> Thanks,
> 
> Josef
> 

