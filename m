Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] cfq-iosched: Fixes for conversion from jiffies to ns
To: Jan Kara <jack@suse.cz>
References: <1467097442-5400-1-git-send-email-jack@suse.cz>
Cc: linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5772881D.8000707@kernel.dk>
Date: Tue, 28 Jun 2016 08:22:21 -0600
MIME-Version: 1.0
In-Reply-To: <1467097442-5400-1-git-send-email-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/28/2016 01:03 AM, Jan Kara wrote:
> Hi,
>
> Commit 9a7f38c42c2b (cfq-iosched: Convert from jiffies to nanoseconds)
> introduced couple of issues into cfq io scheduler. Most notably our QA
> runs within SUSE uncovered a regression in bonnie++ rewrite performance
> due to a broken condition detecting starved sync IO and further review
> unveiled other three mostly cosmetic issues (but still worth fixing).
>
> Jens, please queue these patches to avoid regressions when the above
> mentioned commit gets merged in the next merge window. If you want to
> fold them into the above commit, I'm fine with that as well. Thanks!

Thanks Jan, added for 4.8!

-- 
Jens Axboe
