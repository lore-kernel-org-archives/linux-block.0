Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D669C7EE22
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 12:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjEOM2q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 08:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbjEOM2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 08:28:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF51F19C
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 05:28:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f4e01eb845so29931701cf.2
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684153723; x=1686745723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1VjVPqAfk/ppRiX01W6r2R4tRubSTNMzE3oD3ueN2U=;
        b=ZWDv4c2aGhq+hVZZ96wLRricYpRxNLMwIkL+8XmiKvlkArDwiiYYvmPfggoS2OsHC7
         DpDf88cplcY6csuDKDFO6cpBgJJpBs68+CdJGqkP4x+VH5zCWcDSxki8LSf7cP7nPu8i
         ZFupC7LU7OoOZXbxL88NV35zuUChWS+ZeDzZVhn8VU8h4l7X0yLZ/s4OS0AP7gbp5LCa
         lsRGsdodNgPPhcxoOi4ZfiOk3a2Tnkpehrsw07T/1rPQ+rw0/PDaHD94+LYK4pGG9eEx
         iHEkWpw0kXB29GIdZBGE5XbQKLj5ct/SL+IAPnZBFokfH15IFAx2f0OS8pkoumQEs3nT
         ehUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684153723; x=1686745723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1VjVPqAfk/ppRiX01W6r2R4tRubSTNMzE3oD3ueN2U=;
        b=WfyexlhTR0tQLWSe3pDtUm0TP1FCWzpj0EX22EHbfgy/0AyUYy+viURG9LPR/cULqk
         /NGs0TmGMt0KvURID+C6ogkQnFYuILiLrq1eSUGKz7msQnWGl2PlZ3bwsmmHQ3Ppjr9v
         okLtnnTSuI+GrVR85VfvC+HZQ+wR8m0RiglFB/HPeoqLTXAcht+52i1Lj1klJ3ollmIX
         3IC1S0xcZdRQPRQcBd/dxDcF67Ju4Vu94cFl8tD33yMYDxhOWeRzuP32uCWthSPhRNiN
         2vFBH+BdTT/pTiPDa0eTYBsu2OtsfM8D8T2DMO+4nfZqtHGcv0cO90TfeKuyIkqwnTAg
         2yhQ==
X-Gm-Message-State: AC+VfDxMQTez4s74gs4pnPApdwdeEfyBr14xK24V2FQPnZuX2q57YRRk
        1UhPTIOE1vSXC3VdPl/YcDg=
X-Google-Smtp-Source: ACHHUZ7TsAlETEjPwHwpArVG57crjnQkJXO88HfoqSd41LsVLHtpYRU3+JVmPWC0ZJJEqC9MDT1G/Q==
X-Received: by 2002:a05:622a:1ba4:b0:3ec:4705:d20e with SMTP id bp36-20020a05622a1ba400b003ec4705d20emr50519945qtb.30.1684153722836;
        Mon, 15 May 2023 05:28:42 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id r23-20020ac87ef7000000b003b63b8df24asm5310066qtc.36.2023.05.15.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:28:42 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk
Cc:     horms@kernel.org, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, tilan7663@gmail.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Mon, 15 May 2023 08:28:41 -0400
Message-Id: <20230515122841.602259-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a685e5d2-5da8-2ff2-c53d-dbf77fa9609d@kernel.dk>
References: <a685e5d2-5da8-2ff2-c53d-dbf77fa9609d@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Jens, this is very helpful!

Tian
