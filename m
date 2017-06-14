Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca
Subject: Re: [PATCHSET v2] Add support for write life time hints
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
	<yq160fyvah7.fsf@oracle.com>
	<d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
Date: Wed, 14 Jun 2017 12:00:49 -0400
In-Reply-To: <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk> (Jens Axboe's
	message of "Wed, 14 Jun 2017 09:53:05 -0600")
Message-ID: <yq1wp8etv7y.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> So how about we just call it "write_hint"? It sounds mostly like a
> naming issue to me, as you would then map that to some specific stream
> in your driver. You're free to do that right now. They are all flags,
> it's just packed as a value to not waste too much space.

Sure, that's fine with me. But let's call them bi_hints or something. I
have a couple that I would like to add that are I/O direction agnostic.

-- 
Martin K. Petersen	Oracle Linux Engineering
