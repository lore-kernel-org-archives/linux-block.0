Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 Nov 2017 12:38:49 -0800
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Kernel-team@fb.com, Vivek Goyal <vgoyal@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2] block-throttle: avoid double charge
Message-ID: <20171113203849.GQ983427@devbig577.frc2.facebook.com>
References: <23857cbf1d586e904bd01196fa05705fb0161785.1510605343.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23857cbf1d586e904bd01196fa05705fb0161785.1510605343.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 13, 2017 at 12:37:10PM -0800, Shaohua Li wrote:
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
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shaohua Li <shli@fb.com>

Yeah, this works too.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
