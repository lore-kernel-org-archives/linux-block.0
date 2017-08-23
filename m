Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "loop: support 4k physical blocksize"
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
 Milan Broz <gmazyland@gmail.com>
References: <7e96dfd9a867e2dc16e472f8623c67fad399f6af.1503525187.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ab75358c-dec4-7559-8449-e772b9ac9bab@kernel.dk>
Date: Wed, 23 Aug 2017 15:59:39 -0600
MIME-Version: 1.0
In-Reply-To: <7e96dfd9a867e2dc16e472f8623c67fad399f6af.1503525187.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/23/2017 03:54 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There's some stuff still up in the air, let's not get stuck with a
> subpar ABI. I'll follow up with something better for 4.14.

I think that's a good idea, there was already too much late churn
fixing up the 4k support. Dropped the fixups, added this.

-- 
Jens Axboe
