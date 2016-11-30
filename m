Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:29758 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933043AbcK3SDX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 13:03:23 -0500
Date: Wed, 30 Nov 2016 13:13:57 -0500
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-nvme@lists.infradead.org, Rafael.Antognolli@intel.com,
        axboe@fb.com, jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
Message-ID: <20161130181357.GD21081@localhost.localdomain>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 29, 2016 at 02:52:00PM -0700, Scott Bauer wrote:
> +	dev = get_or_create_opal_dev(bdev, key->opal_act.key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;

The alloc_opal_dev from this call returns ERR_PTR values on error, so
the check should be:

	if (IS_ERR_OR_NULL(dev))
		return PTR_ERR(dev);
