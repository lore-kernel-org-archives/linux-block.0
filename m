Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.12] (mobile-166-171-120-2.mycingular.net. [166.171.120.2])
        by smtp.gmail.com with ESMTPSA id b10sm33576921pfj.20.2017.11.23.20.59.37
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 20:59:37 -0800 (PST)
Subject: Re: [PATCH 0/5] cleanup for blk-wbt
To: linux-block@vger.kernel.org
References: <cover.1511444141.git.zhangweiping@didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5104cf93-041d-3bba-c065-d21909a9ceae@kernel.dk>
Date: Thu, 23 Nov 2017 21:59:35 -0700
MIME-Version: 1.0
In-Reply-To: <cover.1511444141.git.zhangweiping@didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/23/2017 06:37 AM, weiping zhang wrote:
> Hi Jens,
> 
> several cleanup for blk-wbt, no function change, thanks
> 
> weiping zhang (5):
>   blk-wbt: remove duplicated setting in wbt_init
>   blk-wbt: cleanup comments to one line
>   blk-sysfs: remove NULL pointer checking in queue_wb_lat_store
>   blk-wbt: move wbt_clear_stat to common place in wbt_done
>   blk-wbt: fix comments typo

Thanks, looks good - I applied 4, I dropped the comment fixup. It's
pointless churn, and there are lots of other comments using that
style for one line, even in that same file.

-- 
Jens Axboe
