Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E418C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352028AbiHSU4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352183AbiHSU43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 16:56:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A03DEEC
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso8634818pjk.0
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=6xVQjx/R/HbqKaEGaPCQ8jr5QXfE8Xe3etyly8Q5SaA=;
        b=wxFVQOinoVjpukIhZBGDngA/WJfNCnXxHScC9ytzGACnb5kYDqm77Rlw9Lg1Xz91gd
         Qgf/gvPWVpjQ+0p7UGWEc4i86vHRzZSIPx+V8N4EcPOiET/b8tMpVTw6rbuIhxjidWZa
         RvtZrwN00af4ZhZXBeZTZqeae4+FXZmnmV3sKkJpRGN0IBBp0+4cCPAmXxXht+eekDhs
         6a9nPHrn+PbuilBN0EUfbQqJ94CnEDqQmvBK9kaF/f6EMKtfgb0MczsADfEJW+4m2IUU
         UGwXQgTTmNdqwUvCg4Pvz8YRh1UdvBz+BFS3GmvSEXUf6ZfE+5M1NOPSSTC2zubwwSV8
         sqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6xVQjx/R/HbqKaEGaPCQ8jr5QXfE8Xe3etyly8Q5SaA=;
        b=k9/AO2LDSVSp+2nke0lqmMflrGcXKwdr2Bx/5r50eAokrQSsNpQ9FgV9jSZN2xWrj7
         Bzhbzu0VFj3MgiysnoYpVohvaXYjiIs3/3AyiL85rwa/K6HSPur3eCHRMEhlFXB9KdpV
         LL71A3pLhJz14mJ325+2n2g9LptCIHorwI1E9G+xBPezIRrUybh39ISBeKbdQQNC1TS0
         mxbL4XF1TdRNH0KUkZnrllM8WMi8szQBg5gFlk4AipQqhurhLw6wcHOSPqYoBVEgNJ7N
         s+Sr7ipxSSXFjTbkGFSLx/mwB+u9DilMzs/ImfpJ3tUbZi0WUdwuaq8HXIG16ZfsOUfA
         VTyg==
X-Gm-Message-State: ACgBeo3GUqkGQMHDB+pJSUME0ks7+b89KBc059xxHSQyOfzDnlgxEEAl
        4OR2X6NYjRSv8oJwmhiMhaAsGg==
X-Google-Smtp-Source: AA6agR5lYTzvATI1NaGHg1oF/mlUVomUqkebAw75zSdCnXe/TiOrv8h5iT1K4ebRfnQmT2KwjzaPcw==
X-Received: by 2002:a17:903:2641:b0:172:9634:7e92 with SMTP id je1-20020a170903264100b0017296347e92mr9225699plb.91.1660942586281;
        Fri, 19 Aug 2022 13:56:26 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902d14200b0016dbe37cebdsm3532017plt.246.2022.08.19.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:56:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220815170043.19489-1-bvanassche@acm.org>
References: <20220815170043.19489-1-bvanassche@acm.org>
Subject: Re: [PATCH v2 0/2] Make blk_mq_map_queues() return void
Message-Id: <166094258555.37420.11163817960769626491.b4-ty@kernel.dk>
Date:   Fri, 19 Aug 2022 20:56:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 15 Aug 2022 10:00:41 -0700, Bart Van Assche wrote:
> The only block driver for which the .map_queues() callback can fail is
> null_blk. Since most blk_mq_map_queues() callers ignore the return value of
> this function, modify the null_blk driver such that its .map_queues()
> callback does not fail and change the blk_mq_map_queues() return type into
> void.
> 
> Please consider this patch series for the next merge window.
> 
> [...]

Applied, thanks!

[1/2] null_blk: Modify the behavior of null_map_queues()
      commit: 69aa11ae74b809d4539ae587d1ebc1c90592051e
[2/2] block: Change the return type of blk_mq_map_queues() into void
      commit: f19f2c966b2fdead8b1ca10a93fa8a6eda2a456d

Best regards,
-- 
Jens Axboe


