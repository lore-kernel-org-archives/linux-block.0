Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] loop: don't hang on lo_ctl_mutex in ioctls
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org
References: <cover.1522125370.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3f9afeaa-ca95-6317-ac6a-f5c779910d1c@kernel.dk>
Date: Tue, 27 Mar 2018 14:21:45 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1522125370.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/26/18 10:39 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi, Jens,
> 
> We hit an issue where a loop device on NFS (yes, I know) got stuck and a
> bunch of losetup processes got stuck in uninterruptible sleep waiting
> for lo_ctl_mutex as a result. Calling into the filesystem while holding
> lo_ctl_mutex isn't necessary, and there's no reason to be
> uninterruptible here. These two patches fix this issue, based on your
> for-next branch.

Applied for 4.17, thanks Omar.

-- 
Jens Axboe
