Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] blk-mq: provide internal in-flight variant
Date: Thu, 3 Aug 2017 20:54:10 +0000
Message-ID: <1501793646.2922.22.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-4-git-send-email-axboe@kernel.dk>
	 <1501792912.2922.18.camel@wdc.com>
	 <5fcb20ac-8744-4080-c5a2-d6dad771ee97@kernel.dk>
In-Reply-To: <5fcb20ac-8744-4080-c5a2-d6dad771ee97@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:45 -0600, Jens Axboe wrote:
> The inc/dec goes away for mq, the non-mq path still has to use them. I ju=
st
> move them as well. Could be a prep patch, but it's just moving the code o=
ut
> of the header and into a normal C file instead.

Hello Jens,

I misread that part of the patch. Now I have had another look these changes
look fine to me. Hence:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>=
