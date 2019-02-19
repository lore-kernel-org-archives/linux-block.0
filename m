Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18389C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4CC2147A
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfBSQNE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:13:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:4902 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfBSQNE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 11:13:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 08:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="320290226"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 19 Feb 2019 08:13:00 -0800
Date:   Tue, 19 Feb 2019 09:12:57 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
Message-ID: <20190219161256.GA16341@localhost.localdomain>
References: <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
 <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
 <20190213223711.GC8027@localhost.localdomain>
 <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
 <tencent_6460D33741AF25B57E7BE493@qq.com>
 <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
 <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 18, 2019 at 04:42:27PM -0800, 陈华才 wrote:
> I've tested, this patch can fix the nvme problem, but it can't be applied
> to 4.19 because of different context. And, I still think my original solution
> (genirq/affinity: Assign default affinity to pre/post vectors) is correct.
> There may be similar problems except nvme.

I'll send a proper patch to fix the warning.  It's always a driver bug if
they try to extract affinity from a non-managed irq, but I don't think
this particular nvme instance is very urgent as the end result is the
same, just without the warning.
