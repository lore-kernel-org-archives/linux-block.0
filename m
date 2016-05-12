Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41196 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbcELHIH (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 12 May 2016 03:08:07 -0400
Date: Thu, 12 May 2016 00:08:05 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Stephen Bates <stephen.bates@microsemi.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 0/2] Block: Give option to force io polling
Message-ID: <20160512070805.GE20802@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
 <20160508090257.GG15458@infradead.org>
 <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 09, 2016 at 02:53:30PM +0000, Stephen Bates wrote:
> Christoph, this is a DRAM based NVMe device, the code for polling in NVMe was merged in 4.5 right? We are using the inbox NVMe driver. Here is some performance data:
> 
> QD=1, single thread, random 4KB reads
> 
> Polling Off: 12us Avg / 40us 99.99% ;
> Polling On: 9.5us Avg / 25us 99.99%
> 
> Both the average and 99.99% reduction are of interest.

How does CPU usage look for common workloads with polling force
enabled?  If it's really an overall win we should just add a quirk
to the NVMe driver to always force polling for this device based on the
PCI ID.
