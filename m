Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6BC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A420989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCRRUi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:20:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39396 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfCRRUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 13:20:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so1939273pfo.6;
        Mon, 18 Mar 2019 10:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbHAd3+VvwXsq8BBp+6aJ+dj6lwQXqlV8Q8gIb5K+Oc=;
        b=SkMk4A7k5tISUEmGqVZEeVlWHSDo/iiOSRMrS2zrIAW8WHTXi/mx4JxYVC48u2Ng71
         kbcyrnu+GnTVJHw3/YosfTfZ42k7xR80wY214hKNoTRC2xZO/UB8fOe8wW0xl6+4QyEP
         2hTMsK4yBSJL8bdwuBcj9t3qmtyEPjMiByVeeAzP3Dl6QvGnSEHaqOJHtqZPZQC/oQDo
         4tfA05CjZKPN4nO0b8HViXAnbjfEtIB3mZ8hfA+8XZz0w0vznz8wqO75du2qCLvzwDAl
         p7N5BgFxtYteKyeQyqU2LXMmjf4VBz8iJpQLiMmWclxSuBrjM1eE4KSw/lAiGgF1Jux9
         q7WQ==
X-Gm-Message-State: APjAAAWQahCG/GVGrCFTeeWoKSrya3+vAibQCTp9wM2hLNIiHmUdU5zY
        HFwsNeoIison/DpDqbK7syixAW4XAUo=
X-Google-Smtp-Source: APXvYqzJtZgRX2yyQC7iRHWhjVEHwQzKMv+1ggwlJbrumwsJB3wlmJ5Qb83J+qgzjA2v5OykY450mg==
X-Received: by 2002:a17:902:2989:: with SMTP id h9mr21061927plb.26.1552929637160;
        Mon, 18 Mar 2019 10:20:37 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id w2sm12964184pgp.81.2019.03.18.10.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 10:20:36 -0700 (PDT)
Message-ID: <1552929635.152266.30.camel@acm.org>
Subject: Re: [PATCH 6/8] skd: use blk_mq_queue_tag_busy_iter
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        sagi@grimberg.me, keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 10:20:35 -0700
In-Reply-To: <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
         <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>
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
+AD4  drivers/block/skd+AF8-main.c +AHw 4 ++1filechanged2insertions(), 2 deletions(-)
+AD4 
+AD4 diff --git a/drivers/block/skd+AF8-main.c b/drivers/block/skd+AF8-main.c
+AD4 index ab893a7..60c34ff 100644
+AD4 --- a/drivers/block/skd+AF8-main.c
+AD4 diff --git a/drivers/block/skd+AF8-main.c b/drivers/block/skd+AF8-main.c
+AD4 index ab893a7..60c34ff 100644
+AD4 --- a/drivers/block/skd+AF8-main.c
+AD4 +-+-+- b/drivers/block/skd+AF8-main.c
+AD4 +AEAAQA -395,7 +-395,7 +AEAAQA static int skd+AF8-in+AF8-flight(struct skd+AF8-device +ACo-skdev)
+AD4  +AHs
+AD4         int count +AD0 0+ADs
+AD4  
+AD4 -       blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter(+ACY-skdev-+AD4-tag+AF8-set, skd+AF8-inc+AF8-in+AF8-flight, +ACY-count)+ADs
+AD4 +-       blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(skdev-+AD4-queue, skd+AF8-inc+AF8-in+AF8-flight, +ACY-count, true)+ADs
+AD4  
+AD4         return count+ADs
+AD4  +AH0

Hi Jianchao,

If you have a look at the skd+AF8-in+AF8-flight() callers you will see that the above
change is not necessary.

+AD4 +AEAAQA -1916,7 +-1916,7 +AEAAQA static bool skd+AF8-recover+AF8-request(struct request +ACo-req, void +ACo-data, bool reserved)
+AD4  
+AD4  static void skd+AF8-recover+AF8-requests(struct skd+AF8-device +ACo-skdev)
+AD4  +AHs
+AD4 -	blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter(+ACY-skdev-+AD4-tag+AF8-set, skd+AF8-recover+AF8-request, skdev)+ADs
+AD4 +-	blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(skdev-+AD4-queue, skd+AF8-recover+AF8-request, skdev, true)+ADs
+AD4  +AH0

Same comment here. If you have a look at the callers of this function you will
see that this change is not necessary.

Thanks,

Bart.

