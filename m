Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: bsg: move atomic_t ref_count variable to refcount
 API
To: John Pittman <jpittman@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20180827183305.27722-1-jpittman@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <98fb97d4-d098-e3a2-ff5e-4b8244d07610@kernel.dk>
Date: Mon, 27 Aug 2018 19:17:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180827183305.27722-1-jpittman@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/27/18 12:33 PM, John Pittman wrote:
> Currently, variable ref_count within the bsg_device struct is of
> type atomic_t.  For variables being used as reference counters,
> the refcount API should be used instead of atomic.  The newer
> refcount API works to prevent counter overflows and use-after-free
> bugs.  So, move this varable from the atomic API to refcount,
> potentially avoiding the issues mentioned.

Applied, thanks.

-- 
Jens Axboe
