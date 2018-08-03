Return-Path: <prvs=746b4d33f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 8/9] blk-mq: Insert blk_pm_{add,put}_request() calls
Date: Fri, 3 Aug 2018 00:08:54 +0000
Message-ID: <51cfe7ab9e54013e278072e91b59b04432488dc7.camel@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
	 <20180802182944.14442-9-bart.vanassche@wdc.com>
	 <20180802235338.GB16047@ming.t460p>
In-Reply-To: <20180802235338.GB16047@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-03 at 07:53 +-0800, Ming Lei wrote:
+AD4- blk+AF8-pm+AF8-add+AF8-request() calls pm+AF8-request+AF8-resume() fo=
r waking up device, but
+AD4- it is wrong because it is async request, which can't guarantee device
+AD4- will be ready before calling .queue+AF8-rq().

That's a longstanding issue and not something that has been introduced by t=
his
patch series. Hence patch 6/9 that issues a warning if pm+AF8-request+AF8-r=
esume() would
be called.

Bart.
