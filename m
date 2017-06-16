Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 05/12] fs: add fcntl() interface for setting/getting write life time hints
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
	<1497544930-19174-6-git-send-email-axboe@kernel.dk>
Date: Fri, 16 Jun 2017 12:44:09 -0400
In-Reply-To: <1497544930-19174-6-git-send-email-axboe@kernel.dk> (Jens Axboe's
	message of "Thu, 15 Jun 2017 10:42:03 -0600")
Message-ID: <yq1efujq3vq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> We have a pwritev2(2) interface based on passing in flags. Add an
> fcntl interface for querying these flags, and also for setting them
> as well:
>
> F_GET_WRITE_LIFE	Returns one of the valid type of write hints,
> 			like WRITE_HINT_MEDIUM.
>
> F_SET_WRITE_LIFE	Pass in a WRITE_HINT_* type to set the
> 			write life time hint for this file/inode.
> 			Returns 0 on succes, -1 otherwise.

It seems like an overkill to have different fcntls for different
hints. And since we are expecting more, maybe these should be
F_{GET,SET}_HINT and then the individual flags can be
WRITE_LIFETIME_FOOBAR?

Otherwise OK with the fnctl approach.

-- 
Martin K. Petersen	Oracle Linux Engineering
