Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/11] Add support for write life time hints
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
 <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
 <2A5802CF-4DA7-477E-B5AA-F31FCD7F7908@dilger.ca>
 <ee7a8e90-5df9-c1fc-e07e-5d0e62d6334c@kernel.dk>
 <E4EBB016-5EA3-4C2C-BC63-7B8D475768AC@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <60597d4d-9067-82ba-bb2f-74ed4b27ab78@kernel.dk>
Date: Tue, 13 Jun 2017 14:56:53 -0600
MIME-Version: 1.0
In-Reply-To: <E4EBB016-5EA3-4C2C-BC63-7B8D475768AC@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 02:45 PM, Andreas Dilger wrote:
>>>>> I thought that one of the major attractions of numeric stream IDs was
>>>>> that they had no semantic meanings, just "N is similar to N" and "M is
>>>>> similar to M", and it is up to userspace to define what these mean?
>>>>>
>>>>> That allows userspace to use the IDs for lifetimes (as above), but
>>>>> also/instead use them for allocation sizes, different applications,
>>>>> different users, etc.
>>>>
>>>> Right, that is indeed the intent. But we have to attach some naming
>>>> to them. Userspace could in theory use these totally randomly, and
>>>> things like NVMe would not care. But the semantic meaning of "short"
>>>> vs "long" is important on caching infrastructure where you might
>>>> want to use the hint for data placement.
>>>>
>>>> I think the important part here is that no absolute meaning is
>>>> attached to them, only relative.
>>>
>>> In both IOCB_WRITE_LIFE_* and RWF_WRITE_LIFE_* this is consuming 4 bits of
>>> space (which is itself fine) for only 4 different stream IDs.  Why not just
>>> shift a 4-bit arbitrary stream ID to the appropriate offset in those fields,
>>> rather than treating them as 4 individual bits and allowing only one of
>>> them to be passed down the stack at a time?
>>
>> I did think about that, and I'm a bit split on it. It turns a bit mask
>> into a hybrid beast, with bits and sets of bits for values.
> 
> I don't think that is too confusing for anyone.

Agree, especially because it's a win on multiple fronts. I've made that
change (see the write-stream.2 branch).

>> For utilization of the space, yes, we could just use 2 bits instead of
>> the 4. Or use the 4 bits and potentially have the app pass in up to 16
>> values. For the latter, I'm still very much in favor of keeping the app
>> interface super simple and just retaining the 4 life time types.
> 
> I don't think anyone cares too much about 4 bits.  Strictly speaking,
> the current implementation can't fit into 2 bits because it has 5 values
> if one includes "no ID".

Right, I ended up taking 3 bits. That allows 7 valid stream IDs, and one
for unknown.

> It is a bit of overhead to use 32 bits in most of the structs where this
> field is actually stored.  I suspect that using only 8 or 16 bits in the
> structs is better, and even if it doesn't find an existing hole ("pahole"
> is your friend here) it will allow something else to use the remaining
> space in the future.

I packed the i_stream into a hole, and the bio part is filling a hole
too. So while that's not completely free, it's better than taking more
space.

> For userspace, I think it is fine to define the WRITE_LIFE values as they
> are today, and most users will use them, but IMHO it makes sense to
> allow arbitrary IDs as they see fit, especially if the underlying hardware
> doesn't care much about the actual values.

I change the WRITE_LIFT values to just be 1, 2, 3, 4, but shifted up.
Might as well keep them as values, now we've changed the space in the
flags field.

I'll throw this out for more commenting soon. Meanwhile, I'd appreciate
if you could just take a look at the write-stream.2 branch:

http://git.kernel.dk/cgit/linux-block/log/?h=write-stream.2

as it should address all your concerns so far. Thanks! Until I post it,
I may rebase it... I'm going to throw the basic testing at it to ensure
it still works as designed before posting again.

-- 
Jens Axboe
