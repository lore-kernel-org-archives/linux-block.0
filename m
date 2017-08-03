Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] blk-mq: enable checking two part inflight counts at
 the same time
Date: Thu, 3 Aug 2017 22:30:12 +0000
Message-ID: <1501799411.2922.28.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-5-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
> We only need to iterate the queues and tags once, we if just pass

Hello Jens,

Regarding the patch description: it seems to me like in the text "we if" th=
ese
two words appear in the wrong order?

Bart.=
