Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38596 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPQt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jul 2018 12:49:56 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 0/3] blk-mq: support runtime PM
Date: Mon, 16 Jul 2018 16:21:43 +0000
Message-ID: <8fde59725d10f2b48ec0f8e6e3a6216183a5fe53.camel@wdc.com>
References: <20180713080602.31602-1-ming.lei@redhat.com>
         <c4147a47-876f-0ced-6c9d-1c3792d09858@kernel.dk>
         <20180714023740.GA8402@ming.t460p>
         <27bc4ec8-dd63-2b6f-84ef-4c4c0fc7f9e9@kernel.dk>
In-Reply-To: <27bc4ec8-dd63-2b6f-84ef-4c4c0fc7f9e9@kernel.dk>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2018-07-13 at 20:54 -0600, Jens Axboe wrote:
+AD4- On 7/13/18 8:37 PM, Ming Lei wrote:
+AD4- +AD4- OK, I am thinking another idea for addressing this issue.
+AD4- +AD4-=20
+AD4- +AD4- We may introduce one logical admin(pm) request queue for each s=
csi+AF8-device,
+AD4- +AD4- and this queue shares tag with IO queue, with NO+AF8-SCHED set,=
 and always
+AD4- +AD4- use atomic mode of the queue usage refcounter. Then we may send=
 PM
+AD4- +AD4- command to device after the IO queue is frozen.
+AD4- +AD4-=20
+AD4- +AD4- Also PREEMPT+AF8-ONLY can be removed too in this way.
+AD4- +AD4-=20
+AD4- +AD4- Even in future, all pass-through commands may be sent to this a=
dmin queue.
+AD4- +AD4-=20
+AD4- +AD4- If no one objects, I will cook patches towards this direction.
+AD4-=20
+AD4- Yes, this seems like a fine idea. It's essentially the same as handli=
ng
+AD4- the enter differently, but the abstraction is nicer.

Hello Jens,

Why do you support the idea of removing the PREEMPT+AF8-ONLY flag? Are you
perhaps concerned about the performance impact of that flag for NVMe reques=
t
processing? If that is your concern and if it can be shown that the
processing of that flag has a measurable performance impact, how about usin=
g
jump labels to ensure that only request queues that need the PREEMPT+AF8-ON=
LY
flag pay the overhead of processing that flag? See also
Documentation/static-keys.txt.

Thanks,

Bart.
