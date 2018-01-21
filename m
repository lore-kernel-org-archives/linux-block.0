Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Andi Kleen <ak@linux.intel.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
References: <20180119005741.32058-1-rgoldwyn@suse.de>
Date: Sat, 20 Jan 2018 18:11:08 -0800
In-Reply-To: <20180119005741.32058-1-rgoldwyn@suse.de> (Goldwyn Rodrigues's
        message of "Thu, 18 Jan 2018 18:57:40 -0600")
Message-ID: <87zi58rmf7.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Goldwyn Rodrigues <rgoldwyn@suse.de> writes:

> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> In case direct I/O encounters an error midway, it returns the error.
> Instead it should be returning the number of bytes transferred so far.

It's likely there's a lot of code in user space that does

     if (write(..., N) < 0) handle error

With your change it would need to be

     if (write(..., N) != N) handle error

How much code is actually doing that?

I can understand it fixes your artifical test suite, but it seems to me your
change has a high potential to break a lot of existing user code
in subtle ways. So it seems to be a bad idea.

-Andi
