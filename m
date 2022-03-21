Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F2C433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 14:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbiCUO3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349480AbiCUO3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 10:29:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CE75642F
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:25:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t2so15533067pfj.10
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LkLvAp5JsIVmUs47spvcz3bSqL8LP3z+qPUaFmVkik=;
        b=A/f6Pt9FAU8P8ktqBGuwM9a3f6knix5dAgqBfdDWq2iNXVqoSDtepYwnmBwiTOjHFE
         ns7TYcyeKty+pUrM1Si++54R1+1YeKBEkGFFqWjUl0hDwlXsETQAc6eUnGeNDo+NrdTd
         Gb6AUz9v2eOb3baGA3QRhX29kvr4GfF5AOEimGEXDyihiS5ahW9XmzfTX0APTDI+PTlD
         HY92T84GuxywGcyYfmlUxC/rFDj9Pk81LLmLiuwm4jn5uW/WNT2AtbZlcw1oYko30VtW
         4jAIU4MLe7KYM60XxjtoCgjUWNMekMwvFsezmF5H6VMixQ/2IOPA/2it6NborMqhwRYW
         BTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LkLvAp5JsIVmUs47spvcz3bSqL8LP3z+qPUaFmVkik=;
        b=rddhXUjV3SXcTSgWXEnWqv0Llnu6GT/AG41YRw86MuogFIYC//sap5C5VPUSgBFS5V
         qTwPvVdmsjNgP6YTnrS05lHUvUUmaC1+PdCK7aetGYbHnCDRKgvFxHDawyMtwWO57Rdy
         N3LZkpyN24w9wkUZCcElhAl/qGA2/V6yiQwTbMsD2Nbs4sJmE66xGQ9F2nRSwFyz5jww
         Xvn3Kt/j2yxHaWYWp4eSVapwq6GIvXz6PkcLBmWDg/Aqws5jpGWxs8KiaxX/HoZ+INH8
         sD+ToOHB9FkctHVyqY3vjXf2DH/Vr8Qwe0WQabPOekclt8NCejYMkYejMBbC2jRB9lzf
         5eDQ==
X-Gm-Message-State: AOAM530SPUkbpy/lroTfMo0PLSsvuduuoX4zSatIqzuESsiaEVe3Q1eK
        HqRZ9sCx/VcZFCW38Y+0soc=
X-Google-Smtp-Source: ABdhPJzrjQ6d4Zh4AmBS/h1rWrn0xmX7zY8QfUuz4jpIvJPicoWzqinQLKhb4XlUg4xQnndI1wwMEg==
X-Received: by 2002:a63:d4e:0:b0:381:33fb:1538 with SMTP id 14-20020a630d4e000000b0038133fb1538mr18206545pgn.492.1647872704193;
        Mon, 21 Mar 2022 07:25:04 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id e6-20020a056a001a8600b004f78e446ff5sm20503225pfv.15.2022.03.21.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:25:03 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 0/2] virtio-blk: support polling I/O and mq_ops->queue_rqs()
Date:   Mon, 21 Mar 2022 23:24:39 +0900
Message-Id: <20220321142441.132888-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch serise adds support for polling I/O and mq_ops->queue_rqs()
to virtio-blk driver.

Changes v1 -> v2
	- To receive the number of poll queues from user, 
	  use module parameter instead of QEMU uapi change.
	
	- Add the comment about virtblk_map_queues().

	- Add support for mq_ops->queue_rqs() to implement submit side
	  batch.

Suwan Kim (2):
  virtio-blk: support polling I/O
  virtio-blk: support mq_ops->queue_rqs()

 drivers/block/virtio_blk.c | 194 ++++++++++++++++++++++++++++++++++---
 1 file changed, 181 insertions(+), 13 deletions(-)

-- 
2.26.3

