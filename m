Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] compat_hdio_ioctl: Fix a declaration
To: Bart Van Assche <bart.vanassche@wdc.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170823222911.29453-1-bart.vanassche@wdc.com>
 <20170823222911.29453-3-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <75d229f8-347f-417e-a101-a6994be073a6@kernel.dk>
Date: Thu, 24 Aug 2017 08:40:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170823222911.29453-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/23/2017 04:29 PM, Bart Van Assche wrote:
> This patch avoids that sparse reports the following warning messages:
> 
> block/compat_ioctl.c:85:11: warning: incorrect type in assignment (different address spaces)
> block/compat_ioctl.c:85:11:    expected unsigned long *[noderef] <asn:1>p
> block/compat_ioctl.c:85:11:    got void [noderef] <asn:1>*
> block/compat_ioctl.c:91:21: warning: incorrect type in argument 1 (different address spaces)
> block/compat_ioctl.c:91:21:    expected void const volatile [noderef] <asn:1>*<noident>
> block/compat_ioctl.c:91:21:    got unsigned long *[noderef] <asn:1>p
> block/compat_ioctl.c:87:53: warning: dereference of noderef expression
> block/compat_ioctl.c:91:21: warning: dereference of noderef expression

Applied for 4.14, thanks Bart.

-- 
Jens Axboe
