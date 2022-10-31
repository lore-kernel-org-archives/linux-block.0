Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F88ECAAA1
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 13:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJaNZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJaNZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 09:25:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F3DDC1
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:25:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso10279850pjc.2
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8qiM4TCurj1tlDsH15xUGC8ZXrMxgsWFsWtxg8r588=;
        b=NPNSGGowi/HO22plRryo2Ruc5V23PGrcJKLPfnv2h6QccaJLDpyf23ly5ro7gY5lzH
         bNJHC7+rlVvdP24UmRki/5G0OCsaAxG8n3qQE4/2wpmGS6kyzzbj/uszg1Cm2DOsNKlo
         5IXX/ldcGSa5qag7TLg73yHz0U5YsRmWQ5hz+8A9tSAGamxjakSfUDMmIpoIh3J1sNwh
         a6iOkJSRvqPT5gsAnrJ0Wi+qWO5pP8NK3aek4GYqYqD/pYAX597aHOWDSjoGhELxH52z
         aFw+gNdx7j9UOvoDd+iZSYzhIcfDbTKc72URyOD2mkLoS2Wnm22fo89Op/DJ5F83csmu
         6Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8qiM4TCurj1tlDsH15xUGC8ZXrMxgsWFsWtxg8r588=;
        b=KPdAnfm+C43Jtj4lP852J2ih2vkwqAj0wemuo6a//0xKKt+fZXeLHIxUyoVXi6EtPF
         OFkwNmOlPMM2laQz1xhrrR2uVEK09LU7QJ+gG3x3mIVMw9cxqg6bQhRZWqj2ljdYtVkI
         lyq2rTanr4oqQdKc030FnJDzgtzxq5U6X9L4yGdUlWxxHEqpVB5sQajMQpg25m4KCAXa
         nLvzKtMPyC95B95Y+5j95opEeS3HS4A648iazl4O5ZYNUldkFLtnAxTby5Hs6uTcGLvl
         AOx9/NvqJRaWKJJp5iBj7fflb/o65+qh6ltctdyR/zEHL7Fwc93/XwJd9JgHuiTyCXv+
         DgrQ==
X-Gm-Message-State: ACrzQf2SvpWBOrATpJhelhGRcR9MYpVzPW6mJpsRHy+TkU1+8grEeddC
        gk+Uc54maHHb7ch8FmiSLtWZMWSw++UV5nXl
X-Google-Smtp-Source: AMsMyM4ww2a8F3MQ++tHDa+m7aCM5/Fvn1ea/sYxr5PyYK1pgkkgmmZkJePgmIFoiwjlNXYiWQYOFg==
X-Received: by 2002:a17:90a:1a43:b0:20a:ea98:b962 with SMTP id 3-20020a17090a1a4300b0020aea98b962mr32297927pjl.118.1667222700324;
        Mon, 31 Oct 2022 06:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k28-20020aa7999c000000b0056bfebfa6e4sm4523279pfh.190.2022.10.31.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:24:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221029010432.598367-1-ming.lei@redhat.com>
References: <20221029010432.598367-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/4] ublk_drv: uring_cmd queueing improvement and cleanup
Message-Id: <166722269955.66567.1108349324624737978.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:24:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 29 Oct 2022 09:04:28 +0800, Ming Lei wrote:
> The 1st patch returns correct flag of UBLK_F_URING_CMD_COMP_IN_TASK.
> 
> The 2nd patch add help message for deciding to build ublk_drv as module
> or built-in.
> 
> The 3rd patch improves uses of io_uring_cmd_complete_in_task() by only
> touching io_uring cmd when it is necessary, so we can minimize sharing
> of io_uring cmd between blk-mq io and ubq daemon context.
> 
> [...]

Applied, thanks!

[1/4] ublk: return flag of UBLK_F_URING_CMD_COMP_IN_TASK in case of module
      (no commit info)
[2/4] ublk_drv: comment on ublk_driver entry of Kconfig
      (no commit info)
[3/4] ublk_drv: avoid to touch io_uring cmd in blk_mq io path
      (no commit info)
[4/4] ublk_drv: add ublk_queue_cmd() for cleanup
      (no commit info)

Best regards,
-- 
Jens Axboe


