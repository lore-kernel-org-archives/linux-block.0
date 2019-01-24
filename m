Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8DC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C59421872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 12:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfAXMRD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:17:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:25053 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfAXMRD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 07:17:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 04:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="314440261"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2019 04:17:01 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gmdwJ-0000YR-WF; Thu, 24 Jan 2019 14:17:00 +0200
Date:   Thu, 24 Jan 2019 14:16:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
Message-ID: <20190124121659.GH9224@smile.fi.intel.com>
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
 <20190121084732.GE18680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121084732.GE18680@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 21, 2019 at 09:47:32AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 10, 2019 at 04:30:51PM +0200, Andy Shevchenko wrote:
> > There are new types and helpers that are supposed to be used in new code.
> > 
> > As a preparation to get rid of legacy types and API functions do
> > the conversion here.
> 
> This seems to miss a "lightnvm" in the subject line.
> 
> >  static inline void pblk_setup_uuid(struct pblk *pblk)
> >  {
> > +	guid_gen((guid_t *)&pblk->instance_uuid);
> >  }
> 
> I think we can just kill this wrapper.
> 
> But more importantly the instance_uuid fied, and the header.uuid one
> it is copied from should be turned into an actual guid_t, the memcpys
> and memcmps should also be replaced with the proper UUID API.

header.uuid is defined using __u8 type, I'm not sure we can use guid_t there.

-- 
With Best Regards,
Andy Shevchenko


