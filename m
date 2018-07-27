Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 3/5] block: Split blk_add_timer()
Date: Fri, 27 Jul 2018 16:31:42 +0000
Message-ID: <9214bcfcaafce03f0689763f4be1e3ece6757f68.camel@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
	 <20180727162042.13425-4-bart.vanassche@wdc.com>
	 <20180727162925.GA20829@localhost.localdomain>
In-Reply-To: <20180727162925.GA20829@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 10:29 -0600, Keith Busch wrote:
+AD4- On Fri, Jul 27, 2018 at 09:20:40AM -0700, Bart Van Assche wrote:
+AD4- +AD4- +-	if (+ACE-q-+AD4-mq+AF8-ops)
+AD4- +AD4- +-		list+AF8-add+AF8-tail(+ACY-req-+AD4-timeout+AF8-list, +ACY-=
req-+AD4-q-+AD4-timeout+AF8-list)+ADs-
+AD4-=20
+AD4- Do you really need these checks for +ACE-q-+AD4-mq+AF8-ops?

Hello Keith,

Have you noticed that patch 4/5 removes that check?

Thanks,

Bart.
