Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] kernfs: checking for IS_ERR() instead of NULL
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
 <20170831165247.GA26219@kroah.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <26406dc8-2bdc-7bd3-7cd9-7e63986a8769@kernel.dk>
Date: Thu, 31 Aug 2017 13:56:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170831165247.GA26219@kroah.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/31/2017 10:52 AM, Greg Kroah-Hartman wrote:
> On Wed, Aug 30, 2017 at 05:04:56PM +0300, Dan Carpenter wrote:
>> The kernfs_get_inode() returns NULL on error, it never returns error
>> pointers.
>>
>> Fixes: aa8188253474 ("kernfs: add exportfs operations")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Hm, I don't know what tree aa8188253474 is in, but it's not mine, so I
> can't take this patch :(

It's in my tree, I'll take it. Can I add your
acked/reviewed/whatever-by?

-- 
Jens Axboe
