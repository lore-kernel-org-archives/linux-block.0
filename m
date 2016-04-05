Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38648 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcDEMid (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2016 08:38:33 -0400
Date: Tue, 5 Apr 2016 05:38:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: axboe@fb.com, keith.busch@intel.com, hch@infradead.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	stephen.bates@microsemi.com
Subject: Re: [PATCH 0/2] Block: Give option to force io polling
Message-ID: <20160405123832.GA27788@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 31, 2016 at 02:19:12PM -0600, Jon Derrick wrote:
> In 4.6, enabling io polling in direct-io was switched to a per-io flag.
> This had an unintended result of giving a significant difference when
> doing benchmarks between 4.5 and 4.6, using fio's sync engine.

Only if you manually enabled polling beforehand.  I really don't see
how this is going to be useful for actual applications vs benchmarks,
so I'll need more convincing arguments.
