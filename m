Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D88C4321E
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 14:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiK1O66 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiK1O6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 09:58:54 -0500
X-Greylist: delayed 1865 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 06:58:53 PST
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FA71FD
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=6y8qtBVWyVYV+kHOTmBodkRQ5Mtx1AgXX7cehonYoLI=; b=MnC6Hi29ZLGxJmlJOrpukroGFu
        Gx+zUdlvsgFJXJnbdbA/MDiHDgEv99YPt72TJOxn00O8JogVMcbmKx50sjdJxj6qBedQyMgH2hYyi
        OsUxLmAz5qct429ffXgYRWfTb6LlqBriGYBWqkDVZlwVYPjslEb35+3gyd+6cGSkw7fOwpqUK7aTP
        pLcdtXpgoxq8yIu84pEAzwuPtlngHNQ83jMe0g/FOR8AOSo8QWTAhqS8NNMVFldMUvlsFzAILbbsv
        +3+Pt8oYGB8ouP5Gni5ql3iACYHNnBQDWO1uuVUHyXt/lpq0ZT9WU4OToD7H7bP/dFj7p0Gf01dM6
        Q/83nsFfNKvPKfLCRnabao9+cQApCUC6Rajzq8ySmdCQVYqKaiun8A1OAPT69fS+/5kBgt91lCZ01
        a6htQUJw/PQytt9gNExLtjAkHoDGj5eLZYsAcUvZV9wG7FXMJWdbU1Off/e3CtqEoDHOcooX9dN4W
        1PyZjyU2Nd8WxJ6HBLO0vvH5wmpAMESfkiCJpOFghmM9dDQQ+rk0Z30lJS8qtAnRfJMfW4/di8vtz
        fpVfMaog+ZGC3J55w9uVSh55VtBDmVfvE6tTp5CTRUrSKx0YIHYQE0y8iRcgqFdv9UUYfTuut0Eg7
        YA1FND8HIdKagQiNtjiLdB3Q+XyIns4lvnvVlHoqA=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, kraxel@redhat.com,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        Li Zetao <lizetao1@huawei.com>
Cc:     lizetao1@huawei.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] 9p: Fix probe failed when modprobe 9pnet_virtio
Date:   Mon, 28 Nov 2022 15:27:16 +0100
Message-ID: <12013317.ToeGUHxLYt@silver>
In-Reply-To: <20221128021005.232105-2-lizetao1@huawei.com>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128021005.232105-2-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Monday, November 28, 2022 3:10:02 AM CET Li Zetao wrote:
> When doing the following test steps, an error was found:
>   step 1: modprobe 9pnet_virtio succeeded
>     # modprobe 9pnet_virtio      <-- OK
> 
>   step 2: fault injection in sysfs_create_file()
>     # modprobe -r 9pnet_virtio   <-- OK
>     # ...
>       FAULT_INJECTION: forcing a failure.
>       name failslab, interval 1, probability 0, space 0, times 0
>       CPU: 0 PID: 3790 Comm: modprobe Tainted: G        W
>       6.1.0-rc6-00285-g6a1e40c4b995-dirty #108
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>       Call Trace:
>        <TASK>
>        ...
>        should_failslab+0xa/0x20
>        ...
>        sysfs_create_file_ns+0x130/0x1d0
>        p9_virtio_probe+0x662/0xb30 [9pnet_virtio]
>        virtio_dev_probe+0x608/0xae0
>        ...
>        </TASK>
>       9pnet_virtio: probe of virtio3 failed with error -12
> 
>   step 3: modprobe virtio_net failed
>     # modprobe 9pnet_virtio       <-- failed
>       9pnet_virtio: probe of virtio3 failed with error -2
> 
> The root cause of the problem is that the virtqueues are not
> stopped on the error handling path when sysfs_create_file()
> fails in p9_virtio_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. After
> virtio_find_single_vq() succeeded, all virtqueues should be
> stopped on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---

As others said, comment should probably be adjusted, apart from that:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  net/9p/trans_virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index e757f0601304..39933187284b 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -668,6 +668,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  out_free_tag:
>  	kfree(tag);
>  out_free_vq:
> +	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
>  out_free_chan:
>  	kfree(chan);
> 




