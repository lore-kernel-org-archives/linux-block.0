Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD1C282CC
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EF52081B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfBEOxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:53:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:49613 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfBEOxS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 09:53:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 06:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="316492544"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2019 06:53:17 -0800
Date:   Tue, 5 Feb 2019 07:52:44 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
Message-ID: <20190205145244.GB28023@localhost.localdomain>
References: <20190129154433.GF15302@localhost.localdomain>
 <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
 <20190129172059.GC17132@localhost.localdomain>
 <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
 <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
 <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com>
 <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
 <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de>
 <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de>
 <42d149c5-0380-c357-8811-81015159ac04@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d149c5-0380-c357-8811-81015159ac04@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 05, 2019 at 05:24:11AM -0800, John Garry wrote:
> On 04/02/2019 07:12, Hannes Reinecke wrote:
> 
> Hi Hannes,
> 
> >
> > So, as the user then has to wait for the system to declars 'ready for
> > CPU remove', why can't we just disable the SQ and wait for all I/O to
> > complete?
> > We can make it more fine-grained by just waiting on all outstanding I/O
> > on that SQ to complete, but waiting for all I/O should be good as an
> > initial try.
> > With that we wouldn't need to fiddle with driver internals, and could
> > make it pretty generic.
> 
> I don't fully understand this idea - specifically, at which layer would 
> we be waiting for all the IO to complete?

Whichever layer dispatched the IO to a CPU specific context should
be the one to wait for its completion. That should be blk-mq for most
block drivers.
