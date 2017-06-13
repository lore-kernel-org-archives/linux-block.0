Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/11] Add support for write life time hints
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
Date: Tue, 13 Jun 2017 12:26:01 -0600
MIME-Version: 1.0
In-Reply-To: <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 12:04 PM, Andreas Dilger wrote:
> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> A new iteration of this patchset, previously known as write streams.
>> Instead of exposing numeric values for streams, I've previously
>> advocated for just doing a set of hints that makes sense instead. See
>> the coverage from the LSFMM summit this year:
>>
>> https://lwn.net/Articles/717755/
>>
>> This patchset attempts to do that. We define 4 flags for the pwritev2
>> system call:
>>
>> RWF_WRITE_LIFE_SHORT	Data written with this flag is expected to have
>> 			a high overwrite rate, or life time.
>>
>> RWF_WRITE_LIFE_MEDIUM	Longer life time than SHORT
>>
>> RWF_WRITE_LIFE_LONG	Longer life time than MEDIUM
>>
>> RWF_WRITE_LIFE_EXTREME	Longer life time than LONG
>>
>> The idea is that these are relative values, so an application can
>> use them as they see fit. The underlying device can then place
>> data appropriately, or be free to ignore the hint. It's just a hint.
>>
>> Comments appreciated.
> 
> I thought that one of the major attractions of numeric stream IDs was
> that they had no semantic meanings, just "N is similar to N" and "M is
> similar to M", and it is up to userspace to define what these mean?
> 
> That allows userspace to use the IDs for lifetimes (as above), but
> also/instead use them for allocation sizes, different applications,
> different users, etc.

Right, that is indeed the intent. But we have to attach some naming
to them. Userspace could in theory use these totally randomly, and
things like NVMe would not care. But the semantic meaning of "short"
vs "long" is important on caching infrastructure where you might
want to use the hint for data placement.

I think the important part here is that no absolute meaning is
attached to them, only relative.


-- 
Jens Axboe
