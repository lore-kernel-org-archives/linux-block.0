Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1401C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DBD2082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DBD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeLAHwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:52:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:41040 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAHwZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 02:52:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="100694256"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2018 12:41:54 -0800
Date:   Fri, 30 Nov 2018 13:39:02 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181130203901.GA11193@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 01:36:09PM -0700, Jens Axboe wrote:
> On 11/30/18 1:26 PM, Keith Busch wrote:
> > A driver may wish to iterate every tagged request, not just ones that
> > satisfy blk_mq_request_started(). The intended use is so a driver may
> > terminate entered requests on quiesced queues.
> 
> How about we just move the started check into the handler passed in for
> those that care about it? Much saner to make the interface iterate
> everything, and leave whatever state check to the callback.

I agree that's better. I initially didn't want to examine all the users
but looks like only 4 drivers using the current tagset iterator, so
that's not too daunting. I'll give it a look.
