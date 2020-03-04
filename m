Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF6C3F2CE
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596162146E
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583349350;
	bh=ZP4ceR+RTuVeMmYQSYnAbg1hVaBULQI7GHA+xeA49DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f+ms52Wl0yr9UrgG+5L/OEskSemmN/KfO+NrxuDKavYSWG7WCzv8RBYqyD/MTYyhE
	 YPdvfQFnGWIS3QhA0DunysAvGY23dgs4yASOusHTM/1SxYeDGT73FcHKGA8UUpN2Of
	 BRwwkohEBzbCPGjy8O8b8n63jsdmznsWpVVa/RZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDTPt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:15:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37471 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDTPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 14:15:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so2799886qke.4;
        Wed, 04 Mar 2020 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CM8uVr3cNngvJH4mHpoVLPbq5DQiVP5OFQRsZpnfBBI=;
        b=mnIXyYIL60fmWyADaOSwkQuZbSlplpHEr+9OJLVCfSl7lYh3zYU6A2azJ19HS2XTAP
         KC/H3zWC1ltQdGoJiEXwz2pTIRUBX5khgZUuu5U2fZVhJX0dVHA0iBxnZG5xAHBs3CBM
         i0yCFjVuT/1lFbZwNdjxCdZUX9SkyUg2IqalprLtMpWLZZl83BHx18K2jIiTe980Ybbk
         M2/OCJmC/7e6Ff28NUOecYcHWtusyHBq3d/W52Hz7AyXh3R8ZNPaEk/85cBRkwjRe8/H
         +kcW8PwLQa/cmTm/QzE4AqyztGG59nYolFHMUqYAI0GGHqwL8OBeh/DscM6SvPUAxsjV
         hfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CM8uVr3cNngvJH4mHpoVLPbq5DQiVP5OFQRsZpnfBBI=;
        b=UCFC0uRiuYs9BrsFaibDvuxAFHFPvNSoSrMkqAsknuYGuIJGjx/udBD6b/mChn9Maq
         1G4xfecQi2eTSj249LjtuxoSHyCYRC/WKR13VMaR9Gx4YZCWjMZazqpzaeeQ8thQHMaj
         ZygexFGSUjCJsw1oZ6+WDiVnsx2SzwvbIS4qpEu335tWka/TBitmEqZ0iUKMi7/L7E2c
         OTmKAB3Frb8SjA0j5V/7SxX9+Ly/NOYTndTwtBHhQ1mKBJD7ZibzRqWYS0s++Xu38Mto
         86lHfXy0rxRHWZdWMyECUoC3nLpRtrXNvYwA63RMmerk/2oe4bYYU2xHQcqu4qtXvoOs
         saaw==
X-Gm-Message-State: ANhLgQ2e+ipJvEKN0cRFCWxjkvXJ1SNyl5geU2LCCpGNu03pUyemRH1n
        1q6gcQT0E3WCmr1qO1rB/mY=
X-Google-Smtp-Source: ADFU+vtGrX7rGWbtT/3WZ8i0RsVqBiawbO0h6f1Eze5r+mgwZLf9LRDfYSvdod/8QqP8pPrDLozJcw==
X-Received: by 2002:ae9:e892:: with SMTP id a140mr1505046qkg.274.1583349346911;
        Wed, 04 Mar 2020 11:15:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id y62sm14293209qka.19.2020.03.04.11.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:15:46 -0800 (PST)
Date:   Wed, 4 Mar 2020 14:15:44 -0500
From:   Tejun Heo <tj@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304191544.GO189690@mtj.thefacebook.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
 <20200304185056.GM189690@mtj.thefacebook.com>
 <20200304191026.GC74069@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304191026.GC74069@mit.edu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed, Mar 04, 2020 at 02:10:26PM -0500, Theodore Y. Ts'o wrote:
> On Wed, Mar 04, 2020 at 01:50:56PM -0500, Tejun Heo wrote:
> > Lifetime rules in block layer are kinda nebulous. Some of it comes
> > from the fact that some objects are reused. Instead of the usual,
> > create-use-release, they get repurposed to be associated with
> > something else. When looking at such an object from some paths, we
> > don't necessarily have ownership of all of the members.
> 
> I wonder if the current rules should be better documented, and that
> perhaps we should revisit some of them so we can tighten them down?

Oh yeah, that'd be nice for sure. We've been papering over stuff
constantly for probably over a decade now. It'd be really nice if we
could clean the house and have sane nominal lifetime rules for block
objects.

> For things that are likely to be long-lived, such as anything
> corresponding to a bdi or block device, perhaps it would be better if
> the lifetime rules can be made tighter?  The cost of needing to
> release and reallocate longer lived objects is going to be negligible,
> and benefits of improving code readability, reliability, and
> robuestness might be well worth it.

I full-heartedly agree. It's just a lot of historical accumulation and
not a lot of manpower directed at cleaning it up.

Thanks.

-- 
tejun
