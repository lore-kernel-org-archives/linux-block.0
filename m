Return-Path: <prvs=7457c2e9b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"matthew.hart@linaro.org" <matthew.hart@linaro.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "john.garry@huawei.com"
	<john.garry@huawei.com>, "hare@suse.com" <hare@suse.com>,
	"James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH V2 1/2] blk-mq: move blk_mq_request_started() into header
 file
Date: Thu, 2 Aug 2018 18:45:36 +0000
Message-ID: <7777b8256817f09aee22703d760ec3b0daf4fc6a.camel@wdc.com>
References: <20180802174937.15444-1-ming.lei@redhat.com>
	 <20180802174937.15444-2-ming.lei@redhat.com>
In-Reply-To: <20180802174937.15444-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-03 at 01:49 +-0800, Ming Lei wrote:
+AD4- Define it as static inline given it might be called in fast path.

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-
