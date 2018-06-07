Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>, "ming.lei@redhat.com"
 <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Manjunath M Bettegowda <manjumb@synopsys.com>,
 Prabu Thangamuthu <prabut@synopsys.com>,
 Tejas Joglekar <joglekar@synopsys.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <20180601081330.GA13067@infradead.org>
 <BD7FB879CC136E419544C8E2AE7B9C3020C566@IN01WEMBXA.internal.synopsys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <918609fa-8721-0ee1-801e-4c29b64ac9ae@kernel.dk>
Date: Wed, 6 Jun 2018 19:52:51 -0600
MIME-Version: 1.0
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C3020C566@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/6/18 1:35 AM, Ladvine D Almeida wrote:
> On Friday 01 June 2018 09:13 AM, Christoph Hellwig wrote:
>> On Mon, May 28, 2018 at 02:43:09PM +0100, Ladvine D Almeida wrote:
>>> This patch introduces new variable under bio structure to
>>> facilitate inline encryption. This variable is used to
>>> associate I/O requests to crypto information.
>> This seems to be missing a whole lot of context.  Where is the whole
>> series showing what you are trying to do?
>>
> Christoph,
> 
> The patches are generated in the below > manner, with a thought of
> sending separately to the MAINTAINERS responsible for each.

What both Christoph and I have said is that it's _impossible_ to review
changes when you don't know what is being built on top of it. The block
change, by itself, is utterly useless. The use case needs to be seen.
But apart from that, my comments on why it's doing it completely
backwards still apply, and I've outlined how you need to fix it. The
patch, in its current form, isn't going anywhere.

-- 
Jens Axboe
