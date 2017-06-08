Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48152 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdFHAp7 (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 7 Jun 2017 20:45:59 -0400
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fix loop device flush before configure
From: James Wang <jnwang@suse.com>
In-Reply-To: <20170607131718.GC18252@infradead.org>
Date: Thu, 8 Jun 2017 08:45:31 +0800
Cc: axboe@fb.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com
Message-Id: <2D8954BF-E3D2-4A61-AAE2-A3FDD080C26A@suse.com>
References: <20170607090104.17337-1-jnwang@suse.com> <20170607131718.GC18252@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ok I got it blktests is a suite. I'd like to contribute something. If you need, we adapt you,;-)!
But I have to learn some how to do that, need time.

James
 
>From subway.

�� 2017��6��7�գ�21:17��Christoph Hellwig <hch@infradead.org> д����

>> Testing steps are following:
>> modprobe loop max_loop=64
>> dd if=/dev/zero of=disk bs=512 count=200K
>> for((i=0;i<4;i++))do losetup -f disk; done
>> mkfs.ext4 -F /dev/loop0
>> for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
>> for f in `ls /dev/loop[0-9]*|sort`; do \
>>    echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
>>    done
> 
> Can you write this up for blktests, please?
> 
