Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4B9C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349DC204FD
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeLNTPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:15:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45668 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNTPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 14:15:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so3139442plm.12
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 11:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUr0rorcAsBwP1JVWctylssazl+dnHmWq/IaLZNc+3g=;
        b=sce9gQKqSYs3zsZkAkNbxC83hul/eerBp4wLoob9eg/LJ+7UPXq9JL4NWqSwMYhdho
         ZvnlWm1yySgFpT0RTP4uH8GPG9bM4UdgYUo3HgIXiButpc6SmswOV+rb72todbYpejX6
         euhf17jyAuc3/Tg1xM/31bh6ikgOIq9GrRmjEmEieuwKzDryEtbo2CQs4Qkvy8rXtaLi
         yXVRzvfg+cEN22IY1bCyqUf08MRoR2yztAsxnn4MvOEso9MH+f6rz35LqYcXlN7A1IyX
         jjMks+9Ha2qOV5HXw5Wy0Kn98I6+nZG25/zy6PUbTwZzTUDQjFduaEvi8pwb8RQH6wWH
         ge0Q==
X-Gm-Message-State: AA+aEWacZfNey4k5W5L3+N8Iz3JJ0XlRE4mgenAvYJ4D0gaXZnjZBVRr
        YoIzKc/m/drprjj0nmzcfdk=
X-Google-Smtp-Source: AFSGD/Vz1+kzA2b+9TUjGAiuuIFzoGdGaVv3OxU8iY2S5V7I9WuPofX1FwLs+9U9tKfSG62xIULAXA==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr4111875plb.125.1544814905021;
        Fri, 14 Dec 2018 11:15:05 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 128sm8607938pfu.129.2018.12.14.11.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 11:15:04 -0800 (PST)
Message-ID: <1544814903.185366.427.camel@acm.org>
Subject: Re: [PATCH 2/2] blk-wbt: export internal state via debugfs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 14 Dec 2018 11:15:03 -0800
In-Reply-To: <20181214113926.7451-3-ming.lei@redhat.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
         <20181214113926.7451-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-12-14 at 19:39 +-0800, Ming Lei wrote:
+AD4 This information is helpful to either investigate issues, or understand
+AD4 wbt's internal behaviour.
+AD4 
+AD4 Cc: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4
+AD4 Cc: Omar Sandoval +ADw-osandov+AEA-fb.com+AD4
+AD4 Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 Cc: Josef Bacik +ADw-josef+AEA-toxicpanda.com+AD4
+AD4 Signed-off-by: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4
+AD4 ---
+AD4  block/blk-wbt.c +AHw 91 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AD4  1 file changed, 91 insertions(+-)
+AD4 
+AD4 diff --git a/block/blk-wbt.c b/block/blk-wbt.c
+AD4 index 463e4eb80287..2684bf2d112f 100644
+AD4 --- a/block/blk-wbt.c
+AD4 +-+-+- b/block/blk-wbt.c
+AD4 +AEAAQA -715,6 +-715,94 +AEAAQA void wbt+AF8-disable+AF8-default(struct request+AF8-queue +ACo-q)
+AD4  +AH0
+AD4  EXPORT+AF8-SYMBOL+AF8-GPL(wbt+AF8-disable+AF8-default)+ADs
+AD4  
+AD4 +-+ACM-ifdef CONFIG+AF8-BLK+AF8-DEBUG+AF8-FS
+AD4 +-static int wbt+AF8-curr+AF8-window+AF8-show(void +ACo-data, struct seq+AF8-file +ACo-m)
+AD4 +-+AHs
+AD4 +-	struct rq+AF8-qos +ACo-rqos +AD0 data+ADs
+AD4 +-	struct rq+AF8-wb +ACo-rwb +AD0 RQWB(rqos)+ADs
+AD4 +-
+AD4 +-	seq+AF8-printf(m, +ACIAJQ-llu ns+AFw-n+ACI, rwb-+AD4-cur+AF8-win+AF8-nsec)+ADs
+AD4 +-	return 0+ADs
+AD4 +-+AH0

Please consider to embed the unit (+ACI-ns+ACI) in the attribute name instead of
in the attribute value. That will make it easier to process this attribute
in developer debug scripts.

+AD4 +-static int wbt+AF8-min+AF8-latency+AF8-show(void +ACo-data, struct seq+AF8-file +ACo-m)
+AD4 +-+AHs
+AD4 +-	struct rq+AF8-qos +ACo-rqos +AD0 data+ADs
+AD4 +-	struct rq+AF8-wb +ACo-rwb +AD0 RQWB(rqos)+ADs
+AD4 +-
+AD4 +-	seq+AF8-printf(m, +ACIAJQ-luns+AFw-n+ACI, rwb-+AD4-min+AF8-lat+AF8-nsec)+ADs
+AD4 +-	return 0+ADs
+AD4 +-+AH0

Same comment here about the unit.

+AD4 +-static const struct blk+AF8-mq+AF8-debugfs+AF8-attr wbt+AF8-debugfs+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 +-	+AHsAIg-curr+AF8-window+ACI, 0400, wbt+AF8-curr+AF8-window+AF8-show+AH0,
+AD4 +-	+AHsAIg-enable+AF8-state+ACI, 0400, wbt+AF8-enable+AF8-state+AF8-show+AH0,

How about using +ACI-enabled+ACI instead of +ACI-enable+AF8-state+ACI?

Thanks,

Bart.

