Return-Path: <prvs=7457c2e9b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Date: Thu, 2 Aug 2018 17:24:15 +0000
Message-ID: <4868e0b82ac6e87aede7fc52da67d3a7913d680b.camel@wdc.com>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
	 <20180731045805.GE15701@ming.t460p>
	 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
	 <20180731061616.GF15701@ming.t460p>
	 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
	 <20180801085841.GA27962@ming.t460p>
	 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
	 <20180802165831.GB8928@ming.t460p>
	 <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
	 <20180802171723.GD8928@ming.t460p>
In-Reply-To: <20180802171723.GD8928@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-03 at 01:17 +-0800, Ming Lei wrote:
+AD4- Not mentioning big CPU utilization is consumed unnecessarily for iter=
ating
+AD4- over all queues even though there is only one active queue, is this f=
air from
+AD4- system view?

I hope that someone will come up some day with a better solution than the
list+AF8-for+AF8-each+AF8-entry+AF8-rcu+AF8-rr() loop. But as long as such =
a solution has not yet
been found that loop should stay in order to preserve fair handling of larg=
e
numbers of LUNs.

Bart.
