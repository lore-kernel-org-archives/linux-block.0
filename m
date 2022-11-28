Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3410CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 08:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiK1IX7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiK1IXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 03:23:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41517895
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669623765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08ACbZbm+f4rrW15utHPQxye3zrEyxUiKLzM8Bx4A7A=;
        b=SUpPF0G0e0NB6CO9x3nq+Yil42xUzUucTVYoICoWAKVBZXB6GZCF4q+JV1xwPqS+XXJgCr
        FBYv7O6jz8dwSXfqRJvq/Me26avZCA98vDz+Jcso4s7mhzPHbRTkMPcjrik0HtcPv27BYI
        TBZ5xNPvhSE06W7qchDyJteVfqefsu8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-9aBKQM42OMq2apmtsYt2xA-1; Mon, 28 Nov 2022 03:22:44 -0500
X-MC-Unique: 9aBKQM42OMq2apmtsYt2xA-1
Received: by mail-wr1-f72.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so1612800wra.13
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 00:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08ACbZbm+f4rrW15utHPQxye3zrEyxUiKLzM8Bx4A7A=;
        b=7zum3qRzAyuErCncIv4hvBaTY/NyYiJRvarL/iBVs+vUBdgcbHz2tNiLpEMrUeI4gN
         y6JoLwzZeb0QmtFBJ5nmZKqzlh5UxdJBalH22insiMc3E7z3FezqBypcBtDEvMa+Shh1
         sQkEVBPf5EjevTyEa1AvyrOUkQ7TpuqTv5JnQZBKonFXcOKfeNan/eTB8yi1WEG/dQNT
         G4P+BHYW2cidVdCh0O6NFyEGI57qi+j4oeWuGw/845ZmLVhl/7/POk4I2UTwmqU4YgeI
         2bxZWPG6qOndKppjjG3cZHWcxmjKSF8PSmS8w5hS9VXvjT2PM8ahBKElL8TYopQA6xpQ
         QPaQ==
X-Gm-Message-State: ANoB5pkTCDns2+43SVBaey3KdK9arDtN9nWsaDsHnAwO/XoQMIQG1agC
        r7AoJu8QWZ6yB53bhMyfSCSND6iXPclvYJfr2BEH2dY0l1JiYvRg4T1G6UeQ14HpWgVesJ6dGhO
        ahw71eeplJ8VSxk2lM81k6Lo=
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id t10-20020adfeb8a000000b0022e31b2ecb9mr30942294wrn.693.1669623763100;
        Mon, 28 Nov 2022 00:22:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50AS2I3KjwPnQrek1jGvg+yRK5+MF+33CkcubpJsA9CW/SHNSir8fcEWGsp4QA6DOlcXT2PQ==
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id t10-20020adfeb8a000000b0022e31b2ecb9mr30942267wrn.693.1669623762803;
        Mon, 28 Nov 2022 00:22:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id l19-20020a056000023300b00241de5be3f0sm10082939wrz.37.2022.11.28.00.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:22:42 -0800 (PST)
Message-ID: <af62e7fe-d848-acb8-ca77-cdf01022b8de@redhat.com>
Date:   Mon, 28 Nov 2022 09:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Li Zetao <lizetao1@huawei.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, kraxel@redhat.com, ericvh@gmail.com,
        lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rusty@rustcorp.com.au
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128021005.232105-3-lizetao1@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/4] virtio-mem: Fix probe failed when modprobe virtio_mem
In-Reply-To: <20221128021005.232105-3-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28.11.22 03:10, Li Zetao wrote:
> When doing the following test steps, an error was found:
>    step 1: modprobe virtio_mem succeeded
>      # modprobe virtio_mem      <-- OK
> 
>    step 2: fault injection in virtio_mem_init()
>      # modprobe -r virtio_mem   <-- OK
>      # ...
>        CPU: 0 PID: 1837 Comm: modprobe Not tainted
>        6.1.0-rc6-00285-g6a1e40c4b995-dirty
>        Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>        Call Trace:
>         <TASK>
>         should_fail.cold+0x5/0x1f
>         ...
>         virtio_mem_init_hotplug+0x9ae/0xe57 [virtio_mem]
>         virtio_mem_init.cold+0x327/0x339 [virtio_mem]
>         virtio_mem_probe+0x48e/0x910 [virtio_mem]
>         virtio_dev_probe+0x608/0xae0
>         ...
>         </TASK>
>        virtio_mem virtio4: could not reserve device region
>        virtio_mem: probe of virtio4 failed with error -16
> 
>    step 3: modprobe virtio_net failed

virtio_net ?

>      # modprobe virtio_mem       <-- failed
>        virtio_mem: probe of virtio4 failed with error -16
> 
> The root cause of the problem is that the virtqueues are not
> stopped on the error handling path when virtio_mem_init()
> fails in virtio_mem_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. After
> virtio_mem_init_vq() succeeded, all virtqueues should be
> stopped on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")

That commit is from 2014. virtio-mem was merged in 2020

Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")

> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/virtio/virtio_mem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 0c2892ec6817..c7f09c2ce982 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2793,6 +2793,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>   
>   	return 0;
>   out_del_vq:
> +	virtio_reset_device(vdev);
>   	vdev->config->del_vqs(vdev);
>   out_free_vm:
>   	kfree(vm);


Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

