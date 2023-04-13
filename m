Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2A4C77B6E
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 13:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDMNmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjDMNls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 09:41:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500EA5FF
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:39:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63243b0e85aso537470b3a.1
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681393160; x=1683985160;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5GBQ/viuKe150LzqNRyQRtgZN+m/HG81zsds+v56TE=;
        b=e5mMFdgjV9Ay+CSDa0PrCQedxFnxymfPfiK+ktQyOb5laFRVAX19ZPcS4K+ykI/lBP
         pgh82gPWxhGL2Jk0vIPETxAf3QOqzohaObKaxy0VqipqUDPyFDeSnnjIk99O5kH9O9Tx
         rBkEeGhmTV16C8CQSHZ2q47rG7dXAeEIoAwwJ7U3m8d/FG0w3Syq61/TMdCqZFjWcw/T
         R0SamOYhfUM/W9QoPu/no1ftaCJifUO1GCwZgUxpRSYnJT0R8HhlvIuYGeEf8+58KCFj
         SRLWTtTdduBacBLr9tjwZDsfJNmlbo1zB2mm39EQHUTDwFW2zbRz1lytncBl+WzEzNAk
         BGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393160; x=1683985160;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5GBQ/viuKe150LzqNRyQRtgZN+m/HG81zsds+v56TE=;
        b=VtCh3X/k3RSRGdfTnd79U2bGNAvZx2s9DtFVnh1S5nfs5jdSBr0To8Lbk5a4bEZ52m
         jTZ3LlFP66zinFmFcL/APN63mSnEHHrXjYHBkf0MOQGRiO4k2xAkoFTqraltxMWlf9NN
         GgEVsOyBPipR6AbxLY5xt+J+FW9+7f7YhoVAqieIDC/ZtpFDKt7EmdxMDQW/nlNA2KMU
         zhi3akOtlgu7klvXKD01t1/JwFZtYX0LfRadL+rEzSxzbO84F2gdfx3V7Q1cqomwYPSv
         0fUJM953UTz1QGwVXiMn0ymHheSBjYrFvXGKU8Hs4n81oQCLshAReZ0O0dbVFv4D6491
         InbQ==
X-Gm-Message-State: AAQBX9dcGJjtttK5J1XqxPDqS7/TVuVdriwHPL5ueBUWqN1/7WjmbzDn
        E5JPKx4EvW2d3l/NF8m3RaMJIA==
X-Google-Smtp-Source: AKy350a80gAga1CBrAWGU9/NoXp+AD6PiDbJRqU4qPSs3VAk4bvAhuizY6pNRojoASbeFBg4GAB7nw==
X-Received: by 2002:a05:6a21:339a:b0:d7:3c1a:6c9a with SMTP id yy26-20020a056a21339a00b000d73c1a6c9amr2448161pzb.4.1681393160059;
        Thu, 13 Apr 2023 06:39:20 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a11-20020a655c8b000000b0050bd4bb900csm1373954pgt.71.2023.04.13.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:39:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <20230327143733.14599-1-akinobu.mita@gmail.com>
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] block: null_blk: make fault-injection configurable
 via configfs
Message-Id: <168139315928.27943.13141882986699075665.b4-ty@kernel.dk>
Date:   Thu, 13 Apr 2023 07:39:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 27 Mar 2023 23:37:31 +0900, Akinobu Mita wrote:
> This patch set makes null_blk driver-specific fault-injection dynamically
> configurable per device via configfs.
> 
> Since the null_blk driver supports configuration such as device creation
> via configfs, it is natural to configure fault-injection via configfs as
> well.
> 
> [...]

Applied, thanks!

[1/2] fault-inject: allow configuration via configfs
      commit: 4668c7a2940d134bea50058e138591b97485c5da
[2/2] block: null_blk: make fault-injection dynamically configurable per device
      commit: bb4c19e030f45c5416f1eb4daa94fbaf7165e9ea

Best regards,
-- 
Jens Axboe



