Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212D0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067CD61027
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhJRRxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhJRRxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B253C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:12 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i189so17324921ioa.1
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sc+0MD5hDfUvK4+NhtjQyVFaM0KiZCi/zoOdBBKsM1Q=;
        b=f/K00rHQP/BGwprlotvZibTRXuC/Udv9+mUIoEZR+lcA/E5jYe0vkvwyl10KIK8D/K
         VjqQIwdu2pJk/7gFfJ77BF5ySCMUTpRuCoE+BgofMtS0JhCp6Rf9VBVUfBjd2aTjtqtT
         q9GyEZMiRC8SDRXvxd6TZCwIBE5ZWPZeJPBfJhGq1NpyJzFgFB81r8JXp/vC9dy3Rkpz
         A7ooXyc39JZJww/RPxthy2Ya1vApIAW8uIxfTAK6kBpLVcOFfWyNeM2fC9z/0b8aWpgd
         JSzT9EzJLqpVzFbU6YKgnqGuRMJe+tDskEFrnYGtvHB+pJsIFcxds1mOGTrB9bR2nzqj
         F1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sc+0MD5hDfUvK4+NhtjQyVFaM0KiZCi/zoOdBBKsM1Q=;
        b=gITTtWEsbK0uhBhWzNvQM3pjc6BKWmXWWdjYBSajTryVEi0J6as7fnPRsT3fGiYf+G
         fKLnzUhLCnba6gcOq9DArV4qXEwqpX5dRrCPlhRisWoTXOrwzeH8XPZZqQI0+K1JjoPX
         4GT2ZmVKB+t2HgmnmOIodVzzVzklyF3bNrgABF6xFEgUX2zz2rFMAdcVkbDpwMnaCIpZ
         uZOddbvDHGRi1hBXlbA+Ny9YWuh+M2aaTHHeE5hIcgU9RsCJzhW2vHMIFlrMEFmJtoWk
         iz34tt6IXPWdZQHU7bn3mZbB3TXcs7NGfYxmD5KgyTeU2dQTUmEF3jPEeMuTrTOlyH6g
         HNTg==
X-Gm-Message-State: AOAM533LEjWjudBjLv6cYb8GKM8EAa7tI3Dk1VTm4sbi8LniDq/yzE5d
        K68+WzQTFLxJESEytBSC5VAZOlNgV3SItA==
X-Google-Smtp-Source: ABdhPJy7LcHMRjpg7wO3b0XMhtB5X1RdWUtplHrMNpcuH0eP/dUwsff2VMFJw8mIDdq7d5PK7/jSnA==
X-Received: by 2002:a5e:a619:: with SMTP id q25mr15872539ioi.144.1634579471759;
        Mon, 18 Oct 2021 10:51:11 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCHSET v2 0/6] Various block layer optimizations
Date:   Mon, 18 Oct 2021 11:51:03 -0600
Message-Id: <20211018175109.401292-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Here's v2 of this patchset, with the reviewed ones pulled out.
Since v1:

- Use different method for blk_status_to_errno() (Christoph)
- Split plug patch into 3 pieces

-- 
Jens Axboe


