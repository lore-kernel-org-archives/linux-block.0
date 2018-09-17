Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
To: javier@javigon.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5d12e1ca-546d-7909-a8ce-b16ab4596041@lightnvm.io>
Date: Mon, 17 Sep 2018 10:11:02 +0200
MIME-Version: 1.0
In-Reply-To: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/11/2018 01:24 PM, Javier González wrote:
> # Changes since V4:
>   - Rebase on top of Matias' core
>   - Reorder patches to avoid in-patchset changes
> 
> # Changes since V3:
>   - Encapsulate rqd dma allocations to reduce code replication (by Matias)
> 
> # Changes since V2:
>   - Split the original patch between the metadata refactoring and the
>     semaphore logic. This simplifies the write path, where the semaphore
>     is taken.
> 
> # Changes singe V1:
>      - Fix double I/O on the read path (by Matias)
>      - Improve commit message (by Jens)
> 
> This patchset refactors the metadata separate write and read paths,
> which simplifies how the semaphore is taken for writes.
> 
> Thanks,
> Javier
> 
> Javier González (3):
>    lightnvm: encapsule rqd dma allocations
>    lightnvm: pblk: refactor metadata paths
>    lightnvm: pblk: take write semaphore on metadata
> 
>   drivers/lightnvm/pblk-core.c     | 376 ++++++++++++++++++++-------------------
>   drivers/lightnvm/pblk-gc.c       |   2 +-
>   drivers/lightnvm/pblk-read.c     |  31 ++--
>   drivers/lightnvm/pblk-recovery.c |  34 ++--
>   drivers/lightnvm/pblk-write.c    |  15 +-
>   drivers/lightnvm/pblk.h          |   7 +-
>   6 files changed, 222 insertions(+), 243 deletions(-)
> 

Thanks. Applied for 4.20. I've renamed the first patch to "lightnvm: 
pblk: encapsulate rqd dma allocations".
