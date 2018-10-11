Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 12/13] floppy: end whole request on error
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <cover.1539282366.git.osandov@fb.com>
 <4b575ac74fab6d233b891f8c12dadaea3873931c.1539282366.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d1caacaf-56df-a466-cf97-5be4f5f4b45c@kernel.dk>
Date: Thu, 11 Oct 2018 12:39:51 -0600
MIME-Version: 1.0
In-Reply-To: <4b575ac74fab6d233b891f8c12dadaea3873931c.1539282366.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/11/18 12:30 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> If floppy_end_request() gets passed an error, it should end the whole
> request, not just the current segment.

I don't think this is correct, we should still just end the
individual chunks.

-- 
Jens Axboe
