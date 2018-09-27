Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] bcache: add separate workqueue for journal_write to
 avoid deadlock
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, guoju <fangguoju@gmail.com>,
 stable@vger.kernel.org
References: <20180927154146.28262-1-colyli@suse.de>
 <20180927154146.28262-2-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <970bb505-ef6e-7057-5e0f-21d9439b4031@kernel.dk>
Date: Thu, 27 Sep 2018 09:46:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180927154146.28262-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/27/18 9:41 AM, Coly Li wrote:
> From: guoju <fangguoju@gmail.com>

This, and the signed-off, should use the full name. I can fix that up,
assuming Guoju Fang is the full name?

-- 
Jens Axboe
