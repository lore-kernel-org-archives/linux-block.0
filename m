Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B9FC61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 10:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3032086A
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 10:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmDXJpod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfASKId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:08:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfASKId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 05:08:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so17851032wrt.13;
        Sat, 19 Jan 2019 02:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8F9NLQ6kP99EptHHFDvN202g5hUHgqJdJYyjeX/YXZo=;
        b=qmDXJpodc+pzhJoUOEw4j279PeQ4AAN50Gm2xzZNjxVx9iy2udr4/uKYydWi2hVZks
         OBWcy8NNrkpwVtv6HeIWleQGLeQUyjzWoul6X4uKQ3+CG3RSEkgaPFdIbFKLBmcVmmU4
         kQs1EEbrrkimfrs38N9MdpMpxNVWg+8kxcSxE8ORpi2bQdBdZ2qHkhZRWsckGGYun2Dk
         79jR8Btfk5I6HSF9lnIAUsLq8xSU7iK0W+K9FlqKAxwyYIMLmSHQQ8gCM1Znq5gTbCtL
         P7d8xjlPFkcFC6ex/+21RJaA1jQJ8egHLg3wxAGxWohSz6H9A7y5VPPerDuHGvcaaFSS
         J9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8F9NLQ6kP99EptHHFDvN202g5hUHgqJdJYyjeX/YXZo=;
        b=lvxifBBucMFVwo/fH+tHeePKwb278toesMu/iKjDiMkkZCgHjko57+NJqcboASyQBT
         ibJb/7Ch3M8rluIhlTHiGdDZEpwI8LoI9b8c7Ie7SBR1JDYG0zMqGy+RvRzKj9dldC8C
         Xo4q/7fDEW3zjC5sukwmE4o4ZruVsodA+iblER79hY9xLf1Hlx1NvjQ+C/U6Agtd9/FJ
         F57WxePrRoAMG2/O+SsCcC2H7sbBP9n/FvtR/YxKy2n9v1ms/tOEo9XdtYPq2PXzghI+
         zy/9deuUDWNRYRMTPJVs1GgIXWW1aOptLR2SW5XRzK5WY8QRokyovhAB2KoC4ATJfjSI
         +JNA==
X-Gm-Message-State: AJcUukegeseAFowub3r5kraqNgDo4f8UC9KnUCZgMMT1jh3iAwAaWfM/
        tpYlnvbHMgtOFYfWCG9Gg0bbavue9Q==
X-Google-Smtp-Source: ALg8bN47r3Km/D7Kul3h49yiZNWaF09WJTtdtmL7LTZNF37JzaELMeUWePRH+PEDJkGE02VadwhiIQ==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr19275065wrg.325.1547892510242;
        Sat, 19 Jan 2019 02:08:30 -0800 (PST)
Received: from localhost (host150-62-dynamic.57-82-r.retail.telecomitalia.it. [82.57.62.150])
        by smtp.gmail.com with ESMTPSA id h62sm34769616wmf.11.2019.01.19.02.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 02:08:29 -0800 (PST)
Date:   Sat, 19 Jan 2019 11:08:27 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190119100827.GA1630@xps-13>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <20190118184403.GB1535@xps-13>
 <20190118194652.gg5j2yz3h2llecpj@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118194652.gg5j2yz3h2llecpj@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 02:46:53PM -0500, Josef Bacik wrote:
> On Fri, Jan 18, 2019 at 07:44:03PM +0100, Andrea Righi wrote:
> > On Fri, Jan 18, 2019 at 11:35:31AM -0500, Josef Bacik wrote:
> > > On Fri, Jan 18, 2019 at 11:31:24AM +0100, Andrea Righi wrote:
> > > > This is a redesign of my old cgroup-io-throttle controller:
> > > > https://lwn.net/Articles/330531/
> > > > 
> > > > I'm resuming this old patch to point out a problem that I think is still
> > > > not solved completely.
> > > > 
> > > > = Problem =
> > > > 
> > > > The io.max controller works really well at limiting synchronous I/O
> > > > (READs), but a lot of I/O requests are initiated outside the context of
> > > > the process that is ultimately responsible for its creation (e.g.,
> > > > WRITEs).
> > > > 
> > > > Throttling at the block layer in some cases is too late and we may end
> > > > up slowing down processes that are not responsible for the I/O that
> > > > is being processed at that level.
> > > 
> > > How so?  The writeback threads are per-cgroup and have the cgroup stuff set
> > > properly.  So if you dirty a bunch of pages, they are associated with your
> > > cgroup, and then writeback happens and it's done in the writeback thread
> > > associated with your cgroup and then that is throttled.  Then you are throttled
> > > at balance_dirty_pages() because the writeout is taking longer.
> > 
> > Right, writeback is per-cgroup and slowing down writeback affects only
> > that specific cgroup, but, there are cases where other processes from
> > other cgroups may require to wait on that writeback to complete before
> > doing I/O (for example an fsync() to a file shared among different
> > cgroups). In this case we may end up blocking cgroups that shouldn't be
> > blocked, that looks like a priority-inversion problem. This is the
> > problem that I'm trying to address.
> 
> Well this case is a misconfiguration, you shouldn't be sharing files between
> cgroups.  But even if you are, fsync() is synchronous, we should be getting the
> context from the process itself and thus should have its own rules applied.
> There's nothing we can do for outstanding IO, but that shouldn't be that much.
> That would need to be dealt with on a per-contoller basis.

OK, fair point. We shouldn't be sharing files between cgroups.

I'm still not sure if we can have similar issues with metadata I/O (that
may introduce latencies like the sync() scenario), I have to investigate
more and do more tests.

> 
> > 
> > > 
> > > I introduced the blk_cgroup_congested() stuff for paths that it's not easy to
> > > clearly tie IO to the thing generating the IO, such as readahead and such.  If
> > > you are running into this case that may be something worth using.  Course it
> > > only works for io.latency now but there's no reason you can't add support to it
> > > for io.max or whatever.
> > 
> > IIUC blk_cgroup_congested() is used in readahead I/O (and swap with
> > memcg), something like this: if the cgroup is already congested don't
> > generate extra I/O due to readahead. Am I right?
> 
> Yeah, but that's just how it's currently used, it can be used any which way we
> feel like.

I think it'd be very interesting to have the possibility to either
throttle I/O before writeback or during writeback. Right now we can only
throttle writeback. Maybe we can try to introduce some kind of dirty
page throttling controller using blk_cgroup_congested()... Opinions?

> 
> > 
> > > 
> > > > 
> > > > = Proposed solution =
> > > > 
> > > > The main idea of this controller is to split I/O measurement and I/O
> > > > throttling: I/O is measured at the block layer for READS, at page cache
> > > > (dirty pages) for WRITEs, and processes are limited while they're
> > > > generating I/O at the VFS level, based on the measured I/O.
> > > > 
> > > 
> > > This is what blk_cgroup_congested() is meant to accomplish, I would suggest
> > > looking into that route and simply changing the existing io controller you are
> > > using to take advantage of that so it will actually throttle things.  Then just
> > > sprinkle it around the areas where we indirectly generate IO.  Thanks,
> > 
> > Absolutely, I can probably use blk_cgroup_congested() as a method to
> > determine when a cgroup should be throttled (instead of doing my own
> > I/O measuring), but to prevent the "slow writeback slowing down other
> > cgroups" issue I still need to apply throttling when pages are dirtied
> > in page cache.
> 
> Again this is just a fuckup from a configuration stand point.  The argument
> could be made that sync() is probably broken here, but I think the right
> solution here is to just pass the cgroup context along with the writeback
> information and use that if it's set instead.  Thanks,

Alright, let's skip the root cgroup for now. I think the point here is
if we want to provide sync() isolation among cgroups or not.

According to the manpage:

       sync()  causes  all  pending  modifications  to filesystem metadata and cached file data to be
       written to the underlying filesystems.

And:
       According to the standard specification (e.g., POSIX.1-2001), sync() schedules the writes, but
       may  return  before  the actual writing is done.  However Linux waits for I/O completions, and
       thus sync() or syncfs() provide the same guarantees as fsync called on every file in the  sys‐
       tem or filesystem respectively.

Excluding the root cgroup, do you think a sync() issued inside a
specific cgroup should wait for I/O completions only for the writes that
have been generated by that cgroup?

Thanks,
-Andrea
