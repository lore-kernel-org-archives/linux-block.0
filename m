Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3FBECAAD3
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 16:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiIAQnI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiIAQnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 12:43:06 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E589CD1
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 09:43:05 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id k2so2230092ilu.9
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=l9sLZ+mtMjyG+EMCCj/3RzIK11O+APKzysHZzwyGkHE=;
        b=hLqkJvwvL9gUrNw9F6yOUzoTvMcoQeJPoFmlIKG1BmjEcLsw/4s0UQa0n3ZzL1SMD3
         PJn+98fd5CQK1qYIxbP2lKyFkTSVqANwCHiKvi6JmG6YpOS/0rW5zrdTVFuXP9Uz4ZrD
         e3cLItY05tDF5o+IlcdpANZ/4DJmSOJ+x4UMO6lijaVhBN0arUPi9jxIYTU2bVFDMq/f
         56qAm8hY4+jQE51PdqN2owkj/l6UCeZE5nWz4dKSYsbe2xPzQ/VxaCavKKNVXvsf1Y/g
         0hiqbvAZNNwAYaFva3yGJwSglHcYwbnnwI8g+52+o+0CMZ9Ks5DiaXaHzkqsAb5/iRTc
         6pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l9sLZ+mtMjyG+EMCCj/3RzIK11O+APKzysHZzwyGkHE=;
        b=yuOrSZqPxI7fnFUPhSGajzr1DqmUAY3htaD09UANU/zhfsOE9zlVZHQ5il9PURSCAt
         E5QsSfpNiZBXOpVJs2MSoJOUuH9N4u53kPEdfmW6KeEnFt/pxKiZ2I3EP3K8wDy8IuNm
         TasZ/tboQessBO1IRePNAxaC20hVsoxijFCvRzaRJVAH2LPg9RroWFezgtzOSnsahqeq
         PFMTzffz/KKcjoLVY4E+T+Vam9ZBUVfaNhL0IOUtPvk/3N8FN4T08xYz/CZlsL53YJO9
         USxtOEqo/rrOu/aXb6wF3O9LhHzilT2t6d8R/SLUo3GgILf6Hmnyb1kNew2tPGuOxO6l
         Fs9w==
X-Gm-Message-State: ACgBeo0rp1cfgC1j6XQVM8sdasGMYhCs/hfiNhpqjZZbBYZuNMoFynsv
        lHFmeZhNNdsQ+YLM2AZJO/fgwQ==
X-Google-Smtp-Source: AA6agR7aH4XmZw6RO+vvzre4riRTE/cluMJ/XjVMkwj71XoQSUvZ94WKawGQtkIU/1U2UCHHWFO9Wg==
X-Received: by 2002:a05:6e02:b2d:b0:2ec:b5eb:cd63 with SMTP id e13-20020a056e020b2d00b002ecb5ebcd63mr2346876ilu.291.1662050585263;
        Thu, 01 Sep 2022 09:43:05 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z12-20020a02938c000000b0033f043929fbsm8151707jah.107.2022.09.01.09.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:43:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Keith Busch <kbusch@fb.com>
Cc:     pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>, hare@suse.de
In-Reply-To: <20220825145312.1217900-1-kbusch@fb.com>
References: <20220825145312.1217900-1-kbusch@fb.com>
Subject: Re: [PATCHv3] sbitmap: fix batched wait_cnt accounting
Message-Id: <166205058410.59240.3725947759855970973.b4-ty@kernel.dk>
Date:   Thu, 01 Sep 2022 10:43:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 25 Aug 2022 07:53:12 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Batched completions can clear multiple bits, but we're only decrementing
> the wait_cnt by one each time. This can cause waiters to never be woken,
> stalling IO. Use the batched count instead.
> 
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix batched wait_cnt accounting
      commit: 16ede66973c84f890c03584f79158dd5b2d725f5

Best regards,
-- 
Jens Axboe


