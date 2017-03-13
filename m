Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <c514c076-18ea-8605-d439-e46730aa29e0@kernel.dk>
References: <20170306200319.GF19696@htj.duckdns.org> <20170309080531.9048-1-tahsin@google.com>
 <bb97baf4-b08a-b909-1bff-7c933b95be4e@kernel.dk> <e7d7aaab-3a32-61f6-44dd-3680d7f0c8db@kernel.dk>
 <CAAeU0aN6615BUP+ikqZeTm1=BSEN48uDu3Ucz8o9QrmETnkHSA@mail.gmail.com> <c514c076-18ea-8605-d439-e46730aa29e0@kernel.dk>
From: Tahsin Erdogan <tahsin@google.com>
Date: Mon, 13 Mar 2017 09:17:56 -0700
Message-ID: <CAAeU0aMvuzfkAyhzheYRxfb7NzLk2oJSzUk5+BoVcktrZDtcRw@mail.gmail.com>
Subject: Re: [PATCH v5] blkcg: allocate struct blkcg_gq outside request queue spinlock
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

>> Do you mean, you prefer the approach that was taken in v1 patch or
>> something else?
>
> I can no longer find v1 of the patch, just v2 and on. Can you send a
> link to it?

https://lkml.org/lkml/2017/2/28/8
