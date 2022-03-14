Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 06:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiCNGQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiCNGQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 02:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3D22B1B0
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647238504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKkdg3dntOwBcgbQm1XQO9eQ5wZ2M2nVD2q0bsmUAZ0=;
        b=RLKWLDgZDq+UN35XMjCjpgJuEYiLnXjysnJa5q5dNfckJCfGPZ+20Jl+TpPTNf4Em6RabB
        HJnIEk1gmRVKGd5HIxdImxP3gcfRaQwDVQasZaZ2enqzqV/V88nk4YFpbEC7M77XPrdiUo
        rtbtCKe+Z0IQjVUbr48Rflf2pRcyBkY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-ZAfmDZJVPzq_qUfuOC7fdw-1; Mon, 14 Mar 2022 02:15:02 -0400
X-MC-Unique: ZAfmDZJVPzq_qUfuOC7fdw-1
Received: by mail-pf1-f199.google.com with SMTP id l138-20020a628890000000b004f7cb47178cso1071648pfd.12
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 23:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KKkdg3dntOwBcgbQm1XQO9eQ5wZ2M2nVD2q0bsmUAZ0=;
        b=3Rf+ZxuuDbpLFqHyGN3XOkj873haFi5PnCNnBIWSuhBYt+SIGDcTIEfzFKabUIj5HY
         0k2e5duSmPKohXN8rtlTTRCRRgvDpQb8c5YkhxFFhj/NjP1tAR+qRs45hFHjZAwD4BtP
         Lq+DkKvW6+rKx/9daKP4Htya4PBFbQ4jXSyDRFUrOl6ukKu+RqDZlhvVrYgQzF6S7fgq
         mEDEdvpKEnJDd3DWJ7yvWBvQLFjrMnvmrHxpIYHKJlcnQApt8mMO9Ef7EA4KKVyPA5Tq
         m5O6yqghLsJoBTA0Rf1EdPLVOPnkpuqdS9205dbv0d7XeSAdgDtpa7ikQrzokdHip3il
         +X/g==
X-Gm-Message-State: AOAM5321gdxN2WutTNENUYklI3M11RH6nSwcTCYpi1wjtQgE7uf8QymB
        Rz1m1V0Nbu8lU2165EGu7lPS1AY5aLCkyQYb1GUQLWp+wgBzVbXCJiB6h0zlcKpy5boX0Zz2RRY
        UbyNJTkLTP/Yjx1eYfloyosE=
X-Received: by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id f144-20020a623896000000b004f787dcde5bmr16575142pfa.49.1647238501356;
        Sun, 13 Mar 2022 23:15:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCjegCsMLdY4MyXbQThlNlXg5KFF47BFkhiTqq+eHo94WlQutLx6EM8a5QWMl/FeDK0C4Hbg==
X-Received: by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id f144-20020a623896000000b004f787dcde5bmr16575124pfa.49.1647238501100;
        Sun, 13 Mar 2022 23:15:01 -0700 (PDT)
Received: from [10.72.13.210] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n18-20020a628f12000000b004f743724c75sm18185318pfd.53.2022.03.13.23.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 23:15:00 -0700 (PDT)
Message-ID: <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
Date:   Mon, 14 Mar 2022 14:14:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>, mst@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220311152832.17703-1-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2022/3/11 下午11:28, Suwan Kim 写道:
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..3fcaf937afe1 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>   	 * deallocation of one or more of the sectors.
>   	 */
>   	__u8 write_zeroes_may_unmap;
> +	__u8 unused1;
>   
> -	__u8 unused1[3];
> +	__virtio16 num_poll_queues;
>   } __attribute__((packed));


This looks like a implementation specific (virtio-blk-pci) optimization, 
how about other implementation like vhost-user-blk?

Thanks

