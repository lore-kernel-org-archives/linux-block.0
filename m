Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27153 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbcK3SQT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 13:16:19 -0500
Date: Wed, 30 Nov 2016 11:09:42 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, Rafael.Antognolli@intel.com,
        axboe@fb.com, jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
Message-ID: <20161130180941.GA23789@sbauer-Z170X-UD5>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
 <20161130181357.GD21081@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161130181357.GD21081@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

es1;4205;0cOn Wed, Nov 30, 2016 at 01:13:57PM -0500, Keith Busch wrote:
> On Tue, Nov 29, 2016 at 02:52:00PM -0700, Scott Bauer wrote:
> > +	dev = get_or_create_opal_dev(bdev, key->opal_act.key.lr, true);
> > +	if (!dev)
> > +		return -ENOMEM;
> 
> The alloc_opal_dev from this call returns ERR_PTR values on error, so
> the check should be:
> 
> 	if (IS_ERR_OR_NULL(dev))
> 		return PTR_ERR(dev);

Nice catch, I'll go double check the rest of the return values for this
scenario.
