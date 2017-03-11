Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] don't forget to call pd_online_fn when activate policy
To: Zhou Chengming <zhouchengming1@huawei.com>
References: <1489203980-46134-1-git-send-email-zhouchengming1@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 miaoxie@huawei.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8f877e5c-4ceb-7c6e-c44b-c6ca3a72a5f1@kernel.dk>
Date: Sat, 11 Mar 2017 15:25:30 -0700
MIME-Version: 1.0
In-Reply-To: <1489203980-46134-1-git-send-email-zhouchengming1@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/10/2017 08:46 PM, Zhou Chengming wrote:
> When we activate policy on the request_queue, we will create policy_date
> for all the existing blkgs of the request_queue, so we should call
> pd_init_fn() and pd_online_fn() on these newly created policy_data.

I'm not looking at this until you tell me that you have runtime
tested it. I'm assuming you originally ran into some issue
with the lack of calling pd_online_fn?

-- 
Jens Axboe
