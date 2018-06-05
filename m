Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: set discard_alignment to the granularity
To: Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, kernel-team@fb.com
References: <20180605154123.3226-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <809c000c-415b-9b93-dfe4-9af8cdec07a9@kernel.dk>
Date: Tue, 5 Jun 2018 09:51:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180605154123.3226-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/5/18 9:41 AM, Josef Bacik wrote:
> Technically we should be able to get away with 0 as the
> discard_alignment, but there's no way currently for the protocol to
> indicate different alignments, and in real life most disks have
> discard_alignment == discard_granularity.  Just set our alignment to our
> blocksize to make sure discards will actually work properly with 4k
> drives.

Applied, thanks.

-- 
Jens Axboe
