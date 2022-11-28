Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC3C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 09:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiK1Jav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 04:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiK1Jar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 04:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFC13F93
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXe5/Gs5NMc9hqQvF6Q+od4uwWeU4d6k98E6eiWSSHg=;
        b=AVqVd6TGQeIDyPh68Ta5EVvrDu7aWB0Uc43D7fsE+8ng1jms2/x3RcTQ7bTA6sX25s+aHY
        PxQS9kUTp1kuNGrt5IgElq4US1mOOLQf3+KBcok8hpNins5ywXNVjOKsu+6chNTDp3mDEq
        H8Isv9VsC62KeCFjc5V/X4JqZNzAM14=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-uCn9S3JFPOq1r0NGw7PgDg-1; Mon, 28 Nov 2022 04:29:42 -0500
X-MC-Unique: uCn9S3JFPOq1r0NGw7PgDg-1
Received: by mail-wr1-f70.google.com with SMTP id k1-20020adfb341000000b0024215e0f486so429123wrd.21
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 01:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXe5/Gs5NMc9hqQvF6Q+od4uwWeU4d6k98E6eiWSSHg=;
        b=nfaOtIzaWV8cUX+yjsBXUhLlY7XUZ8SNeUziWLIG9f02I99yM8UwwqN/wuM98bQ30u
         7xsyKR+Jc5DaXl2IZFwsYUzNqcAWMkTUeUslNW8TjaJzfm9gWSXkVrR0LAOQlTJN6HPK
         CXPrseBXOogUI31LzurJt6kie4dWxJsAS2qK/CLUKwJACROKwwbRxiuo8ExAl1Z9WRCn
         sJUePC50viFaAtSOiJ+YlvBuiJ62pvZTXvlv/pzFsW5LrFP+3ubcr766nZC98pJMn5iC
         k7tvnSZXxrdKC5P2CTPW/3Qh8n5GZjQ+dBOSCiLi7OuHRuaPEzmN54v7GOkqQQ9I35JB
         FM0Q==
X-Gm-Message-State: ANoB5pk/mUwOV/puKMR1Ma9kCV03R9RWTfNx+yHIJ+Ka+JGUSB+gO5/T
        e8a1UT4YVU5gZn3P5Iol60lc47E9TuEZOe5293XBcBt/3WU9XwmDbYnoL0YFkP3CSx6P45PcbB6
        Vv8Euu084odvF2i7vBVgkSS0=
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id v6-20020adfebc6000000b00241c6d8be83mr22842217wrn.454.1669627781436;
        Mon, 28 Nov 2022 01:29:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5NNWLiFYkS/4BWx2K5W3KIsae1W7cB7QkH/0YG2DaPbKUxNFXJ8iBUflEeJZH3AcNSktTgUw==
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id v6-20020adfebc6000000b00241c6d8be83mr22842182wrn.454.1669627781095;
        Mon, 28 Nov 2022 01:29:41 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc7ce000000b003cf78aafdd7sm14055513wmk.39.2022.11.28.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:29:40 -0800 (PST)
Date:   Mon, 28 Nov 2022 04:29:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, kraxel@redhat.com, david@redhat.com,
        ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 3/4] virtio-input: Fix probe failed when modprobe
 virtio_input
Message-ID: <20221128042649-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128021005.232105-4-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128021005.232105-4-lizetao1@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 28, 2022 at 10:10:04AM +0800, Li Zetao wrote:
> When doing the following test steps, an error was found:
>   step 1: modprobe virtio_input succeeded
>     # modprobe virtio_input      <-- OK
> 
>   step 2: fault injection in input_allocate_device()
>     # modprobe -r virtio_input   <-- OK
>     # ...
>       CPU: 0 PID: 4260 Comm: modprobe Tainted: G        W
>       6.1.0-rc6-00285-g6a1e40c4b995-dirty #109
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>       Call Trace:
>        <TASK>
>        should_fail.cold+0x5/0x1f
>        ...
>        kmalloc_trace+0x27/0xa0
>        input_allocate_device+0x43/0x280
>        virtinput_probe+0x23b/0x1648 [virtio_input]
>        ...
>        </TASK>
>       virtio_input: probe of virtio5 failed with error -12
> 
>   step 3: modprobe virtio_net failed
>     # modprobe virtio_input       <-- failed
>       virtio_input: probe of virtio1 failed with error -2
> 
> The root cause of the problem is that the virtqueues are not
> stopped on the error handling path when input_allocate_device()
> fails in virtinput_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. After
> virtinput_init_vqs() succeeded, all virtqueues should be
> stopped on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")

Probably 271c865161c57cfabca45b93eaa712b19da365bc


> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/virtio/virtio_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index 3aa46703872d..f638f1cd3531 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -330,6 +330,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>  err_mt_init_slots:
>  	input_free_device(vi->idev);
>  err_input_alloc:
> +	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
>  err_init_vq:
>  	kfree(vi);
> -- 
> 2.25.1

