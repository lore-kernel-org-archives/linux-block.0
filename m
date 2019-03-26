Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29391C10F05
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D8B20866
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6XFJyGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfCZIMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:12:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38614 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfCZIMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 04:12:43 -0400
Received: by mail-io1-f66.google.com with SMTP id v4so9982276ioj.5
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YdFwkF4eUySjbpG+38wjJdvK3fCy24c6M03FoBUoupk=;
        b=k6XFJyGwJ9uMM5uZPWX/AMT7fviQV0Ld1mcPlddQHs0cPIvKIZsAGtkGGxowospoCT
         dtY6QW0pQBRdQZw/Pzw1xGUnrxiMWMMWQoLuH0L+NTAhjv0l+Yb/scBRb8Eepi2+jpsZ
         +ZfSqGLB3qiRjeQWh0Tgul4DOKaGm71Q8paP7zVq4PLWFJDKx4e7zw5OVJkORY5a2mpV
         ReGqnFwm0nuny+7m0ehupOQZYBEJ5uTlS1sAE9PGHyJC7FgYKKgwDVuTukwLz/+hRlTd
         MGNnI3tJskCS+Wu1/Aa6+rE98oi17qFjkFteyqgBOHmpSXEWFl1O8/BEaF0M9h/LvEhh
         k/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdFwkF4eUySjbpG+38wjJdvK3fCy24c6M03FoBUoupk=;
        b=a+8QB+0/g5p9agQIe08XsSFRF/hGLMs1ciHHOnFEmUniv+i7acmstDW8uEE+cHAGjo
         5F31DMU8wyljKT8dwsmsFZPmSBCr9omX3l+/t5T5yT46LsRznfh7n11lix8Z3DePmEpE
         laFVKlIEW8fJhJIrP3DffP3ZSxPg1KUab+4JWpWg0rQkX1H76lTJUIlAwOdHd6wOWoaw
         mfK5RIjpk0kh8QzcTyYrUcis6cWI6WRW0SLbGSmBb4NRpBP2MuWihi0IIZvTny8T+/ug
         55FhAhU8yeDFdxBag4wSff3yfF4KWs/z415ZEgcwAhcehwNjjZ+OieMjb3lACDwxR2Ah
         uMmw==
X-Gm-Message-State: APjAAAUooUbPb3EKphIInvIeb1AR+FslkU7Cg3OIMyz+D6uO0oeGMdEJ
        PPQQM8XjVd2zQoU/mwRFBD+ASQ==
X-Google-Smtp-Source: APXvYqzUewoC4h/6psWy97TNreJAfbfzJbNTFpBTiFptGULlXyAtjw1mAFFx3ekIO/Ni0Jr6DpSEmg==
X-Received: by 2002:a5e:db48:: with SMTP id r8mr20194656iop.220.1553587962220;
        Tue, 26 Mar 2019 01:12:42 -0700 (PDT)
Received: from google.com ([2401:fa00:fc:202:858d:45ea:f905:5ed4])
        by smtp.gmail.com with ESMTPSA id t62sm6882457ita.35.2019.03.26.01.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 01:12:41 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:12:33 +0800
From:   Martin Liu <liumartin@google.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Mark Salyzyn <salyzyn@android.com>, akpm@linux-foundation.org,
        axboe@kernel.dk, dchinner@redhat.com, jenhaochen@google.com,
        salyzyn@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm: readahead: add readahead_shift into backing
 device
Message-ID: <20190326081233.GA175058@google.com>
References: <20190322154610.164564-1-liumartin@google.com>
 <20190325121628.zxlogz52go6k36on@wfg-t540p.sh.intel.com>
 <9b194e61-f2d0-82cb-30ac-95afb493b894@android.com>
 <20190326013058.ykdwxbfkk3x3pvtu@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326013058.ykdwxbfkk3x3pvtu@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 26, 2019 at 09:30:58AM +0800, Fengguang Wu wrote:
> On Mon, Mar 25, 2019 at 09:59:31AM -0700, Mark Salyzyn wrote:
> > On 03/25/2019 05:16 AM, Fengguang Wu wrote:
> > > Martin,
> > > 
> > > On Fri, Mar 22, 2019 at 11:46:11PM +0800, Martin Liu wrote:
> > > > As the discussion https://lore.kernel.org/patchwork/patch/334982/
> > > > We know an open file's ra_pages might run out of sync from
> > > > bdi.ra_pages since sequential, random or error read. Current design
> > > > is we have to ask users to reopen the file or use fdavise system
> > > > call to get it sync. However, we might have some cases to change
> > > > system wide file ra_pages to enhance system performance such as
> > > > enhance the boot time by increasing the ra_pages or decrease it to
> > > 
> > > Do you have examples that some distro making use of larger ra_pages
> > > for boot time optimization?
> > 
> > Android (if you are willing to squint and look at android-common AOSP
> > kernels as a Distro).
> 
> OK. I wonder how exactly Android makes use of it. Since phones are not
> using hard disks, so should benefit less from large ra_pages.  Would
> you kindly point me to the code?
>
Yes, one of the example is as below.
https://source.android.com/devices/tech/perf/boot-times#optimizing-i-o-
efficiency
> > > Suppose N read streams with equal read speed. The thrash-free memory
> > > requirement would be (N * 2 * ra_pages).
> > > 
> > > If N=1000 and ra_pages=1MB, it'd require 2GB memory. Which looks
> > > affordable in mainstream servers.
> > That is 50% of the memory on a high end Android device ...
> 
> Yeah but I'm obviously not talking Android device here. Will a phone
> serve 1000 concurrent read streams?
> 
For Android, some important, persistent services and native HALs might
hold fd for a long time unless request a restart action and then would
impact overall user experience(guess more than 100). For some low end
devices which is a big portion of Android devices, their memory size
might be even smaller. Thus, when the device is under memory pressure,
this might bring more overhead to impact the performance. As current
design, we don't have a way to shrink readahead immediately. This
interface gives the flexibility to an adiminstrator to decide how
readahed to participate the mitigation level base on the metric it has.

> > > Sorry but it sounds like introducing an unnecessarily twisted new
> > > interface. I'm afraid it fixes the pain for 0.001% users while
> > > bringing more puzzle to the majority others.
> > >2B Android devices on the planet is 0.001%?
> 
> Nope. Sorry I didn't know about the Android usage.
> Actually nobody mentioned it in the past discussions.
> 
> > I am not defending the proposed interface though, if there is something
> > better that can be used, then looking into:
> > > 
> > > Then let fadvise() and shrink_readahead_size_eio() adjust that
> > > per-file ra_pages_shift.
> > Sounds like this would require a lot from init to globally audit and
> > reduce the read-ahead for all open files?
> 
> It depends. In theory it should be possible to create a standalone
> kernel module to dump the page cache and get the current snapshot of
> all cached file pages. It'd be a one-shot action and don't require
> continuous auditing.
> 
> [RFC] kernel facilities for cache prefetching
> https://lwn.net/Articles/182128
> 
> This tool may also work. It's quick to get the list of opened files by
> walking /proc/*/fd/, however not as easy to get the list of cached
> file names.
> 
> https://github.com/tobert/pcstat
> 
> Perhaps we can do a simplified /proc/filecache that only dumps the
> list of cached file names. Then let mincore() based tools take care
> of the rest work.
> 
Thanks for the information, they are very useful. For Android, it would
keep updating pretty frequently and the lists might need to be updated
as the end users install apps, runtime optimization or get new OTA.
Therefore, this might request pretty much effort to maintain this.
Please kindly correct me if any misunderstanding. Thanks.

Regards,
Martin
