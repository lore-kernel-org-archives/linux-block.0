Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1509898908-7175-1-git-send-email-axboe@kernel.dk>
References: <1509898908-7175-1-git-send-email-axboe@kernel.dk>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 6 Nov 2017 20:21:56 +0800
Message-ID: <CACVXFVPRmauUODH1KjUkyBOiWtORGeAXGWiMS0zhmP6Unt=Jpw@mail.gmail.com>
Subject: Re: [PATCH v2] blktrace: cleanup/fix registration locking
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 6, 2017 at 12:21 AM, Jens Axboe <axboe@kernel.dk> wrote:
> One patch that fixes up a discrepancy in how we lock the queue for
> blktrace registration, and one that fixes up how we globally
> serialize registering the tracepoints.
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
