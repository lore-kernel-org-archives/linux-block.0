Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 01/12] block: add support for carrying stream information in a bio
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
	<1497544930-19174-2-git-send-email-axboe@kernel.dk>
Date: Fri, 16 Jun 2017 12:39:53 -0400
In-Reply-To: <1497544930-19174-2-git-send-email-axboe@kernel.dk> (Jens Axboe's
	message of "Thu, 15 Jun 2017 10:41:59 -0600")
Message-ID: <yq1injvq42u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> No functional changes in this patch, we just add four flags
> that will be used to denote a stream type, and ensure that we
> don't merge across different stream types.

More stream terminology...

-- 
Martin K. Petersen	Oracle Linux Engineering
