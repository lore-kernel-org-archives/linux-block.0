Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/bio: Remove null checks before mempool_destroy in
 bioset_free
To: Tim Hansen <devtimhansen@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexander.levin@one.verizon.com
References: <20171006184513.GA78611@debian>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c40daeba-d490-3190-efa6-a534da96d1db@kernel.dk>
Date: Fri, 6 Oct 2017 13:05:01 -0600
MIME-Version: 1.0
In-Reply-To: <20171006184513.GA78611@debian>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/06/2017 12:45 PM, Tim Hansen wrote:
> This patch removes redundant checks for null values on bio_pool and bvec_pool.
> 
> Found using make coccicheck M=block/ on linux-net tree on the next-20170929 tag.
> 
> Related to patch 9987695 that removed similar checks in bio-integrity. 

Applied, but ditto on the line length. Additionally, I killed that reference
to "patch 9987695", I don't know what that means? What does that refer to?

-- 
Jens Axboe
