Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove unnecessary NULL checks in
 bioset_integrity_free()
To: Tim Hansen <devtimhansen@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexander.levin@one.verizon.com
References: <20171005180920.GA121296@debian>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a1d52c34-6d06-1142-0d3e-2604e15ed993@kernel.dk>
Date: Fri, 6 Oct 2017 13:04:25 -0600
MIME-Version: 1.0
In-Reply-To: <20171005180920.GA121296@debian>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/05/2017 12:09 PM, Tim Hansen wrote:
> mempool_destroy() already checks for a NULL value being passed in, this eliminates duplicate checks.
> 
> This was caught by running make coccicheck M=block/ on linus' tree on commit 77ede3a014a32746002f7889211f0cecf4803163 (current head as of this patch).

Applied, but I had to fix up your commit message. Please line wrap at
72 chars, otherwise it turns into an unreadable mess when people
try to view them.

-- 
Jens Axboe
