Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: constify struct blk_integrity_profile
To: Eric Biggers <ebiggers3@gmail.com>, linux-block@vger.kernel.org
References: <20170325010348.74421-1-ebiggers3@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d2047e25-0c33-2153-1c54-c862f9a235fc@kernel.dk>
Date: Fri, 24 Mar 2017 20:35:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170325010348.74421-1-ebiggers3@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/24/2017 07:03 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> blk_integrity_profile's are never modified, so mark them 'const' so that
> they are placed in .rodata and benefit from memory protection.

Thanks, that's a nice change. Applied for 4.12.

-- 
Jens Axboe
