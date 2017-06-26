Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com,
 linux-nvme@lists.infradead.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-2-git-send-email-axboe@kernel.dk>
 <20170626095148.GB14057@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <91b3fd3b-18f5-cf8c-a1d7-c0637283ce14@kernel.dk>
Date: Mon, 26 Jun 2017 07:55:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170626095148.GB14057@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 03:51 AM, Christoph Hellwig wrote:
> Please document the userspace API (added linux-api and linux-man
> to CC for sugestions), especially including the odd effects of the
> per-inode settings.

Of course, I'll send in a diff for the fcntl(2) man page.

> Also I would highly recommend to use different fcntl commands
> for the file vs inode hints to avoid any strange behavior.

OK, used to have that too... I can add specific _FILE versions.

-- 
Jens Axboe
