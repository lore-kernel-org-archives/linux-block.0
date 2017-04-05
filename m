Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove the obsolete hd driver
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170405135923.953-1-hch@lst.de>
Date: Wed, 05 Apr 2017 11:46:35 -0400
In-Reply-To: <20170405135923.953-1-hch@lst.de> (Christoph Hellwig's message of
	"Wed, 5 Apr 2017 15:59:23 +0200")
Message-ID: <yq17f2ysvqc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> This driver is for pre-IDE hardisk that are only found in PC from the
> stoneage of personal computing, and which we don't support elsewhere
> in the kernel these days.
>
> It's also been marked broken forever.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
