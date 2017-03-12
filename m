Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <e7d7aaab-3a32-61f6-44dd-3680d7f0c8db@kernel.dk>
References: <20170306200319.GF19696@htj.duckdns.org> <20170309080531.9048-1-tahsin@google.com>
 <bb97baf4-b08a-b909-1bff-7c933b95be4e@kernel.dk> <e7d7aaab-3a32-61f6-44dd-3680d7f0c8db@kernel.dk>
From: Tahsin Erdogan <tahsin@google.com>
Date: Sat, 11 Mar 2017 20:35:43 -0800
Message-ID: <CAAeU0aN6615BUP+ikqZeTm1=BSEN48uDu3Ucz8o9QrmETnkHSA@mail.gmail.com>
Subject: Re: [PATCH v5] blkcg: allocate struct blkcg_gq outside request queue spinlock
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sat, Mar 11, 2017 at 2:52 PM, Jens Axboe <axboe@kernel.dk> wrote:

>
> Talked to Tejun about this as well, and we both agree that the splitting
> this into separate init/alloc paths would be much cleaner. I can't
> apply the current patch, sorry, it's just too ugly to live.

Do you mean, you prefer the approach that was taken in v1 patch or
something else?
