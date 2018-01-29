Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/2] Return bytes transferred for partial direct I/O
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, axboe@kernel.dk,
 ak@linux.intel.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20180129145741.29486-1-rgoldwyn@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98449f4d-8ab7-15e6-d3dd-f547d58177e4@infradead.org>
Date: Mon, 29 Jan 2018 11:04:54 -0800
MIME-Version: 1.0
In-Reply-To: <20180129145741.29486-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/29/2018 06:57 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 

> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
> index 6c00c1e2743f..72e213d62511 100644
> --- a/Documentation/sysctl/fs.txt
> +++ b/Documentation/sysctl/fs.txt
> @@ -76,6 +77,19 @@ dcache isn't pruned yet.
>  
>  ==============================================================
>  
> +dio_short_writes:
> +
> +In case Direct I/O encounters an transient error, it returns

                                 a transient

> +the errorcode, even if it has performed part of the write.

       error code,

> +This flag, if on (default), will return the number of bytes written
> +so far, as the write(2) symantics are. However, some older applications

                           semantics

> +still consider a direct write as an error if all of the I/O
> +submitted is not complete. ie write(file, count, buf) != count.

                              I.e.

> +This option can be disabled on systems in order to support
> +existing applications which do not expect short writes.

and if my system has a mix of older applications and new ones,
will they all work just fine?


thanks,
-- 
~Randy
