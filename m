Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EFBC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhLPQjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLPQjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:39:04 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD812C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:03 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d17so4620486ils.8
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuiksDPLX46rGvth8ZoLiIY5pKEIITYAcJQliALs1ec=;
        b=4kV/CAF4VTowFvtMxlL6qG65R7GTZCDJGnm57mJgsFe2IxB8sjZV4ldX32hYm+sutJ
         ucztWjponY482RE/7JFN9AFRkvMCKrbTQBjmmmfo1NMXX9S9YNdPU+CHcwGfQQUEoK2y
         W5bBpg2mcTEHGWaFOM2ES0EXhlrl95fUuwxsBEFoF4DvK3iP2gVzj3ho5eiy79YnfA2+
         +cBkEY26aWtKl7wG9lvddzHhQiClvUjIzl1MIYODSvVSchKeXNmLZeuZE71Gd5P/NRyt
         LeTY6kB4GSzQnzW72FYH5tFp/kSUKMoOpfnPjuLM6O8OxaePESKHpUF7djO+Q3dci1p/
         yvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuiksDPLX46rGvth8ZoLiIY5pKEIITYAcJQliALs1ec=;
        b=ZuqPd2Pf717MLJXLSMn/Y9H3/6UPSyKwSbwdeQ1zKMMLgxwv4MXYrk/wqJx9LchAc8
         BwCevYHho5HC2mQ3wG7Q2759Lvu3pfAsPiPP+nmbeQpV2cdWIaRX6zrNzgAs8xm+mJ7W
         TTTUQje88A42rRkILQNHKRBlpkQmblXbq6Dju6FWZx3b15Zo15HYCztwWYJc/cOH4icd
         ch2KKab95OWgiTKZw/yvczpvGftSFRv47AhD4zCev1jUTigZLgO7X4UOuu4JM4+iWym+
         orJ80Oi9+6D8oJ47dhk7xKstQtDlVUqCVZSBBuaxoBGCEHIp/0LlFo843jQrMqjlw+qY
         WVrQ==
X-Gm-Message-State: AOAM533eyLM6ytnWyk3mwxQMh/dR2wz3TW/JkkqXHXibNZQRxOppeWGp
        Ohm7k3CEMSjQxFXnyuRwsr8ivZTMsXiyXQ==
X-Google-Smtp-Source: ABdhPJye2SGmV1G1NKox7Eax5N3l1SrMAtCAMBAWdWiCRRAjLXyT7evL1MC0E1nB77hJVO4q9ObJ9g==
X-Received: by 2002:a92:cdaa:: with SMTP id g10mr9703007ild.142.1639672743161;
        Thu, 16 Dec 2021 08:39:03 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:39:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCHSET v5 0/4] Add support for list issue
Date:   Thu, 16 Dec 2021 09:38:57 -0700
Message-Id: <20211216163901.81845-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

With the support in 5.16-rc1 for allocating and completing batches of
IO, the one missing piece is passing down a list of requests for issue.
Drivers can take advantage of this by defining an mq_ops->queue_rqs()
hook.

This implements it for NVMe, allowing copy of multiple commands in one
swoop.

This is good for around a 500K IOPS/core improvement in my testing,
which is around a 5-6% improvement in efficiency.

Note to Christoph - I kept the copy helper, since it's used in 3
spots and I _think_ you ended up being fine with that...

Changes since v4:
- Get rid of nvme_submit_cmd()
- Check for prev == NULL for batched issue


