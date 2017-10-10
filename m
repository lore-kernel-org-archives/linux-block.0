Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 2/3] block: set request_list for request
To: Shaohua Li <shli@kernel.org>, linux-block@vger.kernel.org
Cc: vgoyal@redhat.com, tj@kernel.org, Kernel-team@fb.com,
 Shaohua Li <shli@fb.com>
References: <cover.1507337347.git.shli@fb.com>
 <39caee250aa6d115c0505d629a76281b84369f8e.1507337347.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d10296ba-669c-2272-678e-9f4d982a9a3b@kernel.dk>
Date: Tue, 10 Oct 2017 13:47:55 -0600
MIME-Version: 1.0
In-Reply-To: <39caee250aa6d115c0505d629a76281b84369f8e.1507337347.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/06/2017 06:56 PM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Legacy queue sets request's request_list, mq doesn't. This makes mq does
> the same thing, so we can find cgroup of a request. Note, we really
> only use blkg field of request_list, it's pointless to allocate mempool
> for request_list in mq case.

Looks OK to me.

-- 
Jens Axboe
