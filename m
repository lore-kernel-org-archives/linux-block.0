Return-Path: <prvs=7457c2e9b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Date: Thu, 2 Aug 2018 17:08:55 +0000
Message-ID: <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
	 <20180731045805.GE15701@ming.t460p>
	 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
	 <20180731061616.GF15701@ming.t460p>
	 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
	 <20180801085841.GA27962@ming.t460p>
	 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
	 <20180802165831.GB8928@ming.t460p>
In-Reply-To: <20180802165831.GB8928@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-03 at 00:58 +-0800, Ming Lei wrote:
+AD4- And about the situations you mentioned, no any special as normal case=
s
+AD4- or thousands of LUNs. Just a batch of queues are waken up from one
+AD4- single wait queue(sbq+AF8-wait+AF8-state), and inside each wait queue=
, queues
+AD4- are handled actually in FIFO order.
+AD4-=20
+AD4- Or what is your expected ideal behaviour about fairness?

Hello Ming,

What I expect is if the number of LUNs is really large that all LUNs are tr=
eated
equally. Unless someone can set up a test that demonstrates that this is st=
ill
the case for commit 97889f9ac24f (+ACI-blk-mq: remove synchronize+AF8-rcu()=
 from
blk+AF8-mq+AF8-del+AF8-queue+AF8-tag+AF8-set()+ACI-), I will assume that th=
at commit breaks fairness.

Bart.
