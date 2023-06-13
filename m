Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E6EB64D0
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 15:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjFMPqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjFMPqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 11:46:10 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFBC135
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 08:46:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77ae75c75deso45727439f.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686671168; x=1689263168;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlZPd8Cef19jErx4Tjmtpiu/sml0sTXPG6kDLufVzkQ=;
        b=ARt8G/zP7zVbykQ6vJWm9a6DxkxZEdbwZQc64fIf89F1K4nrFMI1MdurJgu7vwXLRa
         zDGaO+wt+C3y1jeC90HETPn1lVBq4+UFA+dT2PD0cxcThXtyRqJKW+0fLlQkVUUuk1MO
         SHNdb6YW6QiwJWVmWkrTtkB2GZUibDDHNTEvvp2v5MnqmJuU9Qc0KvdHLaueWH1GCjxs
         Z4BeiOhJLhF2L+VFCkisJdQCvzT3+Vij6Umk0hFPmnItBhJbIKK/wBKhEy3ZwoWwp63M
         js7VKtVsMs9s0sHjjhB5CRzAAtW3o6RKgByoHG1Xa+Xqy922wLsu5ptr/091MmYgduyt
         XR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686671168; x=1689263168;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlZPd8Cef19jErx4Tjmtpiu/sml0sTXPG6kDLufVzkQ=;
        b=Lb37FuxzNmm2OgAEVKUuvr1KT8ul5hNEKUhXqicAu0Zz6wmoekhRdOxwEVbUBCL7EE
         MGatRPA9WEVgoHtAVo9eechDMUWkaTaeKtA7Dx7U+MKFym3KMV1X65r3+cmuMFgMo5SF
         mNmEK9p/Vf6C5yRX47NqYV01ibRWGiHQah3G6vRLlf4mJlXk0ERznqgAzMu2V2AUbhLg
         cWQOpGNXniNYNVksolJ4kmRQMrDoEjBE1xwztI/Nx3oz05JTUCDwzzdOxsPzNJPxCOCR
         eS0OudI464J/cgO01jmzO7nlK4qxrfuz9j8UPT3V+hCEfJSSFVJCGqENSU6vvjFeDi+O
         TvxQ==
X-Gm-Message-State: AC+VfDwdczGZPEugT++Z2Wrr17l2+XJQEkxXUYo2B8mAiuZ+v9KDrYWe
        oYn9FAe88QmBs8WWKeEAEf1dVQ==
X-Google-Smtp-Source: ACHHUZ67MF5+t40Jr5leJiQgXH3t8g8vToToB8geUPwQbyP1NryCkrA0YOVzBW9zLrUTGaJgNrufOQ==
X-Received: by 2002:a05:6602:15d1:b0:775:78ff:4fff with SMTP id f17-20020a05660215d100b0077578ff4fffmr10950762iow.1.1686671168346;
        Tue, 13 Jun 2023 08:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a02c902000000b00418ad0ca629sm3556758jao.49.2023.06.13.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:46:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230613154309.327557-1-hch@lst.de>
References: <20230613154309.327557-1-hch@lst.de>
Subject: Re: [PATCH] swim3: fix the floppy_locked_ioctl prototype
Message-Id: <168667116749.1374655.2978888015381085693.b4-ty@kernel.dk>
Date:   Tue, 13 Jun 2023 09:46:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 13 Jun 2023 17:43:09 +0200, Christoph Hellwig wrote:
> Add back the accidentally dropped mode parameter.
> 
> 

Applied, thanks!

[1/1] swim3: fix the floppy_locked_ioctl prototype
      commit: 3dbd53c7be1c3dd04875a0672262b56417039869

Best regards,
-- 
Jens Axboe



