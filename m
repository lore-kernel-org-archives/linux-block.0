Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752302AbdF0Gtj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 02:49:39 -0400
Date: Tue, 27 Jun 2017 08:49:32 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests 2/2] block/011: Perform PCI reset while doing IO
Message-ID: <20170627064932.GA4305@linux-x5ow.site>
References: <20170623142951.17189-1-jthumshirn@suse.de>
 <20170623142951.17189-2-jthumshirn@suse.de>
 <20170626212724.GF6710@vader.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170626212724.GF6710@vader.dhcp.thefacebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 26, 2017 at 02:27:24PM -0700, Omar Sandoval wrote:
[...]
> > +
> > +	while kill -0 $! 2>/dev/null; do
> > +		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
> > +		sleep .2
> > +		echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
> 
> Test looks good, but one question: do you want another sleep .2 here?
> Like this, you immediately disable it after enabling it, but maybe
> that's what you want :)

Good catch. I'll fix it up.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
