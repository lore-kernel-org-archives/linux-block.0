Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2119EC282CB
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F059F20823
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBDPgV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:21 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:40137 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfBDPgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:36:21 -0500
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gqgIE-0000pC-RZ; Mon, 04 Feb 2019 08:36:18 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gqgIE-0002xZ-CX; Mon, 04 Feb 2019 08:36:18 -0700
Received: from hacktheplanet (unknown [73.58.156.217])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 34E7121D5F5;
        Mon,  4 Feb 2019 15:36:17 +0000 (UTC)
Date:   Mon, 4 Feb 2019 10:36:10 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Kozub <zub@linux.fjfi.cvut.cz>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190204153138.GA6512@hacktheplanet>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190204150415.GO31132@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204150415.GO31132@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gqgIE-0002xZ-CX;;;mid=<20190204153138.GA6512@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v4 00/16] block: sed-opal: support shadow MBR done flag
 and write
X-SA-Exim-Version: 4.2.1 (built Fri, 13 May 2016 17:07:30 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 07:04:15AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 09:50:07PM +0100, David Kozub wrote:
> > This patch series extends SED OPAL support: it adds IOCTL for setting the shadow
> > MBR done flag which can be useful for unlocking an OPAL disk on boot and it adds
> > IOCTL for writing to the shadow MBR. Also included are some minor fixes and
> > improvements.
> 
> Actually most of it is really useful cleanups and small fixes for the
> existing OPAL code.  Any chance you could resend just those bits as
> a first series ASAP?  I'll try to spend some time to to review the
> actual feature additions in the meantime.
> 
> > There is a fork of sed-opal-temp that can use these new IOCTLs.[2] I tested
> > these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.
> 
> Which brings up another question:  how do we get a properly maintained
> version of the sed-opal tool up ASAP?  It's been a bit bitrotting
> unfortunately, and the documentation and error handling hasn't been all
> that great to start with.  Are we going to find a good home for it?
> Util-linux for example?

I would also like to get it off my github and into a proper location as well.

Christoph, do you know off hand how we would get it in util-linux?

