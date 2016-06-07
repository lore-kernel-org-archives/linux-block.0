Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Missing bio_put following submit_bio_wait
To: Shaun Tancheff <shaun@tancheff.com>, linux-block@vger.kernel.org
References: <1465316612-9649-1-git-send-email-shaun@tancheff.com>
 <1465317133-13266-1-git-send-email-shaun@tancheff.com>
Cc: Christoph Hellwig <hch@lst.de>, David Drysdale <drysdale@google.com>,
 Xiong Zhou <xzhou@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next@vger.kernel.org, linux-nvdimm@ml01.01.org,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
 bart.vanassche@sandisk.com, Shaun Tancheff <shaun.tancheff@seagate.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5756FACF.8030202@kernel.dk>
Date: Tue, 7 Jun 2016 10:48:15 -0600
MIME-Version: 1.0
In-Reply-To: <1465317133-13266-1-git-send-email-shaun@tancheff.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/07/2016 10:32 AM, Shaun Tancheff wrote:
> submit_bio_wait() gives the caller an opportunity to examine
> struct bio and so expects the caller to issue the put_bio()
>
> This fixes a memory leak reported by a few people in 4.7-rc2
> kmemleak report after 9082e87bfbf8 ("block: remove struct bio_batch")
>
> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Larry Finger@lwfinger.net
> Tested-by: David Drysdale <drysdale@google.com>

Thanks, applied.

-- 
Jens Axboe
