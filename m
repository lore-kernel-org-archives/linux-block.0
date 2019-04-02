Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CFC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0E12082C
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDBQCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:02:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33367 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfDBQCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 12:02:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so6605324pfd.0;
        Tue, 02 Apr 2019 09:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/uBRxoSLaw7wt0dOZLsPDgDlRxlgS5VpEnLB3tUVe4=;
        b=RtnziyQ7nqg49SU0mkFngfWLcF0Xss1YuR3fflrso9GPT1PWuXOfUQH7TmSdZIVATB
         Yi6MCNtw5OgcohMKGLttcVShq4lHgNYQic/I1JdmmmKMW4TSgTHcGcSjTkN1z0La/BAo
         MS4SL9omiBKA0cmBR/5EQIXfbxHSsp8FT/Gp/5s+FwwALNHLeisrYl3fewiOIJZ8MJdj
         /Z3BYH5MuMMtJ1MrkDszmaniFrPSngm/7XVLBlhYqiDNTYmisZNZgSfXw+yPu8rtWqpX
         vBPYG9BABsASX5dFO3ie5LEE7YpABUQuovo1Ul9ZzyYsI+v7wLlLCKOkuk0XxuiW8dHk
         0Psg==
X-Gm-Message-State: APjAAAVjcF2/c7xGCRYIJlrIeDivK/La86d5CAyjqwmzGjVdTUz4Cy87
        q+uoKRukPqhdeojtuS07IZsULY+s
X-Google-Smtp-Source: APXvYqxoF4PPZpoqtWmdw1Bn4yJ/eK8x7Z1MLBULanjxdoxSz25FmafF2Ed6NgkMHuJrc/icHkWJjw==
X-Received: by 2002:a63:e004:: with SMTP id e4mr15910058pgh.344.1554220960463;
        Tue, 02 Apr 2019 09:02:40 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a17sm18057191pgd.30.2019.04.02.09.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 09:02:39 -0700 (PDT)
Message-ID: <1554220958.118779.145.camel@acm.org>
Subject: Re: [PATCH v2 3/8] block: Replace all ktype default_attrs with
 groups
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Apr 2019 09:02:38 -0700
In-Reply-To: <e3b82e2105d1e2b4d6313d862172007e0f4477e2.1554151487.git.kimbrownkd@gmail.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
         <cover.1554151487.git.kimbrownkd@gmail.com>
         <e3b82e2105d1e2b4d6313d862172007e0f4477e2.1554151487.git.kimbrownkd@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-01 at 22:51 -0400, Kimberly Brown wrote:
+AD4 The kobj+AF8-type default+AF8-attrs field is being replaced by the
+AD4 default+AF8-groups field. Replace all of the ktype default+AF8-attrs fields in
+AD4 the block subsystem with default+AF8-groups and use the ATTRIBUTE+AF8-GROUPS
+AD4 macro to create the default groups.
+AD4 
+AD4 Remove default+AF8-ctx+AF8-attrs+AFsAXQ because it doesn't contain any attributes.
+AD4 
+AD4 This patch was tested by verifying that the sysfs files for the
+AD4 attributes in the default groups were created.
+AD4 
+AD4 Signed-off-by: Kimberly Brown +ADw-kimbrownkd+AEA-gmail.com+AD4
+AD4 ---
+AD4  block/blk-integrity.c +AHw 3 +-+--
+AD4  block/blk-mq-sysfs.c  +AHw 8 +-+-------
+AD4  block/blk-sysfs.c     +AHw 3 +-+--
+AD4  3 files changed, 6 insertions(+-), 8 deletions(-)
+AD4 
+AD4 diff --git a/block/blk-integrity.c b/block/blk-integrity.c
+AD4 index d1ab089e0919..85864c71e858 100644
+AD4 --- a/block/blk-integrity.c
+AD4 +-+-+- b/block/blk-integrity.c
+AD4 +AEAAQA -365,6 +-365,7 +AEAAQA static struct attribute +ACo-integrity+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4  	+ACY-integrity+AF8-device+AF8-entry.attr,
+AD4  	NULL,
+AD4  +AH0AOw
+AD4 +-ATTRIBUTE+AF8-GROUPS(integrity)+ADs
+AD4  
+AD4  static const struct sysfs+AF8-ops integrity+AF8-ops +AD0 +AHs
+AD4  	.show	+AD0 +ACY-integrity+AF8-attr+AF8-show,
+AD4 +AEAAQA -372,7 +-373,7 +AEAAQA static const struct sysfs+AF8-ops integrity+AF8-ops +AD0 +AHs
+AD4  +AH0AOw
+AD4  
+AD4  static struct kobj+AF8-type integrity+AF8-ktype +AD0 +AHs
+AD4 -	.default+AF8-attrs	+AD0 integrity+AF8-attrs,
+AD4 +-	.default+AF8-groups +AD0 integrity+AF8-groups,
+AD4  	.sysfs+AF8-ops	+AD0 +ACY-integrity+AF8-ops,
+AD4  +AH0AOw
+AD4  
+AD4 diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
+AD4 index 3f9c3f4ac44c..5315e538b3b1 100644
+AD4 --- a/block/blk-mq-sysfs.c
+AD4 +-+-+- b/block/blk-mq-sysfs.c
+AD4 +AEAAQA -173,10 +-173,6 +AEAAQA static ssize+AF8-t blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-cpus+AF8-show(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, char +ACo-page)
+AD4  	return ret+ADs
+AD4  +AH0
+AD4  
+AD4 -static struct attribute +ACo-default+AF8-ctx+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 -	NULL,
+AD4 -+AH0AOw
+AD4 -
+AD4  static struct blk+AF8-mq+AF8-hw+AF8-ctx+AF8-sysfs+AF8-entry blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-nr+AF8-tags +AD0 +AHs
+AD4  	.attr +AD0 +AHs.name +AD0 +ACI-nr+AF8-tags+ACI, .mode +AD0 0444 +AH0,
+AD4  	.show +AD0 blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-nr+AF8-tags+AF8-show,
+AD4 +AEAAQA -196,6 +-192,7 +AEAAQA static struct attribute +ACo-default+AF8-hw+AF8-ctx+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4  	+ACY-blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-cpus.attr,
+AD4  	NULL,
+AD4  +AH0AOw
+AD4 +-ATTRIBUTE+AF8-GROUPS(default+AF8-hw+AF8-ctx)+ADs
+AD4  
+AD4  static const struct sysfs+AF8-ops blk+AF8-mq+AF8-sysfs+AF8-ops +AD0 +AHs
+AD4  	.show	+AD0 blk+AF8-mq+AF8-sysfs+AF8-show,
+AD4 +AEAAQA -214,13 +-211,12 +AEAAQA static struct kobj+AF8-type blk+AF8-mq+AF8-ktype +AD0 +AHs
+AD4  
+AD4  static struct kobj+AF8-type blk+AF8-mq+AF8-ctx+AF8-ktype +AD0 +AHs
+AD4  	.sysfs+AF8-ops	+AD0 +ACY-blk+AF8-mq+AF8-sysfs+AF8-ops,
+AD4 -	.default+AF8-attrs	+AD0 default+AF8-ctx+AF8-attrs,
+AD4  	.release	+AD0 blk+AF8-mq+AF8-ctx+AF8-sysfs+AF8-release,
+AD4  +AH0AOw
+AD4  
+AD4  static struct kobj+AF8-type blk+AF8-mq+AF8-hw+AF8-ktype +AD0 +AHs
+AD4  	.sysfs+AF8-ops	+AD0 +ACY-blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-ops,
+AD4 -	.default+AF8-attrs	+AD0 default+AF8-hw+AF8-ctx+AF8-attrs,
+AD4 +-	.default+AF8-groups +AD0 default+AF8-hw+AF8-ctx+AF8-groups,
+AD4  	.release	+AD0 blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-release,
+AD4  +AH0AOw
+AD4  
+AD4 diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
+AD4 index 422327089e0f..7a95a1eb27e1 100644
+AD4 --- a/block/blk-sysfs.c
+AD4 +-+-+- b/block/blk-sysfs.c
+AD4 +AEAAQA -769,6 +-769,7 +AEAAQA static struct attribute +ACo-default+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4  +ACM-endif
+AD4  	NULL,
+AD4  +AH0AOw
+AD4 +-ATTRIBUTE+AF8-GROUPS(default)+ADs
+AD4  
+AD4  +ACM-define to+AF8-queue(atr) container+AF8-of((atr), struct queue+AF8-sysfs+AF8-entry, attr)
+AD4  
+AD4 +AEAAQA -890,7 +-891,7 +AEAAQA static const struct sysfs+AF8-ops queue+AF8-sysfs+AF8-ops +AD0 +AHs
+AD4  
+AD4  struct kobj+AF8-type blk+AF8-queue+AF8-ktype +AD0 +AHs
+AD4  	.sysfs+AF8-ops	+AD0 +ACY-queue+AF8-sysfs+AF8-ops,
+AD4 -	.default+AF8-attrs	+AD0 default+AF8-attrs,
+AD4 +-	.default+AF8-groups +AD0 default+AF8-groups,
+AD4  	.release	+AD0 blk+AF8-release+AF8-queue,
+AD4  +AH0AOw

I think this should have been four patches instead of one.

Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

