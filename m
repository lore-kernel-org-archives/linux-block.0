Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:58277 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdBEQk0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Feb 2017 11:40:26 -0500
Date: Sun, 5 Feb 2017 17:40:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Joe Korty <joe.korty@ccur.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] genirq: allow assigning affinity to present but
        not online CPUs
Message-ID: <20170205164023.GA9281@lst.de>
References: <t6NbP-2IT-5@gated-at.bofh.it> <t6NbP-2IT-13@gated-at.bofh.it> <20170204015809.GA16203@zipoli.ccur.kvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170204015809.GA16203@zipoli.ccur.kvm>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Joe,

On Fri, Feb 03, 2017 at 08:58:09PM -0500, Joe Korty wrote:
> IIRC, some years ago I ran across a customer system where
> the #cpus_present was twice as big as #cpus_possible.
> 
> Hyperthreading was turned off in the BIOS so it was not
> entirely out of line for the extra cpus to be declared
> present, even though none of them would ever be available
> for use.

This sounds like a system we should quirk around instead of optimizing
for it.  Unless I totally misunderstand the idea behind cpu_possible
and cpu_present.
