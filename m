Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9968AC04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 19:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4F76140B
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhEXTmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 15:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233171AbhEXTmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 15:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621885268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcfSAHV/HbBYuaNWDdQvTZ83TZMYeFvwpY5VZffsoCQ=;
        b=grIN13C7EQn4IgpAWyeyS7JixRWDGWmvo8n3IaU8LXL8MRb4zIu7RD+8NbK/Jzt5A2vO3R
        GqqaVWOkYYRe5TMO2zVTSgvw+bHHj4oin/am6ysAWCP808gBR/ec7R4wbPAqMHqWQ5I/qB
        Bk0uThhlppaB/aKf4SJvpwd2bnarxgY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-maYOjeVQPHG3EXrF-KpEAA-1; Mon, 24 May 2021 15:41:05 -0400
X-MC-Unique: maYOjeVQPHG3EXrF-KpEAA-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a50cc920000b029038cf491864cso16068449edi.14
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 12:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QcfSAHV/HbBYuaNWDdQvTZ83TZMYeFvwpY5VZffsoCQ=;
        b=JdFvdl03pLXLyCCFm3/N5rz/dGbROjyvzTZP0dqbEhftSGMh57wwE8Um+6XJXpYJlZ
         QdJtDskBwUPo5v8EJDjnzeuGU+29b8RTZpfV5fXM+Kq14YJwLzS2d3YY+Ws5iT9tNPML
         SDRKxzCMBsdo8rNHzGNERnOtUep48WGMyAvZAMI5P5zKI6UGg3x3TRbwkl36WSOJedoR
         LOMOpXxXfJ5K+zrom8xnS5NEqPgt1bf3vaCVoakywHV3bsGQHP9xvUgistCvKwVP3igM
         bS8kS5T+7whzuyVDfZ43pdXHZJQzWda7U3m/CnQvss7vazQeUsWxAjJf8bl9Br4AjMLv
         rmCw==
X-Gm-Message-State: AOAM5303OLcLUx5hq3qLTOHyi6OlBTTIOkui3YIz0emLtfKWf3s1nvMK
        M0k84kl9PxKTiE2YKHDY0ibItZRUdCpZe3b53tDkxhD8VGC32BsXwU6ahvRMjfZwNnkY0HBzVQX
        EEbUoX5o3/izLLYH2xtsGDkc=
X-Received: by 2002:a17:906:9bd6:: with SMTP id de22mr24479788ejc.382.1621885264647;
        Mon, 24 May 2021 12:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb4isv8pBsruVvEy4nUeVgEq0+hKwTOOLp/Fu8OxjdxDfKOhmSPBcjZq+SxEFJohnfubgZfQ==
X-Received: by 2002:a17:906:9bd6:: with SMTP id de22mr24479772ejc.382.1621885264427;
        Mon, 24 May 2021 12:41:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t9sm10273326edf.70.2021.05.24.12.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 12:41:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To:     =?UTF-8?B?0K7RgNC40Lkg0JrQsNC80LXQvdC10LI=?= 
        <damtev@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210520133908.98891-1-damtev@yandex-team.ru>
 <20210520133908.98891-2-damtev@yandex-team.ru>
 <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
 <90021621883891@mail.yandex-team.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21b08ea7-71c6-1b4b-3833-1c51d0e1d310@redhat.com>
Date:   Mon, 24 May 2021 21:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <90021621883891@mail.yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/05/21 21:34, Юрий Каменев wrote:
> Hi
> 
>     Is your goal to avoid accidentally detecting partitions because it's
>     confusing when that happens?
> 
> The main goal is reducing the kernel start time. It might be use useful 
> in tiny systems that use, for example, squashfs images with certainly no 
> partitions. Disabling partitions scanning for these images can save a 
> few tens of milliseconds which can be a significant acceleration for 
> starting such systems.

Perhaps that could be configured in the image, for example in the kernel 
command line?

Paolo

> 24.05.2021, 17:29, "Stefan Hajnoczi" <stefanha@redhat.com>:
> 
>     On Thu, May 20, 2021 at 04:39:08PM +0300, Yury Kamenev wrote:
> 
>     Hi,
>     Is there a VIRTIO spec change for the new VIRTIO_BLK_F_NO_PS feature
>     bit? Please send one:
>     https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback
>     <https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback>
> 
>     GENHD_FL_NO_PART_SCAN is not used much in other drivers. This makes me
>     wonder if the same use case is addressed through other means with SCSI,
>     NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
>     adding a bit to disable partition scanning for a virtio-blk fits into
>     the big picture?
> 
>     Is your goal to avoid accidentally detecting partitions because it's
>     confusing when that happens?
> 
>     VIRTIO is currently undergoing auditing and changes to support untrusted
>     devices. From that perspective adding a device feature bit to disable
>     partition scanning does not help protect the guest from an untrusted
>     disk. The guest cannot trust the device, instead the guest itself would
>     need to be configured to avoid partition scanning of untrusted devices.
> 
>     Stefan
> 
>           Signed-off-by: Yury Kamenev <damtev@yandex-team.ru
>         <mailto:damtev@yandex-team.ru>>
>           ---
>            drivers/block/virtio_blk.c | 6 ++++++
>            include/uapi/linux/virtio_blk.h | 1 +
>            2 files changed, 7 insertions(+)
> 
>           diff --git a/drivers/block/virtio_blk.c
>         b/drivers/block/virtio_blk.c
>           index b9fa3ef5b57c..17edcfee2208 100644
>           --- a/drivers/block/virtio_blk.c
>           +++ b/drivers/block/virtio_blk.c
>           @@ -799,6 +799,10 @@ static int virtblk_probe(struct
>         virtio_device *vdev)
>                    vblk->disk->flags |= GENHD_FL_EXT_DEVT;
>                    vblk->index = index;
> 
>           + /*Disable partitions scanning for no-partitions block*/
> 
> 
>     Formatting cleanup and rephrasing:
> 
>        /* Disable partition scanning for devices with no partitions */
> 
>           + if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PS))
> 
> 
>     I suggest user a more obvious name:
> 
>        VIRTIO_BLK_F_NO_PART_SCAN
> 
>           + vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
>           +
>                    /* configure queue flush support */
>                    virtblk_update_cache_mode(vdev);
> 
>           @@ -977,6 +981,7 @@ static unsigned int features_legacy[] = {
>                    VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>                    VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
>         VIRTIO_BLK_F_CONFIG_WCE,
>                    VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>         VIRTIO_BLK_F_WRITE_ZEROES,
>           + VIRTIO_BLK_F_NO_PS,
>            }
>            ;
>            static unsigned int features[] = {
>           @@ -984,6 +989,7 @@ static unsigned int features[] = {
>                    VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>                    VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
>         VIRTIO_BLK_F_CONFIG_WCE,
>                    VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>         VIRTIO_BLK_F_WRITE_ZEROES,
>           + VIRTIO_BLK_F_NO_PS,
>            };
> 
>            static struct virtio_driver virtio_blk = {
>           diff --git a/include/uapi/linux/virtio_blk.h
>         b/include/uapi/linux/virtio_blk.h
>           index d888f013d9ff..f197d07afb05 100644
>           --- a/include/uapi/linux/virtio_blk.h
>           +++ b/include/uapi/linux/virtio_blk.h
>           @@ -40,6 +40,7 @@
>            #define VIRTIO_BLK_F_MQ 12 /* support more than one vq */
>            #define VIRTIO_BLK_F_DISCARD 13 /* DISCARD is supported */
>            #define VIRTIO_BLK_F_WRITE_ZEROES 14 /* WRITE ZEROES is
>         supported */
>           +#define VIRTIO_BLK_F_NO_PS 16 /* No partitions */
> 
>            /* Legacy feature bits */
>            #ifndef VIRTIO_BLK_NO_LEGACY
>           --
>           2.24.3 (Apple Git-128)
> 

