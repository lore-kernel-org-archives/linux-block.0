Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: Add should_fail_bio() for bpf error injection
To: Howard McLauchlan <hmclauchlan@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@osandov.com>,
 Josef Bacik <jbacik@fb.com>
References: <20180206220539.30413-1-hmclauchlan@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2a573a6e-e7c8-a7af-6826-04442d243d33@kernel.dk>
Date: Tue, 6 Feb 2018 15:14:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180206220539.30413-1-hmclauchlan@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/6/18 3:05 PM, Howard McLauchlan wrote:
> The classic error injection mechanism, should_fail_request() does not
> support use cases where more information is required (from the entire
> struct bio, for example).
> 
> To that end, this patch introduces should_fail_bio(), which calls
> should_fail_request() under the hood but provides a convenient
> place for kprobes to hook into if they require the entire struct bio.
> This patch also replaces some existing calls to should_fail_request()
> with should_fail_bio() with no degradation in performance.

This seems better, applied, thanks.

-- 
Jens Axboe
