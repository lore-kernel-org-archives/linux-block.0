Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45390 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbcEHJC7 (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Sun, 8 May 2016 05:02:59 -0400
Date: Sun, 8 May 2016 02:02:57 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Stephen Bates <stephen.bates@microsemi.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 0/2] Block: Give option to force io polling
Message-ID: <20160508090257.GG15458@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 05, 2016 at 07:44:29PM +0000, Stephen Bates wrote:
> I am very interested in seeing this added. There are use cases involving super-low latency (non-NAND based) NVMe devices and they want the fastest possible IO response times for ALL IO to that device. They also have no desire to wait for the new system calls and glibc updates needed to tie their applications into polling or to rewrite their applications to avail of those new calls. I have done some testing on Jon's "big hammer" and it seems to work well for this use case and applied cleanly against v4.6-rc6.

Let's get the driver for those devices merged first, and if you can
provide numbers that it's worth it we can add a tweak to always enable
polling from the driver for those devices.
