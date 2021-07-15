Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE861C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 11:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2961278
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 11:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhGOLZV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 07:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240818AbhGOLZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 07:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626348146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3XMjsLqmL6fZAAA+JBtyt58Zb9isCAphRrAoufbmyY=;
        b=gGqXWSAqUdtKoN5RqiXiSDJUUylntgAneUf/dCPJRUcfVFBGKTyeYzC+KF+S5ICn2Uxv71
        wW6MXE/U+n4CJ/OJyy6NLmGm0TtR5TyvIWkBCXTS7j5zbIEj70iSxQQkRFH0pdRTmFgWnb
        HdIjhrOEZoNnoHrcpO8QW9cFSpP4kmM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-Ka_3RBDyNRm0nAaJhTW_Cw-1; Thu, 15 Jul 2021 07:22:25 -0400
X-MC-Unique: Ka_3RBDyNRm0nAaJhTW_Cw-1
Received: by mail-wr1-f70.google.com with SMTP id r18-20020adfce920000b029013bbfb19640so3142016wrn.17
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 04:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3XMjsLqmL6fZAAA+JBtyt58Zb9isCAphRrAoufbmyY=;
        b=dO/L1IOC99Mb214xZn05bfo8c7CzFZQDXLyTOQJsi9Wf8PC1M4NipoXCTfDkvRd+sI
         MbVx30MMx8YY0ivd7xQmrmRGj7jxDuRrsg8fbxgzz1J605guFmmKovD2KO3G0FEhg4T4
         u4zTCNVC3Ka6G1AjQzYeFzPJn8P7sN7Fvk9v9ChrVT/d6cUeIjNBdAa1g4NtKQ+vDIKW
         O1OeCiOpf7BZbKr93cZy9c3FVilIqfIsuUVmR9R/8XsEZItA8Oo0ZNWTT2e+otLhDdBQ
         2hAirHb1Piks+1z85zHp+qF3lJIFW9sXppQtq1XXBDPTKtmJN92U20r6xPUYAfQ7HAur
         G56Q==
X-Gm-Message-State: AOAM530p6wFaY2y4LtCWHyXTvQSjLPUdXSjv6B1v/imIHFQYxVYUEJ5L
        mHLqznq7YnpGsjSZt4098VWXEkrsqeXpIZsoarJK4qkpramsVfZtvceIy2jhKTTkAtrBt9qri5D
        O5vCZBEz1xTkB3qiHj1AREi0=
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr4822757wrv.323.1626348143923;
        Thu, 15 Jul 2021 04:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxUBHhfe+A3WtzBYo5eZtyU+fS1EBqnOvDIUROVv21BrPU/0Ixxe0AbzLRTePqxWt25P3MgA==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr4822740wrv.323.1626348143761;
        Thu, 15 Jul 2021 04:22:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id w15sm8708936wmi.3.2021.07.15.04.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 04:22:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To:     Yury Kamenev <damtev@yandex-team.ru>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        hch@lst.de, cand@gmx.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715094707.19997-1-damtev@yandex-team.ru>
 <20210715094707.19997-2-damtev@yandex-team.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd3c75a-63b3-427c-c54c-cd12587ba58b@redhat.com>
Date:   Thu, 15 Jul 2021 13:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715094707.19997-2-damtev@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/07/21 11:47, Yury Kamenev wrote:
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +	if (unlikely(partitions_scanning_disable))
> +		/* disable partitions scanning if it was stated in virtio features*/
> +		if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PART_SCAN))
> +			vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
> +#endif
> +

Has this been added to the spec?  It doesn't seem like a good idea, as 
pointed out by Stefan[1], Christoph[2] and myself[3].

Paolo

[1] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#m2697cb41578490aad49ed1d8fa6604bf0924b54d
[2] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#mc59329fd824102f94ac2f6b29fe94a652849aca0
[3] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#mee6787c4fd87790b64feccc9e77fd5f618c2c336

