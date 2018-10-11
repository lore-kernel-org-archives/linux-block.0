Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 11 Oct 2018 11:57:16 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/13] floppy: end whole request on error
Message-ID: <20181011185716.GA15691@vader>
References: <cover.1539282366.git.osandov@fb.com>
 <4b575ac74fab6d233b891f8c12dadaea3873931c.1539282366.git.osandov@fb.com>
 <d1caacaf-56df-a466-cf97-5be4f5f4b45c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d1caacaf-56df-a466-cf97-5be4f5f4b45c@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 11, 2018 at 12:39:51PM -0600, Jens Axboe wrote:
> On 10/11/18 12:30 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > If floppy_end_request() gets passed an error, it should end the whole
> > request, not just the current segment.
> 
> I don't think this is correct, we should still just end the
> individual chunks.

Yup, I'll drop this and the swim3 equivalent, thanks.
