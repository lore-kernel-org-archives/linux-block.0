Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL v3 00/10] lightnvm updates for 4.18
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 javier@cnexlabs.com, igor.j.konopko@intel.com, marcin.dziegielewski@intel.com
References: <20180601144114.17490-1-mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <166defee-d9a7-dcec-8c77-b7e9d4e0d78e@kernel.dk>
Date: Fri, 1 Jun 2018 09:03:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/1/18 8:41 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up the following patches.
> 
> Changes since v2:
> 
>  Rebased write error recovery patch on top of latest
>  for-4.18/block
> 
>  Added (missed the first round)
>   lightnvm: pblk: only try to recover lines with written smeta
>   lightnvm: pblk: kick writer on new flush points
>   lightnvm: pblk: take bitmap alloc. out of critical section
> 
> Changes since v1:
> 
>  Removed
>   lightnvm: pblk: sync RB and RL states during GC
>   lightnvm: error handling when whole line is bad
>   lightnvm: pblk: handle case when mw_cunits equals to 0
> 
>  Added
>   lightnvm: pblk: remove unnecessary bio_get/put
> 
> Thanks!
> 
> Hans Holmberg (5):
>   lightnvm: pblk: rework write error recovery path
>   lightnvm: pblk: garbage collect lines with failed writes
>   lightnvm: pblk: fix smeta write error path
>   lightnvm: pblk: only try to recover lines with written smeta
>   lightnvm: pblk: kick writer on new flush points
> 
> Igor Konopko (2):
>   lightnvm: proper error handling for pblk_bio_add_pages
>   lightnvm: fix partial read error path
> 
> Javier González (2):
>   lightnvm: pblk: remove unnecessary bio_get/put
>   lightnvm: pblk: take bitmap alloc. out of critical section
> 
> Marcin Dziegielewski (1):
>   lightnvm: pblk: add possibility to set write buffer size manually
> 
>  drivers/lightnvm/pblk-cache.c    |  10 +-
>  drivers/lightnvm/pblk-core.c     | 157 +++++++++++++++-------
>  drivers/lightnvm/pblk-gc.c       | 102 ++++++++------
>  drivers/lightnvm/pblk-init.c     |  62 ++++++---
>  drivers/lightnvm/pblk-rb.c       |  43 +-----
>  drivers/lightnvm/pblk-read.c     |  69 +++++-----
>  drivers/lightnvm/pblk-recovery.c | 121 +++--------------
>  drivers/lightnvm/pblk-rl.c       |  29 +++-
>  drivers/lightnvm/pblk-sysfs.c    |  15 ++-
>  drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
>  drivers/lightnvm/pblk.h          |  37 ++++--
>  11 files changed, 524 insertions(+), 402 deletions(-)

Applied, thanks.

-- 
Jens Axboe
