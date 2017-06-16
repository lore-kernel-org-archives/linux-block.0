Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/12] block: add support for carrying stream information
 in a bio
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, hch@infradead.org
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
 <1497544930-19174-2-git-send-email-axboe@kernel.dk>
 <yq1injvq42u.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0b2f0456-d230-b9e2-de67-cb002eb38343@kernel.dk>
Date: Fri, 16 Jun 2017 10:42:02 -0600
MIME-Version: 1.0
In-Reply-To: <yq1injvq42u.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:39 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> No functional changes in this patch, we just add four flags
>> that will be used to denote a stream type, and ensure that we
>> don't merge across different stream types.
> 
> More stream terminology...

Thanks, will fix up that too...

-- 
Jens Axboe
