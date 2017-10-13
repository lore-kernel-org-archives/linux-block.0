Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s5sm889630its.1.2017.10.13.09.52.32
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 09:52:32 -0700 (PDT)
Subject: Re: [PATCH 0/2] Update the usage hints of submit_queues and
To: linux-block@vger.kernel.org
References: <20171013162453.GA12557@source.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6d6d5597-7476-0242-b748-03777481fc6a@kernel.dk>
Date: Fri, 13 Oct 2017 10:52:31 -0600
MIME-Version: 1.0
In-Reply-To: <20171013162453.GA12557@source.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/13/2017 10:24 AM, weiping zhang wrote:
> no_sched
> Message-ID: <cover.1507911414.git.zhangweiping@didichuxing.com>
> Reply-To: 
> 
> Hi Jens,
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> These two misc patch update the usage hints of null_blk module
> parameter.
> 
> Because submit_queues was changed to 1 by default, so update it's
> description.
> 
> The second patch add usage hints for no_sched.

Not sure what is going on with your email, and the subject line
seems cut off. But I applied the two patches for 4.15.

-- 
Jens Axboe
