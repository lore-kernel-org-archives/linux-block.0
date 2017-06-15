Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
Message-ID: <bb49b5a3-ac8e-84ce-1886-62deab29a3a4@kernel.dk>
Date: Thu, 15 Jun 2017 09:23:02 -0600
MIME-Version: 1.0
In-Reply-To: <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/15/2017 08:21 AM, Jens Axboe wrote:
> On 06/15/2017 02:19 AM, Christoph Hellwig wrote:
>> I think Darrick has a very valid concern here - using RWF_* flags
>> to affect inode or fd-wide state is extremely counter productive.
>>
>> Combined with the fact that the streams need a special setup in NVMe
>> I'm tempted to say that the interface really should be fadvise or
>> similar, which would keep the setup out of the I/O path and make clear
>> it's a sticky interface.  For direct I/O RWF_* would make some sense,
>> but we'd still have to deal with the setup issue.
> 
> OK, which is exactly how I had implemented the interface 2 years ago.
> I can resurrect that part and dump the RWF_* flags. I agree the RWF_*
> flags are confusing for buffered IO, since they are persistent. For
> O_DIRECT, they make more sense. So the question is if we want to
> retain the RWF_WRITE_LIFE_* hints at all, or simply go back to the
> fadvise with something ala:
> 
> POSIX_FADV_WRITE_HINT_SET	Set write life time hint
> POSIX_FADV_WRITE_HINT_GET	Get write life time hint

And then I remembered why fadvise _sucks_. It returns the error value
directly. So 0 is success > 0 is some error. That does not work well
for adding a set/get interface. Additionally, with fadvise, we have
to overload either 'offset' or 'length' for the write hint for the
set operation. Not super pretty.

Any objections to making the auxiliary interface fcntl(2) based?
That would be a cleaner fit, imho.

-- 
Jens Axboe
