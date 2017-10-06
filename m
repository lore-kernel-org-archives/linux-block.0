Return-Path: <devtimhansen@gmail.com>
Return-Path: <devtimhansen@gmail.com>
Date: Fri, 6 Oct 2017 18:26:57 -0400
From: Tim Hansen <devtimhansen@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.levin@one.verizon.com
Subject: Re: [PATCH] block: remove unnecessary NULL checks in
 bioset_integrity_free()
Message-ID: <20171006222629.GA30627@debian>
References: <20171005180920.GA121296@debian>
 <a1d52c34-6d06-1142-0d3e-2604e15ed993@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1d52c34-6d06-1142-0d3e-2604e15ed993@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 06, 2017 at 01:04:25PM -0600, Jens Axboe wrote:
> On 10/05/2017 12:09 PM, Tim Hansen wrote:
> > mempool_destroy() already checks for a NULL value being passed in, this eliminates duplicate checks.
> > 
> > This was caught by running make coccicheck M=block/ on linus' tree on commit 77ede3a014a32746002f7889211f0cecf4803163 (current head as of this patch).
> 
> Applied, but I had to fix up your commit message. Please line wrap at
> 72 chars, otherwise it turns into an unreadable mess when people
> try to view them.
> 
> -- 
> Jens Axboe
> 

Noted! Thanks for the heads up on the char limit.
