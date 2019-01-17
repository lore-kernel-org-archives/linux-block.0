Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28DAC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7C920657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="fOndDpfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfAQBkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:40:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38235 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfAQBkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 20:40:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so3656287pgc.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 17:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1F4RXLLWZKCQTR0DE+ljE1Kbcc69ln+YlgRZusShew=;
        b=fOndDpfJDipDJ0bYIK8ZKpayqvwW2GN8VbPxFSMjDG2zVQQxGRp8bc8eAGroO0lahI
         8lHSJ71nkGiUa+qSJaN+vo3iGStM38iwRXN1V3sjipEysmW8TUS/ehMZt9L4pu01Q1pO
         BST6YbX3FSMgwIB3ZDTbqc0jnv1OvVAIbxfgKJ3xptgrUK47zjI/PKWknmiWlJoqdgkn
         Bl27O4jyaiCY3FpeFi32TlBduWeeROjDJjQhyUByxTT+v1s/sgYpzIehT3316jGbrtU1
         nFOUzxEyywlLd0ZBU+0wOJjDbLbvVRtpVwZ+d/HjLqWTBnPHcvuMDdKaqQhyIIk5jU98
         /lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1F4RXLLWZKCQTR0DE+ljE1Kbcc69ln+YlgRZusShew=;
        b=lLIzl1meTqomy/TN5EyEOJDNH1OYrtdd4Ivv4+5ZutG6kmnvD8tN8x3kHUVLtMH5fa
         Q5nQZ3pJjTffBTy8mw2MXxGOjtfsgUzbxrhLwJuYUJ8oGCnE23VZ5VPdDjenv55xOaT5
         nJwgTIQSfaMBSedGZbZz+zDDNZUhfclDqrKXQWCxcOWer91lmFYVTzD0nsrBpvNDcvrb
         0ucZaWjzInhIuJanbzL7xKtTZxQccP2PBzicntfB2CTNoxCD+mw2La5bHcGsfHTuqrc2
         RkYfvwwIROe7Ps7eqfSrY7OmmXfN6L3/ByTbNQkaaCwxRowmArcIsrZdRjq6DLh/ybNR
         OgbQ==
X-Gm-Message-State: AJcUukfs0uS/bLeqfJNmRKeQ60XtdEmiBjEd+7kXohC6lvariQBLttdF
        +wjbzW4S0UbUYfkJeIYBgJhaHA==
X-Google-Smtp-Source: ALg8bN7pJzNB0WJOLEwD24yhfhstFS0LmbxzNHhSYyIm17DHKe1OVWkqO/b2FxbuojAZVSD3JQJoXA==
X-Received: by 2002:a63:4101:: with SMTP id o1mr11567462pga.447.1547689241198;
        Wed, 16 Jan 2019 17:40:41 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id 202sm85828pfy.87.2019.01.16.17.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 17:40:40 -0800 (PST)
Date:   Wed, 16 Jan 2019 17:40:39 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, osandov@fb.com
Subject: Re: [PATCH 1/3] blktests: add cgroup2 infrastructure
Message-ID: <20190117014039.GA25494@vader>
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-2-josef@toxicpanda.com>
 <1211bf78-c442-ea71-9e71-f6d86681ed56@acm.org>
 <1547570441.83374.112.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547570441.83374.112.camel@acm.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 08:40:41AM -0800, Bart Van Assche wrote:
> On Tue, 2019-01-01 at 19:13 -0800, Bart Van Assche wrote:
> > On 12/4/18 9:47 AM, Josef Bacik wrote:
> > > In order to test io.latency and other cgroup related things we need some
> > > supporting helpers to setup and tear down cgroup2.  This adds support
> > > for checking that we can even configure cgroup2 things, set them up if
> > > need be, and then add the cleanup stuff to the main cleanup function so
> > > everything is always in a clean state.
> > 
> > Is this the patch that went in as commit ae7daae7e35a ("blktests: add 
> > cgroup2 infrastructure")? I think that commit introduced a regression. 
> > With that patch applied the SRP tests fail as follows:
> > 
> > # ./check -q srp/001
> > srp/001 (Create and remove LUNs)
> >      runtime  4.067s  ...
> > common/cgroup: line 25: CGROUP2_DIR: unbound variable
> > 
> > Is this a known issue?
> 
> Hi Josef,
> 
> Had you noticed this e-mail?
> 
> Thanks,
> 
> Bart.

Hey, Bart, I just pushed a fix for this:

commit 8a274578e2895b9f0b66c09f3a8f63b5ff1293b2
Author: Omar Sandoval <osandov@fb.com>
Date:   Wed Jan 16 17:34:19 2019 -0800

    cgroup: test if CGROUP2_DIR is set with -v instead of -n
    
    common/multipath-over-rdma does set -u, so -n "$CGROUP2_DIR" fails with
    an unbound variable error. Instead, use -v to test if the variable was
    set.
    
    Signed-off-by: Omar Sandoval <osandov@fb.com>

diff --git a/common/cgroup b/common/cgroup
index 48e546f..554ebf7 100644
--- a/common/cgroup
+++ b/common/cgroup
@@ -22,7 +22,7 @@ _init_cgroup2()
 
 _exit_cgroup2()
 {
-	if [[ -n $CGROUP2_DIR ]]; then
+	if [[ -v CGROUP2_DIR ]]; then
 		find "$CGROUP2_DIR" -type d -delete
 		unset CGROUP2_DIR
 	fi
