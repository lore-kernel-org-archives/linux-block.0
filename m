Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAAAC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 22:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C00A24676
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 22:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="AaYXIWTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSWoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:44:00 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37426 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 17:43:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so3216740pjb.2
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 14:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nx1GFVhK4cgTsK0sn6kKnP1a5ElZyM4XkzOfrxOF3rg=;
        b=AaYXIWTaC1RtehBohxg4QwM04ayGnGTsDE+hWp+hJhvbgXLh99yD8fBouprPy8/kse
         qNtDVJxLM8fAUIDiQzTDy4j8KvUkvNivEKSpq9VFxbKerYB1S/t14FSTm+bO6fU/bALy
         Lv5scfA5hcpQ7tOO/jf/PFkKSqfhY3Cj0e88OmtKvQeJLiMQ6Fzk2e93PCOsCtSq+Lxp
         fNlFHlTfzAP8ycTzT0KJ8PL2LPWNtoaIikzkg5Z1jCCizNmPuC4RQm0A04YnYygBkljB
         pqIp2hF3Haa0OzRo4vGwUQJy9F/ePiIRcCy5T0rVIFN8nXNPxtD3KAhFPIK4A/MtDR+i
         syRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nx1GFVhK4cgTsK0sn6kKnP1a5ElZyM4XkzOfrxOF3rg=;
        b=LNpKxsxyFiuj2lL+lRkwmmT3hXB16r+XRMgX+ioN8WjP2cv0YCBrq/iZ/+uUp2dhZB
         QoH3oJzT/iHzkJzFH6mawbbLe/eMFpZRXSDGsKvSCqI/LQy+ygTSByultLqLjqaCmk+C
         hvb1nL3TxX5tPKHjsGOYC76r/Aw78ntl57kMUOtmAfo/90n9HcVAE5YjE5q0/g8IYdC3
         QvvwgW5ovLEXwEE5eDAhoxO70lCLpDVqYpTdWIX6jqXEc4iokyVirfrwTBuD3R8TW/eF
         tzTYv5cXbzdfCdrRCyAFXIdkgI6rz2FZOL3h24sx4dMygvJ3cMAFailJvX2y28APS84s
         uLcw==
X-Gm-Message-State: APjAAAWnPOixWzYCqwcG3fgaCkG2sxp2JzzH+lCzFKwaL14kRtwOY7v0
        dcXObhNIu8HBaeHBNpIPUKlh+w==
X-Google-Smtp-Source: APXvYqx0s8FxJ2KxpfjokpHjizC3CSHZIy8/SGPAN9bezuRAg5vp5Cp8/4PZu7KzUZqnRMtXdTYRwA==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr11639587pjo.127.1576795438920;
        Thu, 19 Dec 2019 14:43:58 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id h16sm9843890pfn.85.2019.12.19.14.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:43:58 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:43:57 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add an SRP test for the SoftiWARP driver
Message-ID: <20191219224357.GC830111@vader>
References: <20191213143232.29899-1-bvanassche@acm.org>
 <20191219214735.GA830111@vader>
 <de0feeff-debb-8c14-2f17-6d17c5c27c9a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0feeff-debb-8c14-2f17-6d17c5c27c9a@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 19, 2019 at 02:04:13PM -0800, Bart Van Assche wrote:
> On 12/19/19 1:47 PM, Omar Sandoval wrote:
> > On Fri, Dec 13, 2019 at 09:32:28AM -0500, Bart Van Assche wrote:
> > > Recently a new low-level RDMA driver went upstream, namely the SoftiWARP
> > > driver. That driver implements RDMA over TCP. Support has been added in the
> > > SRP initiator and target drivers for iWARP. This patch series adds a test
> > > for SRP over SoftiWARP. Please consider integration of this patch series in
> > > the official blktests repository.
> > > 
> > > Changes compared to v1:
> > > - Only run the new test if the kernel version is at least 5.5 (the version in
> > >    which iWARP support was added to the SRP drivers) and if "rdma link" is
> > >    supported.
> > 
> > Is there no way to detect this feature other than checking the kernel
> > version?
> 
> Hi Omar,
> 
> The only other way I can think of to verify whether the SRP initiator and
> target drivers support iWARP is by loading the SRP drivers, loading the
> iWARP driver, by configuring LIO + ib_srpt and by attempting to set up a
> connection. However, I assume that's way more than what a _have() test
> should do?

Hmm, we should probably add the ability to skip a test from test() in
order to handle these cases where you need to do a bunch of setup before
you know whether the test can run. For now, the kernel version check is
fine.
