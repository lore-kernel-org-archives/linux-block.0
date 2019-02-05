Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67571C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49ACC2083B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 18:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfBESX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:23:27 -0500
Received: from verein.lst.de ([213.95.11.211]:55570 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfBESX1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 13:23:27 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7A7DF68D93; Tue,  5 Feb 2019 19:23:25 +0100 (CET)
Date:   Tue, 5 Feb 2019 19:23:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
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
Message-ID: <20190205182325.GA3302@lst.de>
References: <20190129172059.GC17132@localhost.localdomain> <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com> <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de> <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com> <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de> <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de> <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de> <42d149c5-0380-c357-8811-81015159ac04@huawei.com> <20190205145244.GB28023@localhost.localdomain> <d4a04c13-b7db-84df-b1d3-90022905c084@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a04c13-b7db-84df-b1d3-90022905c084@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 05, 2019 at 03:09:28PM +0000, John Garry wrote:
> For SCSI devices, unfortunately not all IO sent to the HW originates from 
> blk-mq or any other single entity.

Where else would SCSI I/O originate from?
