Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD56C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhLPQFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhLPQFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:05:41 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0035AC061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:05:40 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id b187so35767760iof.11
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL3o525SSbhSebgjQfZMQ7uigsMTO2fDpoEDGUF4HUE=;
        b=0LEQNGb1bTHq9e+hYsc3l+U2okJ0k4nHCnm1dhpKeonjqY5/ZM5neoakgeOcnU8rMt
         pqd/Xs3gl8OfNB5zpWbbHRemeoSAhzx4OjzZC9/nUuQ5hNpz9f5iBm0955pOnS1isizS
         JAip0m3naR8v4h1fESL4IKpKKycnMHxyPGjlktYqX9o1oKPQgvGE6+BklJ58NVHSreeu
         pIxhC+CTNkzBhAgy0G4S4qMsOTW6SLnoF3binn+Y5vangPa3tr2JNByLyvb6RJlZUOSc
         Q6M4wLWZjHPSPDI/FLUA7mI2SPGwGpULFNf82V7VdpjkSXl9392Ow7vVukUVOmKvpL0U
         /eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL3o525SSbhSebgjQfZMQ7uigsMTO2fDpoEDGUF4HUE=;
        b=WDMGuZxaSMdI4zQvXvWyh8eZ3TJeAfokl65hqZdIwz/Na3A3ncjqThKbJJ09ZI8X5y
         DvAY2p10GrG8XuWlaofQY8zVUqFGDzP+g/EZiCnZeBA6Nci0DnKICeqcbnlf02Roh8kF
         RHV2Bta9dYu9AQTrgdaHamtNBNuMijfCv0NL3l3ZJCVWqcOLtR6VXQacNBv0LVg8jjeG
         PT0t5jn6eu5DUO54tpulRehlikE4bG9QCbk+e0ODKmD6c3H0cSUuS5tpwFELNNXplgcO
         C3DlE7oaYFTPsmPg5dTiRPoDQeoQL5wO3AaU6cA7iY2lI0ymcPh3YO8vN4fG1AyNYxeZ
         3ATw==
X-Gm-Message-State: AOAM531PJNhUrBAWDnwReq2o7EL1RlCIzn0khx0OmUsOE2b4DPWOYw7E
        nonO2PODhwRQe4S/SE4tIjKQzRwvFK2cBQ==
X-Google-Smtp-Source: ABdhPJyX8QJ18MhgVKKInSNZnCJnXEn3TufvHX3LuCasO/H2/ZZH4vXTozIHee1wM/MvTcWLkJaRoA==
X-Received: by 2002:a05:6638:3381:: with SMTP id h1mr10264337jav.176.1639670740358;
        Thu, 16 Dec 2021 08:05:40 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:05:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCHSET v4 0/4] Add support for list issue
Date:   Thu, 16 Dec 2021 09:05:33 -0700
Message-Id: <20211216160537.73236-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

Changes since v3:
- Use nvme_sq_copy_cmd() in nvme_submit_cmds()
- Add reviewed-by's

-- 
Jens Axboe


