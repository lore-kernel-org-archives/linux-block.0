Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D1EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 13:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFUNtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjFUNtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 09:49:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2398619AB
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:49:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-557224e7716so197944a12.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687355340; x=1689947340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQVfcIqveXsfsK3itMYSQuSztm1ReHSoYZfaAsBALV8=;
        b=s0kub7Su7/NFRezFTfLSPk+AhS25fiwTQE6haAec7XooNLc9Gf+TXlcKYHs7j4Xyh0
         8X+pvXNfnSB4Mkr9Kz8/6IsCOV/PiBYRad1VO4QApD39IgacrW+cMWVW89tFDEkayopx
         SD5iOE0s/RSh6ZypaopyaqONwU41vlIy9+BROKUjIH7A284thEoO2gV6hXO3UMtRRmbY
         ASrZ0k+y4ol9XVEh1p5X2etJufqJn0gEP7Aow7pHy8LAQueWuYMSpg+8XG4y6BzBM/Tt
         Ulnm60SnetKCeIJRPWO5YFGgcgmdqB7zEDbCcl0EFDVOuTn3nJwIGlvFeETiLutNM80B
         7vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355340; x=1689947340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQVfcIqveXsfsK3itMYSQuSztm1ReHSoYZfaAsBALV8=;
        b=AxW3zEDXunbxVTc7noh/PYXBozTyZtjOl9O0xdFlgLCmORDhgrrfj5i6v47T9EBxLS
         +5+qdTmmsOoSoWqcOjiGBP4Dey+XIay79OiJ7xUWxl+Nkh1YAN5HhdaYRmv+Hh1+SxsL
         +WA7hCf3n5r+Ta3erdbpPNF3IMMWutjzUbB1n7frCoU98tkvgMbOLC+F7UKNv7akkvnq
         3vMZI7E1RLIqB1eN9zzNL47ELDS2QkGtBK0XO5DWihAfmADjtTQM3w3GkIItcsiMyJEE
         QbsXfPbKQccrFj+zm6edo4ZbMQFGWHSmtd3VpOwBdmdRXhKMo6Oc7MOK1Gjz3pUPTMm4
         IE8w==
X-Gm-Message-State: AC+VfDy7luwmBxHvscGUdUu7FBsISgFZa+EudeGACkHZf8qxjqIL7ZUe
        1ePu26g6zbtkXa3+6n9WehHscw==
X-Google-Smtp-Source: ACHHUZ7mwfxs1B9qnWlxJCKrjHr0lIx3q7e9uj4FP+M8vJLOlZW66y42WfNCmtL9lmw5ZZA86eAXdQ==
X-Received: by 2002:a17:90b:1bc2:b0:25c:1ad3:a4a1 with SMTP id oa2-20020a17090b1bc200b0025c1ad3a4a1mr18507169pjb.1.1687355340543;
        Wed, 21 Jun 2023 06:49:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a19c100b0025e9519f9e7sm3466163pjj.15.2023.06.21.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:49:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>
In-Reply-To: <20230621132208.1142318-1-ming.lei@redhat.com>
References: <20230621132208.1142318-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't insert passthrough request into sw queue
Message-Id: <168735533970.3923881.12686023221662839779.b4-ty@kernel.dk>
Date:   Wed, 21 Jun 2023 07:48:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 21 Jun 2023 21:22:08 +0800, Ming Lei wrote:
> In case of real io scheduler, q->elevator is set, so blk_mq_run_hw_queue()
> may just check if scheduler queue has request to dispatch, see
> __blk_mq_sched_dispatch_requests(). Then IO hang may be caused because
> all passthorugh requests may stay in sw queue.
> 
> And any passthrough request should have been inserted to hctx->dispatch
> always.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't insert passthrough request into sw queue
      commit: 2293cae703cda162684ae966db6b1b4a11b5e88f

Best regards,
-- 
Jens Axboe



