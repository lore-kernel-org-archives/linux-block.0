Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22244 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbcLIS56 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Dec 2016 13:57:58 -0500
Date: Fri, 9 Dec 2016 11:50:51 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        sagi@grimberg.me, Rafael.Antognolli@intel.com, axboe@fb.com,
        linux-nvme@lists.infradead.org, jonathan.derrick@intel.com,
        j.naumann@fu-berlin.de
Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
Message-ID: <20161209185051.GB7865@sbauer-Z170X-UD5>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
 <20161201005006.GE21081@localhost.localdomain>
 <20161201100456.GA17592@infradead.org>
 <20161201175343.GA6554@sbauer-Z170X-UD5>
 <20161201182239.GH21081@localhost.localdomain>
 <20161209174529.GA7865@sbauer-Z170X-UD5>
 <20161209183034.GA28669@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161209183034.GA28669@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 09, 2016 at 10:30:34AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 09, 2016 at 10:45:30AM -0700, Scott Bauer wrote:
> > Now, with this in mind, it sort of makes sense to move this from
> > block/ back into lib/ and interface with the character dev. Instead
> > of passing around block_devices, we can pass around struct file *'s.
> >
> 
> Even the character device is always backed by the queues, and I'd really
> not prefer to have a struct file here - that's not useful at all
> for in-kernel users.

Is your main concern that if an in-kernel user wants to use this functionality
they have to pass us a block device pointer, and may not be able to? Is that
why you wanted to pass a function pointer to the code because a driver/kernel-user
can probably always have that availiable to send to us?

