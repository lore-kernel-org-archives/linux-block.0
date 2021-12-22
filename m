Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD3C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 08:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhLVI1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhLVI1g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 03:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiCJI2Ld40vcwNQ1UmTsVWp+vpo93LIjdzoVcEzuB/c=;
        b=cS0D9eOISdGKjV++9qm/90FSsNQFdi4qntkl1ZcfZRayArsawtKO8mEnMKc9zyq1k6JPcc
        GcOFwtEP63YjBtKvpMCSeHII3sSorp6GG10U0nbbpkSUNCf1TMQljFG0b3QMMKwIJ2n13d
        Ej44MwegyZjmsT4PYnPy/RcL7rEpuxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-1cfffWTtNSGcCIrgj1CW1Q-1; Wed, 22 Dec 2021 03:27:34 -0500
X-MC-Unique: 1cfffWTtNSGcCIrgj1CW1Q-1
Received: by mail-wm1-f69.google.com with SMTP id r2-20020a05600c35c200b00345c3b82b22so742560wmq.0
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 00:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=YiCJI2Ld40vcwNQ1UmTsVWp+vpo93LIjdzoVcEzuB/c=;
        b=2luyv+tNxwcQi8zO772gsjznJLhTYlh5avlK3+DLCEn6bbOtJv1ZTH/sqXiONjNwH0
         t8gONXFEFsz+OLxkUdV3z0j0S9Nq2G/Vw9Z4qJ7A6wsoh4WjobVT6nwjMvCS//oulK/7
         AdZcmAY+d9It4ZE/mlYEy203tWFcz1Nc+16b9x95wbbWdtQc/RXMnOIJjc3iJEPPSdsq
         NbclMfk9JelNXgjshWJJkEYAB1gIgUNeP2FNWQlBpO5EUh7TOjFl3k/wCJElQz9qyLfK
         fzgkb640Sn4jSu6+VYv9K4IMYrjVbSK5yoU+JWnP+Y/5uCdJlUU5F2s8B4r1+UNBuxEP
         MsgA==
X-Gm-Message-State: AOAM532jRWymf677R4qpPxCAKqshBjOcMVv8HN+6r4VUxM6GnNBfQCqD
        pUPj+HCaghSvpu1Pfu1Sc8kn3qTrFdWJ7B2wJstyTSHLNA3yWgK27qSJ8XV9WniOF55eY75mJfb
        YIuV3QyeVkreaAXikbZdPu5w=
X-Received: by 2002:a7b:c457:: with SMTP id l23mr120647wmi.24.1640161653046;
        Wed, 22 Dec 2021 00:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWxMheKBopAqBgCXoAxuJXOZ6bUwWYRp22yAOCWcNz13FizqbU4zHNjtnz+PQeYZV6wpX7ng==
X-Received: by 2002:a7b:c457:: with SMTP id l23mr120634wmi.24.1640161652845;
        Wed, 22 Dec 2021 00:27:32 -0800 (PST)
Received: from [192.168.3.132] (p5b0c646a.dip0.t-ipconnect.de. [91.12.100.106])
        by smtp.gmail.com with ESMTPSA id u13sm5243476wmq.14.2021.12.22.00.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 00:27:32 -0800 (PST)
Message-ID: <94cb5c11-97b1-f157-ad8e-d916175e0690@redhat.com>
Date:   Wed, 22 Dec 2021 09:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peng Hao <flyingpenghao@gmail.com>, mst@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222011225.40573-1-flyingpeng@tencent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] virtio/virtio_mem: handle a possible NULL as a memcpy
 parameter
In-Reply-To: <20211222011225.40573-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.12.21 02:12, Peng Hao wrote:
> There is a check for vm->sbm.sb_states before, and it should check
> it here as well.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 96e5a8782769..b6b7c489c8b6 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -592,7 +592,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
>  		return -ENOMEM;
>  
>  	mutex_lock(&vm->hotplug_mutex);
> -	if (new_bitmap)
> +	if (vm->sbm.sb_states)
>  		memcpy(new_bitmap, vm->sbm.sb_states, old_pages * PAGE_SIZE);
>  
>  	old_bitmap = vm->sbm.sb_states;

Right, on the first iteration (vm->sbm.sb_states == NULL) we would copy
from NULL.

I wonder why this never failed so far. I guess that's because "the
behavior is undefined" if a NULL pointer is passed.

I assume the memcpy implementation that we've been using so far simply
skips the operation if they detect a NULL pointer, although according to
the standard the behavior is undefined:

"
AFAIK, most implementations allow null pointers for no-op calls to
memcpy() but gcc issues a warning when it detects at compile time
that a null pointer is passed as the first or second argument to
memcpy().
" [1]

Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")
Cc: stable@vger.kernel.org # v5.8+


Thanks!

[1]
https://mail-archives.apache.org/mod_mbox/stdcxx-dev/200804.mbox/%3CCFFDD219128FD94FB4F92B99F52D0A49010A36F4@exchmail01.Blue.Roguewave.Com%3E

-- 
Thanks,

David / dhildenb

