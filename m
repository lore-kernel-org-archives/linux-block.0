Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472ADC43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21A2204FD
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbeLNTLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:11:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45462 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNTLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 14:11:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so3136052plm.12
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 11:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUy5MC8+irkWzwuoeP2XlwBbgbbfn5Q7aS0Sk3i0FU0=;
        b=Tl8ZWpmchRRk1yjeK6HTlZKlzsvBrTE1aXIwXKnlsB+b/3tVdsEYEmQyoTtoMG/J1+
         XkZEV6Zd0LH+CmbLwkOyegrvdyfCIjEbGEkkeT1/9WiH8BcuDeuF/3DN0GKFXaLxFCPR
         Y/S6RAXt9Y0aSVWiQTl1itsmMDX58vaQot2eSlgNt8ndNcFLZ+thkJyKH/Yk3HPpVFJE
         jR43yOzPBtNZWKmAjWGjGLgEc4BCxl+y7Ranz+vqlYyl+OBTiBUIAPRqSiQQSWcvbFNh
         vrzDip2UmYz9GZuuv0UVH502bOyyEZVXL73ERs1Mwpug71Ft3iRvcz9oKvSCzlrcUeqp
         YYpw==
X-Gm-Message-State: AA+aEWY8oJDkAycA2k78nWXPXUGi9afOyJXRerVeJWQaYYByCINh+di/
        arD10t6z1OY80aX28Ka2sy0=
X-Google-Smtp-Source: AFSGD/Uek/AJlHPhqGpwf3OUvY2fdRBko4JlGPaQygokCq2kRpE0tdIo9RGseT2g0Z1LwRG06qOKMg==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr4068791plp.9.1544814709078;
        Fri, 14 Dec 2018 11:11:49 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k38sm9162264pgb.33.2018.12.14.11.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 11:11:48 -0800 (PST)
Message-ID: <1544814707.185366.425.camel@acm.org>
Subject: Re: [PATCH 1/2] blk-mq-debugfs: support rq_qos
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 14 Dec 2018 11:11:47 -0800
In-Reply-To: <20181214113926.7451-2-ming.lei@redhat.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
         <20181214113926.7451-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-12-14 at 19:39 +-0800, Ming Lei wrote:
+AD4  static void print+AF8-stat(struct seq+AF8-file +ACo-m, struct blk+AF8-rq+AF8-stat +ACo-stat)
+AD4  +AHs
+AD4 +AEAAQA -856,6 +-857,15 +AEAAQA int blk+AF8-mq+AF8-debugfs+AF8-register(struct request+AF8-queue +ACo-q)
+AD4  			goto err+ADs
+AD4  	+AH0
+AD4  
+AD4 +-	if (q-+AD4-rq+AF8-qos) +AHs
+AD4 +-		struct rq+AF8-qos +ACo-rqos +AD0 q-+AD4-rq+AF8-qos+ADs
+AD4 +-
+AD4 +-		while (rqos) +AHs
+AD4 +-			blk+AF8-mq+AF8-debugfs+AF8-register+AF8-rqos(rqos)+ADs
+AD4 +-			rqos +AD0 rqos-+AD4-next+ADs
+AD4 +-		+AH0
+AD4 +-	+AH0

Have you considered to use a for-loop instead of a while loop? That would
allow to remove the if-statement and hence would make the code more compact.

+AD4 +-int blk+AF8-mq+AF8-debugfs+AF8-register+AF8-rqos(struct rq+AF8-qos +ACo-rqos)
+AD4 +-+AHs
+AD4 +-	struct request+AF8-queue +ACo-q +AD0 rqos-+AD4-q+ADs
+AD4 +-	char +ACo-dir+AF8-name +AD0 rq+AF8-qos+AF8-id+AF8-to+AF8-name(rqos-+AD4-id)+ADs

Please change +ACI-char +ACoAIg into +ACI-const char +ACoAIg.

+AD4  enum rq+AF8-qos+AF8-id +AHs
+AD4  	RQ+AF8-QOS+AF8-WBT,
+AD4  	RQ+AF8-QOS+AF8-CGROUP,
+AD4 +AEAAQA -22,6 +-26,9 +AEAAQA struct rq+AF8-qos +AHs
+AD4  	struct request+AF8-queue +ACo-q+ADs
+AD4  	enum rq+AF8-qos+AF8-id id+ADs
+AD4  	struct rq+AF8-qos +ACo-next+ADs
+AD4 +-+ACM-ifdef CONFIG+AF8-BLK+AF8-DEBUG+AF8-FS
+AD4 +-	struct dentry		+ACo-debugfs+AF8-dir+ADs
+AD4 +-+ACM-endif
+AD4  +AH0AOw

The indentation of +ACI-debugfs+AF8-dir+ACI looks odd to me.

+AD4 +-static inline char +ACo-rq+AF8-qos+AF8-id+AF8-to+AF8-name(enum rq+AF8-qos+AF8-id id)
+AD4 +-+AHs
+AD4 +-	switch (id) +AHs
+AD4 +-	case RQ+AF8-QOS+AF8-WBT:
+AD4 +-		return +ACI-wbt+ACIAOw
+AD4 +-	case RQ+AF8-QOS+AF8-CGROUP:
+AD4 +-		return +ACI-cgroup+ACIAOw
+AD4 +-	+AH0
+AD4 +-	return +ACI-unknown+ACIAOw
+AD4 +-+AH0

Same comment here as earlier: please use +ACI-const char +ACoAIg instead of +ACI-char +ACoAIg
for constant strings. Otherwise this patch looks fine to me.

Thanks,

Bart.

