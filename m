Return-Path: <prvs=749b68ccf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 4/9] percpu-refcount: Introduce percpu_ref_read()
Date: Mon, 6 Aug 2018 17:28:52 +0000
Message-ID: <32574ddb03c47a273deac07e2b4f200626ed1f27.camel@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
	 <20180802182944.14442-5-bart.vanassche@wdc.com>
	 <20180802190649.GV1206094@devbig004.ftw2.facebook.com>
	 <aa524e89-6626-ed22-ff46-25674354ba58@wdc.com>
	 <20180806171812.GB410235@devbig004.ftw2.facebook.com>
In-Reply-To: <20180806171812.GB410235@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-08-06 at 10:18 -0700, Tejun Heo wrote:
+AD4- I'm worried that this is too inviting for misuses and subtle problems=
.
+AD4- For example, your patch which uses this function uses
+AD4- synchronize+AF8-rcu() to synchronize against per-cpu counts after the
+AD4- first snoop+ADs- however, percpu+AF8-ref uses sched rcu, not the regu=
lar one,
+AD4- so depending on the config, this will lead to +ACo-really+ACo- subtle
+AD4- failures.  Even if that gets fixed, it's still leaking percpu-ref
+AD4- internal details to its users - details which may change in the futur=
e
+AD4- and will cause super subtle bugs.
+AD4-=20
+AD4- I'd go for something a lot more specific, like percpu+AF8-ref+AF8-is+=
AF8-one(), so
+AD4- that all the magics can be contained in percpu-ref implementation
+AD4- proper.

Hello Tejun,

I will try to come up with an approach that does not require to modify the
per-cpu counter code.

Thanks,

Bart.
