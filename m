Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC4C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 18:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1997206BA
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 18:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tower-research-com.20150623.gappssmtp.com header.i=@tower-research-com.20150623.gappssmtp.com header.b="k6GCGGTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeLNS0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:26:35 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37534 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeLNS0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 13:26:35 -0500
Received: by mail-wm1-f51.google.com with SMTP id g67so6722125wmd.2
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 10:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tower-research-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGfCJNeJ3w9j+q4Gd+bH0qkJ925P/z+n+EeNC01Y1eY=;
        b=k6GCGGTPdnmMNEod0LVdfe6RrYk11KtDhHUn/TbjgOP2qblCMARcPK8Kdmc/ZPrUC5
         tFUfDMrh7KrpWQu2IVIgYwFKmNA6foSa8O2RkFrNqP7s4XyWROPFjgBgVekQOqB8SvD6
         4ve3DnViiJztrEK9zeWvIoDtKDJLs2Jd4cko80vvNppxWprSp2DD6RiLZ+/G50JYVQZ5
         XgM/i5Sy2i/2v36qaq5CpZfKSEwLeOhwvWuASA8XmApbU009aIz1R64SJaj+4ZHXD2E0
         8BDZ0jI9LryFatcfYO3G/EPM0SMXj8/r6CpPKqKZl1gMQARotWhJhJdOFyZHrQmRaN+Y
         rGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGfCJNeJ3w9j+q4Gd+bH0qkJ925P/z+n+EeNC01Y1eY=;
        b=Cl200Ccdp1OSMIzgLyNLQkFMQdyeWSaLfCcqcT9mPwi+tCEFp7IB6XW2kRb/wttwzS
         H2QaSNBMdtD1Q/qM0O0Y0ghsruUFWfn/YwBNnzaPZ0TLTD22JtG5XlcelWA0iBcZzcAl
         JLjB5P6Uw8gUaIW2mG/3HW0UULRSUz2Mb9LzVimamJM+xLC6UKuf2jKhpm6XW3zhwyJg
         jbMCuLVf/BWwVP9MmfKNRIRTkA95asvLdrgv6kNxn3+8JJdfCZ3G134KAa78SSwDVaOJ
         pFh/LS44X/hV8DQ+TlplPMl9NB/75W/HpNDZ9I0yf6iH4+tzC8VkeBSYO+u2JsBMSgtC
         hdSw==
X-Gm-Message-State: AA+aEWZFZhu94fY0I72wgArb3ggwL3ydSr8ZtWa4VfQzeZBqQtYgbnkF
        cmAIXAZn8MTekJpvAjIjLZXVNsc0S9Q3AxcgOmYkrA==
X-Google-Smtp-Source: AFSGD/VwbDnhRXOexSdAzzPWHiJBZk+5hpU2yMcXvVr/bH9CzUMkFX7fMihw6KQ+6tp/P9rpf7KZL8s2h8KftZTN10g=
X-Received: by 2002:a1c:e913:: with SMTP id q19mr4204855wmc.55.1544811992782;
 Fri, 14 Dec 2018 10:26:32 -0800 (PST)
MIME-Version: 1.0
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org> <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
In-Reply-To: <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
From:   Madhav Ancha <mancha@tower-research.com>
Date:   Fri, 14 Dec 2018 13:25:56 -0500
Message-ID: <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
Subject: Re: Unintuitive scheduling results using BFQ
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo,

    Thanks a lot for your time and help.

    I reset all the parameters for bfq and am now running with this
one change from the defaults.
    - low_latency is set to 0.

    When tested with our applications, the IOPRIO_CLASS_RT (doing
direct I/O) task has no preference over the IOPRIO_CLASS_BE task (that
was using the kernel page cache)

    When tested with dd, the IOPRIO_CLASS_RT task (with direct I/O)
was getting about 1/4th the bandwidth the IOPRIO_CLASS_BE task (with
buffered I/O) was getting.
        - RT task with direct I/O: ionice -c1 -n2 /bin/dd if=/dev/zero
of=/n/ssd1/ddtestRT bs=2M oflag=direct
        - BE task                       : /bin/dd if=/dev/zero
of=/n/ssd1/ddtestRT bs=2M

    Please let me know if you want me to test more Paolo.
    Will look forward to hearing from you.

Thanks,
Madhav.


On Fri, Dec 14, 2018 at 12:20 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>
>
>
> > Il giorno 14 dic 2018, alle ore 14:55, Madhav Ancha <mancha@tower-research.com> ha scritto:
> >
> > Hi Paolo,
> >
> >    Thanks a lot for your work and your response to this email.
> >
>
> Thank you for trying bfq!
>
> >    Following your advise, I switched my real time application to direct I/O.
> >    We now have
> >
> >    Task1: Using ionice -c1, we run a RT IO/ O_DIRECT task that writes
> > to flood the NVME drive to its capacity.
> >    Task2: We run a normal (best-effort) IO/ asyn(page-cache buffered)
> > task that writes to flood the NVME drive to its capacity.
> >
> >    What we now see is that Task2 still ends up getting about 3/5th or
> > more of the NVMe bandwidth and Task1 ends up getting the rest of the
> > NVMe disk bandwidth. Could the kernel threads/buffering be
> > overpowering the RT priority of Task1?
> >
> >    What we desire is to loosely ensure that Task1 gets as much
> > bandwidth as it asks for in any iteration while Task2 and the
> > remaining tasks share the leftover bandwidth.
> >
> >    We are currently testing with these settings in BFQ.
> >    low_latency = 0 (to control the bandwidth allocation)
>
> This may be a good idea.  But, after we sort this out, you could try
> leaving low_latency enabled.  It should cause no harm (I'm trying to
> make bfq smarter and smarter).
>
>
> >    slice_idle = 0     (we are using a fast NVMe and if Task1 does not
> > have any requests and control goes to Task2, it seems to make sense we
> > get the control back to Task1 quickly)
>
> Unfortunately, this is not correct.  Setting slice_idle to 0 means
> losing completely control on I/O.  And in you case you need ...
> control :)
>
> So, you'd better leave slice_idle as it is.
>
> The actual problem is that, while thinking on whether it was
> reasonable to set slice_idle == 0, I realized that bfq is likely to fail
> even with slice_idle > 0.  In fact, I have not checked the respect of
> RT priority for probably a few years.  And I have changed lots of
> critical operations in these years.
>
> So, I'll wait for your feedback, which I do expect to be negative.
> Then, if it is actually negative, I'll work on the bug behind the
> failure.
>
> >    timeout_sync = 1 (Task1 does application level buffering and sends
> > the biggest chunk of data available (in high MB's) always)
> >
>
> Also for this one, things should go well even without touching it.
> But we will find out after discovering whether bfq is broken for your
> use case.
>
> Looking forward to your feedback,
> Paolo
>
> >    We are unable to make the leap to cpugroups at this time Paolo. Is
> > there anything we can tune in BFQ or change the way we generate
> > traffic in Task1 to ensure that Task1 gets the bandwidth it asks for?
> >
> >    A rough approximation to the Task1 and Task2 traffic we discussed
> > above seem to be these instantiations of dd.
> >    Task1: ionice -c1 -n2 /bin/dd if=/dev/zero of=/n/ssd1/ddtestRT1
> > bs=2M oflag=direct
> >    Task2: /bin/dd if=/dev/zero of=/n/ssd1/ddtestRT2   bs=2M
> >
> > Thanks again Paolo,
> > Madhav.
> >
> >
> >
> > On Fri, Dec 14, 2018 at 1:38 AM Paolo Valente <paolo.valente@linaro.org> wrote:
> >>
> >>
> >>
> >>> Il giorno 13 dic 2018, alle ore 21:34, Madhav Ancha <mancha@tower-research.com> ha scritto:
> >>>
> >>> In our setup, we have a task that writes to a NVMe SSD drive using the
> >>> page cache. (using ::write os calls). This task does application level
> >>> buffering and sends big (large MBs) chunks of data to ::write call.
> >>> Each instance of the task writes upto 10Gbps of data to the NVME SSD.
> >>>
> >>> We run two instances of this task as below.
> >>> Instance 1: Using ionice -c1, we run a RT IO instance of this task.
> >>> Instance 2: We run a normal (best-effort) IO instance of this task.
> >>>
> >>> Both the write task instances compete for NVMe bandwidth. We observe
> >>> that BFQ allocates equal bandwidth to both the task instances starting
> >>> a few seconds after they start up.
> >>>
> >>> What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling class)
> >>> will be granted all the bandwidth it asked for while Instance2 will be
> >>> allowed to consume the remaining bandwidth.
> >>>
> >>> Could you please help us understand how we may be able to design to
> >>> get our expected behavior.
> >>>
> >>
> >> Hi,
> >> if you do async, in-memory writes, then your task instances just dirty
> >> vm pages.  Then different processes, the kworkers, will do the
> >> writeback of dirty pages asynchronously, according to the system
> >> writeback logic and configuration.  kworkers have their own priority,
> >> which is likely to be the same for each such process.  AFAICT this
> >> priority is not related to the priority you give to your processes.
> >>
> >> If you want to control I/O bandwidths for writes, go for direct I/O or
> >> use cgroups.  In case of cgroups, consider that there is still the
> >> oddity that bfq interface parameters are non standard.  We have
> >> proposed and are pushing for a solution to this problem [1].
> >>
> >> Thanks,
> >> Paolo
> >>
> >> [1] https://lkml.org/lkml/2018/11/19/366
> >>
> >>> Thanks
> >>
>
