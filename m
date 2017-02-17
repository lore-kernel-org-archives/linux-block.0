Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43865 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdBQRQ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 12:16:26 -0500
Date: Fri, 17 Feb 2017 18:16:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: re-check security protocol support after
        reset
Message-ID: <20170217171624.GA29297@lst.de>
References: <20170217125941.14319-1-hch@lst.de> <20170217125941.14319-5-hch@lst.de> <20170217152651.GA18275@localhost.localdomain> <20170217170128.GA29208@lst.de> <20170217165551.GA2062@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217165551.GA2062@sbauer-Z170X-UD5>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 09:55:51AM -0700, Scott Bauer wrote:
> I'm working on it now. Do you want a diff like Keith did or a separate patch?

Please make it a proper patch that applies on top of my patches 1-3 (where
3 really is yours anyway).  I'll respin 4 with the updates from Keith on
top of 1-3 + your patch then.
