Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B34C32772
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 20:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352133AbiHSU4d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352029AbiHSU4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 16:56:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27CAE43
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 73so4565270pgb.9
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=vVnZAoDj6iosXMgacxEZIlMxCehF/3KLjohxC/w3AOc=;
        b=MBvLd0H5Ln7CTnufs25UW0Fbguo21Rc/RYtnhn+bQgV7gHIkbs8kjFOJGUVyWXQjb4
         vbTdLgja/b/1X1AjWWEIeNm4n4DVcNbTf/EA44cq7Nunu1xmONrQ49mXsPRbS/nvn6q6
         hNh1B5pyHdcZ8pq9P7vR3uS1v3mamIqagTmvjEDwiDVcK/L2MPAnlvDMxlO4Nuuvfriq
         22+AvemSIXG5ONVSrSY1cJQQOxdkSQjCi5gOJdmPIQDPlsGk1hlJHqYMNIqv35f0nNaD
         W2RBFmy+RxwEI5ddG999iRV6TXK0O0s72Ukso5eOpLN7EhnyUXDVTz9+t2p5b6tZBWvz
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vVnZAoDj6iosXMgacxEZIlMxCehF/3KLjohxC/w3AOc=;
        b=gNpuE29lyp5enA78SBsX0CsNvw+2XkRIapTdeo1KAr8jDLX45Gv8Gepk3rW3XzZmfb
         LGcfPmS37Xf+fnhxUe0pvnD4mlfwkpKHnZ7ulDDFdMiQvmpbyMZbuB+qZYXua2kIrXxH
         GBtDQSlOmk7oqSedWYzaLnP9AIhJPks10PXmXPc4kOMJnyDGQhOhbMrtM9Rxu1Ilzpx7
         7CcMMeUnEBctvnv481ms/zfhATA0xN1ahwiAva9N/XnD23taoPWT8P81w1hQTXev4mE1
         LWL/I6KzBntDGrTqXR6XUNXFHMPctPLng7o7aQfNez/+AuvdgVArBEMDRFHa5ehgw56s
         YKWg==
X-Gm-Message-State: ACgBeo28IlD7YU2ORB2OhayjuN6Nj95KbmR8Umb+YfDNUw+kK2aOCj0v
        MHoS7YzhUECrjxrINuEZwJuqLg==
X-Google-Smtp-Source: AA6agR4ELTuxzU7AGUSqlbX/zDb5+OvC5W9Ri0nVIlI1brZH+i8seV91Kq9Eb7sW7lAEwGETD1XPIQ==
X-Received: by 2002:a62:1d86:0:b0:52d:9df0:2151 with SMTP id d128-20020a621d86000000b0052d9df02151mr9493732pfd.33.1660942590520;
        Fri, 19 Aug 2022 13:56:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v4-20020a626104000000b005327281cb8dsm3977375pfb.97.2022.08.19.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:56:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai1@huaweicloud.com, osandov@fb.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
References: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3] blk-mq: fix io hung due to missing commit_rqs
Message-Id: <166094258954.37536.4791587641314567827.b4-ty@kernel.dk>
Date:   Fri, 19 Aug 2022 20:56:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Jul 2022 20:22:24 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, in virtio_scsi, if 'bd->last' is not set to true while
> dispatching request, such io will stay in driver's queue, and driver
> will wait for block layer to dispatch more rqs. However, if block
> layer failed to dispatch more rq, it should trigger commit_rqs to
> inform driver.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix io hung due to missing commit_rqs
      (no commit info)

Best regards,
-- 
Jens Axboe


