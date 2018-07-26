Return-Path: <prvs=7387fcde5=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 3/5] block: Serialize queue freezing and
 blk_pre_runtime_suspend()
Date: Thu, 26 Jul 2018 22:18:32 +0000
Message-ID: <420b3fca86e4f20a278473e3bb5f91d4f3ae7201.camel@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
	 <20180725222607.8854-4-bart.vanassche@wdc.com>
	 <3593cfaf-06c5-db39-7f93-2cb4e8c7812f@oracle.com>
In-Reply-To: <3593cfaf-06c5-db39-7f93-2cb4e8c7812f@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-26 at 10:45 +-0800, jianchao.wang wrote:
+AD4- On 07/26/2018 06:26 AM, Bart Van Assche wrote:
+AD4- +AD4- +-
+AD4- +AD4- +-void blk+AF8-pm+AF8-runtime+AF8-lock(struct request+AF8-queue=
 +ACo-q)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-	spin+AF8-lock(+ACY-q-+AD4-rpm+AF8-lock)+ADs-
+AD4- +AD4- +-	wait+AF8-event+AF8-interruptible+AF8-locked(q-+AD4-rpm+AF8-w=
q,
+AD4- +AD4- +-			  q-+AD4-rpm+AF8-owner +AD0APQ- NULL +AHwAfA- q-+AD4-rpm+A=
F8-owner +AD0APQ- current)+ADs-
+AD4- +AD4- +-	if (q-+AD4-rpm+AF8-owner +AD0APQ- NULL)
+AD4- +AD4- +-		q-+AD4-rpm+AF8-owner +AD0- current+ADs-
+AD4- +AD4- +-	q-+AD4-rpm+AF8-nesting+AF8-level+-+-+ADs-
+AD4- +AD4- +-	spin+AF8-unlock(+ACY-q-+AD4-rpm+AF8-lock)+ADs-
+AD4- +AD4- +-+AH0-
+AD4-=20
+AD4- The lock which wait+AF8-event+AF8-interruptible+AF8-locked want to ho=
ld is the wq.lock.

The above code is indeed wrong. This is what I think it should be changed
into:

+-void blk+AF8-pm+AF8-runtime+AF8-lock(struct request+AF8-queue +ACo-q)
+-+AHs-
+-	might+AF8-sleep()+ADs-
+-
+-	spin+AF8-lock(+ACY-q-+AD4-rpm+AF8-lock)+ADs-
+-	wait+AF8-event+AF8-exclusive+AF8-cmd(q-+AD4-rpm+AF8-wq,
+-			q-+AD4-rpm+AF8-owner +AD0APQ- NULL +AHwAfA- q-+AD4-rpm+AF8-owner +AD0A=
PQ- current,
+-			spin+AF8-unlock(+ACY-q-+AD4-rpm+AF8-lock), spin+AF8-lock(+ACY-q-+AD4-r=
pm+AF8-lock))+ADs-
+-	if (q-+AD4-rpm+AF8-owner +AD0APQ- NULL)
+-		q-+AD4-rpm+AF8-owner +AD0- current+ADs-
+-	q-+AD4-rpm+AF8-nesting+AF8-level+-+-+ADs-
+-	spin+AF8-unlock(+ACY-q-+AD4-rpm+AF8-lock)+ADs-
+-+AH0-

Bart.
