Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E68DC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C71218A1
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553276197;
	bh=GWmzpEXHZLcTlnW83g5ygRKMuvBGrH3uZgBq4va+EMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lzjlD/CwRigiGXN6olvM8xAuky6STzKrDD3MpReJq9DNKGOeYTHMPak6YHZ/iai8q
	 2JfK8b/1xpR+HaerDjNUwzx7yUYB8HFl5giO1ZwbfAKhPCdktWfajQfzQgAbevl7cP
	 L1WOFz124eLJ5I07Dayme28IO+/e+RFfa5cqzcG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCVRgg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:36:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:23456 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfCVRgg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 13:36:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 10:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="285028592"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2019 10:36:35 -0700
Date:   Fri, 22 Mar 2019 11:37:36 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC] optimize nvme single segment I/O
Message-ID: <20190322173736.GC31194@localhost.localdomain>
References: <20190321231037.25104-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 21, 2019 at 04:10:22PM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> with all the discussion on small I/O performance lately I thought
> it was time off to dust my old idea to optimize this path a bit
> by avoiding to build a scatterlist.  I've only done very basic
> testing because I've been a bit busy, but I thought it might be
> worthwhile to get it out for feedback.

Tests well here with a measurable IOPs improvement at lower queue depths.

Series looks good to me, especially patch 5! :p

Reviewed-by: Keith Busch <keith.busch@intel.com>
