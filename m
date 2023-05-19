Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAAFC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 01:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjESBfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjESBfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 21:35:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC616E72
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:34:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae65e44536so2852875ad.0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684460098; x=1687052098;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifxe3tDv3c+qxAf5X6kT+W+SEkU+5CrWLSEnV1mR9VU=;
        b=ulN0hdQQAaPNQYiO6fTSwgTL6vcZcpaeiHMCz0gn6UrsVYICebax27O0kkp2Dv4cc2
         MRzLMJQNcT3QXxGMgtKBeP4TiQ+1xmbUSNC54ciF9f+4qNr4460qplm1CuWpvv/mQMKb
         W4SAU9hB5ePuYtQen1vwrakFdIWnPeRffDQkFCT7/3VOMAHVUM4/oaenHbQy4UYwRWAv
         WXRwhvp8qZCpyDX86YcQIVFhh4Uu256wLtlH1nlWp3qbJftvYL2aYsX6dWL08auuN2/S
         lezPERk7eCx4nH/mhtuHuZ8z/NXZDTAWFsxKLlei3avAbceDKpJUXlmRlxo5Rsc34o4R
         2Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460098; x=1687052098;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifxe3tDv3c+qxAf5X6kT+W+SEkU+5CrWLSEnV1mR9VU=;
        b=RB6ixe+mWjqhAk2Yjw+oGIVWIJ3dApvAahDpYWtTr1PQcKr5W6NcmD5qwMLc+4x0w4
         p1wa1EKVp58hMCbNOZh/ETxzt25azDzou3SBmBxGuFDK5ObDbVOpJN2dCuRMMq4J/2qN
         Sa/IB9l2sRsFKxAVpbOU6iK14X1Y7R4vfMW0TWRp0NH1+IhbGSpHmZLnb0WHSOCvgo0N
         JSXBUWX7vAaaPGo6n2mTYxybWz6d60qnZRoBf0nZy3LTQE3tIqTLCfeSA6r4PxBcKBtG
         RyjuPuRMs+VRTZCMFF7eaNY10Ht/fNevmDTWHtn8oeHQIW/1wqcBVeVV59zqpcsfMGSR
         62QQ==
X-Gm-Message-State: AC+VfDy5Gaj2RDZNvfBTb8wzDgt99B1OQZy25mA46mff91pYt9KC15bw
        U79S1IfwVfyrU4lcWfDr3Nul6ZUINbT2K4RbPRk=
X-Google-Smtp-Source: ACHHUZ7YgUF6CTUZFj+o+M2ewkQ6d8EBVtHNuX3bG2eIljORdC8PixREKDCyMNLYRZxzw6u8pMT8/w==
X-Received: by 2002:a17:902:f689:b0:1ae:ff6:be11 with SMTP id l9-20020a170902f68900b001ae0ff6be11mr1203232plg.0.1684460098368;
        Thu, 18 May 2023 18:34:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001aafdf8063dsm2124343plz.157.2023.05.18.18.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:34:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20230518222708.1190867-1-bvanassche@acm.org>
References: <20230518222708.1190867-1-bvanassche@acm.org>
Subject: Re: [PATCH v2] block: Decode all flag names in the debugfs output
Message-Id: <168446009723.139376.14923689918312832759.b4-ty@kernel.dk>
Date:   Thu, 18 May 2023 19:34:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 18 May 2023 15:27:08 -0700, Bart Van Assche wrote:
> See also:
> * Commit 4d337cebcb1c ("blk-mq: avoid to touch q->elevator without any protection").
> * Commit 414dd48e882c ("blk-mq: add tagset quiesce interface").
> 
> 

Applied, thanks!

[1/1] block: Decode all flag names in the debugfs output
      commit: d5fb8726f1dea70543a93ab1d7332857f157b7f3

Best regards,
-- 
Jens Axboe



