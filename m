Return-Path: <prvs=7568bcc2f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v6 08/12] block, scsi: Introduce blk_pm_runtime_exit()
Date: Mon, 13 Aug 2018 16:09:09 +0000
Message-ID: <b28b6fbbacb1d6f06dc80f3dfb98548cdf0e7382.camel@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
	 <20180809194149.15285-9-bart.vanassche@wdc.com>
	 <be4d4011-efba-c866-e9a8-c14743eb0a1a@oracle.com>
	 <e993bdc480ccffc4922463fef7102b0cb2e542fd.camel@wdc.com>
	 <01569014d645b6561a7c1da0f20d08b41a8a213a.camel@wdc.com>
	 <04e102b0-909f-7a25-16ca-ab153188f8f8@oracle.com>
In-Reply-To: <04e102b0-909f-7a25-16ca-ab153188f8f8@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-08-13 at 17:24 +-0800, jianchao.wang wrote:
+AD4- I'm afraid this will not work.

Since this patch fixes a bug that nobody has reported so far and since no
later patches rely on this patch, I will leave it out.

Thanks,

Bart.
