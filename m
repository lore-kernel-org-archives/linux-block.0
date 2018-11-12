Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 12 Nov 2018 11:14:06 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Li Zefan
 <lizefan@huawei.com>, Angelo Ruocco <angeloruocco90@gmail.com>, Dennis Zhou
 <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Liu Bo
 <bo.liu@linux.alibaba.com>, Bart Van Assche <bvanassche@acm.org>, Johannes
 Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org, bfq-iosched@googlegroups.com,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
In-Reply-To: <9e8adb3271680165d85994a225713391@natalenko.name>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
Message-ID: <cf9ef5511050f321c358fe70b6b8494c@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

On 12.11.2018 11:00, Oleksandr Natalenko wrote:
> I thought all the legacy stuff including CFS et al. is going to be
> removed in v4.21 completely…

Paolo, [1] and [2].

[1] http://git.kernel.dk/cgit/linux-block/log/?h=for-4.21/block
[2] 
http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.21/block&id=f382fb0bcef4c37dc049e9f6963e3baf204d815c

-- 
   Oleksandr Natalenko (post-factum)
