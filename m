Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX V5] block: add missing group association in
 bio-cloning functions
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
References: <1469549700-9732-1-git-send-email-paolo.valente@linaro.org>
 <1469596932-14448-1-git-send-email-paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 stable@vger.kernel.org, jmoyer@redhat.com, Nikolay Borisov <kernel@kyup.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b90aac4c-7116-d872-4854-9cd012145061@kernel.dk>
Date: Wed, 27 Jul 2016 08:45:24 -0600
MIME-Version: 1.0
In-Reply-To: <1469596932-14448-1-git-send-email-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/26/2016 11:22 PM, Paolo Valente wrote:
> When a bio is cloned, the newly created bio must be associated with
> the same blkcg as the original bio (if BLK_CGROUP is enabled). If
> this operation is not performed, then the new bio is not associated
> with any group, and the group of the current task is returned when
> the group of the bio is requested.
>
> Depending on the cloning frequency, this may cause a large
> percentage of the bios belonging to a given group to be treated
> as if belonging to other groups (in most cases as if belonging to
> the root group). The expected group isolation may thereby be broken.
>
> This commit adds the missing association in bio-cloning functions.

Added for 4.8, thanks.

-- 
Jens Axboe
