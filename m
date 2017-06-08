Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdFHCmG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Jun 2017 22:42:06 -0400
Date: Thu, 8 Jun 2017 10:41:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: James Wang <jnwang@suse.com>
Cc: axboe@fb.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com
Subject: Re: [PATCH] Fix loop device flush before configure v2
Message-ID: <20170608024149.GC5602@ming.t460p>
References: <20170608021734.5025-1-jnwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608021734.5025-1-jnwang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 08, 2017 at 10:17:34AM +0800, James Wang wrote:
> This condition check was exist at before commit b5dd2f6047ca ("block: loop:
> improve performance via blk-mq") When add MQ support to loop device, it be
> removed because the member of '->lo_thread' be removed. And then upstream
> add '->worker_task', I think they forget add it to here.
> 
> When I install SLES-12 product is base on 4.4 kernel I found installer will
> hang +60 second at scan disks. and I found LVM tools would take this action.
> finally I found this problem is more obvious on AMD platform. This problem
> will impact all scenarios that scan loop devcie.
> 
> When the loop device didn't configure backing file or Request Queue, we
> shouldn't to cost a lot of time to flush it.
> 
> Testing steps are following:
> modprobe loop max_loop=64
> dd if=/dev/zero of=disk bs=512 count=200K
> for((i=0;i<4;i++))do losetup -f disk; done
> mkfs.ext4 -F /dev/loop0
> for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
> for f in `ls /dev/loop[0-9]*|sort`; do \
> 	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
> 	done
> 
> Testing data is following:
> /dev/loop0	<rpm-4.4.68-2> <+patched>
> 		8.1217e-05 	8.3842e-05
> /dev/loop1
> 		6.1114e-05 	0.000147979
> /dev/loop10
> 		0.414701 	0.000116564
> /dev/loop11
> 		0.7474 		6.7942e-05
> /dev/loop12
> 		0.747986 	8.9082e-05
> /dev/loop13
> 		0.746532 	7.4799e-05
> /dev/loop14
> 		0.480041 	9.3926e-05
> /dev/loop15
> 		1.26453 	7.2522e-05
> 
> From /dev/loop10 start, loop isn't mounted. but it take more time than
> mounted devices. And The data differ by several orders of magnitude.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> 
> Signed-off-by: James Wang <jnwang@suse.com>
> ---
>  drivers/block/loop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 48f6fa6f810e..2e5b8538760c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -625,6 +625,9 @@ static int loop_switch(struct loop_device *lo, struct file *file)
>   */
>  static int loop_flush(struct loop_device *lo)
>  {
> +	/* loop not yet configured, no running thread, nothing to flush */
> +	if (lo->lo_state != Lo_bound)
> +		return 0;
>  	return loop_switch(lo, NULL);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
