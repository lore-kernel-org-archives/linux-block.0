Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9ECC4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiKPVvt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbiKPVv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D71266CAC
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w8sc6ccmIuZ5y2kueBPTj95unxJJNUHkbfTdAl9rzY=;
        b=QHnqi2au6ulWd51K8a5mp1XKsKfCEX3e6RXWy2fKOlbDfln0j95K7OhSGABSZk5pZqEizt
        HrolOCHY1p+bWJ3vRk9LfdYIDch+BY3uapUar9yV9rjxqOGxoEm1tQ/Ay+wvYhCQPKB/Xq
        JPTPzbESC6TMlm7JSei+LWHpZTKcThU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-1iyCq_fnP0-mSEerXLtWRw-1; Wed, 16 Nov 2022 16:49:59 -0500
X-MC-Unique: 1iyCq_fnP0-mSEerXLtWRw-1
Received: by mail-qv1-f71.google.com with SMTP id l6-20020ad44446000000b004bb60364075so14472874qvt.13
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w8sc6ccmIuZ5y2kueBPTj95unxJJNUHkbfTdAl9rzY=;
        b=Rg7kuugd5yMLmeYZf5hXAzl97Ia905pbIHypDcDWUJ5KH/uvdPiteZYsX0cVSArZMj
         xeLpuadEx7saf8yum8ZoiSUMqAO75Q8bU6M0AK2yVd0ScxoupGjd6NpH7yE9yIFKBILk
         MEPAQ5SVSlaiFm5is8P7ip4OJaKd5qaspbRNmG1hnOsAkZkMcdwgZ0dt7jyQx16MKd4K
         Jk2GvCkcPvpPGxFWFW66VofN1jf2/J27p/ryCHFiD9qPI4kY7haTPWT0+RA7uwJl8eLN
         V7iPr2gYMEbz5MQ3Ha+AL83Mb9ylR6nIYLVMljvWt3ghvGi0K03Rdhtj7e+jB6I8PScZ
         vGVA==
X-Gm-Message-State: ANoB5plOrElbSGN+juPNxTiAwQQmrY9gCbxcVzj1yC/qd5vdvVpcaMKG
        qM+CGyqeWSx20ZXoW/g0tS3sIjT+QqGJwd4Oj4HtnYJtLoPPbEe/iNnynPbf/Iu9qqDlrVHFi1s
        lbZYD/E4B8RneeVCQ11Rdbw==
X-Received: by 2002:ad4:40c1:0:b0:4bb:84ba:a413 with SMTP id x1-20020ad440c1000000b004bb84baa413mr4740qvp.100.1668635398947;
        Wed, 16 Nov 2022 13:49:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4BnT2ggUvkeRYRo5Emt1G4E8xePLqRg/4lNDVcvpLW30ftub/O923iYrtX29gcyNWbOz9JeA==
X-Received: by 2002:ad4:40c1:0:b0:4bb:84ba:a413 with SMTP id x1-20020ad440c1000000b004bb84baa413mr4725qvp.100.1668635398766;
        Wed, 16 Nov 2022 13:49:58 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8699a000000b003a50b9f099esm9307666qtq.12.2022.11.16.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:49:58 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:49:57 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 06/10] dm: track per-add_disk holder relations in DM
Message-ID: <Y3VbBeuQvOLKH81a@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-7-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-7-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> dm is a bit special in that it opens the underlying devices.  Commit
> 89f871af1b26 ("dm: delay registering the gendisk") tried to accommodate
> that by allowing to add the holder to the list before add_gendisk and
> then just add them to sysfs once add_disk is called.  But that leads to
> really odd lifetime problems and error handling problems as we can't
> know the state of the kobjects and don't unwind properly.  To fix this
> switch to just registering all existing table_devices with the holder
> code right after add_disk, and remove them before calling del_gendisk.
> 
> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

