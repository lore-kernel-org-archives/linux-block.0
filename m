Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Add should_fail_bio() for bpf error injection
To: Howard McLauchlan <hmclauchlan@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@osandov.com>,
 Josef Bacik <jbacik@fb.com>
References: <20180206211108.3236-1-hmclauchlan@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2ad8a90d-d3c1-be0d-0f60-b365286b13b3@kernel.dk>
Date: Tue, 6 Feb 2018 14:15:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180206211108.3236-1-hmclauchlan@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/6/18 2:11 PM, Howard McLauchlan wrote:
> The classic error injection mechanism, should_fail_request() does not
> support use cases where more information is required (from the entire
> struct bio, for example).
> 
> To that end, this patch introduces should_fail_bio(), which calls
> should_fail_request() under the hood but provides a convenient
> place for kprobes to hook into if they require the entire struct bio.
> This patch also replaces some existing calls to should_fail_request()
> with should_fail_bio() with no degradation in performance.

It fails:

block/blk-core.c:2091:1: warning: data definition has no type or storage class
 BPF_ALLOW_ERROR_INJECTION(should_fail_bio);
 ^~~~~~~~~~~~~~~~~~~~~~~~~
block/blk-core.c:2091:1: error: type defaults to ‘int’ in declaration of ‘BPF_ALLOW_ERROR_INJECTION’ [-Werror=implicit-int]
block/blk-core.c:2091:1: warning: parameter names (without types) in function declaration
cc1: some warnings being treated as errors

-- 
Jens Axboe
