Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FCEC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 22:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FB9217FA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 22:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfDQWHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:07:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:51067 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfDQWHe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 18:07:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 15:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,363,1549958400"; 
   d="scan'208";a="338475981"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2019 15:07:34 -0700
Date:   Wed, 17 Apr 2019 16:01:19 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] fio: Add advise THP option to mmap engine
Message-ID: <20190417220119.GB6176@localhost.localdomain>
References: <20190417212816.6460-1-keith.busch@intel.com>
 <8a288283-e4c1-6fdc-6884-d98cfd246492@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a288283-e4c1-6fdc-6884-d98cfd246492@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 17, 2019 at 04:01:28PM -0600, Jens Axboe wrote:
> On 4/17/19 3:28 PM, Keith Busch wrote:
> > The transparent hugepage Linux-specific memory advisory has potentially
> > significant implications for how the memory management behaves. Add a
> > new mmap specific option that enables private TLP mmap mode when set so
> > we can test running fio with anonymous memory (i.e. mmap /dev/zero).
> 
> I'm fine with this, but the usual approach to platform stuff like this
> is to have
> 
> #define FIO_HAVE_THP
> 
> or similar in the os/os-linux.h file and then have:
> 
> #if FIO_OS==os_linux
> 	if (o->thp)
> 		madvise(io_u->mmap_data, fmd->mmap_sz, MADV_HUGEPAGE);
> #endif
> 
> #if defined(FIO_HAVE_THP)
> 	...
> #endif
> 
> instead. Since we need MADV_HUGEPAGE as well, might even make sense to
> just have this be a configure check instead...

Sounds good. I like to fit in with the local customs, so will take
another shot at this.
