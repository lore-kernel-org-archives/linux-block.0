Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA74FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiE0PuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 11:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbiE0PuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 11:50:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297F134E17
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 08:50:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 2so5038299iou.5
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=n/fJ9wjC1pXIX0DkPRAjEiWZ9G1KQvCFPCpSJkb5kZs=;
        b=HHVjUg8t4BWFFgTKNQj18T7ROAfp8yg3lU1yYo3y5F7lcH1FgXr5rV0DWfzjs63qIo
         HhkcCTMKyf+YiTJyNyCl5LnUBI5n+6bkABchoWZZe++/BmlDlprh/CgKz2cslBjFAESt
         0I46rY6nNzUpEHl8OkXwyipRNsAcokT2/n5tBpZ3XXXxfvtVR2JAmP1VGCH977ohz5k0
         71ThdrNoFx3MQx+zgIKpZzk0/ec/MEFsy0aP8ZstL2E1Wm/qSmB4d6xHOUPWjDq0qRrm
         6THasFNsoZK1l/s2ZqOk8Q7gxsRtonRUahfG4E0VZnKXHVxGIrBO6/JxN2+GmCuJkxDL
         XU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=n/fJ9wjC1pXIX0DkPRAjEiWZ9G1KQvCFPCpSJkb5kZs=;
        b=1avRRrXf9PjUp8Tjh+Yxcb4FQcHIgBTvW/2mk/wfS/O/hHnUikLYGAdwAJ7Q1pdYet
         jxYwiFBiVn1oiz2OZkrLgE3TBwWgy/uplEtWSPzOeoUHT010J66MxUp1VE+6dVg7KJhx
         YpbPab3FSs0CDXbMt0Y5FG3aaKOhNuc9sy9R9EnYqXUKChlafu99i01WMRTp+R+OnZzt
         7R9GPCrfXSDvefucnlEsziLzZeMwa9mOL1h5YLkXNIHMoaOzKU4iLThimKbKdr8Po7Mu
         1cLsvPMt5rrBjJuoqN8vTxWlu430GpvTAiSkNg93WaWDqEN9dhKsbdMZvsKD56RfD8S5
         DZBw==
X-Gm-Message-State: AOAM531Pv6heD4KCwf9MZz7x0oTOCzXvPXGWjf9+dHNI68Y+JN8efk5c
        DGik0iHMsKc8BzjeHzE1Ya0A4hG+WTKBHg==
X-Google-Smtp-Source: ABdhPJw2KdfmHyyNNE4chqN4Y7/j5DxuJsK4COnZirkfKvSFiDy3UwdbdrfGBhj/0lAasoeyVWU6ZA==
X-Received: by 2002:a05:6638:4883:b0:32e:4d19:4583 with SMTP id ct3-20020a056638488300b0032e4d194583mr21849565jab.312.1653666607800;
        Fri, 27 May 2022 08:50:07 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k22-20020a6b3c16000000b0065a989b183asm1251723iob.41.2022.05.27.08.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 08:50:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     colyli@suse.de
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
In-Reply-To: <20220527152818.27545-1-colyli@suse.de>
References: <20220527152818.27545-1-colyli@suse.de>
Subject: Re: (subset) [PATCH 0/3] bcache fixes for Linux v5.19 (2nd wave)
Message-Id: <165366660711.122737.5293591142225711731.b4-ty@kernel.dk>
Date:   Fri, 27 May 2022 09:50:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 27 May 2022 23:28:15 +0800, Coly Li wrote:
> Here are the 2nd wave bcache fixes for Linux v5.19, they just survives
> from my I/O pressure testing and look fine.
> 
> The patch from Jia-Ju Bai is in my testing queue for a while, it handles
> a memory allocation failure in the I/O path on a backing device when it
> is not attached to cache device.
> 
> [...]

Applied, thanks!

[1/3] bcache: memset on stack variables in bch_btree_check() and bch_sectors_dirty_init()
      commit: 7d6b902ea0e02b2a25c480edf471cbaa4ebe6b3c
[3/3] md: bcache: check the return value of kzalloc() in detached_dev_do_request()
      commit: 40f567bbb3b0639d2ec7d1c6ad4b1b018f80cf19

Best regards,
-- 
Jens Axboe


