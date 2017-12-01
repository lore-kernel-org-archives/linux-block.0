Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdLARgF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 12:36:05 -0500
Date: Sat, 2 Dec 2017 01:35:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "mauricfo@linux.vnet.ibm.com" <mauricfo@linux.vnet.ibm.com>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Message-ID: <20171201173542.GB22528@ming.t460p>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
 <1512144528.2520.2.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512144528.2520.2.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 01, 2017 at 04:08:49PM +0000, Bart Van Assche wrote:
> On Fri, 2017-12-01 at 13:36 -0200, Mauricio Faria de Oliveira wrote:
> > On 11/29/2017 12:57 AM, chenxiang (M) wrote:
> > > I applied this v2 patchset to kernel 4.15-rc1, running fio on a SATA 
> > > disk, then disable the disk with sysfs interface
> > > (echo 0 > /sys/class/sas_phy/phy-1:0:1/enable), and find system is hung. 
> > > But with v1 patch, it doesn't
> > > has this issue. Please have a check.
> > 
> > Indeed, with this particular test-case (thanks, chenxiang) the problem
> > can be recreated with PATCH v2 but _not_ with v1.
> > 
> > For reference, I'm including the tests with v2 in this e-mail.
> > The same tests have too been performed with v1, without blocked tasks.
> > 
> > Interestingly, physical disk pulls did not hit the problem either
> > on v1 or v2 (but it does not matter anymore) -- so v1 is the one.
> 
> The test chenxiang ran does not prove that there is anything wrong with v2.
> Maybe chenxiang hit the issue described in https://lkml.org/lkml/2017/9/5/381?

No, if the issue is in SCSI EH, blk_drain_queue() shouldn't have moved on too.

Anyway, V1/V3 is the correct thing to do.

Thanks,
Ming
