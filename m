Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] virtio_blk: fix panic in initialization error path
To: "Michael S. Tsirkin" <mst@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
 <20170110060937-mutt-send-email-mst@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 kernel-team@fb.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fd8cbf0-cca1-d38c-33b8-8b71a1e40457@kernel.dk>
Date: Mon, 9 Jan 2017 21:11:14 -0700
MIME-Version: 1.0
In-Reply-To: <20170110060937-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/09/2017 09:10 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 09, 2017 at 11:44:12AM -0800, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> If blk_mq_init_queue() returns an error, it gets assigned to
>> vblk->disk->queue. Then, when we call put_disk(), we end up calling
>> blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
>> only assigning to vblk->disk->queue on success.
>>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Jens, do you mind picking this one up as well, since
> you have one virtio-blk patch already?

No problem, in fact I already queued it up.

-- 
Jens Axboe
