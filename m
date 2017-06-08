Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751450AbdFHHx7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jun 2017 03:53:59 -0400
Subject: Re: [PATCH] Fix loop device flush before configure v3
To: James Wang <jnwang@suse.com>, axboe@fb.com, efault@gmx.de
Cc: ming.lei@redhat.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com
References: <20170608065251.13961-1-jnwang@suse.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <6e68d055-4a1d-2b4c-6ddd-1071af162d3a@suse.de>
Date: Thu, 8 Jun 2017 09:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170608065251.13961-1-jnwang@suse.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/08/2017 08:52 AM, James Wang wrote:
> Test method:
> modprobe loop max_loop=64
> dd if=/dev/zero of=disk bs=512 count=200K
> for((i=0;i<4;i++))do losetup -f disk; done
> mkfs.ext4 -F /dev/loop0
> for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
> for f in `ls /dev/loop[0-9]*|sort`; do \
> 	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
> 	done
I think Christoph already asked this, but can you send a patch for
blktests [1] as well?

Thanks,
	Johannes

[1] https://github.com/osandov/blktests

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
