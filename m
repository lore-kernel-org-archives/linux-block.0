Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <7A48D12A-E656-4FC8-9D03-1BC482B8AE34@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B040DACB-3243-4ED7-8FC2-75A1050FA747";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 9/9] nvme: add support for streams and directives
Date: Mon, 26 Jun 2017 13:36:59 -0600
In-Reply-To: <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block@vger.kernel.org,
 Martin Petersen <martin.petersen@oracle.com>,
 linux-nvme@lists.infradead.org
To: Jens Axboe <axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_B040DACB-3243-4ED7-8FC2-75A1050FA747
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 26, 2017, at 7:56 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 06/26/2017 03:59 AM, Christoph Hellwig wrote:
>> Looks mostly good,
>> 
>> but two nit-picks:
>> 
>> - can we keep a module option to disable streams, or in fact for
>>   now maybe to explicitly enable it?  I expect this to be interesting
>>   at least for the first devices that implement it.  Also given that
>>   it needs to be explicitly enabled I would expect some overhead of
>>   just enabling it when never used
> 
> Fine with me, I can add the 'streams' parameter back, but just default
> it to false.

Better would be a parameter to set the default streams count, 0 by default.

>> - do we even need the < 4 streams fallback now that they are global
>>   instead of per-ns instead of just disabling the feature for now?
> 
> Maybe the device only supports 2? or 3?
> 
> --
> Jens Axboe
> 


Cheers, Andreas






--Apple-Mail=_B040DACB-3243-4ED7-8FC2-75A1050FA747
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD4DBQFZUWJgpIg59Q01vtYRAvDxAJjjA9dGZ9owOE6ulsfszgC4GSdcAKDVa37c
SakaAC4pdo4jP551N7RcdQ==
=D98V
-----END PGP SIGNATURE-----

--Apple-Mail=_B040DACB-3243-4ED7-8FC2-75A1050FA747--
