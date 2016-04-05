Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60420 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399AbcDER1u (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2016 13:27:50 -0400
Date: Tue, 5 Apr 2016 10:27:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jon Derrick <jonathan.derrick@intel.com>, axboe@fb.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	stephen.bates@microsemi.com
Subject: Re: [PATCH 0/2] Block: Give option to force io polling
Message-ID: <20160405172749.GB31055@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <20160405123832.GA27788@infradead.org>
 <20160405155453.GB12625@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160405155453.GB12625@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 05, 2016 at 03:54:54PM +0000, Keith Busch wrote:
> I think it's more about providing opt-in control to make the low-latency
> benefit reachable to users with existing programs.

What program benefits from unconditional polling for all I/O on a given
device?

