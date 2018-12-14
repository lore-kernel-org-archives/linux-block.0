Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09AEC43444
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3173208CA
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tower-research-com.20150623.gappssmtp.com header.i=@tower-research-com.20150623.gappssmtp.com header.b="ZpjQp6pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeLNN4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:56:25 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35796 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeLNN4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 08:56:24 -0500
Received: by mail-wm1-f41.google.com with SMTP id c126so5883603wmh.0
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tower-research-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuCDgDMGBF3jVB+fRjKFHQAUuD4kgIbdI14SdkTEFCQ=;
        b=ZpjQp6peajX25XspDXOrmVbzHvgMZu343JeOTUZgyVzxKwsyxRR2R5A2pi3m0lU/8z
         06ZyGi3jVHqXovQZ5+LWmLMBMe3+uUK9TZMOtcrU8fkGndujbBg3Sa4SGA5OHpA0Camg
         ie+OIZCKKwFp9W5xis9Ezfrqi4e6yZgvzZ5AH04in3Bdr5gzfqzd48+W4Ohg2Q7xGG6s
         is8nmV7nvJzaXgBqizxMpo5T8ZmPnJ9s62ERBRumdq4544YlIHxo77N1nDu81YPojFJu
         hohJ9lF3bsLwv3F7CCCTEVyB+zpVI/5VitB8NnNzxRv07cRosXiw+stF1o00NF8JiIWX
         tRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuCDgDMGBF3jVB+fRjKFHQAUuD4kgIbdI14SdkTEFCQ=;
        b=nPv6tYZKVJFt8kgfGUFUOVucyQsB/ULRnDepo5fuZlfkdPphj3sRdvm4iIZTDQeJfV
         e8WcEi1nJkQijNliQe9IObT65Qd3UCeMhZkB9JNwz/7fgmQrAF4otP3gHZptysgdfijQ
         AOn2bLPjK5BmA8qD14lBiI+aDOZV+o91LXgxR50Qn/+Zn1irUtEuyGl2W5IF+aWborNQ
         OiR5N15mkl2QtXPmVr7MtBWncI+VIshoYnWCci8ALrxNLiSO+Mmyp/Q1sAn2whhHWHYR
         lMSepBluxaOqlFS/WjQ+UjdcDSiVEjKiw0gGneJYeKS9XWwK2eN9xTFQjj8RxALRp3Dh
         LBNw==
X-Gm-Message-State: AA+aEWYNm7x7DNUEKTugH8XBsSRU9reuo7Q4YkCEghTQRP1tKnMpa62P
        f3ml/eBflt1sncKxJCH7uSlz7VJguABwDHz26/TOpw==
X-Google-Smtp-Source: AFSGD/WxFc5K+2/SkHaPlmjRI+IMGkKW+KzDiGWhrpJ1XGCz09gm2/AhxUpJdOhKFlfR8I6Pj9iMTRhzEfyy5lfuBJc=
X-Received: by 2002:a1c:1593:: with SMTP id 141mr3240562wmv.85.1544795782475;
 Fri, 14 Dec 2018 05:56:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
In-Reply-To: <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
From:   Madhav Ancha <mancha@tower-research.com>
Date:   Fri, 14 Dec 2018 08:55:46 -0500
Message-ID: <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
Subject: Re: Unintuitive scheduling results using BFQ
To:     paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo,

    Thanks a lot for your work and your response to this email.

    Following your advise, I switched my real time application to direct I/O.
    We now have

    Task1: Using ionice -c1, we run a RT IO/ O_DIRECT task that writes
to flood the NVME drive to its capacity.
    Task2: We run a normal (best-effort) IO/ asyn(page-cache buffered)
task that writes to flood the NVME drive to its capacity.

    What we now see is that Task2 still ends up getting about 3/5th or
more of the NVMe bandwidth and Task1 ends up getting the rest of the
NVMe disk bandwidth. Could the kernel threads/buffering be
overpowering the RT priority of Task1?

    What we desire is to loosely ensure that Task1 gets as much
bandwidth as it asks for in any iteration while Task2 and the
remaining tasks share the leftover bandwidth.

    We are currently testing with these settings in BFQ.
    low_latency = 0 (to control the bandwidth allocation)
    slice_idle = 0     (we are using a fast NVMe and if Task1 does not
have any requests and control goes to Task2, it seems to make sense we
get the control back to Task1 quickly)
    timeout_sync = 1 (Task1 does application level buffering and sends
the biggest chunk of data available (in high MB's) always)

    We are unable to make the leap to cpugroups at this time Paolo. Is
there anything we can tune in BFQ or change the way we generate
traffic in Task1 to ensure that Task1 gets the bandwidth it asks for?

    A rough approximation to the Task1 and Task2 traffic we discussed
above seem to be these instantiations of dd.
    Task1: ionice -c1 -n2 /bin/dd if=/dev/zero of=/n/ssd1/ddtestRT1
bs=2M oflag=direct
    Task2: /bin/dd if=/dev/zero of=/n/ssd1/ddtestRT2   bs=2M

Thanks again Paolo,
Madhav.



On Fri, Dec 14, 2018 at 1:38 AM Paolo Valente <paolo.valente@linaro.org> wrote:
>
>
>
> > Il giorno 13 dic 2018, alle ore 21:34, Madhav Ancha <mancha@tower-research.com> ha scritto:
> >
> > In our setup, we have a task that writes to a NVMe SSD drive using the
> > page cache. (using ::write os calls). This task does application level
> > buffering and sends big (large MBs) chunks of data to ::write call.
> > Each instance of the task writes upto 10Gbps of data to the NVME SSD.
> >
> > We run two instances of this task as below.
> > Instance 1: Using ionice -c1, we run a RT IO instance of this task.
> > Instance 2: We run a normal (best-effort) IO instance of this task.
> >
> > Both the write task instances compete for NVMe bandwidth. We observe
> > that BFQ allocates equal bandwidth to both the task instances starting
> > a few seconds after they start up.
> >
> > What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling class)
> > will be granted all the bandwidth it asked for while Instance2 will be
> > allowed to consume the remaining bandwidth.
> >
> > Could you please help us understand how we may be able to design to
> > get our expected behavior.
> >
>
> Hi,
> if you do async, in-memory writes, then your task instances just dirty
> vm pages.  Then different processes, the kworkers, will do the
> writeback of dirty pages asynchronously, according to the system
> writeback logic and configuration.  kworkers have their own priority,
> which is likely to be the same for each such process.  AFAICT this
> priority is not related to the priority you give to your processes.
>
> If you want to control I/O bandwidths for writes, go for direct I/O or
> use cgroups.  In case of cgroups, consider that there is still the
> oddity that bfq interface parameters are non standard.  We have
> proposed and are pushing for a solution to this problem [1].
>
> Thanks,
> Paolo
>
> [1] https://lkml.org/lkml/2018/11/19/366
>
> > Thanks
>
