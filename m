Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE00C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D43820868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D43820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeK3ErL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:47:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:15877 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbeK3ErL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:47:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 09:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="95842973"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2018 09:41:01 -0800
Date:   Thu, 29 Nov 2018 10:38:07 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
Message-ID: <20181129173806.GA9377@localhost.localdomain>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
 <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
 <20181129170430.GA27364@infradead.org>
 <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 10:06:20AM -0700, Jens Axboe wrote:
> On 11/29/18 10:04 AM, Christoph Hellwig wrote:
> > gcc never warns about unused static inline functions.  Which makes a lot
> > of sense at least for headers..
> 
> Not so much for non-headers :-)

You can #include .c files too! :)
