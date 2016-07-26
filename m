Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blkcg: kill unused field nr_undestroyed_grps
To: Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
References: <1469524422-63439-1-git-send-email-houtao1@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <03861f05-bc86-5139-50e1-b847b86bd4e3@kernel.dk>
Date: Tue, 26 Jul 2016 08:40:08 -0600
MIME-Version: 1.0
In-Reply-To: <1469524422-63439-1-git-send-email-houtao1@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/26/2016 03:13 AM, Hou Tao wrote:
> 'nr_undestroyed_grps' in struct throtl_data was used to count
> the number of throtl_grp related with throtl_data, but now
> throtl_grp is tracked by blkcg_gq, so it is useless anymore.

Thanks, applied.

-- 
Jens Axboe
