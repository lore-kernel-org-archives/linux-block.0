Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/12] fs: add fcntl() interface for setting/getting write
 life time hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, hch@infradead.org
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
 <1497544930-19174-6-git-send-email-axboe@kernel.dk>
 <yq1efujq3vq.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c556272e-9d7c-4043-cd7b-b2d143f60d5f@kernel.dk>
Date: Fri, 16 Jun 2017 10:55:07 -0600
MIME-Version: 1.0
In-Reply-To: <yq1efujq3vq.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:44 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> We have a pwritev2(2) interface based on passing in flags. Add an
>> fcntl interface for querying these flags, and also for setting them
>> as well:
>>
>> F_GET_WRITE_LIFE	Returns one of the valid type of write hints,
>> 			like WRITE_HINT_MEDIUM.
>>
>> F_SET_WRITE_LIFE	Pass in a WRITE_HINT_* type to set the
>> 			write life time hint for this file/inode.
>> 			Returns 0 on succes, -1 otherwise.
> 
> It seems like an overkill to have different fcntls for different
> hints. And since we are expecting more, maybe these should be
> F_{GET,SET}_HINT and then the individual flags can be
> WRITE_LIFETIME_FOOBAR?
> 
> Otherwise OK with the fnctl approach.

OK, that's a useful suggestion. The hints are already of the
WRITE_HINT_* variant, so I don't think we need to change that. I'll
change the name.

-- 
Jens Axboe
