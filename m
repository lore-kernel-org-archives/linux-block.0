Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, adilger@dilger.ca,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: add support for streams and directives
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
	<1498004526-4543-10-git-send-email-axboe@kernel.dk>
	<20170626095907.GG14057@infradead.org>
Date: Mon, 26 Jun 2017 13:52:02 -0400
In-Reply-To: <20170626095907.GG14057@infradead.org> (Christoph Hellwig's
	message of "Mon, 26 Jun 2017 02:59:07 -0700")
Message-ID: <yq17ezy4oxp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

>  - can we keep a module option to disable streams, or in fact for
>    now maybe to explicitly enable it?  I expect this to be interesting
>    at least for the first devices that implement it.  Also given that
>    it needs to be explicitly enabled I would expect some overhead of
>    just enabling it when never used

Yeah, based on my experiments we'll need to drive this as an opt-in
feature for now. Short term the module option is OK. Once more devices
start materializing we probably need a white/blacklist/quirk scheme.

-- 
Martin K. Petersen	Oracle Linux Engineering
