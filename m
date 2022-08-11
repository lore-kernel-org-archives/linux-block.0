Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F12C25B06
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 23:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiHKXEG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiHKXEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 19:04:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6FB6E2FC
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 16:04:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 17so18150981plj.10
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XV3d3jsQUJYVJchztvaIBQqSUAMrrh69qI/8EtCuYe4=;
        b=tAYpw4CDkWc6eiIf/KCP+KBGnVlg8ib0fvqDt5ayrPmOQ3UDOO3arWXihLT3hSbZKj
         1pdlYcKzB+T4+SasFbEJMHOq/hP4vIojAIE07EA0aHkak71KSWZBqg5GapGWPMtJLR+T
         GWQhqJ6aYuIolDRFFAQSA5ibYCoyfDyxmshgkCAZsT/x/Gq39TTr0V8mlZWHQNlKK+bo
         VtX3WQYPMJWzrLJmDLGqRrEz1l878YJIcYf9Aei5WQqWVRInY6G8UDjqe/rXnqPky2As
         vI59jAUyB/EIs2MwGoH2eStvS3NW2P0nzF4GRBOzPfpXoAezr8zzT3N5KjemNsHcQkk4
         GAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XV3d3jsQUJYVJchztvaIBQqSUAMrrh69qI/8EtCuYe4=;
        b=h/uX+p0+UEhTi6br+BG07s/EO+rJsu7G1CYT1SjmVtUzv0he2lGOgVB/pPR21UMSud
         TXUfSrd5+Xjc15owgy8BLncGkLaQM8qQJoLMRSSGR9lb55mZk3CzeF7XkCTFXNScUwEZ
         iUeTJ8ZBuhcdUgDmVpd087cN3IlW61k+nxYQ5bGsoak2GhTtlZZOXBCZnCL+MmQktka4
         hgO08/0NueiYJVCoHaiu6jv4fdv0HKyv59mmzp617or+imYVk7VzdnF6rGwlyV5zGGmF
         QmihHDqLIw02SdCC6AXAcLRmTgRQ2TjI4jd5meBOIr3EJrD6XFZmPbRFfQpTq3QBf6Tp
         YZBQ==
X-Gm-Message-State: ACgBeo2LWLFiNNSBlqiOr/mK2b6o7hFYr/plEmYV0xe35I529q1Gu2K+
        AhEu4w+CHoP+fidH3nSHvikg9w==
X-Google-Smtp-Source: AA6agR7c5ZybC8xsrpjrvhBO6n0LEHYhEqXt4UG2OAj9R+Pf2rUxq/CaSStiRwn5gSOKfUmkZxXwJA==
X-Received: by 2002:a17:90a:b00b:b0:1f1:6023:dacd with SMTP id x11-20020a17090ab00b00b001f16023dacdmr10643291pjq.184.1660259043795;
        Thu, 11 Aug 2022 16:04:03 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w186-20020a627bc3000000b005289ef6db79sm232168pfc.32.2022.08.11.16.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 16:04:03 -0700 (PDT)
Message-ID: <05cfb9dc-c740-5764-35f9-b5636e0577cb@kernel.dk>
Date:   Thu, 11 Aug 2022 17:04:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] virtio-blk: Avoid use-after-free on suspend/resume
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        suwan.kim027@gmail.com
References: <20220810160948.959781-1-syoshida@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220810160948.959781-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/22 10:09 AM, Shigeru Yoshida wrote:
> +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +
> +	return vq;
> +}

Would probably be cleaner as:

static struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
{
	struct virtio_blk *vblk = hctx->queue->queuedata;

	return &vblk->vqs[hctx->queue_num];
}

dropping the 'vq' variable, and also dropping the inline as the compiler
will work that out anyway.

Apart from that minor nit, looks good to me.

-- 
Jens Axboe

