Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] cfq-iosched: Delete unused function min_vdisktime()
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>
References: <20170526212237.103525-1-mka@chromium.org>
 <20170526212237.103525-4-mka@chromium.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <86aeaf5a-281b-1c18-0359-7e7650219576@kernel.dk>
Date: Tue, 30 May 2017 09:50:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170526212237.103525-4-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/26/2017 03:22 PM, Matthias Kaehlcke wrote:
> This fixes the following warning when building with clang:
> 
>     block/cfq-iosched.c:970:19: error: unused function 'min_vdisktime'
>         [-Werror,-Wunused-function]

I have applied this one for 4.13, as that is just dead code. I don't
think the others are worth bothering with.

-- 
Jens Axboe
