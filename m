Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] (xen) stable/for-jens-4.20
To: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
References: <20181022193132.GB20677@dhcp-10-175-29-12.vpn.oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c5cb854-12fd-159c-12b5-afbefc4bd131@kernel.dk>
Date: Mon, 22 Oct 2018 15:52:33 -0600
MIME-Version: 1.0
In-Reply-To: <20181022193132.GB20677@dhcp-10-175-29-12.vpn.oracle.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 10/22/18 1:31 PM, Konrad Rzeszutek Wilk wrote:
> 
> Hi Jens,
> 
> Please git pull the following branch:
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.20
> 
> which has exactly one tiny patch fixing an NULL pointer issue (also has stable tree CCed).
> 
> Thank you!
> 
> drivers/block/xen-blkfront.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> Vasilis Liaskovitis (2):
>       xen/blkfront: avoid NULL blkfront_info dereference on device removal

Pulled, thanks.

-- 
Jens Axboe
