Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E768C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B665218BA
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 17:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="U7mHMqbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSRtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:49:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34311 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfHSRtn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 13:49:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id m10so2160032qkk.1
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DZpwu7CA6Yl+nVNk9nVuM3aH/qQVZp5XGs/Dvk76upM=;
        b=U7mHMqbozQMyKIM1CGMSnXy4vlhuytl29tpxccMlrVZY+cC7loQpzGl8Kc/xXsFv3t
         JCQ+77zAhEYjWutRb0NceqpR4Qre1TwX+4l9EuQ1pASOhGLrbZ0Mkw4+kdulA2TM4nGo
         Kv5bPipOjhVc80H4j93G+AEOJ6aHvReD5rqahML+TQLwrk1XAvN5kHLfxykGbCarIwBq
         F/SLq02VhsuAeDlAORv6OfJYpaxe4kLmfslkeWBDGN33fB/vm6+lSPNj/7X4/DGG3VLK
         oxer7dv11Dl1RJ2VGE7I4DXmNYtmPnyXGxxod0NJeKlx+AWz2BeABK0U+8sVprBVg/Nu
         puGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZpwu7CA6Yl+nVNk9nVuM3aH/qQVZp5XGs/Dvk76upM=;
        b=jpmztcojqVetVRrO+47BiZgPTji1T+YNELuTroqpf33XaeWM86IcFgB7NuueYubUqQ
         SdkcfFagmA346LjMnCbmoIN/Fleb3+S6wRZGS/e3Iw5de+BlenIZ2WH4lUDXvTghwBCr
         /RXV8Fv4gfMtZ9wwdmxPXjsSbGtbeQQWZcXtp1J88u8Upv4EqlGIPAuigqyt4iH5i7wF
         iYcd+JfXeUzEMhyVa+gd3JmFtA7ZltBdKcWSEEljMEuoJNhOsbZtPsx0vK2/lfBCscqJ
         epLBmOnJbs5WqTel53zx96fkV6Rk40jsMnhJE2j8tv+NGwULT7lrYi4zgF7HnKMjUCZ6
         Kbjw==
X-Gm-Message-State: APjAAAUnGaPT48/p0LLfNF8o2KFRADzMhS5IdDrKfa09EuKG1yvcjxG5
        8bwmRTkPQci8OsSiMYu2rFyIvg==
X-Google-Smtp-Source: APXvYqxg35fYExT4QE637s8h7V2czjI+HUKOb6qS3ZGARcMEayKdNcIIdzncpofIcIMj/npKkKZ25g==
X-Received: by 2002:a37:5846:: with SMTP id m67mr21499794qkb.375.1566236981216;
        Mon, 19 Aug 2019 10:49:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 1sm829088qko.73.2019.08.19.10.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 10:49:40 -0700 (PDT)
Date:   Mon, 19 Aug 2019 13:49:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Subject: Re: io.latency controller apparently not working
Message-ID: <20190819174938.om55afpr2o6fsfin@MacBook-Pro-91.local>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
 <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
 <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
 <20190816175931.cxpdko44cuyq7trj@MacBook-Pro-91.local>
 <88488E82-E360-45B0-B010-209190D32892@linaro.org>
 <FE51815E-787B-474C-A6B2-ABDC8853C772@linaro.org>
 <20D79D51-468A-4FA7-9213-F0EC2AD3D78A@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20D79D51-468A-4FA7-9213-F0EC2AD3D78A@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 07:00:56PM +0200, Paolo Valente wrote:
> 
> 
> > Il giorno 19 ago 2019, alle ore 18:41, Paolo Valente <paolo.valente@linaro.org> ha scritto:
> > 
> > 
> > 
> >> Il giorno 16 ago 2019, alle ore 20:17, Paolo Valente <paolo.valente@linaro.org> ha scritto:
> >> 
> >> 
> >> 
> >>> Il giorno 16 ago 2019, alle ore 19:59, Josef Bacik <josef@toxicpanda.com> ha scritto:
> >>> 
> >>> On Fri, Aug 16, 2019 at 07:52:40PM +0200, Paolo Valente wrote:
> >>>> 
> >>>> 
> >>>>> Il giorno 16 ago 2019, alle ore 15:21, Josef Bacik <josef@toxicpanda.com> ha scritto:
> >>>>> 
> >>>>> On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
> >>>>>> Hi,
> >>>>>> I happened to test the io.latency controller, to make a comparison
> >>>>>> between this controller and BFQ.  But io.latency seems not to work,
> >>>>>> i.e., not to reduce latency compared with what happens with no I/O
> >>>>>> control at all.  Here is a summary of the results for one of the
> >>>>>> workloads I tested, on three different devices (latencies in ms):
> >>>>>> 
> >>>>>>          no I/O control        io.latency         BFQ
> >>>>>> NVMe SSD     1.9                   1.9                0.07
> >>>>>> SATA SSD     39                    56                 0.7
> >>>>>> HDD          4500                  4500               11
> >>>>>> 
> >>>>>> I have put all details on hardware, OS, scenarios and results in the
> >>>>>> attached pdf.  For your convenience, I'm pasting the source file too.
> >>>>>> 
> >>>>> 
> >>>>> Do you have the fio jobs you use for this?
> >>>> 
> >>>> The script mentioned in the draft (executed with the command line
> >>>> reported in the draft), executes one fio instance for the target
> >>>> process, and one fio instance for each interferer.  I couldn't do with
> >>>> just one fio instance executing all jobs, because the weight parameter
> >>>> doesn't work in fio jobfiles for some reason, and because the ioprio
> >>>> class cannot be set for individual jobs.
> >>>> 
> >>>> In particular, the script generates a job with the following
> >>>> parameters for the target process:
> >>>> 
> >>>> ioengine=sync
> >>>> loops=10000
> >>>> direct=0
> >>>> readwrite=randread
> >>>> fdatasync=0
> >>>> bs=4k
> >>>> thread=0
> >>>> filename=/mnt/scsi_debug/largefile_interfered0
> >>>> iodepth=1
> >>>> numjobs=1
> >>>> invalidate=1
> >>>> 
> >>>> and a job with the following parameters for each of the interferers,
> >>>> in case, e.g., of a workload made of reads:
> >>>> 
> >>>> ioengine=sync
> >>>> direct=0
> >>>> readwrite=read
> >>>> fdatasync=0
> >>>> bs=4k
> >>>> filename=/mnt/scsi_debug/largefileX
> >>>> invalidate=1
> >>>> 
> >>>> Should you fail to reproduce this issue by creating groups, setting
> >>>> latencies and starting fio jobs manually, what if you try by just
> >>>> executing my script?  Maybe this could help us spot the culprit more
> >>>> quickly.
> >>> 
> >>> Ah ok, you are doing it on a mountpoint.
> >> 
> >> Yep
> >> 
> >>> Are you using btrfs?
> >> 
> >> ext4
> >> 
> >>> Cause otherwise
> >>> you are going to have a sad time.
> >> 
> >> Could you elaborate more on this?  I/O seems to be controllable on ext4.
> >> 
> >>> The other thing is you are using buffered,
> >> 
> >> Actually, the problem is suffered by sync random reads, which always
> >> hit the disk in this test.
> >> 
> >>> which may or may not hit the disk.  This is what I use to test io.latency
> >>> 
> >>> https://patchwork.kernel.org/patch/10714425/
> >>> 
> >>> I had to massage it since it didn't apply directly, but running this against the
> >>> actual block device, with O_DIRECT so I'm sure to be measure the actual impact
> >>> of the controller, it all works out fine.
> >> 
> >> I'm not getting why non-direct sync reads, or buffered writes, should
> >> be uncontrollable.  As a trivial example, BFQ in this tests controls
> >> I/O as expected, and keeps latency extremely low.
> >> 
> >> What am I missing?
> >> 
> > 
> > While waiting for your answer, I've added also the direct-I/O case to
> > my test.  Now we have also this new case reproduced by the command
> > line reported in the draft.

Sorry something caught fire and I got distracted.

> > 
> > Even with direct I/O, nothing changes with writers as interferers,
> > apart from latency becoming at least equal to the case of no I/O
> > control for the HDD.  Summing up, with writers as interferers (latency
> > in ms):
> > 
> >            no I/O control        io.latency         BFQ
> > NVMe SSD     3                     3                 0.2
> > SATA SSD     3                     3                 0.2
> > HDD          56                    56                13
> > 
> > In contrast, there are important improvements with the SSDs, in case
> > of readers as interferers.  This is the new situation (latency still
> > in ms):
> > 
> >            no I/O control        io.latency         BFQ
> > NVMe SSD     1.9                   0.08              0.07
> > SATA SSD     39                    0.2               0.7
> > HDD          4500                  118               11
> > 
> 
> I'm sorry, I didn't repeat tests with direct I/O for BFQ too.  And
> results change for BFQ too in case of readers as interferes.  Here
> are all correct figures for readers as interferers (latency in ms):
> 
>            no I/O control        io.latency         BFQ
> NVMe SSD     1.9                   0.08              0.07
> SATA SSD     39                    0.2               0.2
> HDD          4500                  118               10

Alright so it's working right with reads an O_DIRECT.  I'm not entirely sure
what's happening with the buffered side, I will investigate.

The writes I don't expect to work on ext4, there's a priority inversion in ext4
that I haven't bothered to work around since we use btrfs anywhere we want io
control.  That being said it shouldn't be behaving this poorly.  Once I've
wrapped up what I'm currently working on I'll run through this and figure out
the weirdness for these two cases.  Thanks,

Josef
