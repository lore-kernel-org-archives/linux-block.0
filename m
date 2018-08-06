Return-Path: <prvs=749b68ccf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4 05/10] block: Serialize queue freezing and
 blk_pre_runtime_suspend()
Date: Mon, 6 Aug 2018 14:19:56 +0000
Message-ID: <3644dbbe5e684ba2fb6988416cb4d71e6d719624.camel@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
	 <20180804000325.3610-6-bart.vanassche@wdc.com>
	 <CACVXFVPdK3VDW2sj3ozqO0H2-Kr3bDjLpbZ+BY8ZrzudUDgeiQ@mail.gmail.com>
In-Reply-To: 
 <CACVXFVPdK3VDW2sj3ozqO0H2-Kr3bDjLpbZ+BY8ZrzudUDgeiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2018-08-04 at 18:23 +-0800, Ming Lei wrote:
+AD4- From user view, it isn't reasonable to prevent runtime suspend from h=
appening
+AD4- during queue freeze. The period can be a bit long, and it should be o=
ne perfect
+AD4- opportunity to suspend device during the period since no any IO is po=
ssible.

Hello Ming,

I will look into reducing the scope of the code that is protected by
blk+AF8-pm+AF8-runtime+AF8-lock() / blk+AF8-pm+AF8-runtime+AF8-unlock() to =
the code in blk+AF8-freeze+AF8-queue+AF8-start()
under +ACI-if (freeze+AF8-depth +AD0APQ- 1)+ACI-.

Bart.
