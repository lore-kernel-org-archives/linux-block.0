Return-Path: <linux-fsdevel-owner@vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <de9e2460-3633-ee4b-904d-6510f9045b8b@deltatee.com>
Date: Tue, 6 Feb 2018 10:14:53 -0700
MIME-Version: 1.0
In-Reply-To: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 1/2] char_dev: Fix off-by-one bugs in find_dynamic_major()
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Thanks!

On 05/02/18 07:25 PM, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
> 
> CHRDEV_MAJOR_DYN_END and CHRDEV_MAJOR_DYN_EXT_END are valid major
> numbers. So fix the loop iteration to include them in the search for
> free major numbers.
> 
> While at it, also remove a redundant if condition ("cd->major != i"),
> as it will never be true.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


Logan
