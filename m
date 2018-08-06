Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] xen-blkfront: use true and false for boolean values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180805000859.GA20132@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <40c7f420-804c-6ea4-c4aa-11dd35bf9ce5@kernel.dk>
Date: Mon, 6 Aug 2018 08:15:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180805000859.GA20132@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/4/18 6:08 PM, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.

Applied, thanks.

-- 
Jens Axboe
