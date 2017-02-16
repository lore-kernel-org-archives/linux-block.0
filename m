Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbdBPRVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 12:21:45 -0500
Date: Thu, 16 Feb 2017 09:21:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216172144.GA18507@infradead.org>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
 <20170216075812.GA7662@infradead.org>
 <84b78f2d-0238-0fa1-e0b3-d46e7d4cb9be@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84b78f2d-0238-0fa1-e0b3-d46e7d4cb9be@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 10:18:59AM -0700, Jon Derrick wrote:
> It looks good to me at first glance but I can't apply it. What tree are
> you on?

It's against Jens' for-next tree (actually from two days ago, but
nothing in this area should have changed since then)
