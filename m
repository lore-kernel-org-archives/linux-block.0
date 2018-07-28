Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] pktcdvd: Fix possible Spectre-v1 for pkt_devs
To: Jinbum Park <jinb.park7@gmail.com>, bart.vanassche@wdc.com,
 jiufei.xue@linux.alibaba.com, gustavo@embeddedor.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728042044.GA3571@pjb1027-Latitude-E5410>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bf58dfc7-3a76-3011-f575-0d43a8ff932b@kernel.dk>
Date: Sat, 28 Jul 2018 09:08:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180728042044.GA3571@pjb1027-Latitude-E5410>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/27/18 10:20 PM, Jinbum Park wrote:
> User controls @dev_minor which to be used as index of pkt_devs.
> So, It can be exploited via Spectre-like attack. (speculative execution)
> 
> This kind of attack leaks address of pkt_devs, [1]
> It leads an attacker to bypass security mechanism such as KASLR.
> 
> So sanitize @dev_minor before using it to prevent attack.
> 
> [1] https://github.com/jinb-park/linux-exploit/
> tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Applied for 4.19, thanks.

-- 
Jens Axboe
