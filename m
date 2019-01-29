Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20680C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEE921848
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkgE3kN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfA2Sjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:39:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfA2Sjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:39:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so23313242wru.0;
        Tue, 29 Jan 2019 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cDhKTSjPSKNFJAoJf2RJ1PgKpP5FKFxQFjJIs8ZLIwk=;
        b=XkgE3kN6euhtNj0ywO3dHrrEH7bRZqyShWBQ3LWi/l0EWzjwkZuW+5uj036Qjpan7I
         5QoHGzCUpsZpu3KgpUQK3i2rjrgP8aWTauQu3zumeeRm/1X3tn1PmsHAJPAG3vWYeM++
         49S3PjNCiU/dJ9QvUTzrQa0NnTWck2xywFarV2tYyZd1tXEsBzbY8y0tgJCQQdS6I3qz
         twwrMoX5xTc9TWLsCfe21ipZoat/RaOAGX3DJdvAMthG58o00YhFwJBykOdl1q7R87Gq
         I+zx+xIz0xcMeyVU8AkLzuT44oIqXis1fZeOfP6bpPM9xcFXDrPnkUoIFTj2K/kzHiPh
         eS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cDhKTSjPSKNFJAoJf2RJ1PgKpP5FKFxQFjJIs8ZLIwk=;
        b=Vua9CkBqXmxxXr0uF7FgvnBtkkwgNz3FO8qTC7sVT3cHnnS8Wm0Exd+cuRPu+XHLdp
         QNNdZkYVwYlHGsBLUxhjeYKVXEoM6dvuEjdk2fPOpv0nG6xqlJal00CAPuiFZ6wUQgJ6
         SfwrGgMqldRqK7ZL9gaL9Hqdcam0vt/9rGRPuNhaTDQCXZUGIuQLEJpHTU46iQpfATE1
         EZiSLipkEUKBByc283DZx4lNoPWCpSicMX4CIk0lRwmWyXo8HxxSu0icCCGt7VSYjIRC
         jZYtvZaORAwMkLj/TT4tvYlTY4py7SQwBjYC1jORRPve+6qLS/IhznHD9Mv2KSs/L/QR
         B/Gw==
X-Gm-Message-State: AJcUukeCPBcSj+oL+irfG73/CYnklLL5TP4t40BrI7PLTEbxFe3SEiPC
        Vtg2TCCfcHEu8xOs/yo1jg==
X-Google-Smtp-Source: ALg8bN5mbpoQcKrF+E2CAjW1Ik3BbSkWIKaekVwkFYCwA5OZc4RzvHQ1Hb1YO+IjY8gTkjalhiSJUw==
X-Received: by 2002:adf:8068:: with SMTP id 95mr27634808wrk.181.1548787180924;
        Tue, 29 Jan 2019 10:39:40 -0800 (PST)
Received: from localhost (host180-106-dynamic.51-82-r.retail.telecomitalia.it. [82.51.106.180])
        by smtp.gmail.com with ESMTPSA id f2sm109272735wru.14.2019.01.29.10.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 10:39:40 -0800 (PST)
Date:   Tue, 29 Jan 2019 19:39:38 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190129183938.GA2960@xps-13>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <20190118184403.GB1535@xps-13>
 <20190118194652.gg5j2yz3h2llecpj@macbook-pro-91.dhcp.thefacebook.com>
 <20190119100827.GA1630@xps-13>
 <20190121214715.GA27713@redhat.com>
 <20190128174129.GB8272@xps-13>
 <20190128192620.GB10240@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128192620.GB10240@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 02:26:20PM -0500, Vivek Goyal wrote:
> On Mon, Jan 28, 2019 at 06:41:29PM +0100, Andrea Righi wrote:
> > Hi Vivek,
> > 
> > sorry for the late reply.
> > 
> > On Mon, Jan 21, 2019 at 04:47:15PM -0500, Vivek Goyal wrote:
> > > On Sat, Jan 19, 2019 at 11:08:27AM +0100, Andrea Righi wrote:
> > > 
> > > [..]
> > > > Alright, let's skip the root cgroup for now. I think the point here is
> > > > if we want to provide sync() isolation among cgroups or not.
> > > > 
> > > > According to the manpage:
> > > > 
> > > >        sync()  causes  all  pending  modifications  to filesystem metadata and cached file data to be
> > > >        written to the underlying filesystems.
> > > > 
> > > > And:
> > > >        According to the standard specification (e.g., POSIX.1-2001), sync() schedules the writes, but
> > > >        may  return  before  the actual writing is done.  However Linux waits for I/O completions, and
> > > >        thus sync() or syncfs() provide the same guarantees as fsync called on every file in the  sys‐
> > > >        tem or filesystem respectively.
> > > > 
> > > > Excluding the root cgroup, do you think a sync() issued inside a
> > > > specific cgroup should wait for I/O completions only for the writes that
> > > > have been generated by that cgroup?
> > > 
> > > Can we account I/O towards the cgroup which issued "sync" only if write
> > > rate of sync cgroup is higher than cgroup to which page belongs to. Will
> > > that solve problem, assuming its doable?
> > 
> > Maybe this would mitigate the problem, in part, but it doesn't solve it.
> > 
> > The thing is, if a dirty page belongs to a slow cgroup and a fast cgroup
> > issues "sync", the fast cgroup needs to wait a lot, because writeback is
> > happening at the speed of the slow cgroup.
> 
> Hi Andrea,
> 
> But that's true only for I/O which has already been submitted to block
> layer, right? Any new I/O yet to be submitted could still be attributed
> to faster cgroup requesting sync.

Right. If we could bump up the new I/O yet to be submitted I think we
could effectively prevent the priority inversion problem (the ongoing
writeback I/O should be negligible).

> 
> Until and unless cgroups limits are absurdly low, it should not take very
> long for already submitted I/O to finish. If yes, then in practice, it
> might not be a big problem?

I was actually doing my tests with a very low limit (1MB/s both for rbps
and wbps), but this shows the problem very well I think.

Here's what I'm doing:

 [ slow cgroup (1Mbps read/write) ]

   $ cat /sys/fs/cgroup/unified/cg1/io.max
   259:0 rbps=1048576 wbps=1048576 riops=max wiops=max
   $ cat /proc/self/cgroup
   0::/cg1

   $ fio --rw=write --bs=1M --size=32M --numjobs=16 --name=writer --time_based --runtime=30

 [ fast cgroup (root cgroup, no limitation) ]

   # cat /proc/self/cgroup
   0::/

   # time sync
   real	9m32,618s
   user	0m0,000s
   sys	0m0,018s

With this simple test I can easily trigger hung task timeout warnings
and make the whole system totally sluggish (even the processes running
in the root cgroup).

When fio ends, writeback is still taking forever to complete, as you can
see by the insane amount that sync takes to complete.

-Andrea
