Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46CC282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD44B20863
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558618087;
	bh=a8odGaj+vyncYG3jLQkxZESgzaf78WbiGXQiSXAS0EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZREZlk0YiPFzsgvT7kMFvgoxdedEu1PZEJSFWqcn79AjF+g+MD8wA3/dHg7Tlk1qK
	 bpj+NQURqlCn0evcciQc/4QBoLaDDWE3rIy34Cn5NB9mYWBv5uMnTpLLVRMKSbnybj
	 8oTjOnTxbQVGreK1pC+l0SdC5MlCQAj/Hcjebyeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfEWN2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 09:28:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:35321 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfEWN2H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 09:28:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 06:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,503,1549958400"; 
   d="scan'208";a="174753008"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 23 May 2019 06:28:05 -0700
Date:   Thu, 23 May 2019 07:23:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
Message-ID: <20190523132304.GB14049@localhost.localdomain>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190523032925.GA10601@ming.t460p>
 <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
 <20190523101311.GB15492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523101311.GB15492@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 03:13:11AM -0700, Christoph Hellwig wrote:
> On Wed, May 22, 2019 at 09:48:10PM -0600, Keith Busch wrote:
> > Yeah, that's a good question. A FW update may have been initiated out
> > of band or from another host entirely. The driver can't count on
> > preparing for hardware pausing command processing before it's
> > happened, but we'll always find out asynchronously after it's too late
> > to freeze.
> 
> I don't think that is the case at least for spec compliant devices.
> 
> From NVMe 1.3:
> 
> Figure 49: Asynchronous Event Information - Notice
> 
> 1h		Firmware Activation Starting: The controller is starting
> 		a firmware activation process during which command
> 		processing is paused. Host software may use CSTS.PP to
> 		determine when command processing has resumed. To clear
> 		this event, host software reads the Firmware Slot
> 		Information log page.
> 
> So we are supposed to get an AEN before the device stops processing
> commands.

Hm, I read the same section, but conclude differently (and at least some
vendors did too). A spec compliant controller activating new firmware
without reset would stop processing commands and set CSTS.PP first,
then send the AEN. When the host is aware to poll Processing Paused,
the controller hasn't been processing new commands for some time.

Could you give some more detail on your interpretation?
