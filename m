Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703261252310.2204@hadrien>
References: <alpine.DEB.2.20.1703261252310.2204@hadrien>
From: Tahsin Erdogan <tahsin@google.com>
Date: Mon, 27 Mar 2017 11:29:18 -0700
Message-ID: <CAAeU0aMQwEQ=URKGaJHxNb81w3BfAysNJkmgmo_+cXVLCrbAxw@mail.gmail.com>
Subject: Re: [PATCH] blkcg: allocate struct blkcg_gq outside request queue spinlock
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sun, Mar 26, 2017 at 3:54 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Is an unlock needed before line 848?  Or does blkg_lookup_check take care
> of it?

Unlock is not needed. On success, function returns with locks held.
It is documented at line 805:

"... This function returns with RCU read
 * lock and queue lock held and must be paired with blkg_conf_finish()."
