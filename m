Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C66C61DB3
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 16:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjADQKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjADQJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 11:09:57 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827233C3B3
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 08:09:42 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z10so11372426ilq.8
        for <linux-block@vger.kernel.org>; Wed, 04 Jan 2023 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEP7z+JXK9Oq2OGFDhXitj8AXCiJHy68dV/wPo4Deeo=;
        b=dUN9+FRRO8NRUNgKi8iOqQyRi7bgkkUVGa3RcQAJkt29JhtQQvfgIBIhSGVXy0H9YE
         E/97vuLkaV4TmN4FGRM1pSLINhGWe/0DQSM9CjoPHwDZfiTZpfUU8e4raJD4Xm2L4u+l
         uKwuskzN9hvXSAIgnFENg+cTWvK/8lyNXgfmGcaGMvl2SHCtcbipMoE0yitpqW8FJF5s
         /WV4kZKYqC+U1Ri2rGGkJdrz4xirLbU+iRIZIng9blCHWPurnVLjSXZTnGBdZBFQy1zy
         XJjkYUAxJtVOfgKgzeLDq2JQSu621YYVwa1yZ/b8EmXxYS10l1w0rSbq6HIYzYy3Osg+
         Gh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEP7z+JXK9Oq2OGFDhXitj8AXCiJHy68dV/wPo4Deeo=;
        b=NViEbI0uY2lJ2rkhyCPkulYZo0Dz1KpIFcayWhAZZBGVlAkPGKrSmTZR3G9gVyfTmn
         0fhFl7zOuWorSNyvV0vfPuBd/H9JwPH2k08eKcz5c0njiJswscW89sqKwJBrRCUZoaf5
         W3SxNacJLIjaz8qNai2f5pjVIIhBnoI2Vnuep2lgSey9t4VFlYR7FBgg+AYa7gmqjAbw
         kbGU2LUw1NHWnXJS+J5pWj6PE2prThbB7bcf18P3S+mEpnYvF4L6ckFxDxoZ/dGsNZh2
         /VEBIuqHFKG+KY4Gf7+ZkH3S5QVItxCBBbzxidU5iDlK22+dUm/jdrhqTXZ18FgD+ZC+
         AmoA==
X-Gm-Message-State: AFqh2kqc/jMiySEI6n6ORNVLnlN/jOxSLusQo5HHAcT9IzcIAOZpbDcb
        L27UvS708RxaHgcifgNWI3zwxG0aAJDWH4KV
X-Google-Smtp-Source: AMrXdXup1WAXKWxmYtU1ZmOMSCEEku0dcb13OGdOAmIPgI9fmU1n6lVlfDwRO3+CnUAHci7UEJVprw==
X-Received: by 2002:a92:c151:0:b0:303:9c30:7eff with SMTP id b17-20020a92c151000000b003039c307effmr7151651ilh.2.1672848581630;
        Wed, 04 Jan 2023 08:09:41 -0800 (PST)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t24-20020a02b198000000b0038a41eb1ba3sm10955243jah.177.2023.01.04.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:09:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 0/2] Don't allow REQ_NOWAIT for bio splitting
Date:   Wed,  4 Jan 2023 09:09:36 -0700
Message-Id: <20230104160938.62636-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

If we end up needing to split a bio that is marked with REQ_NOWAIT, it's
entirely possible that any part of the split bio will hit a failure
trying to get submitted. If this happens, then the entire request ends
up being errored with BLK_STS_AGAIN, even if any parts of this bio has
been read or written to the device/file.

Rather than end up in this odd state, disallow splitting with REQ_NOWAIT.
If we end the entire request upfront with EAGAIN, then we don't end up
with a partially written IO that still returns EAGAIN.

-- 
Jens Axboe


