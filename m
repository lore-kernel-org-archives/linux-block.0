Return-Path: <prvs=753ac577b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v6 11/12] block: Change the runtime power management
 approach (2/2)
Date: Fri, 10 Aug 2018 15:22:57 +0000
Message-ID: <025ba5e656e45a6cf1a2cba3bdbd3b2d8d64fb09.camel@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
	 <20180809194149.15285-12-bart.vanassche@wdc.com>
	 <e69986b2-1cd4-ad00-5cd8-6500305cdbd1@oracle.com>
In-Reply-To: <e69986b2-1cd4-ad00-5cd8-6500305cdbd1@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-10 at 09:51 +-0800, jianchao.wang wrote:
+AD4- On 08/10/2018 03:41 AM, Bart Van Assche wrote:
+AD4- +AD4- +-
+AD4- +AD4- +-	blk+AF8-set+AF8-pm+AF8-only(q)+ADs-
+AD4- +AD4- +-	/+ACo-
+AD4- +AD4- +-	 +ACo- This function only gets called if the most recent
+AD4- +AD4- +-	 +ACo- pm+AF8-request+AF8-resume() call occurred at least au=
tosuspend+AF8-delay+AF8-ms
+AD4- +AD4- +-	 +ACo- ago. Since blk+AF8-queue+AF8-enter() is called by the=
 request allocation
+AD4- +AD4- +-	 +ACo- code before pm+AF8-request+AF8-resume(), if no reques=
ts have a tag assigned
+AD4- +AD4- +-	 +ACo- it is safe to suspend the device.
+AD4- +AD4- +-	 +ACo-/
+AD4- +AD4- +-	ret +AD0- -EBUSY+ADs-
+AD4- +AD4- +-	if (blk+AF8-requests+AF8-in+AF8-flight(q) +AD0APQ- 0) +AHs-
+AD4- +AD4- +-		/+ACo-
+AD4- +AD4- +-		 +ACo- Call synchronize+AF8-rcu() such that later blk+AF8-q=
ueue+AF8-enter()
+AD4- +AD4- +-		 +ACo- calls see the preempt-only state. See also
+AD4- +AD4- +-		 +ACo-=20
+AD4- +AD4- https://urldefense.proofpoint.com/v2/url?u+AD0-http-3A+AF8AXw-l=
wn.net+AF8-Articles+AF8-573497+AF8AJg-d+AD0-DwIBAg+ACY-c+AD0-RoP1YumCXCgaWH=
vlZYR8PZh8Bv7qIrMUB65eapI+AF8-JnE+ACY-r+AD0-7WdAxUBeiTUTCy8v-7zXyr4qk7sx26A=
Tvfo6QSTvZyQ+ACY-m+AD0-U9uPCJD2WnkXvdzrWaKPh2wJuk8-IHvxZ9sWDVrg2Tg+ACY-s+AD=
0-c9E23TPCpNQkiZpuzGztwHxjWF8qrESfRnPmI-e-Z48+ACY-e+AD0-
+AD4- +AD4- .
+AD4- +AD4- +-		 +ACo-/
+AD4- +AD4- +-		synchronize+AF8-rcu()+ADs-
+AD4- +AD4- +-		if (blk+AF8-requests+AF8-in+AF8-flight(q) +AD0APQ- 0)
+AD4- +AD4- +-			ret +AD0- 0+ADs-
+AD4- +AD4- +-	+AH0-
+AD4-=20
+AD4- I still think blk+AF8-set+AF8-pm+AF8-only should be moved after blk+A=
F8-requests+AF8-in+AF8-flight.
+AD4- Otherwise, the normal IO will be blocked for a little while if there =
are still
+AD4- busy requests.

Hi Jianchao,

Although I think it is unlikely that the scenario you described will happen=
, I
will make the change you requested.

Bart.
