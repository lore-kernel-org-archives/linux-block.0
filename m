Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F291CC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B938720C01
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 19:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="awbHjxN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfB0TAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:00:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35418 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfB0TAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 14:00:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id p19so8457432plo.2
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+lC0zvy66mrLMfCJ3T/Oj5wfxFaDvQe6qtr5SyR/6ys=;
        b=awbHjxN/fbzxJQC2LhXgbJ/VTJWYv0ORace28osvROCxK5mFw0I+2dHigITholmQ+2
         kIgdbgTLe+5o9d7mZEasmsIX96JSy/LEajfLP+03SsoWUawqvtKbWL1Qemgf+uKOf6ar
         RnY044BU6OMSgaHWsYvUXFkCODL4q+Eg1TN7PRLs6cvpyLwg8iMsb66iCPW26Sq7+AJ0
         Qv4Faz5cWMoCUWImf6kwYOKSzblIiJOHeAdfzGcMzMMEBE5hMKBt0Uiwroog4n0FLLsc
         AnsaZyjOcCwRnOmsgoej7S48JE40b9HxRPOAnSnaJ37q1/nopALc6W7tfPBs5HO5Ob7X
         ZAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+lC0zvy66mrLMfCJ3T/Oj5wfxFaDvQe6qtr5SyR/6ys=;
        b=jodnG2Q1b+g6U4Tqw3vNl4+NVfcHgX46B5TXbbm8GJ2N/E5Qt/h3FAF4V1AXgNjN5J
         TkI0CQv7EXC5AxdbsFBneRFS9OgQoK4Yyrzc6NKcGBmniI6QtCThR96IfIfOBVTcQ47Y
         1l97PP4PlI3tgUW02sAK7U3gRWBB0r9wYTgHnIweS+0L1urfXcr9aX4U3h2FPQgs0pxm
         mTSmaLg4zUW7auhvLdpAGd6t0McWbGtqc1aeiyKWrsrpL2JoggIiETIkvM+kwx8LRvhn
         LGdaYglSj1al7+u7mxUvp9W2Ahau66A9j9E9HghEKZMBuSQvoxwB+kFJxuxr4A4hPdYe
         2LEw==
X-Gm-Message-State: AHQUAuazUslLzlAErsc2IdQfxIJCO1msmVxiCzM0wKc1fFiPRd6Lr8XK
        CNHP6BGGY4gt7Exjm5hcSNt1fg==
X-Google-Smtp-Source: AHgI3IaS+l1jYRXIuVWhOWVBTkxEWMtsMC5bmOF2jBsWl9tPsNc7rr/b02N/gjVdyuRmx6uA8T5bZQ==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr3697564pla.246.1551294045731;
        Wed, 27 Feb 2019 11:00:45 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id n75sm31959855pfb.39.2019.02.27.11.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 11:00:44 -0800 (PST)
Date:   Wed, 27 Feb 2019 11:00:43 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Message-ID: <20190227190043.GB11806@vader>
References: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220180327.GA8325@vader>
 <SN6PR04MB4527D0FAE8B353AEA45E0CD8867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190220193500.GE8325@vader>
 <20190221150418.GB4062@mit.edu>
 <SN6PR04MB452790045C42F3DEAD63BE76867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB452790045C42F3DEAD63BE76867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 22, 2019 at 12:00:43AM +0000, Chaitanya Kulkarni wrote:
> On 02/21/2019 07:04 AM, Theodore Y. Ts'o wrote:
> > On Wed, Feb 20, 2019 at 11:35:00AM -0800, Omar Sandoval wrote:
> >>> It should fail on older cli versions, we want latest cli/tools to be
> >>> used when running these testcases so that all the latest tools are
> >>> also been tested for the compliance, else we might be running tests
> >>> with any bugs with older version(s) which are fixed already.
> >>>
> >>> Actually I'd like to add quick nvme-cli version check at the start of
> >>> each test that will certainly help/force user to have a latest version.
> >>
> >> Perfect, I was going to suggest adding a check for the minimum version
> >> needed for each test.
> >
> > It would be great if we could document what is (a) the minimum version
> > for things to work at all,
> Actually the latest version or the HEAD of the git repo should work all
> the time if it is breaking test or the tool or driver we need to add
> a fix respectively.
> 
>   and (b) the ideal version to use so that
> > tests aren't being skipped due to version constraints and so we are
> > testing the kernel as much as possible.
> >
> Agree.
> > Ideally, tests should either be designed primarily to test userspace,
> > or to test the kernel, so that people who want to use blktests aren't
> > having to build the latest versions of userspace.
> >
> At least with the current NVMe infrastructure we need latest tools
> (git HEAD) to be compliant all the time with the tests, since it
> guarantees the tools, driver and kernel compatibility.
> 
> We can a little install script to build and install the
> cli if desired version is not present.
> 
> > (As an aside, Bart has told me that the failures I'm seeing with
> > srp/002 and srp/011 are due to the fact that I'm using a version of
> > multipathd which is too old.  Apparently both the version of
> > multipathd in Debian stable *and* Debian unstable are still too old,
> > since they are still failing.  Next stop, building multipathd from
> > the git repo....   Grrr......)
> This is exact reason why tools needs to be built and check with latest
> HEAD.

I don't think we should be _requiring_ that the tests are run with the
latest tools from git. That just adds another annoying step to someone
trying to get the tests up and running. Like I said, each test should
check for the minimum version it needs, and we should avoid making the
golden output too dependent on version.

However, I do think it's a reasonable expectation that if you want
maximum test coverage, you should build the tools from git.
