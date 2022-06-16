Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F610C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 20:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiFPUq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPUq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 16:46:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901C5C767
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:46:26 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d123so2657026iof.10
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=+wLVzNwY2jHpwX+aEnW44jAqHIKGEH5zjb8YxjQ0Bw8=;
        b=jLpDTyf2V81DfcQwzDHBN8SkRjoUSsfCP0LQTPavU6lKtyjzqoQPMcaA9uKButM8zB
         Z8LIPSP/uTMQTnBMPq4PS0pnV39G2Z0bS19R9z5TIyqAKyRNl0arg6rY75QZNUXUPECd
         bzI3Abvlj7R64lV3fME/Mqm/N0O3sVVqLwatKjUzDtOXCz9YfVxtNicSSfbiI+rSFND2
         cis2WBLAZ4jzs//PlpxTA6Urzig1pQNXZ0Q1oZzfqb0O728DmkCaaBTmE878CGpsDCR9
         FN1aqpR4vX2JDFf+0yAvLD/W0i3knU4hO9Ha9o9tJvst2q/qfoLs3QGjdfZyxFglhX61
         9VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=+wLVzNwY2jHpwX+aEnW44jAqHIKGEH5zjb8YxjQ0Bw8=;
        b=7apD+lw6P7hYD4CghR/WaDtK05N+fuxIsx4pkNDFfau7tufilyqQpqPpBpGPmtMLXg
         47AxVrdjKwm7p4ZGNetmTopG1doVmjdQH6ZMxioS9n3VGL6GhUSV4qiwsGv0odvRwkep
         rKTdp0ufuvPpKdj2PJJkiy/QNehnZ4k8PhEqGCSSeyRyu7UzGArO9dj5RY5S8Dzo4Ink
         nKqXs7JYFcK4z4cBojwG+pCGaHIl363XKdNQknv365grec0AP2TBkoa0BZ5xoo65vLtZ
         SNYsZVwK4qna7BDF1496lUkPCrx0HEF4Jf/RoGIEH2hFYc8JbRnq2WhmG6M4cjbVDcjs
         kitA==
X-Gm-Message-State: AJIora8mqWyOUcslxcckTvRc1VOmQS1uOnAhknsfimmN3aaWnHuKyiio
        QsNNuF4K/NC+lZ+uXo0JNH/3qRpKB3WRdw==
X-Google-Smtp-Source: AGRyM1vNvMLqqdqwbKxPP/S2DtxGuUNSODvZOaTWGjlivXHSKFpyR1HT+Zh9OK4Axj8FYtQn+E5Vhw==
X-Received: by 2002:a02:c513:0:b0:331:604b:a631 with SMTP id s19-20020a02c513000000b00331604ba631mr3836816jam.42.1655412386058;
        Thu, 16 Jun 2022 13:46:26 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z65-20020a0293c7000000b0032b7fb6c33asm1320251jah.84.2022.06.16.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:46:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220615210004.1031820-1-bvanassche@acm.org>
References: <20220615210004.1031820-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Fix handling of offline queues in blk_mq_alloc_request_hctx()
Message-Id: <165541238531.250853.2935714049059909581.b4-ty@kernel.dk>
Date:   Thu, 16 Jun 2022 14:46:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Jun 2022 14:00:04 -0700, Bart Van Assche wrote:
> This patch prevents that test nvme/004 triggers the following:
> 
> UBSAN: array-index-out-of-bounds in block/blk-mq.h:135:9
> index 512 is out of range for type 'long unsigned int [512]'
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack_lvl+0x49/0x5e
>  dump_stack+0x10/0x12
>  ubsan_epilogue+0x9/0x3b
>  __ubsan_handle_out_of_bounds.cold+0x44/0x49
>  blk_mq_alloc_request_hctx+0x304/0x310
>  __nvme_submit_sync_cmd+0x70/0x200 [nvme_core]
>  nvmf_connect_io_queue+0x23e/0x2a0 [nvme_fabrics]
>  nvme_loop_connect_io_queues+0x8d/0xb0 [nvme_loop]
>  nvme_loop_create_ctrl+0x58e/0x7d0 [nvme_loop]
>  nvmf_create_ctrl+0x1d7/0x4d0 [nvme_fabrics]
>  nvmf_dev_write+0xae/0x111 [nvme_fabrics]
>  vfs_write+0x144/0x560
>  ksys_write+0xb7/0x140
>  __x64_sys_write+0x42/0x50
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [...]

Applied, thanks!

[1/1] block: Fix handling of offline queues in blk_mq_alloc_request_hctx()
      commit: 14dc7a18abbe4176f5626c13c333670da8e06aa1

Best regards,
-- 
Jens Axboe


