Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca
Subject: Re: [PATCHSET v2] Add support for write life time hints
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
	<yq160fyvah7.fsf@oracle.com>
	<d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
	<20170614160127.GA30644@infradead.org>
Date: Wed, 14 Jun 2017 12:04:24 -0400
In-Reply-To: <20170614160127.GA30644@infradead.org> (Christoph Hellwig's
	message of "Wed, 14 Jun 2017 09:01:27 -0700")
Message-ID: <yq1shj2tv1z.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> I think what Martin wants (or at least what I'd want him to want) is
> to define a few REQ_* bits that mirror the RWF bits, use that to
> transfer the information down the stack, and then only translate it
> to stream ids in the driver.

Yup. If we have enough space in the existing flags that's perfect (I
lost count after your op/flag shuffle).

-- 
Martin K. Petersen	Oracle Linux Engineering
