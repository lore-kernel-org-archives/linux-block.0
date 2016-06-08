Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3 v2] cfq: High precision slice tuning
To: Jan Kara <jack@suse.cz>
References: <1465391499-27867-1-git-send-email-jack@suse.cz>
Cc: linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <575834D3.6050406@kernel.dk>
Date: Wed, 8 Jun 2016 09:08:03 -0600
MIME-Version: 1.0
In-Reply-To: <1465391499-27867-1-git-send-email-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/08/2016 07:11 AM, Jan Kara wrote:
> Hi,
>
> since Jens didn't merge the patches yet, I'm sending v2 of the series. Since
> v1 I have added Jeff's Reviewed-by tag and also fixed two 32-bit issues
> (possible overflow when computing cfq_latency_target and 64-bit division using
> '/' in choose_wl_class_and_type()). Jens, please merge these patches. Thanks!

Added for 4.8, thanks guys.

-- 
Jens Axboe
