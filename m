Subject: Re: [GIT PULL 00/10] lightnvm updates for 4.19
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com, javier@cnexlabs.com,
 hlitz@ucsc.edu, igor.j.konopko@intel.com, marcin.dziegielewski@intel.com
References: <20180713084845.19511-1-mb@lightnvm.io>
From: Jens Axboe <axboe@fb.com>
Message-ID: <04ed78d5-1911-be77-a671-3696b12c8656@fb.com>
Date: Fri, 13 Jul 2018 08:15:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/13/18 2:48 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up the following patches for 4.19.
> 
>  - A couple of small fixes from Bart, Gustavo, Hans and me.
>  - Heiner has reworked the read path to issue reads in parallel on
>    partial reads.
>  - Marcin fixed up the case where a device does need a host-side
>    cache to provide reliability.
>  - I added device description to error messages in pblk,
>    moved the compile DEBUG option to be pblk only, and limited the
>    report chunk command size.

Applied, thanks Matias.

-- 
Jens Axboe
