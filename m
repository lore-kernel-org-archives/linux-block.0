Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49057 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdFGNRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2017 09:17:48 -0400
Date: Wed, 7 Jun 2017 06:17:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Wang <jnwang@suse.com>
Cc: axboe@fb.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com
Subject: Re: [PATCH] Fix loop device flush before configure
Message-ID: <20170607131718.GC18252@infradead.org>
References: <20170607090104.17337-1-jnwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607090104.17337-1-jnwang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Testing steps are following:
> modprobe loop max_loop=64
> dd if=/dev/zero of=disk bs=512 count=200K
> for((i=0;i<4;i++))do losetup -f disk; done
> mkfs.ext4 -F /dev/loop0
> for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
> for f in `ls /dev/loop[0-9]*|sort`; do \
> 	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
> 	done

Can you write this up for blktests, please?
