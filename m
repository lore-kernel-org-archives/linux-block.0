Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8787 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759415AbcDEPy4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 5 Apr 2016 11:54:56 -0400
Date: Tue, 5 Apr 2016 15:54:54 +0000
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jon Derrick <jonathan.derrick@intel.com>, axboe@fb.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	stephen.bates@microsemi.com
Subject: Re: [PATCH 0/2] Block: Give option to force io polling
Message-ID: <20160405155453.GB12625@localhost.localdomain>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <20160405123832.GA27788@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160405123832.GA27788@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 05, 2016 at 05:38:32AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 31, 2016 at 02:19:12PM -0600, Jon Derrick wrote:
> > In 4.6, enabling io polling in direct-io was switched to a per-io flag.
> > This had an unintended result of giving a significant difference when
> > doing benchmarks between 4.5 and 4.6, using fio's sync engine.
> 
> Only if you manually enabled polling beforehand.  I really don't see
> how this is going to be useful for actual applications vs benchmarks,
> so I'll need more convincing arguments.

I think it's more about providing opt-in control to make the low-latency
benefit reachable to users with existing programs.
