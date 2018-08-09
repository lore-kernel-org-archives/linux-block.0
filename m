Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"osandov@fb.com" <osandov@fb.com>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v5 1/3] blkcg: Introduce blkg_root_lookup()
Date: Thu, 9 Aug 2018 20:17:06 +0000
Message-ID: <794ba3894d7099fa7a855d3eb4d51c30faecd248.camel@wdc.com>
References: <20180809145338.6160-1-bart.vanassche@wdc.com>
	 <20180809145338.6160-2-bart.vanassche@wdc.com>
	 <20180809195612.GE3978217@devbig004.ftw2.facebook.com>
In-Reply-To: <20180809195612.GE3978217@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-08-09 at 12:56 -0700, Tejun Heo wrote:
+AD4- Hello,
+AD4-=20
+AD4- On Thu, Aug 09, 2018 at 07:53:36AM -0700, Bart Van Assche wrote:
+AD4- +AD4- +-/+ACoAKg-
+AD4- +AD4- +- +ACo- blkg+AF8-lookup - look up blkg for the specified reque=
st queue
+AD4- +AD4- +- +ACo- +AEA-q: request+AF8-queue of interest
+AD4- +AD4- +- +ACo-
+AD4- +AD4- +- +ACo- Lookup blkg for +AEA-q at the root level. See also blk=
g+AF8-lookup().
+AD4- +AD4- +- +ACo-/
+AD4- +AD4- +-static inline struct blkcg+AF8-gq +ACo-blkg+AF8-root+AF8-look=
up(struct request+AF8-queue +ACo-q)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-	struct blkcg+AF8-gq +ACo-blkg+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-	rcu+AF8-read+AF8-lock()+ADs-
+AD4- +AD4- +-	blkg +AD0- blkg+AF8-lookup(+ACY-blkcg+AF8-root, q)+ADs-
+AD4- +AD4- +-	rcu+AF8-read+AF8-unlock()+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-	return blkg+ADs-
+AD4- +AD4- +-+AH0-
+AD4-=20
+AD4- So, root blkg is always available as long as the request+AF8-queue is
+AD4- alive.  Sth like the following would be simpler?
+AD4-=20
+AD4- static inline struct blkcg+AF8-gq +ACo-blk+AF8-queue+AF8-root+AF8-blk=
g(struct request+AF8-queue +ACo-q)
+AD4- +AHs-
+AD4- 	return q-+AD4-root+AF8-blkg+ADs-
+AD4- +AH0-

That would not only be simpler, it would also avoid that blk+AF8-queue+AF8-=
root+AF8-blkg()
returns NULL if bypass mode is enabled and the request queue is still assoc=
iated
with the block cgroup controller. How do you want to proceed with this chan=
ge?

Bart.
