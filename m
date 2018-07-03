Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl
To: Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sam Hurst <shurst@google.com>
References: <20180702230346.72350-1-evgreen@chromium.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c507d876-baa9-8294-f8f9-790be3bae3db@kernel.dk>
Date: Tue, 3 Jul 2018 07:52:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180702230346.72350-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 5:03 PM, Evan Green wrote:
> This change adds LOOP_SET_BLOCK_SIZE as one of the supported ioctls
> in lo_compat_ioctl. It only takes an unsigned long argument, and
> in practice a 32-bit value works fine.

Applied for 4.18, thanks.

-- 
Jens Axboe
