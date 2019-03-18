Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B7C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCACC20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCRRQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:16:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46648 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRRQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 13:16:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so11805562pgg.13;
        Mon, 18 Mar 2019 10:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4E1evcqLqxZDwrDpf1S27x2FhHzdkvtC33qAjLzojw=;
        b=k70YN2MjuvxTsPlE+Ntb4dm/K0jBmhHpFBds3jpqqLYMrCFz3yk/1FLMyHcSZiV+fa
         gX1ukPmpLrEfSHv+CjjahlsgpICTBVcgNvnekY1TRsi33srN4NPOR1sDbgeCE01Fka99
         BGD8pI8oYJP++elbbuNdnfAc099sVtbWMxGT+NYO9Vbutf0d83r1W5RSQqtZrr8b4Nmz
         FtLwsHuyf6Z7cCugWsglxSFQWFgfsGAEA9LhxMuUCPB0yGu10glfCwYe3oFEc5KchJbh
         kbYNzFr+ELqjdls2GPwJT6onJOWMoUxtcbiOa6vDqjwws/9Ejv0NRRcJsOxmXPTm0K8Z
         9OtA==
X-Gm-Message-State: APjAAAWkfOaEd2opYf1CddOaKJqN/MYcZL1xxuSp24iHRo1c6Ydzc1f1
        PpXSmDVT9yLvyOP4EXwy4es1QadJo1w=
X-Google-Smtp-Source: APXvYqxUm3w2rctlqHvfzCxw5PpFZYfXdmB7cCThe5p5W3sSylHV9U4SRMmLhsnxCXJG82eEKv71YQ==
X-Received: by 2002:a65:6210:: with SMTP id d16mr18684648pgv.189.1552929386882;
        Mon, 18 Mar 2019 10:16:26 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z6sm47644372pgo.31.2019.03.18.10.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 10:16:25 -0700 (PDT)
Message-ID: <1552929384.152266.27.camel@acm.org>
Subject: Re: [PATCH 5/8] nbd: use blk_mq_queue_tag_busy_iter
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        sagi@grimberg.me, keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 10:16:24 -0700
In-Reply-To: <1552640264-26101-6-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
         <1552640264-26101-6-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-15 at 16:57 +-0800, Jianchao Wang wrote:
+AD4 blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter is not safe that it could get stale request
+AD4 in tags-+AD4-rqs+AFsAXQ. Use blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter here.
+AD4 
+AD4 Signed-off-by: Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 ---
+AD4  drivers/block/nbd.c +AHw 2 +-
+AD4  1 file changed, 1 insertion(), 1 deletion(-)
+AD4 
+AD4 diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
+AD4 index 7c9a949..9e7e828 100644
+AD4 --- a/drivers/block/nbd.c
+AD4 +-+-+- b/drivers/block/nbd.c
+AD4 +AEAAQA -747,7 +-747,7 +AEAAQA static bool nbd+AF8-clear+AF8-req(struct request +ACo-req, void +ACo-data, bool reserved)
+AD4  static void nbd+AF8-clear+AF8-que(struct nbd+AF8-device +ACo-nbd)
+AD4  +AHs
+AD4         blk+AF8-mq+AF8-quiesce+AF8-queue(nbd-+AD4-disk-+AD4-queue)+ADs
+AD4 -       blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter(+ACY-nbd-+AD4-tag+AF8-set, nbd+AF8-clear+AF8-req, NULL)+ADs
+AD4 +-       blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(nbd-+AD4-disk-+AD4-queue, nbd+AF8-clear+AF8-req, NULL, true)+ADs
+AD4         blk+AF8-mq+AF8-unquiesce+AF8-queue(nbd-+AD4-disk-+AD4-queue)+ADs
+AD4         dev+AF8-dbg(disk+AF8-to+AF8-dev(nbd-+AD4-disk), +ACI-queue cleared+AFw-n+ACI)+ADs
+AD4  +AH0

Hi Jianchao,

The nbd driver calls nbd+AF8-clear+AF8-que() after having called sock+AF8-shutdown(). So
what makes you think that it's not safe to call blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter()
from nbd+AF8-clear+AF8-que()?

Thanks,

Bart.
