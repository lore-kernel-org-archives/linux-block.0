Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH, RESEND] blk-mq: Remove blk_mq_queue_data.list
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170405153918.22350-1-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3583ca56-66fa-e944-9fa9-2306b58e9520@kernel.dk>
Date: Wed, 5 Apr 2017 09:40:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170405153918.22350-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/05/2017 09:39 AM, Bart Van Assche wrote:
> The block layer core sets blk_mq_queue_data.list but no block
> drivers read that member. Hence remove it and also the code that
> is used to set this member.

Thanks, this came through fine. Applied for 4.12.

-- 
Jens Axboe
