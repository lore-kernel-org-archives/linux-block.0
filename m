Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V7 00/18] blk-throttle: add .low limit
To: Shaohua Li <shli@fb.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1490634565.git.shli@fb.com>
Cc: tj@kernel.org, Vivek Goyal <vgoyal@redhat.com>, jmoyer@redhat.com,
 Kernel-team@fb.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dfc4078b-a130-2997-9c44-20d3d17db9cc@kernel.dk>
Date: Mon, 27 Mar 2017 12:15:29 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1490634565.git.shli@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/27/2017 11:51 AM, Shaohua Li wrote:
> V6->V7:
> - Don't overload blk stat, which will simplify the code. This will add extra
>   space in bio/request though with the low interface configure option on.

Hmm, why? As far as I can see, it just makes things worse.

-- 
Jens Axboe
