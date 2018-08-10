Return-Path: <prvs=753ac577b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v6 10/12] block: Change the runtime power management
 approach (1/2)
Date: Fri, 10 Aug 2018 15:20:54 +0000
Message-ID: <10bda502006c6d3ceef59005610d189a70edc059.camel@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
	 <20180809194149.15285-11-bart.vanassche@wdc.com>
	 <b09a092b-da49-c071-c79a-63c3d1cde494@oracle.com>
In-Reply-To: <b09a092b-da49-c071-c79a-63c3d1cde494@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-10 at 09:59 +-0800, jianchao.wang wrote:
+AD4- On 08/10/2018 03:41 AM, Bart Van Assche wrote:
+AD4- +AD4- Instead of scheduling runtime resume of a request queue after a
+AD4- +AD4- request has been queued, schedule asynchronous resume during re=
quest
+AD4- +AD4- allocation. The new pm+AF8-request+AF8-resume() calls occur aft=
er
+AD4- +AD4- blk+AF8-queue+AF8-enter() has increased the q+AF8-usage+AF8-cou=
nter request queue
+AD4-=20
+AD4-                         +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4A=
XgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4-
+AD4- +AD4- member. This change is needed for a later patch that will make =
request
+AD4- +AD4- allocation block while the queue status is not RPM+AF8-ACTIVE.
+AD4-=20
+AD4- Is it +ACI-after getting q-+AD4-q+AF8-usage+AF8-counter fails+ACI- ?
+AD4- And also this blk+AF8-pm+AF8-request+AF8-resume  will not affect the =
normal path. +ADs-)

Right, the commit message needs to be brought in sync with the code.

Bart.
