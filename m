Return-Path: <mhocko@kernel.org>
Date: Mon, 9 Apr 2018 11:00:16 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "willy@infradead.org" <willy@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hare@suse.com" <hare@suse.com>,
	"martin@lichtvoll.de" <martin@lichtvoll.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: Block layer use of __GFP flags
Message-ID: <20180409090016.GA21771@dhcp22.suse.cz>
References: <20180408065425.GD16007@bombadil.infradead.org>
 <aea2f6bcae3fe2b88e020d6a258706af1ce1a58b.camel@wdc.com>
 <20180408190825.GC5704@bombadil.infradead.org>
 <63d16891d115de25ac2776088571d7e90dab867a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63d16891d115de25ac2776088571d7e90dab867a.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon 09-04-18 04:46:22, Bart Van Assche wrote:
[...]
[...]
> diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
> index ad8a125defdd..3ddb464b72e6 100644
> --- a/drivers/ide/ide-pm.c
> +++ b/drivers/ide/ide-pm.c
> @@ -91,7 +91,7 @@ int generic_ide_resume(struct device *dev)
>  
>  	memset(&rqpm, 0, sizeof(rqpm));
>  	rq = blk_get_request_flags(drive->queue, REQ_OP_DRV_IN,
> -				   BLK_MQ_REQ_PREEMPT);
> +				   BLK_MQ_REQ_PREEMPT, __GFP_RECLAIM);

Is there any reason to use __GFP_RECLAIM directly. I guess you wanted to
have GFP_NOIO semantic, right? So why not be explicit about that. Same
for other instances of this flag in the patch
-- 
Michal Hocko
SUSE Labs
