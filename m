Return-Path: <prvs=736960120=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "roman.penyaev@profitbricks.com"
	<roman.penyaev@profitbricks.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"jack.wang.usish@gmail.com" <jack.wang.usish@gmail.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Avoid that a request queue stalls when restarting
 a shared hctx
Date: Tue, 24 Jul 2018 22:06:37 +0000
Message-ID: <58799f667bcd4a874770816febfdd0b89809d040.camel@wdc.com>
References: <20180723155038.22062-1-bart.vanassche@wdc.com>
	 <914fb260-5529-4e1b-8c38-7355cc298c3a@oracle.com>
In-Reply-To: <914fb260-5529-4e1b-8c38-7355cc298c3a@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-07-24 at 16:10 +-0800, jianchao.wang wrote:
+AD4- The blk+AF8-mq+AF8-hw+AF8-ctx structure is also per request+AF8-queue
+AD4- Please refer to blk+AF8-mq+AF8-init+AF8-allocated+AF8-queue -+AD4- bl=
k+AF8-mq+AF8-realloc+AF8-hw+AF8-ctxs

Hello Jianchao,

I think that Ming Lei's patch +ACI-blk-mq: remove synchronize+AF8-rcu() fro=
m
blk+AF8-mq+AF8-del+AF8-queue+AF8-tag+AF8-set()+ACI- makes Roman's patch sup=
erfluous. When I reposted
Roman's patch I had not yet noticed that Ming's patch is already in Jens'
tree. See also https://www.mail-archive.com/linux-block+AEA-vger.kernel.org=
/msg22956.html.

Bart.
