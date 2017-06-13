Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <2A5802CF-4DA7-477E-B5AA-F31FCD7F7908@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AF46D165-92FE-47A1-AF42-6ECC37CC0729";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/11] Add support for write life time hints
Date: Tue, 13 Jun 2017 13:21:24 -0600
In-Reply-To: <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
 <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_AF46D165-92FE-47A1-AF42-6ECC37CC0729
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 12:26 PM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 06/13/2017 12:04 PM, Andreas Dilger wrote:
>> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>> 
>>> A new iteration of this patchset, previously known as write streams.
>>> Instead of exposing numeric values for streams, I've previously
>>> advocated for just doing a set of hints that makes sense instead. See
>>> the coverage from the LSFMM summit this year:
>>> 
>>> https://lwn.net/Articles/717755/
>>> 
>>> This patchset attempts to do that. We define 4 flags for the pwritev2
>>> system call:
>>> 
>>> RWF_WRITE_LIFE_SHORT	Data written with this flag is expected to have
>>> 			a high overwrite rate, or life time.
>>> 
>>> RWF_WRITE_LIFE_MEDIUM	Longer life time than SHORT
>>> 
>>> RWF_WRITE_LIFE_LONG	Longer life time than MEDIUM
>>> 
>>> RWF_WRITE_LIFE_EXTREME	Longer life time than LONG
>>> 
>>> The idea is that these are relative values, so an application can
>>> use them as they see fit. The underlying device can then place
>>> data appropriately, or be free to ignore the hint. It's just a hint.
>>> 
>>> Comments appreciated.
>> 
>> I thought that one of the major attractions of numeric stream IDs was
>> that they had no semantic meanings, just "N is similar to N" and "M is
>> similar to M", and it is up to userspace to define what these mean?
>> 
>> That allows userspace to use the IDs for lifetimes (as above), but
>> also/instead use them for allocation sizes, different applications,
>> different users, etc.
> 
> Right, that is indeed the intent. But we have to attach some naming
> to them. Userspace could in theory use these totally randomly, and
> things like NVMe would not care. But the semantic meaning of "short"
> vs "long" is important on caching infrastructure where you might
> want to use the hint for data placement.
> 
> I think the important part here is that no absolute meaning is
> attached to them, only relative.

In both IOCB_WRITE_LIFE_* and RWF_WRITE_LIFE_* this is consuming 4 bits of
space (which is itself fine) for only 4 different stream IDs.  Why not just
shift a 4-bit arbitrary stream ID to the appropriate offset in those fields,
rather than treating them as 4 individual bits and allowing only one of
them to be passed down the stack at a time?

Cheers, Andreas






--Apple-Mail=_AF46D165-92FE-47A1-AF42-6ECC37CC0729
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQDs0pIg59Q01vtYRAhz+AKCDxlj1jPqM2Jz7HJkzw7T+IJjU6wCgx+uj
b7B5SVP7cNZPTFLK58IlMwk=
=RtOi
-----END PGP SIGNATURE-----

--Apple-Mail=_AF46D165-92FE-47A1-AF42-6ECC37CC0729--
