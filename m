Return-Path: <prvs=526004f015=axboe@fb.com>
Subject: Re: [PATCH 0/3] blk-throttle: add .low limit fix
To: Shaohua Li <shli@fb.com>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
References: <567d5361-7d6b-c53e-8ada-a2966e48dc54@fb.com>
 <cover.1490651903.git.shli@fb.com>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a03455d1-270d-85e7-d351-3efd90aa36d2@fb.com>
Date: Tue, 28 Mar 2017 09:58:02 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1490651903.git.shli@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 03/27/2017 04:19 PM, Shaohua Li wrote:
> Jens,
> 
> The 3 patches replace the last two patches (patch 17/18) of the series I sent
> out today. The new patch overloads blk stat as you suggested.

Thanks! With that, I've queued it up for 4.12.

-- 
Jens Axboe
