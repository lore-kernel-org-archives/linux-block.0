Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH V2] lightnvm: pblk: take write semaphore on metadata
To: javier@javigon.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1533303011-2855-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <17e4f9c3-856a-9e7b-8d36-e93ebc7dbf0b@lightnvm.io>
Date: Sat, 4 Aug 2018 20:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <1533303011-2855-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/03/2018 03:30 PM, Javier González wrote:
> # Changes singe V1:
>    - Fix double I/O on the read path (by Matias)
>    - Improve commit message (by Jens)
> 
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
> 
> Since metadata I/O is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
> 
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metdatada scheme could cause
> ordering issues.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 18 ++++++++++++++++--
>   drivers/lightnvm/pblk.h      |  1 +
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..6432faf5b19c 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>   	return nvm_submit_io_sync(dev, rqd);
>   }
>   
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)

Nitpicking a bit. It looks to me that a function that has semaphore in 
its name, should take the semaphore in all cases unless it returns an 
error. When it only does it on writes, it creates confusion.

Maybe this would be one of the cases where it is okay to have the logic 
it in the caller function, or do such that it takes a flag if it should 
take the semaphore. That'll make it explicit when it is done.
