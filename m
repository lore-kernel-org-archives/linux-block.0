Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F1BC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE8A21848
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="VAifM9Xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfA2SuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:50:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43632 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfA2SuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:50:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id z18so12144715qkj.10
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q6joBr0fqtyC412CkUtub58bUqRUjZG+AFn6kz8B8N4=;
        b=VAifM9XdWSBqRuh4BwNdOiCm9wC0UPiKzpr3h/hBmK7h7DACgaGRFo2kVmBxkXYBUq
         jy8wTe7ggvdm4KREJPe2zIaIbq6iH+ZYSu2PIBApbHpSAMaioKnAtnYhOHBXnOK/p30g
         wG//3s8TLbJys7F+bmZkyY7+rGjNnI/cPT8FBFNrRg7qlruuv+avqqGNXqNBbNa6S/ez
         S8vovjxgLSkmt4vtjxV/Fpdfs4Hguy3qTpf5zJd8AVPAcAMY5OseEnwglRJ37CSTZHe6
         FBksNVpPHDXUDb1eeqTkKTTHQ1BNKaczf0hY434RESNSxAEm8u+fZ8hdyYuyYisN8iDW
         iL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q6joBr0fqtyC412CkUtub58bUqRUjZG+AFn6kz8B8N4=;
        b=ldxuvXIpfnD8Gujtdhc4C19ylt5VNvSdfH4vOl7YwsLsMvwY6zv/Tgl2dWEGs/Gsw7
         P1plICx6xFHSEdmb/mS564etriljxdy/GSdKiagc9VYJmgneDAzMhaCZA5B0YxNrVhlS
         Ma53Lf4gYWAvY5GsVYcl+YFVSbkxJu6hQdMmnygRC3WMRbU7el/28oIxXYcTVAPksSPr
         ALoZ8fcnK52+ELITTFHObJWoiSTOkRd3+QYlH3shWCkuw0disENLN2VThlrwt/x6XuLv
         YBFpmM5taOPNxg6T5549rU8SOv9h7ga6r/b8y8to5L6y6ynQIgiNhmwTAfrM9jhqPo8l
         6+cg==
X-Gm-Message-State: AJcUukeYBLI9Hu2vKbrLZK6fq+7W0WQoB+uzGroq4zUPCtZ2UR8vkTf5
        qYGga84K/tsdVKmkxwgqbj6O1PHrMBddWg==
X-Google-Smtp-Source: ALg8bN42/fnTkMMeAZa4S8DsLtE0U02Gvv2OAeXF7Nxtgibm5ePdLvE+kgauPoNJcl6HtXG4pnCdbg==
X-Received: by 2002:a37:7b01:: with SMTP id w1mr24870367qkc.122.1548787815512;
        Tue, 29 Jan 2019 10:50:15 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l195sm49637515qke.58.2019.01.29.10.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:50:14 -0800 (PST)
Date:   Tue, 29 Jan 2019 13:50:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190129185012.jieed26ddcbz7jmb@MacBook-Pro-91.local>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <20190118184403.GB1535@xps-13>
 <20190118194652.gg5j2yz3h2llecpj@macbook-pro-91.dhcp.thefacebook.com>
 <20190119100827.GA1630@xps-13>
 <20190121214715.GA27713@redhat.com>
 <20190128174129.GB8272@xps-13>
 <20190128192620.GB10240@redhat.com>
 <20190129183938.GA2960@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129183938.GA2960@xps-13>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 07:39:38PM +0100, Andrea Righi wrote:
> On Mon, Jan 28, 2019 at 02:26:20PM -0500, Vivek Goyal wrote:
> > On Mon, Jan 28, 2019 at 06:41:29PM +0100, Andrea Righi wrote:
> > > Hi Vivek,
> > > 
> > > sorry for the late reply.
> > > 
> > > On Mon, Jan 21, 2019 at 04:47:15PM -0500, Vivek Goyal wrote:
> > > > On Sat, Jan 19, 2019 at 11:08:27AM +0100, Andrea Righi wrote:
> > > > 
> > > > [..]
> > > > > Alright, let's skip the root cgroup for now. I think the point here is
> > > > > if we want to provide sync() isolation among cgroups or not.
> > > > > 
> > > > > According to the manpage:
> > > > > 
> > > > >        sync()  causes  all  pending  modifications  to filesystem metadata and cached file data to be
> > > > >        written to the underlying filesystems.
> > > > > 
> > > > > And:
> > > > >        According to the standard specification (e.g., POSIX.1-2001), sync() schedules the writes, but
> > > > >        may  return  before  the actual writing is done.  However Linux waits for I/O completions, and
> > > > >        thus sync() or syncfs() provide the same guarantees as fsync called on every file in the  sys‐
> > > > >        tem or filesystem respectively.
> > > > > 
> > > > > Excluding the root cgroup, do you think a sync() issued inside a
> > > > > specific cgroup should wait for I/O completions only for the writes that
> > > > > have been generated by that cgroup?
> > > > 
> > > > Can we account I/O towards the cgroup which issued "sync" only if write
> > > > rate of sync cgroup is higher than cgroup to which page belongs to. Will
> > > > that solve problem, assuming its doable?
> > > 
> > > Maybe this would mitigate the problem, in part, but it doesn't solve it.
> > > 
> > > The thing is, if a dirty page belongs to a slow cgroup and a fast cgroup
> > > issues "sync", the fast cgroup needs to wait a lot, because writeback is
> > > happening at the speed of the slow cgroup.
> > 
> > Hi Andrea,
> > 
> > But that's true only for I/O which has already been submitted to block
> > layer, right? Any new I/O yet to be submitted could still be attributed
> > to faster cgroup requesting sync.
> 
> Right. If we could bump up the new I/O yet to be submitted I think we
> could effectively prevent the priority inversion problem (the ongoing
> writeback I/O should be negligible).
> 
> > 
> > Until and unless cgroups limits are absurdly low, it should not take very
> > long for already submitted I/O to finish. If yes, then in practice, it
> > might not be a big problem?
> 
> I was actually doing my tests with a very low limit (1MB/s both for rbps
> and wbps), but this shows the problem very well I think.
> 
> Here's what I'm doing:
> 
>  [ slow cgroup (1Mbps read/write) ]
> 
>    $ cat /sys/fs/cgroup/unified/cg1/io.max
>    259:0 rbps=1048576 wbps=1048576 riops=max wiops=max
>    $ cat /proc/self/cgroup
>    0::/cg1
> 
>    $ fio --rw=write --bs=1M --size=32M --numjobs=16 --name=writer --time_based --runtime=30
> 
>  [ fast cgroup (root cgroup, no limitation) ]
> 
>    # cat /proc/self/cgroup
>    0::/
> 
>    # time sync
>    real	9m32,618s
>    user	0m0,000s
>    sys	0m0,018s
> 
> With this simple test I can easily trigger hung task timeout warnings
> and make the whole system totally sluggish (even the processes running
> in the root cgroup).
> 
> When fio ends, writeback is still taking forever to complete, as you can
> see by the insane amount that sync takes to complete.
> 

Yeah sync() needs to be treated differently, but its kind of special too.  We
don't want slow to run sync() and backup fast doing sync() because we make all
of the io go based on the submitting cgroup.  The problem here is we don't know
who's more important until we get to the blk cgroup layer, and even then
sometimes we can't tell (different hierarchies would make this tricky with
io.weight or io.latency).

We could treat it like REQ_META and just let everything go through and back
charge.  This feels like a way for the slow group to cheat though, unless we
just throttle the shit out of him before returning to user space.  I'll have to
think about this some more.  Thanks,

Josef
