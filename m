Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51321C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EBF21929
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 17:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfBORcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:32:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:45873 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfBORca (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 12:32:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 09:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="320730347"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2019 09:32:29 -0800
Date:   Fri, 15 Feb 2019 10:32:18 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Omar Sandoval <osandov@osandov.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190215173217.GA11055@localhost.localdomain>
References: <20190213180754.GX23000@mit.edu>
 <20190214215634.GD9819@vader>
 <20190215030202.GA723@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215030202.GA723@mit.edu>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 10:02:02PM -0500, Theodore Y. Ts'o wrote:
> > My (undocumented) rule of thumb has been that blktests shouldn't assume
> > anything newer than whatever ships on Debian oldstable. I can document
> > that requirement.
> 
> That's definitely not true for the nvme tests; the nvme-cli from
> Debian stable is *not* sufficient.  This is why I've started building
> nvme-cli as part of the test appliance in xfstests-bld.  I'm now
> somewhat suspicious that there are problems because using the latest
> HEAD of the nvme-cli git tree may have had messages printed to
> standard out that is subtly different from the version of nvme-cli
> that was used to develop some of the nvme tests.

It does appear some expected output has hard coded values that are not
fixed. Some of the failures are assuming an auto-incrementing generation
number will always be 1, but that should just be a wildcard match.
