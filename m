Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625FDC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 14:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiBBOsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBBOsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 09:48:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943BC061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 06:48:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso6223115pjt.3
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 06:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=o2YwdDrmz2Gi+LFty9hPLez4dJYG3tDKGBRIQIFGHlY=;
        b=ciZHZivMW32BQJwTSSyu4AB2jCIoRiAX8bxIKaDdGtzINzzZgrdiKZw5zykAnQ4vZw
         8mfUdwK9lubVZmQfz6z7P46pGEB7Dp4bHYnH1sA/JtpfgTt/jAW8RRHpuZHpA37QKd3C
         xH+kOJTpMbz6rVp1cHfqrSODVZADLwTWo8+NPRBlJSGYqNcMjdXlXcvGyHdKUn2WrVCy
         h0hnn0s5Rj2AUPktZQpp7nK0T7a8ETlcncT+yJH824T3VTVT4s+1jZ8v8noPpzjww+EW
         T1M6lzjgFFrG9FMcZJyExW1VaGPio8vuN4IBw256E2Obx8Qark2Jnk47nJ7Wk443892r
         kdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=o2YwdDrmz2Gi+LFty9hPLez4dJYG3tDKGBRIQIFGHlY=;
        b=DKuPp2XaoTMY11OEtwRWA+dLDs8w3zcfqcTpHCAXlQ38F7cEyBp3AH/0luPIlKZBiW
         Rro/q/Jl/dg0qQaOxFO4aDMCP6n6cpJJYIaKhd+hhMZIDIwaDP+eq3lkb2YUXfOaOg+c
         GQUHRM1zltlx5CtOzDAfgPyjPUTgK5bIyyYBbRBQjX7u/WAtESzoEwiV52LhS7ONUDck
         uoRmRFg+gJGnYrI3uX1o4mm/rvCRgiGGPPPoU+w3i+l3KVizykjgDIYv493OC1RziCGa
         3mQW/LN6IVua4boGQwLVtCbWFPGC9nwjPf+zC0flNWnLIbzUwFLEAJihc1Ew1fynSYVH
         552Q==
X-Gm-Message-State: AOAM531u7K7nLDO8yn+dJuvNbqn0Ly/f6LbCS3RHyhRi7VlXiLhE9OBK
        ZtcqucFuq2Cnpvuo841Trl7HgQ==
X-Google-Smtp-Source: ABdhPJyHwRBbaqcSa4if9zeZtcm8WmzfudtV8ZQYfEsw1AH8kXbPkrt8FuHP8dN8OBUVsn/SQZOepw==
X-Received: by 2002:a17:90b:2385:: with SMTP id mr5mr8384586pjb.186.1643813330845;
        Wed, 02 Feb 2022 06:48:50 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y42sm27096277pfa.5.2022.02.02.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:48:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ilya Dryomov <idryomov@gmail.com>, linux-block@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220201100420.25875-1-idryomov@gmail.com>
References: <20220201100420.25875-1-idryomov@gmail.com>
Subject: Re: [PATCH] block: fix DIO handling regressions in blkdev_read_iter()
Message-Id: <164381332963.169219.170063515987307185.b4-ty@kernel.dk>
Date:   Wed, 02 Feb 2022 07:48:49 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 1 Feb 2022 11:04:20 +0100, Ilya Dryomov wrote:
> Commit ceaa762527f4 ("block: move direct_IO into our own read_iter
> handler") introduced several regressions for bdev DIO:
> 
> 1. read spanning EOF always returns 0 instead of the number of bytes
>    read.  This is because "count" is assigned early and isn't updated
>    when the iterator is truncated:
> 
> [...]

Applied, thanks!

[1/1] block: fix DIO handling regressions in blkdev_read_iter()
      commit: 3e1f941dd9f33776b3df4e30f741fe445ff773f3

Best regards,
-- 
Jens Axboe


