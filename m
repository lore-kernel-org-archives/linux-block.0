Return-Path: <lvivier@redhat.com>
Subject: Re: [PATCH v2 02/11] swim: convert to blk-mq
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, kernel-team@fb.com,
 Finn Thain <fthain@telegraphics.com.au>
References: <cover.1539284959.git.osandov@fb.com>
 <93deb9240babdba64c4a7e2fd8b8b0d3b2bdcbdc.1539284959.git.osandov@fb.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0bc045a5-99b7-f744-c084-84fb0df6406a@redhat.com>
Date: Mon, 15 Oct 2018 18:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <93deb9240babdba64c4a7e2fd8b8b0d3b2bdcbdc.1539284959.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2018 21:20, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The only interesting thing here is that there may be two floppies (i.e.,
> request queues) sharing the same controller, so we use the global struct
> swim_priv->lock to check whether the controller is busy. Compile-tested
> only.
> 
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/swim.c | 101 +++++++++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 52 deletions(-)
> 

Acked-by: Laurent Vivier <lvivier@redhat.com>
