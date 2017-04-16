Subject: Re: [GIT PULL 00/19] LightNVM patches for 4.12.
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <38deae6f-7978-189d-b4b2-c37719ba807e@fb.com>
Date: Sun, 16 Apr 2017 14:37:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/15/2017 12:55 PM, Matias Bjørling wrote:
> Hi Jens,
> 
> With this merge window, we like to push pblk upstream. It is a new
> host-side translation layer that implements support for exposing
> Open-Channel SSDs as block devices.
> 
> We have described pblk in the LightNVM paper "LightNVM: The Linux
> Open-Channel SSD Subsystem" that was accepted at FAST 2017. The paper
> defines open-channel SSDs, the subsystem, pblk and has an evaluation as
> well. Over the past couple of kernel versions we have shipped the
> support patches for pblk, and we are now comfortable pushing the core of
> pblk upstream.
> 
> The core contains the logic to control data placement and I/O scheduling
> on open-channel SSDs. Including implementation of translation table
> management, GC, recovery, rate-limiting, and similar components. It
> assumes that the SSD is media-agnostic, and runs on both 1.2 and 2.0 of
> the Open-Channel SSD specification without modifications.
> 
> I want to point out two neat features of pblk. First, pblk can be
> instantiated multiple times on the same SSD, enabling I/O isolation
> between tenants, and makes it able to fulfill strict QoS requirements.
> We showed results from this at the NVMW '17 workshop this year, while
> presenting the "Multi-Tenant I/O Isolation with Open-Channel SSDs" talk.
> Second, now that a full host-side translation layer is implemented, one
> can begin to optimize its data placement and I/O scheduling algorithms
> to match user workloads. We have shown a couple of the benefits in the
> LightNVM paper, and we know of a couple of companies and universities
> that have begun making new algorithms.
> 
> In detail, this pull request contains:
> 
>  - The new host-side FTL pblk from Javier, and other contributors.
> 
>  - Add support to the "create" ioctl to force a target to be
>    re-initialized at using "factory" flag from Javier.
> 
>  - Fix various errors in LightNVM core from Javier and me.
> 
>  - An optimization from Neil Brown to skip error checking on mempool
>    allocations that can sleep.
> 
>  - A buffer overflow fix in nvme_nvm_identify from Scott Bauer.
> 
>  - Fix for bad block discovery handle error handling from Christophe
>    Jaillet.
> 
>  - Fixes from Dan Carpenter to pblk after it went into linux-next.
> 
> Please pull from the for-jens branch or apply the patches posted with
> this mail:
> 
>    https://github.com/OpenChannelSSD/linux.git for-jens

Applied for 4.12, thanks Matias.

-- 
Jens Axboe
