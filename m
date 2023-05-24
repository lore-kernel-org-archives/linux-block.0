Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB690C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 14:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjEXOQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 10:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEXOQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 10:16:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3857D11D
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 07:16:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so4708339f.1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684937776; x=1687529776;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiOLRIi3DHfMDnXvxWOJoB40jJavD8Yydt2FXOwoBZU=;
        b=e2DKdPlooJHrLrUxwNjplTsZN6eiBscHOUxA7JOdrqIcKIDUT9VeoqzPO+QP0HPGOy
         BWsNw6abVGVIDqoHPIo+nONiMbUGW9of3+8al9q6OR+jpuTk9E0y6vUI2C5kMzijiuOn
         lfo3/swYsXRKJfsoE3TQkA6orMYgDAS9YL1T18bF9i2VXhQ7sEWakkPPyv6bxz767uo4
         hJo5YfEWUICWt2QyVqVegDSssRRTlv53Po8UqgOqgeNNVIcU+Z2Lol4HszqsvQ5Jhw4f
         OvuRuhHrCtah/TDofElxtUBE+KWrQoFJrqjHHW1533sh23Gp2mq/HaOa1hqRhmXQyO1M
         SgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937776; x=1687529776;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiOLRIi3DHfMDnXvxWOJoB40jJavD8Yydt2FXOwoBZU=;
        b=c60Hau4UfsjQAresxppwLwHchFvQIHv3qWgtpnZOaYpJixa5pUiNSNyXj2zbvLvPGo
         HysqF0U0f4jd1/S5Itk8rW1fhQUJGJKG5zMXABB/f95r64Akfanu919rj34WJw6wJgM6
         oYBsOBscCkf7FYa/bW5k93cF9m3SRROzad+9aEn1QDLL1BCRVwU2/n7z7JSRlTrB7Fu8
         IUwMFjsZb29W8v2eVhZ4hyRisIuCC2C1OR+Jrf6gYxv0Opwk6Ps9LELcphM07bowIDPR
         ax5ShY60rQdg6o1+17ejlmzGIv8QLODteGZHBInhdHLl7APn+vniFzhoKu40yMYqgMGv
         CDnQ==
X-Gm-Message-State: AC+VfDynK0Ib+tzclKP3J0cf9oi9DcJhM1Q0VldF78dcE7LGaTXWz02V
        K8lzpDYzxFQMeXBJsRAElRXQYJp+gAVLx+EiKuQ=
X-Google-Smtp-Source: ACHHUZ66QYZkD5ylIRgxYXw/SO2wyAzNV5OzKckqd/kMSgpVwCT6QKbIA50/dE+PvcxRh7gDiqgAXg==
X-Received: by 2002:a6b:3b85:0:b0:774:8d63:449c with SMTP id i127-20020a6b3b85000000b007748d63449cmr1945566ioa.0.1684937776029;
        Wed, 24 May 2023 07:16:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k6-20020a02a706000000b0041cd0951a93sm16376jam.8.2023.05.24.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:16:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
        yhs@meta.com, Francis Laniel <flaniel@linux.microsoft.com>
In-Reply-To: <20230520084057.1467003-1-hengqi.chen@gmail.com>
References: <20230520084057.1467003-1-hengqi.chen@gmail.com>
Subject: Re: [PATCH] block: introduce block_io_start/block_io_done
 tracepoints
Message-Id: <168493777523.545508.7296231125702799266.b4-ty@kernel.dk>
Date:   Wed, 24 May 2023 08:16:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 20 May 2023 08:40:57 +0000, Hengqi Chen wrote:
> Currently, several BCC ([0]) tools (biosnoop/biostacks/biotop) use
> kprobes to blk_account_io_start/blk_account_io_done to implement
> their functionalities. This is fragile because the target kernel
> functions may be renamed ([1]) or inlined ([2]). So introduces two
> new tracepoints for such use cases.
> 
>   [0]: https://github.com/iovisor/bcc
>   [1]: https://github.com/iovisor/bcc/issues/3954
>   [2]: https://github.com/iovisor/bcc/issues/4261
> 
> [...]

Applied, thanks!

[1/1] block: introduce block_io_start/block_io_done tracepoints
      commit: 03fcc599757cd74dbcf1a5977f9c6497a6798587

Best regards,
-- 
Jens Axboe



