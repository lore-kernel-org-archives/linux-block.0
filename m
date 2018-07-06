Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: Add default switch case to
 blk_pm_allow_request() to kill warning
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180706084935.30359-1-geert+renesas@glider.be>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a02df37d-7d27-98e5-1a04-2976c9354e1b@kernel.dk>
Date: Fri, 6 Jul 2018 09:09:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180706084935.30359-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/6/18 2:49 AM, Geert Uytterhoeven wrote:
> With gcc 4.9.0 and 7.3.0:
> 
>     block/blk-core.c: In function 'blk_pm_allow_request':
>     block/blk-core.c:2747:2: warning: enumeration value 'RPM_ACTIVE' not handled in switch [-Wswitch]
>       switch (rq->q->rpm_status) {
>       ^
> 
> Convert the return statement below the switch() block into a default
> case to fix this.

Applied, thanks.

-- 
Jens Axboe
