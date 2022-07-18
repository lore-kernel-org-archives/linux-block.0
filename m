Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526F0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 19:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiGRTNG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiGRTNF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CC2D1C5
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r70so8939599iod.10
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=ZJEuLsMRKUxpd8gJCMilrz767jCkM6zmrnjpbeCFU9M=;
        b=kKR9I4FVfr4npYm/FwMPeGKnE1tPcWbWEboAMzIbnqmGPBfE0HhcHLODZX9wCjssBr
         pIUHKVSchsGIf/CRmXV3AjI6hb232hHVwMabwFCJwXNIzJhMe/b9sVmdtA2r7mtLtfFs
         4twaLIAXt43x48uQ5vN9z2s1Z8E0PIpg4DoZaTTW6AhYaKY+mAfb2Nhd5DQjizgXwESg
         T8haaDru1vuB3FX/EN/76vlFksF1xER108KfwUr4xtLQVmchCdtRad8ClkBLQ68m5n2e
         zOHsoZG6c7eLCsvZXa1YWo7tTEuhqAOgjhUsI6N7yKddSlOuvbqqmJHFYFtZfMG7vadu
         hIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ZJEuLsMRKUxpd8gJCMilrz767jCkM6zmrnjpbeCFU9M=;
        b=qVBZMDhg6DUpn9YNuB5/Nv+GRA3dLdmANl6EHF7VVGzVykVfW9XhibnrwTyJJ9PxyL
         9YCwab/ZnOzDpX9noDYztygTgtg5h5XCLgYs3IUdQRl9aK48fC47xxAoGjZruli/Ip7z
         yL7al+JLCuMbEQhivOj+TaQ3ZNh5nVrP0F5JoSLKyrztRp2I2wagjxUe2TzebHBfQQ50
         dLjgAjl7sEZOSy4AyPFNWZG3wLYHB8NJ28edxTEXqvUVVjR4ZvwN6eS3MAEyuEv239ky
         xHjOfwFwFz7qs2MrK8SrUmtEktTuHmVtPx0eiDaLBXHgXQHwO+nYkWuzTxECE1VxeqQK
         Qjjw==
X-Gm-Message-State: AJIora+e4lNUOTNRur+xfeNH7W3TBRgK15ELXmuE7rRVza+mayvtOeHw
        3ZP2Yd40vqSmo4V3zENrsJTtAet3ofNdyw==
X-Google-Smtp-Source: AGRyM1vYRfQKwwNpLfaIlTDzujVOxSzsfBauBFQCXTJMDcVRaclA7QalraSqvoqixrhuat0nLczyCQ==
X-Received: by 2002:a05:6638:1a1a:b0:33f:405d:b1ed with SMTP id cd26-20020a0566381a1a00b0033f405db1edmr15085179jab.164.1658171582231;
        Mon, 18 Jul 2022 12:13:02 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j195-20020a0263cc000000b003417ba4f66asm725116jac.41.2022.07.18.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:13:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220718042408.3132835-1-yangyingliang@huawei.com>
References: <20220718042408.3132835-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ublk_drv: fix missing error return code in ublk_add_dev()
Message-Id: <165817158152.143885.14328206381467598787.b4-ty@kernel.dk>
Date:   Mon, 18 Jul 2022 13:13:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Jul 2022 12:24:08 +0800, Yang Yingliang wrote:
> If blk_mq_init_queue() fails, it should return error code in ublk_add_dev()
> 
> 

Applied, thanks!

[1/1] ublk_drv: fix missing error return code in ublk_add_dev()
      commit: f50e5d670c622349277a46996a70386cc3661b10

Best regards,
-- 
Jens Axboe


