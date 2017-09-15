Return-Path: <prvs=4242a8d18=damien.lemoal@wdc.com>
Subject: Re: [PATCH] Support for secure erase functionality
To: Philipp <philipp.guendisch@fau.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, viro@zeniv.linux.org.uk,
 bart.vanassche@sandisk.com, martin.petersen@oracle.com, hare@suse.de,
 osandov@fb.com, dan.j.williams@intel.com, ming.lei@redhat.com,
 linux-kernel@i4.cs.fau.de, Mate Horvath <horvatmate@gmail.com>
References: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
 <2b2d3855-00e9-77d0-7ee4-050c210b718e@wdc.com>
 <B5C3A846-D993-4356-8F89-1CEE253D54F7@fau.de>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <75924e04-b9db-b00e-697c-0020fdb33b21@wdc.com>
Date: Fri, 15 Sep 2017 11:46:11 +0900
MIME-Version: 1.0
In-Reply-To: <B5C3A846-D993-4356-8F89-1CEE253D54F7@fau.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Philipp,

On 9/14/17 21:51, Philipp wrote:
> Dear Damien,
> 
> Thank you for your feedback.
> 
>> On 14. Sep 2017, at 10:46, Damien Le Moal <damien.lemoal@wdc.com>
>> wrote:
> 
> […]
> 
>> Writing once to a sector stored on spinning rust will *not* fully
>> erase the previous data. Part of the signal used for storing that
>> data will remain on the track (because the disk head is never
>> perfectly aligned on the track). With some signal processing work,
>> the old data can be retrieved.
>> 
>> You will need a *lot* of normal writes to make sure nothing remains
>> of the old data signal. Granted, even a single write will make it
>> hard to get to the old data, but it is possible nevertheless. Hence
>> the standard defined SANITIZE with cryptographic erase option to
>> ensure that the old data is really dead.
> 
> 
> We constructed our patch based on a paper called “Overwriting Hard
> Drive Data: The Great Wiping Controversy” which stated that a single
> overwrite of the data is sufficient. Nevertheless this should not be
> a solution to replace encryption but to improve data security when 
> better techniques are not viable (e.g. travelling between countries
> while importing or exporting encrypted data may be prohibited without
> a license).

I was in doubt so I checked with our recording physicists about this.
The paper is mostly correct. Under good conditions (old data written
on-track and overwritten on-track too), a single write is mostly
equivalent to a secure erase: it will wipe the old data. The problem I
have with the paper though is that the statistics shown are a little
misleading: off-tracks events can be for several contiguous sectors,
resulting is a fair chunk of data being recoverable after an overwrite.

More importantly though, the paper dates back to 2008 when indirection
systems in HDDs where not common. They tend to be the norm now, so the
behavior of an overwrite may well end up being similar to an SSD, i.e.
directed to a different physical location and leaving the original data
untouched.

As for SMR drives, the concept of "overwriting" does not even exists...

>> I think that a similar problem also exist for SSDs, and it is even
>> worse there since writing twice to the same logical sector does not
>> even go to the same physical sector. The old data is not even
>> overwritten.
> 
> We know about the problems regarding the data placement on SSDs, but
> there is very little we can do with code against the hardware
> controller of specific devices. On SSDs, you would probably want to
> use full disk encryption, because it should be no problem, when
> encrypted blocks are left on the drive.
> 
> However in cases where encryption is too slow or not possible, this
> could improve data confidentiality.

Fair enough. But then is the feature name "software secure erase" a
little misleading ? Since your method is absolutely not equivalent to a
hardware implementation of secure erase, another name should be chosen
to avoid user confusion and misplaced trust in the feature.

Best regards.

-- 
Damien Le Moal,
Western Digital
