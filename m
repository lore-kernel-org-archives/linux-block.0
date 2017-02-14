Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:32831 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdBNISP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 03:18:15 -0500
Date: Tue, 14 Feb 2017 00:18:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-nvme@lists.infradead.org, David.Laight@ACULAB.COM,
        arnd@arndb.de, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH V5 2/4] uapi: sed-opal fix IOW for activate lsp to use
 correct struct
Message-ID: <20170214081811.GB20251@infradead.org>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-3-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487002272-17940-3-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>

Let's get this one in ASAP while waiting for a respin of the KASAN
fix.
