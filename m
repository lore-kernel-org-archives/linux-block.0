Return-Path: <logang@deltatee.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
 <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2550ca60-5f02-56e7-ff4c-6cd96b20a4d0@deltatee.com>
Date: Tue, 6 Feb 2018 10:15:50 -0700
MIME-Version: 1.0
In-Reply-To: <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 2/2] block, char_dev: Use correct format specifier for
 unsigned ints
List-ID: <linux-block@vger.kernel.org>



On 05/02/18 07:25 PM, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
> 
> register_blkdev() and __register_chrdev_region() treat the major
> number as an unsigned int. So print it the same way to avoid
> absurd error statements such as:
> "... major requested (-1) is greater than the maximum (511) ..."
> (and also fix off-by-one bugs in the error prints).
> 
> While at it, also update the comment describing register_blkdev().
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
