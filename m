Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] block-throttle: avoid double charge
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: Kernel-team@fb.com, Tejun Heo <tj@kernel.org>,
 Vivek Goyal <vgoyal@redhat.com>, stable@vger.kernel.org
References: <23857cbf1d586e904bd01196fa05705fb0161785.1510605343.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0381171c-7d88-77f4-6df0-5f321b93de0e@kernel.dk>
Date: Wed, 20 Dec 2017 11:12:44 -0700
MIME-Version: 1.0
In-Reply-To: <23857cbf1d586e904bd01196fa05705fb0161785.1510605343.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/13/17 1:37 PM, Shaohua Li wrote:
> If a bio is throttled and splitted after throttling, the bio could be
> resubmited and enters the throttling again. This will cause part of the
> bio is charged multiple times. If the cgroup has an IO limit, the double
> charge will significantly harm the performance. The bio split becomes
> quite common after arbitrary bio size change.
> 
> To fix this, we always set the BIO_THROTTLED flag if a bio is throttled.
> If the bio is cloned/slitted, we copy the flag to new bio too to avoid
> double charge. However cloned bio could be directed to a new disk,
> keeping the flag will have problem. The observation is we always set new
> disk for the bio in this case, so we can clear the flag in
> bio_set_dev().
> 
> This issue exists a long time, arbitrary bio size change makes it worse,
> so this should go into stable at least since v4.2.
> 
> V1-> V2: Not add extra field in bio based on discussion with Tejun

Applied, thanks Shaohua.

-- 
Jens Axboe
