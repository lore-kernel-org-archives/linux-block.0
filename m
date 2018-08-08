Return-Path: <prvs=75172a298=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "tj@kernel.org" <tj@kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v4 2/2] block: Ensure that a request queue is dissociated
 from the cgroup controller
Date: Wed, 8 Aug 2018 15:04:27 +0000
Message-ID: <7dacc4f78f7d4379e1f561afe526fbe23405fe6e.camel@wdc.com>
References: <20180730211056.18570-1-bart.vanassche@wdc.com>
	 <20180730211056.18570-3-bart.vanassche@wdc.com>
	 <d04d4403-8b56-27c6-8601-56b5a45da936@kernel.dk>
In-Reply-To: <d04d4403-8b56-27c6-8601-56b5a45da936@kernel.dk>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 08:41 -0600, Jens Axboe wrote:
+AD4- On 7/30/18 3:10 PM, Bart Van Assche wrote:
+AD4- +AD4- +-+ACM-ifdef CONFIG+AF8-BLK+AF8-CGROUP
+AD4- +AD4- +-	+AHs-
+AD4- +AD4- +-		struct blkcg+AF8-gq +ACo-blkg+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-		rcu+AF8-read+AF8-lock()+ADs-
+AD4- +AD4- +-		blkg +AD0- blkg+AF8-lookup(+ACY-blkcg+AF8-root, q)+ADs-
+AD4- +AD4- +-		rcu+AF8-read+AF8-unlock()+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-		WARN(blkg,
+AD4- +AD4- +-		     +ACI-request queue +ACU-p is being released but it has=
 not yet been removed from the blkcg controller+AFw-n+ACI-,
+AD4- +AD4- +-		     q)+ADs-
+AD4- +AD4- +-	+AH0-
+AD4- +AD4- +-+ACM-endif
+AD4-=20
+AD4- This last hunk should go in the cgroup code.

Hello Jens,

How about leaving out the +ACM-ifdef CONFIG+AF8-BLK+AF8-CGROUP / +ACM-endif=
? Would that be
sufficient? I just noticed that blkg+AF8-lookup() returns NULL anyway if cg=
roup support
is disabled in the kernel config.

Thanks,

Bart.
