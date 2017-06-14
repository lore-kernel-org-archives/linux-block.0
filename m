Return-Path: <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v2 1/6] block: Avoid that blk_exit_rl() triggers a
 use-after-free
To: Jens Axboe <axboe@kernel.dk>, Ross Zwisler <zwisler@gmail.com>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jan Kara
	<jack@suse.cz>, <stable@vger.kernel.org>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
 <20170531214350.31157-2-bart.vanassche@sandisk.com>
 <CAOxpaSVwuO6kRQN4aNELVTzfWbJORUNZh=E5xBRgvuC0wajptA@mail.gmail.com>
 <3eef2937-86bc-958a-99b5-96a67836d3d3@sandisk.com>
 <c098cc8e-a029-28f3-c8ae-665959ea115b@kernel.dk>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <ae89b8b7-64b0-029b-434e-cbf4403f169f@wdc.com>
Date: Wed, 14 Jun 2017 12:32:54 -0700
MIME-Version: 1.0
In-Reply-To: <c098cc8e-a029-28f3-c8ae-665959ea115b@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 06/14/17 12:28, Jens Axboe wrote:
> I added this, but the above is really a horrible changelog. It doesn't
> say how the problem is fixed. I added some verbiage to that effect.

Hello Jens,

Thanks for having fixed up the changelog and for already having picked
up this patch. I was going to repost the patch and write a proper
changelog but apparently you were faster than I :-)

BTW, since last night I can finally receive and send e-mails with a
@wdc.com suffix (thirteen months after the acquisition closed).

Bart.
