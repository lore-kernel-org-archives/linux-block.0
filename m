Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50330C07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBE620883
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLAJqvdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfARTCb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:02:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45667 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfARTCb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 14:02:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so16292145wrr.12;
        Fri, 18 Jan 2019 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1UMa4yCXmM3OK38bryfUjoNkHrVdY+842bxFOYwuFrA=;
        b=hLAJqvdqa5AmoAZ8dykKzHIvpLwfc/1enH5Qndq2pLDg3c0WHNnomUGTN6V8M/h03L
         wDSs5wP2dW+1ktrRparURlTqi4fwUyCW02xYH6j0Xydo9r9u/rX8DVlKeuAljhAVHRlq
         Z1IHAnvmvyGRMJJYYu6KSArZ/p1wbzjiLIplwznGq9ZzG7JH6yTmEu0tTjOo3vCS6iAA
         vMj5S58YJeklAQZiAQ/hn9k7Ac0BaEJcfb+LYKuGlQf9En0H1Xp58H6bvlc/X7xBQ1LR
         8+FaBdcMoGLfxmPnjWR8DRKYpukSxJIcmLAT1j+vMOaBE73QYxV5lNxz1aEMJj4DEWX/
         mZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1UMa4yCXmM3OK38bryfUjoNkHrVdY+842bxFOYwuFrA=;
        b=FP7gU75BpobA3SwOWx70xUYusDBvmqd8PMjLbh63oUqdY3yJmJv9lyY+cnd3DpqOtZ
         JVq9OXhDs96KibvI+Hyfon9s1RmCsguiJQxuIhb2xS2a6t5LnS8AL4iPgkbkjo/1mtyn
         Pt4IioXXqn5F3z0ka9eAYG8WXaOcsCmPygNYQgUYRRb7DRr/x9T/5FWwa4zSm8nlVoRP
         ASlC1iXh5cg/HXI7IXe6mYrPIzi7W+ddze+4pGHR4uXX2JG3xvMM3bl1stp2KB8b7Wt9
         h4bka8OpsNokGY/yuaw1cTlcOMtZgK5NnT4063RO9MxcyyqpdKeqAyUp7XxldLt8lBEA
         0ZaQ==
X-Gm-Message-State: AJcUukc/IisineDMV1KGVofaE0O6jEHV6BUy3SbPwtp9ncAdftxe5OTD
        fj6HOOZy3+FYoj1CHdR8tg==
X-Google-Smtp-Source: ALg8bN5xKgUapCYysy92WvHP8KiJgbPshZesVo6BzhrUlrN2olYNSch4Mo/MWfp8Qqw4+ZLrHIijJw==
X-Received: by 2002:adf:f848:: with SMTP id d8mr18850760wrq.178.1547838148828;
        Fri, 18 Jan 2019 11:02:28 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id l20sm175173029wrb.93.2019.01.18.11.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:02:28 -0800 (PST)
Date:   Fri, 18 Jan 2019 20:02:27 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190118190227.GC1535@xps-13>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <F576C256-A032-4E62-99EA-F60162B6E069@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F576C256-A032-4E62-99EA-F60162B6E069@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 06:07:45PM +0100, Paolo Valente wrote:
> 
> 
> > Il giorno 18 gen 2019, alle ore 17:35, Josef Bacik <josef@toxicpanda.com> ha scritto:
> > 
> > On Fri, Jan 18, 2019 at 11:31:24AM +0100, Andrea Righi wrote:
> >> This is a redesign of my old cgroup-io-throttle controller:
> >> https://lwn.net/Articles/330531/
> >> 
> >> I'm resuming this old patch to point out a problem that I think is still
> >> not solved completely.
> >> 
> >> = Problem =
> >> 
> >> The io.max controller works really well at limiting synchronous I/O
> >> (READs), but a lot of I/O requests are initiated outside the context of
> >> the process that is ultimately responsible for its creation (e.g.,
> >> WRITEs).
> >> 
> >> Throttling at the block layer in some cases is too late and we may end
> >> up slowing down processes that are not responsible for the I/O that
> >> is being processed at that level.
> > 
> > How so?  The writeback threads are per-cgroup and have the cgroup stuff set
> > properly.  So if you dirty a bunch of pages, they are associated with your
> > cgroup, and then writeback happens and it's done in the writeback thread
> > associated with your cgroup and then that is throttled.  Then you are throttled
> > at balance_dirty_pages() because the writeout is taking longer.
> > 
> 
> IIUC, Andrea described this problem: certain processes in a certain group dirty a
> lot of pages, causing write back to start.  Then some other blameless
> process in the same group experiences very high latency, in spite of
> the fact that it has to do little I/O.
> 
> Does your blk_cgroup_congested() stuff solves this issue?
> 
> Or simply I didn't get what Andrea meant at all :)
> 
> Thanks,
> Paolo

Yes, there is also this problem: provide fairness among processes
running inside the same cgroup.

This is a tough one, because once the I/O limit is reached whoever
process comes next gets punished, even if it hasn't done any I/O before.

Well, my proposal doesn't solve this problem. To solve this one in the
"throttling" scenario, we should probably save some information about
the previously generated I/O activity and apply a delay proportional to
that (like a dynamic weight for each process inside each cgroup).

AFAICS the io.max controller doesn't solve this problem either.

-Andrea
