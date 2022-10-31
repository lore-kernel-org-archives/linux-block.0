Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E27AECAAA1
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 13:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJaNcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJaNcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 09:32:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72985A186
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b11so10401335pjp.2
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Caka6+jliHYQg5uBcU6S8n+cjTKgZhOIgl/ZiyeC4=;
        b=LWca2xBIGrpbxgMjif6KZcqGr0yCXVaBuCGQP7A6xxcliR5BlxM4FTavP++TnqkZV6
         P2A9n2btoVznnOJlHL2nur8hKienST/+gRjvR/72oxpl7DYXC8kqubFmAGD5jofFmdTO
         ZJxyTe1PWsJH+q6WNpsF8cptLuPiw68I2Zr7/dcVf/GH4Lx/Je74LGEA140tT+KgJdGq
         cpbdMMLCU+GMJ47qwhTTZAnNfvRqZc9wSqR79aR/yl71SfRO1qwf3ilsJlxxts9KZCDN
         dO9K84Wa2wotAQxfulML3xzcVWdsHEQfFI3dyJr8eV6KX2dLjfvn5SsteM+Qvod+heDW
         dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Caka6+jliHYQg5uBcU6S8n+cjTKgZhOIgl/ZiyeC4=;
        b=sRLoipIvFrDcDOn/F7XLebHTEZ4L82JiGMzG5fpMTkeMeo4vVPXAaK8+/ljs9HiIAm
         bwS+COcrn3h2mlVoYafaxG3SfV+otNA/ND0CTgbQ31T/E2LJuEnuyKWrsoiCtncvIs+G
         yW6oJ9/OpGYJGm8zfF+/cuibJeIYxZ7DCnBAZQMdpfeI5s+/u/T8qQsmOYZselxB8byE
         0gcKYWIZpSgWTqZ05tXkjDhXWdJZoNC9nh3FOo5FmKHUg8d3nTFegYHXFr8isRS6IfGu
         OQCO2PkB0b+XprIDgBWuGzwTF711veinP+wSlxcAXe9rLAWrhVSmXypkOy3P6IUnLeID
         gm8Q==
X-Gm-Message-State: ACrzQf3Y1gEQg7vlVWa4t+NU8aqjddzwoXqtzRoCfg9+QDSTAJvKaX3n
        t3iy3uJLHalhN4P7X1odS/YCKA==
X-Google-Smtp-Source: AMsMyM7neRX3blBajjm7QTcRJvZB5fGWSap2FlMkbO8MNYxCMNIhSBhjTUn10hyIE1k/XE1vFmgWYg==
X-Received: by 2002:a17:902:c942:b0:187:3c1:ad3d with SMTP id i2-20020a170902c94200b0018703c1ad3dmr13882994pla.139.1667223131871;
        Mon, 31 Oct 2022 06:32:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005668b26ade0sm4565791pfd.136.2022.10.31.06.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:32:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@lst.de
In-Reply-To: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
References: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
Subject: Re: [PATCH] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
Message-Id: <166722313098.68022.8855320029749085471.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:32:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 30 Oct 2022 17:47:30 +0800, Jinlong Chen wrote:
> The only caller that needs queue_is_mq check is del_gendisk, so move the
> check into it.
> 
> 

Applied, thanks!

[1/1] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
      commit: 219cf43c552a49a7710b7b341bf616682a2643f0

Best regards,
-- 
Jens Axboe


