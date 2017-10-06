Return-Path: <martin.petersen@oracle.com>
To: Tim Hansen <devtimhansen@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.levin@one.verizon.com
Subject: Re: [PATCH] block: remove unnecessary NULL checks in bioset_integrity_free()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171005180920.GA121296@debian>
Date: Fri, 06 Oct 2017 14:40:19 -0400
In-Reply-To: <20171005180920.GA121296@debian> (Tim Hansen's message of "Thu, 5
	Oct 2017 14:09:20 -0400")
Message-ID: <yq1tvzcnmr0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Tim,

> mempool_destroy() already checks for a NULL value being passed in,
> this eliminates duplicate checks.

That's fine.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
