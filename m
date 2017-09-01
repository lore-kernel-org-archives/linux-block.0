Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] kernfs: checking for IS_ERR() instead of NULL
To: Dan Carpenter <dan.carpenter@oracle.com>, Shaohua Li <shli@fb.com>,
 linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel-janitors@vger.kernel.org
References: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <615eb575-b64f-c315-f1e8-800a2652aa5e@kernel.dk>
Date: Fri, 1 Sep 2017 08:19:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/30/2017 08:04 AM, Dan Carpenter wrote:
> The kernfs_get_inode() returns NULL on error, it never returns error
> pointers.

Added for 4.14, with the ack from Tejun and Greg.

-- 
Jens Axboe
