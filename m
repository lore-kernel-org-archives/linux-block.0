Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F545C00140
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 13:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiHRNkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbiHRNjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:17 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AE5F12E
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 06:39:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y187so1112502iof.0
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=TMQSZUCZC8D0qnlqKDQ8wCig9O22hkmyWeg060C7Dqw=;
        b=iAOlAo6JwIKEc1AT6NzgBjmRJqXf3ZYQBfB+0/4GExt7Z3TvLuQl3CiKLSaxR+qH6J
         Khrk+rPGCGJkIvlvtTHx+OopONEwliQtqc/t1LQK8wll6ZsHmLgittD1DArkCTxkkBj7
         Sh1kmF6q1SClD5gtbVTlbebQibXo+50J4CfU5j+bAWYMaxtKEUTcDlNHuusirdoPH9L4
         kZdg9EN1W/1bwvHrTUB5+3Jqu5rgw0rveN5fbdvNN/Gxnb2GQSUAwo6YvWCxx7diKjeo
         GHAR5JuixydbMfHsMbC88RlmEyDTDj67zO42cMJKPoZdlaQfnJ9Be3B9ET+IUYEqlni5
         n5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TMQSZUCZC8D0qnlqKDQ8wCig9O22hkmyWeg060C7Dqw=;
        b=bqAzFWmtv647mmlKBSQY1GlOoWV9B+sO+GRG5kskyx+wHwfG9Wb3cWBMdSf9wCA1ix
         NalPpbJzEfh1sIeCOwVCVZF06uX7JsWiwZ0w92akv3cm0uN6pa12hwkValEFR4LDtlv/
         mXoBvUP3bZ0j2p8/Y7V0km1T0ELrT+PuJ8QWQVGXxoILshwuaUWJmr5Qcg9Nj8fFquBB
         RCQDs3Oy2XxxD9MdEfyo/UzbdB5OvIblwxlwJiGN4XjAAQ0rJQrlPnWEVq62vRQPfcX3
         cBwdiytEXKzv6774vAAK5lOQ1h1oPUg+Rm+X2TwWxoyQ+fN3ZwZRF5Gl3hf/DBHrGOrx
         VNvQ==
X-Gm-Message-State: ACgBeo0kcRRRQccshZSlbRhQm0lbZKNHIkUzXr+AXZAfniCOcYQgGhMF
        f8zUbZF8VkwJUCaadG2uxmOGgEeAZDHbBg==
X-Google-Smtp-Source: AA6agR43uRqzzOVYll13LQflWopeR9e3K+6odb3eDKggDjHWpYI0yIujnbq516dQV2LKbWQ/RhmnUg==
X-Received: by 2002:a5d:844d:0:b0:67c:a76d:85cd with SMTP id w13-20020a5d844d000000b0067ca76d85cdmr1426124ior.191.1660829954597;
        Thu, 18 Aug 2022 06:39:14 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i28-20020a056e021d1c00b002e0f21f0be4sm655007ila.27.2022.08.18.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:39:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yuyufen@huaweicloud.com
Cc:     yuyufen@huawei.com, linux-block@vger.kernel.org,
        yukuai3@huawei.com, ming.lei@redhat.com
In-Reply-To: <20220803023355.3687360-1-yuyufen@huaweicloud.com>
References: <20220803023355.3687360-1-yuyufen@huaweicloud.com>
Subject: Re: [PATCH RESEND v2] blk-mq: run queue no matter whether the request is the last request
Message-Id: <166082995377.9130.11768988688286847060.b4-ty@kernel.dk>
Date:   Thu, 18 Aug 2022 07:39:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 3 Aug 2022 10:33:55 +0800, Yufen Yu wrote:
> From: Yufen Yu <yuyufen@huawei.com>
> 
> We do test on a virtio scsi device (/dev/sda) and the default mq
> scheduler is 'none'. We found a IO hung as following:
> 
> blk_finish_plug
>   blk_mq_plug_issue_direct
>       scsi_mq_get_budget
>       //get budget_token fail and sdev->restarts=1
> 
> [...]

Applied, thanks!

[1/1] blk-mq: run queue no matter whether the request is the last request
      commit: d3b38596875dbc709b4e721a5873f4663d8a9ea2

Best regards,
-- 
Jens Axboe


