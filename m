Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751841AbdLBAuQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 19:50:16 -0500
Date: Sat, 2 Dec 2017 08:49:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Message-ID: <20171202004953.GB24521@ming.t460p>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
 <1512144528.2520.2.camel@sandisk.com>
 <ea717cce-a083-1fef-362f-6c302b4434fa@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea717cce-a083-1fef-362f-6c302b4434fa@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 01, 2017 at 04:49:31PM -0200, Mauricio Faria de Oliveira wrote:
> Hi Bart,
> 
> On 12/01/2017 02:08 PM, Bart Van Assche wrote:
> > The test chenxiang ran does not prove that there is anything wrong with v2.
> > Maybe chenxiang hit the issue described inhttps://lkml.org/lkml/2017/9/5/381?
> 
> Unfortunately v2 has been found to exhibit another problem, an Oops in
> the systemd shutdown path for device-mapper LVM volumes at least, when
> calling 'q->request_fn(q)' if 'q->request_fn' is NULL.

That issue can be fixed easily in V2 and we understand DM's case clearly.

But the most important thing is that V2 can't fix Chenxiang's issue, but
V3/V1 can.


-- 
Ming
