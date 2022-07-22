Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC5C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 15:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiGVPXc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiGVPXb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 11:23:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA19DEF6
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 08:23:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l24so3861161ion.13
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=4E9ffZWo48VqZN8DRdIWXLdH7FBFPVhFQ3tDW+E3A/4=;
        b=vM2Hi6jAGYRCESN4R2Ligq/rwTyhvOk6wTzhq3E79Io5aTt8ce8fgs+7fIBaPEAFvZ
         fDT1SLI8FnDl0e6JdhMa7XAo3rzXBgPbBJ4j/w/s4YygB95q6zc7xh3OVWMVkUYEGBNA
         cRlgPQ4QgVk6U7e6rVMggCcn4GjZNiByva4kBhLzLeSbaSg8AOhOHJtc5gtFgsIR/PPH
         ogYY9gZ0vML7DSWNcMx92oVUkoO1Vx3CHslkJEs9RjcmIS3dDHGzY1xUUerDwN0IhrLi
         YkkbgMzmwmbzIdmojgqmujuJHA6kYTAzgfrVOWKbZlGhO8LRqC+8VhfH/DANWlXKnxLR
         66wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=4E9ffZWo48VqZN8DRdIWXLdH7FBFPVhFQ3tDW+E3A/4=;
        b=4aT6EqvCJdSHFVwBi6lffnTJz7IEcDcztvf5shYzV1XaJHPESQ09DuYnhtoaT6gOMK
         7aEYR/mxQIDqhg+n6E1I6bveE76OU4jxV8m9OeaddjaVbNsFv8/h5KrGxqacyuDSX4v2
         XB8P85XUbnB3pa3QjBYdyHUp5QgvvsfiapV7y87qCTFTHcaX3/qxZ3i9q+sxSpdU5Z0E
         FI0mn8uRQZuNNu1MR5yavFIfVmN3zGJrQn0Wqgw2IKHl0L7mrODqG6cE0LOqFKyUMN7+
         PZeARtUCdbR223JJpzlt++9ahidCbi+kJQQRbC6PxMVx/63I2YuUC+rsaTJD1QPE+AU9
         Ah7g==
X-Gm-Message-State: AJIora8XYl+BdpJv2Wg78DEefGC15GzKlU9HvN16QjYfJkewCrGbuLeD
        RCPOvVzJXxuoUP6uvmPuCgj1mM72/T/TEQ==
X-Google-Smtp-Source: AGRyM1uyTHtnsFvxzLO2vF6f5tsYRb9W24BzjYpInq4CE02QaUkVLbfiZMkq1e60ORLGfmsQcD+ZmQ==
X-Received: by 2002:a05:6602:2b10:b0:67b:80f8:6f2b with SMTP id p16-20020a0566022b1000b0067b80f86f2bmr89621iov.147.1658503399164;
        Fri, 22 Jul 2022 08:23:19 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v18-20020a02b092000000b0033c836fe144sm2099256jah.85.2022.07.22.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:23:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        ZiyangZhang@linux.alibaba.com
In-Reply-To: <20220722103817.631258-1-ming.lei@redhat.com>
References: <20220722103817.631258-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4 0/2] ublk_drv: make sure that correct flags(features) returned to userspace
Message-Id: <165850339736.236870.2964518260731776133.b4-ty@kernel.dk>
Date:   Fri, 22 Jul 2022 09:23:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Jul 2022 18:38:15 +0800, Ming Lei wrote:
> The 1st patch cleans ublk_add_dev a bit, meantime fix one potential
> free un-allocated buffer issue.
> 
> The 2nd one makes sure that driver supported flags returned to
> userspace, this way is important for maintaining compatibility.
> 
> V4:
> - move UBLK_F_ALL out of uapi header, and change order of clearing
> dev_info.flags as suggested by Chrisotph
> 
> [...]

Applied, thanks!

[1/2] ublk_drv: fix error handling of ublk_add_dev
      commit: fa9482e0b23d9abe7034becff59daeaba09146ff
[2/2] ublk_drv: make sure that correct flags(features) returned to userspace
      commit: 6d8c5afc9ab14595707ff25d971dde45728eba3e

Best regards,
-- 
Jens Axboe


