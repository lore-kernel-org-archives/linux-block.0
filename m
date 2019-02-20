Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F2C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE282147A
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 16:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbfBTQjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:39:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:37610 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTQjY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 11:39:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 08:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="125905373"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2019 08:39:22 -0800
Date:   Wed, 20 Feb 2019 09:39:22 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: Read-only Mapping of Program Text using Large THP Pages
Message-ID: <20190220163921.GA4451@localhost.localdomain>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
 <20190220144345.GG12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220144345.GG12668@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 06:43:46AM -0800, Matthew Wilcox wrote:
> What NVMe doesn't have is a way for the host to tell the controller
> "Here's a 2MB sized I/O; bytes 40960 to 45056 are most important to
> me; please give me a completion event once those bytes are valid and
> then another completion event once the entire I/O is finished".
> 
> I have no idea if hardware designers would be interested in adding that
> kind of complexity, but this is why we also have I/O people at the same
> meeting, so we can get these kinds of whole-stack discussions going.

We have two unused PRP bits, so I guess there's room to define something
like a "me first" flag. I am skeptical we'd get committee approval for
that or partial completion events, though.

I think the host should just split the more important part of the transfer
into a separate command. The only hardware support we have to prioritize
that command ahead of others is with weighted priority queues, but we're
missing driver support for that at the moment.
