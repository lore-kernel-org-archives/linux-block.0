Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 16:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbhLOQaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244802AbhLOQaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Dec 2021 11:30:12 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A3C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 08:30:12 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z18so31084722iof.5
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRUFk3fWt0Ep26l0AkSGsM9K8KN1VGOIRrLKhZsbHAc=;
        b=bnhBmWd3xzAyUBjUlomDtKS28RoDzLYZBTWhiq5+S54U7tm6GSQzYe2q21m3NTCMDl
         jsC4wsnWltBC+JqHKC6EP2mBFnTrK3I51uXPVgQA5M7eDqQYbaHPZz5bmEZGszHHD8IL
         6IQ52UEDrcPg6FwAZqr1ahRqpRR2LdA0f+tOIfGYvut9z0Oui9RTRnPzmbRvAVeNRzPK
         Dzw8hzn/zgs6IPkH9vJ0jtdBtvA1WPcJhFF/Antc3GdjiTZ3RM8WvkDYescLq3rMmhjH
         FT/8nxbCDvcSf59bjprIW/aDwaTY+/7MSRTDeq2QI/5taReRxKLAivhtgHuC3zGCOYp6
         qVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRUFk3fWt0Ep26l0AkSGsM9K8KN1VGOIRrLKhZsbHAc=;
        b=aIeh3wkU993LDnC0v0j8/2oR7axYuuaEhiEGDxB1uSxuB4gi++9pqYuF0qb37ksUqQ
         CX0nVu5sNlvs1Z362hFM32bIUPdYZkeaU18/1YlFKeDOfr1G10S+sMX/Vcxof/gatNqj
         /I+qKOvgZDAYA3/36btP/ar2e7DqfxGQ1v95ku6M7NsaoibTB/BQ3FXkDArSXBIQEKmR
         +Zgim2oi42S55rYNjQTU9ZdMwMkRZJ00W7mIlgCpYcD6YwGuHjNU/cEV1M6U+a+VXq+Y
         C+pQb8gRWX56X6l5avwZuW0NHlVIv7EXQrC/V11Y45w9cdF9o65KcE0CSbZ2RYIgFT9N
         kImQ==
X-Gm-Message-State: AOAM5322tYOBYCFBQ8sf31IrsmMdUmnzezwNL8OUF6pYOF2w5CTHtifT
        xTa4JGMh4ydN6rzHV3rtGeKb2b+3hmRrRA==
X-Google-Smtp-Source: ABdhPJzjJl+mcuCe4HqqX1bIcJJEhock+/RceyvJbzgM+E22030zN0Eh7Z4Co0CYZIJ6gkheG6lF9g==
X-Received: by 2002:a6b:440f:: with SMTP id r15mr6751126ioa.128.1639585811665;
        Wed, 15 Dec 2021 08:30:11 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d12sm1338528ilg.85.2021.12.15.08.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:30:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCHSET 0/3] Improve IRQ driven performance
Date:   Wed, 15 Dec 2021 09:30:06 -0700
Message-Id: <20211215163009.15269-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

1/2 are really just optimizations, but were done with the support for
using cached bio allocations with IRQ driven IO. The bio recycling is an
even bigger win on IRQ driven IO than it was on polling, around a 13%
improvement for me.

A caller that is prepared to get a bio passed back at completion time may
set IOCB_BIO_PASSBACK in the iocb, and then the completion side may notice
this and assign iocb->private and set IOCB_PRIV_IS_BIO and have
->ki_complete() handle the freeing. This works for io_uring as IRQ
completions are processed in task context.

-- 
Jens Axboe


