Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j193sm1423364ita.9.2017.11.03.11.20.53
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 11:20:53 -0700 (PDT)
Subject: Re: [PATCH v4] blk-mq: fix nr_requests wrong value when modify it
 from sysfs
To: linux-block@vger.kernel.org
References: <20170922153624.GA15873@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <461834d0-f71a-8d12-932a-36abf45bbba5@kernel.dk>
Date: Fri, 3 Nov 2017 12:20:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170922153624.GA15873@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/22/2017 09:36 AM, weiping zhang wrote:
> if blk-mq use "none" io scheduler, nr_request get a wrong value when
> input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
> the smaller one min(nr, set->queue_depth), and then q->nr_request get a
> wrong value.
> 
> Reproduce:
> 
> echo none > /sys/block/nvme0n1/queue/scheduler
> echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
> cat /sys/block/nvme0n1/queue/nr_requests
> 1000000

Sorry for the delay - looks good to me, and also tested that it does
fix the issue. Thanks, applied for 4.15.

-- 
Jens Axboe
