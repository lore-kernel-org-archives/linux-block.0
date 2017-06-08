Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:40374 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdFHIOF (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 8 Jun 2017 04:14:05 -0400
Subject: Re: [PATCH] Fix loop device flush before configure v3
To: Johannes Thumshirn <jthumshirn@suse.de>, axboe@fb.com,
        efault@gmx.de
Cc: ming.lei@redhat.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com
References: <20170608065251.13961-1-jnwang@suse.com>
 <6e68d055-4a1d-2b4c-6ddd-1071af162d3a@suse.de>
From: James Wang <jnwang@suse.com>
Message-ID: <34d87480-d52a-42c5-f0e2-fbf89c832a42@suse.com>
Date: Thu, 8 Jun 2017 16:13:36 +0800
MIME-Version: 1.0
In-Reply-To: <6e68d055-4a1d-2b4c-6ddd-1071af162d3a@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 06/08/2017 03:53 PM, Johannes Thumshirn wrote:
> On 06/08/2017 08:52 AM, James Wang wrote:
>> Test method:
>> modprobe loop max_loop=64
>> dd if=/dev/zero of=disk bs=512 count=200K
>> for((i=0;i<4;i++))do losetup -f disk; done
>> mkfs.ext4 -F /dev/loop0
>> for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
>> for f in `ls /dev/loop[0-9]*|sort`; do \
>> 	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
>> 	done
> I think Christoph already asked this, but can you send a patch for
> blktests [1] as well?
I have forked this project and I'm working on it.
due to framework is limited, so I'm adjusting my code.
> Thanks,
> 	Johannes
>
> [1] https://github.com/osandov/blktests
>

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
