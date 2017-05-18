Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964801AbdERNaA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2017 09:30:00 -0400
Subject: Re: [PATCH blktests 0/3] Add SCSI generic test group
To: Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@osandov.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
References: <cover.1495109149.git.jthumshirn@suse.de>
 <20170518131928.GA26060@infradead.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <94150f71-5bbb-2ee2-b7d4-d0f2f7124684@suse.de>
Date: Thu, 18 May 2017 15:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170518131928.GA26060@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/18/2017 03:19 PM, Christoph Hellwig wrote:
> All SG_IO test should also apply to block device nodes that support
> the ioctl..
> 

But these are not necessarily SG_IO tests, are they?

The test included is doesn't hit the SG_IO path in the sg driver, but
the sg_read path.

Of cause we can make a generic sg_io tool but IMHO it's quite convenient
to just throw in the reproducers we get.

And as it exercises the /dev/sg character device I decided to make a new
group.

	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
