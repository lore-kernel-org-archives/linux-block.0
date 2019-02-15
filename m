Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB14CC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 21:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5718222DE
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392745AbfBOVr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:47:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:5107 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387436AbfBOVr0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 16:47:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 13:47:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,374,1544515200"; 
   d="scan'208";a="118299769"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2019 13:47:25 -0800
Date:   Fri, 15 Feb 2019 14:47:14 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
Message-ID: <20190215214714.GA11307@localhost.localdomain>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 15, 2019 at 09:19:02PM +0000, Felipe Franciosi wrote:
> Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. 

Try the io_uring interface instead. Its queued up in the linux-block
for-next tree.

> For hypervisors, where storage devices can be exclusively accessed with userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient.

It doesn't work so well for file based or multi-device backing
storage. But if you are sequestering an entire controller over to a VM,
direct-assign/device-passthrough is usually also an option and that
ought to be even faster.
