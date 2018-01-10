Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: silently forbid sending any ioctl to a
 partition
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: hch@infradead.org
References: <20180110155452.26563-1-pbonzini@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7c7b840c-8df2-bbf9-cf43-e973971609a6@kernel.dk>
Date: Wed, 10 Jan 2018 12:30:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180110155452.26563-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 8:54 AM, Paolo Bonzini wrote:
> After the first few months, the message has not led to many bug reports.
> It's been almost five years now, and in practice the main source of
> it seems to be MTIOCGET that someone is using to detect tape devices.
> While we could whitelist it just like CDROM_GET_CAPABILITY, this patch
> just removes the message altogether.
> 
> The patch also removes the "safe but not very useful" ioctl whitelist,
> as suggested by Christoph.  I doubt anything is using most of those
> ioctls _in general_, let alone on a partition.

Applied, thanks.

-- 
Jens Axboe
