Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
To: Stephen Bates <sbates@raithlin.com>, Omar Sandoval <osandov@osandov.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
 <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
 <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
 <D356CC80-F509-4427-B999-641636131E8D@raithlin.com>
 <ca5bec05-ba3c-55db-6f3d-ef0965a79737@kernel.dk>
 <0C2FFC52-512F-4031-8E6F-487FA651A31B@raithlin.com>
 <6214fe06-c636-c565-9b2c-fab7cf2e6d19@kernel.dk>
 <F8C6A572-C589-4FF9-8DB2-66D6CC045EA1@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <16225338-232a-ef39-0b9d-1281e0a66367@kernel.dk>
Date: Thu, 20 Apr 2017 15:42:56 -0600
MIME-Version: 1.0
In-Reply-To: <F8C6A572-C589-4FF9-8DB2-66D6CC045EA1@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 03:41 PM, Stephen  Bates wrote:
> 
>> Great thanks, pushed. I'll get this added for 4.11. Thanks for
>> the report!
> 
> I see you applied my v3 series to the for-4.12/block branch. There is
> one issue there I need to fix. Can I send you a v4 a bit later today
> instead?

You can, but it won't do much good since v3 is already applied. Any
further changes must be incremental.

-- 
Jens Axboe
