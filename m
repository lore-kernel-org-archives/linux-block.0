Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB92C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7710B60FC2
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhJRMvt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhJRMvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:51:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46172C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:49:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r134so16052381iod.11
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLKDXUKQqWTbJTiWV1/kFYSTFP2tjURT6TRkLRAYYtg=;
        b=bJwmJktRzN1qtiJKkoEMwvKaNRvMdH3D5o9zWhVuY/sIkYhTpzwu6bUJ/To3P/mx+9
         YqhmezqD1lZqYBT+YVfqzPMGFw2QSfrLjytgkCnu9PDJO0y7vkc3NhU4OaXKfCxXIJu4
         EZBuEDu6GjwbQgmWkzO4ka506semfPQ4VkqVudflcmzkgj3pLfBaWy6D0T88b/w79Kci
         lw3JM2UtESlSZrx1EqbsXo9k30EqspmuratJ1zUrqAzlQveuGyic+nELCKIeX2PgFAMZ
         dtw3HKuC7FAPYQnQaHfjGUCFhk59gI4oc+OP1Je0UmXH+Grnje9hQwvWb+lKkFWk9IFV
         60tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLKDXUKQqWTbJTiWV1/kFYSTFP2tjURT6TRkLRAYYtg=;
        b=xKAwKoALNXqrrVSE2qZjbpVj3JqINEvMmDDYiNRCHFAIBqjc/J4pKvQ/0zyri++lMH
         fmlu/A0tu3C3I0D8r4d4F80fsiyyi0uQtqQ3vELFIDbIT98YBZBFuKHO3tZPHYDuleVw
         ysf60PW4GkvulddtZ95qFRnIX9RwnzwrKQrWhr+G+VajSt6rDudi4sUO2EOMhYENQBEo
         WPo9Iu2SrxNvjjiIIAW2F8IYbRJpFNyQ3+fJyZwbJQWPxNWW/KwQ4TYSITx38STow5mj
         /DINSN5VsQ7rTRlwjDSv6hF0uVeg49zCUTIQHT8QRtnBlU1PmOb0cga45xvqKSHnFzkr
         V8AA==
X-Gm-Message-State: AOAM533Ao3tNxIVQPiz+RcMmlGGSTnzDP/XtJn1GUEenpDJ4R/r7vtk9
        MoosUNC5on/aAjKEyNDjrsJH0cKvCYniMQ==
X-Google-Smtp-Source: ABdhPJyziHHv/UUhSZ4HU1jpHray5Of/1Zs868u9vpuqRAKVlT+Z8O7sb3JxtkfPgPpwaal//pgWyA==
X-Received: by 2002:a6b:b5cd:: with SMTP id e196mr14469109iof.195.1634561377557;
        Mon, 18 Oct 2021 05:49:37 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm6780081ioe.9.2021.10.18.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:49:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCHSET v2] nvme: don't do full memset() for command setup
Date:   Mon, 18 Oct 2021 06:49:32 -0600
Message-Id: <20211018124934.235658-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Respun this one, splitting it into two pieces.

-- 
Jens Axboe


