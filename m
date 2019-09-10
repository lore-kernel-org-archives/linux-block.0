Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A598C49ED8
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445D3206A1
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568131740;
	bh=Iyom6nVo13zvWT0J4vP9mpQMZj8t1KHSkeSG+h6adVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W6iWsx0DW/wymKMIbfLqm7epIoIRUPWj3z9wkpFM96sOUheKw+B0v2bGGpfFsP0pU
	 9iTWvRkAzWMT2kX9WMRwPGMv6hmowhhokfi4XgUSdHMoCnIbLW7hcGxhDcr9p+1R91
	 pxXsVXTClFcSpBrWPElWRq5R+2EUkpqUTDXPayIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394077AbfIJQI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:08:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36605 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfIJQI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 12:08:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so21425827qtf.3;
        Tue, 10 Sep 2019 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bdd/RVi8vfAfg851AYquHh04me7NuiJ7iVVTsDpYp68=;
        b=fUA+fYqvDaEh6XnC8UBQ3JpjN/2WjcxI+8CiRk4SalHIoVe5prkjFMu71bb/uLhLEi
         vdSRmM1ImkGHh+5l222crJZZ8/ZbN5H9jaqs5XiMxOkLTzGZGkekXnXHoceWM87OVVZW
         t0OZsTU5TT8dmyCn/uOnVU4OzwLHubfn9Uk/eyxwR46e9wcUNF0twyojDJIJ4r9hPgm+
         ctrVk79+ExOfFiWG/zP/jiTtOv9aL/Mk6GmHBR0tH9tBI793M0JSgUKIbdE11v4CZcki
         biWouuq8snH+yIDMNXZDgpkw+bvxzlXrTIXXskJqm/qPfuoXfRt7hgJ7cl/2r4M4jd6M
         /rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bdd/RVi8vfAfg851AYquHh04me7NuiJ7iVVTsDpYp68=;
        b=Xt5SG5XtyBA6qhASIRM4KZGFpyopS97sn8S5HuVAFUEbkVzbcEsEyDWUHo1RX1mwrW
         rhQG9GLGfmIGNhOP3G+V5XbJP0/LyKEPvCQXmy6uJkYVuRXzT9CigmeimNN72DXwbTlS
         zpFWATZi5N9rrPzyUxPOR4+X9zHvLO0oQE4MXq/nxiZLb5s/kzDlssfqRjSzCHsbz6D9
         fFD/rvzTbF6NRtUD2IyWDax53rPajgUWVWQmduRvPFvX8g1jNpuSzdDDgkkQcTrJkk99
         bfSzed4xzb7DZHoFqIFLYsdDxMNv4CT+5a+mb6sElaCpTrQyExoWfm020ri3ZH1k9Bxb
         8c+Q==
X-Gm-Message-State: APjAAAWPIbZUEyyqpRYG70FV9tEbe6mC9V0sAO03Z5vWqerhrI8gsDlX
        EmghMwuQtq2teD9SWSg+pPY=
X-Google-Smtp-Source: APXvYqy1mXMLatf/bfCumeTCUJ4Qv5l0eyL7tNeUKutGwTA1BrLjrBcgiAJOawTlqrJzUwRaNUHvnw==
X-Received: by 2002:ac8:23b9:: with SMTP id q54mr31058151qtq.107.1568131737923;
        Tue, 10 Sep 2019 09:08:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f049])
        by smtp.gmail.com with ESMTPSA id a134sm9730633qkc.95.2019.09.10.09.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:08:57 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:08:55 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, clm@fb.com, dennisz@fb.com, newella@fb.com,
        lizefan@huawei.com, axboe@kernel.dk, josef@toxicpanda.com,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190910125513.GA6399@blackbody.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Michal.

On Tue, Sep 10, 2019 at 02:55:14PM +0200, Michal Koutný wrote:
> This adds the generic io.weight attribute. How will this compose with
> the weight from IO schedulers? (AFAIK, only BFQ allows proportional
> control as of now. +CC Paolo.)

The two being enabled at the same time doesn't make sense, so we can
just switch over to bfq when bfq is selected as the iosched.  I asked
what Paolo wanted to do in terms of interface a couple times now but
didn't get an answer and he posted a patch which makes the two
controllers conflict, so....  Paolo, so it looks like you want to
rename all bfq files to drop the bfq prefix, right?  I can implement
the switching if so.

> I see this attributes are effectively per-cgroup per-device. Apparently,
> one device should have only one weight across hierarchy. Would it make
> sense to have io.bfq.weight and io.cost.weight with disjunctive devices?

It never makes sense to have both enabled, so I don't think that
interface makes sense.

> > +		.name = "cost.qos",
> > +		.flags = CFTYPE_ONLY_ON_ROOT,
> > [...]
> > +		.name = "cost.model",
> > +		.flags = CFTYPE_ONLY_ON_ROOT,
> I'm concerned that these aren't true cgroup attributes. The root cgroup
> would act as container for global configuration options. Wouldn't these
> values better fit as (configurable) attributes of the respective
> devices?

Initially, I put them under block device sysfs but it was too clumsy
with different config file formats and all.  I think it's better to
have global controller configs at the root cgroup.

> Secondly, how is CFTYPE_ONLY_ON_ROOT supposed to be presented in cgroup
> namespaces?

Not at all.  These are system-wide configs.  cgroup namespaces
shouldn't have anything which aren't in non-root cgroups.

Thanks.

-- 
tejun
