Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] ide:ide-cd: fix kernel panic resulting from missing
 scsi_req_init
To: Hongxu Jia <hongxu.jia@windriver.com>, hch@lst.de,
 linux-block@vger.kernel.org
References: <1509435580-8308-1-git-send-email-hongxu.jia@windriver.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1781b5f0-a608-09f3-1f9f-bebe9c43f50c@kernel.dk>
Date: Wed, 1 Nov 2017 08:58:45 -0600
MIME-Version: 1.0
In-Reply-To: <1509435580-8308-1-git-send-email-hongxu.jia@windriver.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/31/2017 01:39 AM, Hongxu Jia wrote:
> Since we split the scsi_request out of struct request, while the
> standard prep_rq_fn builds 10 byte cmds, it missed to invoke
> scsi_req_init() to initialize certain fields of a scsi_request
> structure (.__cmd[], .cmd, .cmd_len and .sense_len but no other
> members of struct scsi_request).

Added for 4.14, thanks.

-- 
Jens Axboe
