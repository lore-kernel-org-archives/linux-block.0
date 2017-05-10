Subject: Re: [PATCH] blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error
 on dd with split op
To: wenxiong@linux.vnet.ibm.com, linux-block@vger.kernel.org
References: <1494424451-856-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Cc: brking@linux.vnet.ibm.com, dougmill@linux.vnet.ibm.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <7e276e31-68fb-6e63-ef0c-14b0b4e66673@fb.com>
Date: Wed, 10 May 2017 08:02:43 -0600
MIME-Version: 1.0
In-Reply-To: <1494424451-856-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/10/2017 07:54 AM, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> 
> When formatting NVMe to 512B/4K + T10 DIf/DIX, dd with split op returns
> "Input/output error". Looks block layer split the bio after calling
> bio_integrity_prep(bio). This patch fixes the issue.
> 
> Below is how we debug this issue:
> (1)format nvme to 4K block # size with type 2 DIF
> (2)dd with block size bigger than 1024k.
> oflag=direct
> dd: error writing '/dev/nvme0n1': Input/output error
> 
> We added some debug code in nvme device driver. It showed us the first
> op and the second op have the same bi and pi address. This is not
> correct.
> 
> 1st op: nvme0n1 Op:Wr slba 0x505 length 0x100, PI ctrl=0x1400,
> 	dsmgmt=0x0, AT=0x0 & RT=0x505
> 	Guard 0x00b1, AT 0x0000, RT physical 0x00000505 RT virtual 0x00002828
> 
> 2nd op: nvme0n1 Op:Wr slba 0x605 length 0x1, PI ctrl=0x1400, dsmgmt=0x0,
> 	AT=0x0 & RT=0x605  ==> This op fails and subsequent 5 retires..
> 	Guard 0x00b1, AT 0x0000, RT physical 0x00000605 RT virtual 0x00002828
> 
> With the fix, It showed us both of the first op and the second op have
> correct bi and pi address.
> 
> 1st op: nvme2n1 Op:Wr slba 0x505 length 0x100, PI ctrl=0x1400,
> 	dsmgmt=0x0, AT=0x0 & RT=0x505
> 	Guard 0x5ccb, AT 0x0000, RT physical 0x00000505 RT virtual
> 	0x00002828
> 2nd op: nvme2n1 Op:Wr slba 0x605 length 0x1, PI ctrl=0x1400, dsmgmt=0x0,
> 	AT=0x0 & RT=0x605
> 	Guard 0xab4c, AT 0x0000, RT physical 0x00000605 RT virtual
> 	0x00003028

Good catch, your fix looks correct to me.


-- 
Jens Axboe
