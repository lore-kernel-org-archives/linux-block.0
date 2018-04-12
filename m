Return-Path: <martin.petersen@oracle.com>
To: Jack Wang <jinpu.wang@profitbricks.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        elliott@hpe.com
Subject: Re: [PATCH v2] block: ratelimite pr_err on IO path
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
Date: Thu, 12 Apr 2018 17:20:54 -0400
In-Reply-To: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
	(Jack Wang's message of "Thu, 12 Apr 2018 11:21:55 +0200")
Message-ID: <yq1y3hsunnt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jack,

> +				pr_err_ratelimited("%s: ref tag error at location %llu (rcvd %u)\n",

I'm a bit concerned about dropping records of potential data loss.

Also, what are you doing that compels all these to be logged? This
should be a very rare occurrence.

-- 
Martin K. Petersen	Oracle Linux Engineering
