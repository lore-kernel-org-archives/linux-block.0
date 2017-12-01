Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbdLAPnC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 10:43:02 -0500
Date: Fri, 1 Dec 2017 23:42:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Jens Axboe <axboe@fb.com>
Cc: "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Message-ID: <20171201154242.GA21731@ming.t460p>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 01, 2017 at 01:36:13PM -0200, Mauricio Faria de Oliveira wrote:
> Hi Ming Lei,
> 
> On 11/29/2017 12:57 AM, chenxiang (M) wrote:
> > I applied this v2 patchset to kernel 4.15-rc1, running fio on a SATA
> > disk, then disable the disk with sysfs interface
> > (echo 0 > /sys/class/sas_phy/phy-1:0:1/enable), and find system is hung.
> > But with v1 patch, it doesn't
> > has this issue. Please have a check.
> 
> Indeed, with this particular test-case (thanks, chenxiang) the problem
> can be recreated with PATCH v2 but _not_ with v1.
> 
> For reference, I'm including the tests with v2 in this e-mail.
> The same tests have too been performed with v1, without blocked tasks.
> 
> Interestingly, physical disk pulls did not hit the problem either
> on v1 or v2 (but it does not matter anymore) -- so v1 is the one.

V1 has been resent out in the following link with your tested-by:

	https://marc.info/?l=linux-block&m=151200356024020&w=2

Jens, since it fixes regression from two reports, could you take a look?

-- 
Ming
