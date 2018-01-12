Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35481 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964998AbeALTfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jan 2018 14:35:55 -0500
Date: Fri, 12 Jan 2018 20:35:46 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] genirq/affinity: assign vectors to all possible
 CPUs
In-Reply-To: <20180112025306.28004-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.20.1801122035220.2371@nanos>
References: <20180112025306.28004-1-ming.lei@redhat.com> <20180112025306.28004-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 12 Jan 2018, Ming Lei wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Currently we assign managed interrupt vectors to all present CPUs.  This
> works fine for systems were we only online/offline CPUs.  But in case of
> systems that support physical CPU hotplug (or the virtualized version of
> it) this means the additional CPUs covered for in the ACPI tables or on
> the command line are not catered for.  To fix this we'd either need to
> introduce new hotplug CPU states just for this case, or we can start
> assining vectors to possible but not present CPUs.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>

FWIW, Acked-by: Thomas Gleixner <tglx@linutronix.de>
