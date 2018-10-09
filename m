Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 0/2] blk-mq: two fixes about updating hw queues
To: axboe@kernel.dk
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0bc3c8a1-484b-5fe5-a8af-17d09b0458fa@oracle.com>
Date: Tue, 9 Oct 2018 09:41:49 +0800
MIME-Version: 1.0
In-Reply-To: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Would anyone please take a look at this patch ?

Thanks in advance
Jianchao

On 09/27/2018 06:43 PM, Jianchao Wang wrote:
> Hi Jens
> 
> This patch set fixes two defects during update hw queues.
> 
> 1st patch refactor the blk-mq debugfs and sysfs register during
> blk_mq_update_nr_hw_queues.
> 
> 2nd patch should be able to fix the panic reported in follwing link
> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D153799465603723-26w-3D2&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=JoGIFiPF4RF8WH8rquW8Qswr2FYvPOVaTxlgmjKHsDk&s=TQn_KiIX2sfmXP_9IYy2IFFRxBj4jBKVaSSU-I1z9g8&e=
> 
> Jianchao Wang (2)
> blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
> blk-mq: fallback to previous nr_hw_queues when updating fails
> 
> block/blk-mq.c | 79 ++++++++++++++++++++++++++++++++++------------------------
> 1 file changed, 47 insertions(+), 32 deletions(-)
> 
> Thanks
> Jianchao
> 
