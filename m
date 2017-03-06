Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Johannes Thumshirn <jthumshirn@suse.de>, Minchan Kim
 <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
References: <20170306102335.9180-1-jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Hannes Reinecke <hare@suse.de>, yizhan@redhat.com,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <96ed9003-6299-b303-a901-d040a8cfe03f@fb.com>
Date: Mon, 6 Mar 2017 08:21:11 -0700
MIME-Version: 1.0
In-Reply-To: <20170306102335.9180-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/06/2017 03:23 AM, Johannes Thumshirn wrote:
> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> pages attached to the bio's bvec this results in a kernel panic because of
> array out of bounds accesses in zram_decompress_page().

Applied, thanks.

-- 
Jens Axboe
