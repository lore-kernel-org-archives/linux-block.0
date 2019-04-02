Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EC4C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1AD2070B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfDBSGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:06:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35925 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDBSGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 14:06:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so6957816pgc.3;
        Tue, 02 Apr 2019 11:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upl7Ak9MU7qPKZ6+4/X6UfyAbWjbPwFYio9ncW74KRQ=;
        b=S1xAsGpsphgQHVxTev8gYYYttZzKlegBL27F4VSonh6rdxX0uIkxJqTezqJSWDPW6c
         9unIggDd94Y/lqbpqZDG9w+wQFxD7mJQ19e5Bw2/l5y8hH8y/3BtV9l8b62KIbijPMqT
         cwJ70zi121uoHlDm0VaIFQGdm4WAIzTipOpUjxIr7kL0UMROIl7yXS9qVPN7J+KKW7nH
         Jel64NURx+qf0EuD4OeApbRFn9M+wwzr0IlhVLRStO3c1YRSgFzPE7cd1SE6FG4yTg6+
         7XvbUiczs+jAoFZqjKjiSmQQP5M0nX2j205dC3U0wkmXnOZztByNw6883Jo+qqzk1taO
         LbAw==
X-Gm-Message-State: APjAAAXwJd6+lrujuBJQrqiehOHlLmmoUVEDM1HF8j13qg5V3a6GFkrY
        DoOwYc7Gs8xjqrw5SIz5Fpw=
X-Google-Smtp-Source: APXvYqz7f7o0xPPGB/gXQ8InY+wxX1wbLrZ0ZU68cX3HauwiwJn8ZBnL1mxG+lB9E+s5bvCiWcxCMg==
X-Received: by 2002:a63:6a45:: with SMTP id f66mr48507511pgc.7.1554228402409;
        Tue, 02 Apr 2019 11:06:42 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h64sm20811941pfj.40.2019.04.02.11.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 11:06:41 -0700 (PDT)
Message-ID: <1554228400.118779.162.camel@acm.org>
Subject: Re: [PATCH v2 3/8] block: Replace all ktype default_attrs with
 groups
From:   Bart Van Assche <bvanassche@acm.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kimberly Brown <kimbrownkd@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Apr 2019 11:06:40 -0700
In-Reply-To: <20190402174629.GA23882@kroah.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
         <cover.1554151487.git.kimbrownkd@gmail.com>
         <e3b82e2105d1e2b4d6313d862172007e0f4477e2.1554151487.git.kimbrownkd@gmail.com>
         <1554220958.118779.145.camel@acm.org> <20190402174629.GA23882@kroah.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 19:46 +-0200, Greg Kroah-Hartman wrote:
+AD4 On Tue, Apr 02, 2019 at 09:02:38AM -0700, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2019-04-01 at 22:51 -0400, Kimberly Brown wrote:
+AD4 +AD4 +AD4 The kobj+AF8-type default+AF8-attrs field is being replaced by the
+AD4 +AD4 +AD4 default+AF8-groups field. Replace all of the ktype default+AF8-attrs fields in
+AD4 +AD4 +AD4 the block subsystem with default+AF8-groups and use the ATTRIBUTE+AF8-GROUPS
+AD4 +AD4 +AD4 macro to create the default groups.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Remove default+AF8-ctx+AF8-attrs+AFsAXQ because it doesn't contain any attributes.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 This patch was tested by verifying that the sysfs files for the
+AD4 +AD4 +AD4 attributes in the default groups were created.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Kimberly Brown +ADw-kimbrownkd+AEA-gmail.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  block/blk-integrity.c +AHw 3 +-+--
+AD4 +AD4 +AD4  block/blk-mq-sysfs.c  +AHw 8 +-+-------
+AD4 +AD4 +AD4  block/blk-sysfs.c     +AHw 3 +-+--
+AD4 +AD4 +AD4  3 files changed, 6 insertions(+-), 8 deletions(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/block/blk-integrity.c b/block/blk-integrity.c
+AD4 +AD4 +AD4 index d1ab089e0919..85864c71e858 100644
+AD4 +AD4 +AD4 --- a/block/blk-integrity.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-integrity.c
+AD4 +AD4 +AD4 +AEAAQA -365,6 +-365,7 +AEAAQA static struct attribute +ACo-integrity+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 +AD4 +AD4  	+ACY-integrity+AF8-device+AF8-entry.attr,
+AD4 +AD4 +AD4  	NULL,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4 +-ATTRIBUTE+AF8-GROUPS(integrity)+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  static const struct sysfs+AF8-ops integrity+AF8-ops +AD0 +AHs
+AD4 +AD4 +AD4  	.show	+AD0 +ACY-integrity+AF8-attr+AF8-show,
+AD4 +AD4 +AD4 +AEAAQA -372,7 +-373,7 +AEAAQA static const struct sysfs+AF8-ops integrity+AF8-ops +AD0 +AHs
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  static struct kobj+AF8-type integrity+AF8-ktype +AD0 +AHs
+AD4 +AD4 +AD4 -	.default+AF8-attrs	+AD0 integrity+AF8-attrs,
+AD4 +AD4 +AD4 +-	.default+AF8-groups +AD0 integrity+AF8-groups,
+AD4 +AD4 +AD4  	.sysfs+AF8-ops	+AD0 +ACY-integrity+AF8-ops,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
+AD4 +AD4 +AD4 index 3f9c3f4ac44c..5315e538b3b1 100644
+AD4 +AD4 +AD4 --- a/block/blk-mq-sysfs.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-mq-sysfs.c
+AD4 +AD4 +AD4 +AEAAQA -173,10 +-173,6 +AEAAQA static ssize+AF8-t blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-cpus+AF8-show(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, char +ACo-page)
+AD4 +AD4 +AD4  	return ret+ADs
+AD4 +AD4 +AD4  +AH0
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 -static struct attribute +ACo-default+AF8-ctx+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 +AD4 +AD4 -	NULL,
+AD4 +AD4 +AD4 -+AH0AOw
+AD4 +AD4 +AD4 -
+AD4 +AD4 +AD4  static struct blk+AF8-mq+AF8-hw+AF8-ctx+AF8-sysfs+AF8-entry blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-nr+AF8-tags +AD0 +AHs
+AD4 +AD4 +AD4  	.attr +AD0 +AHs.name +AD0 +ACI-nr+AF8-tags+ACI, .mode +AD0 0444 +AH0,
+AD4 +AD4 +AD4  	.show +AD0 blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-nr+AF8-tags+AF8-show,
+AD4 +AD4 +AD4 +AEAAQA -196,6 +-192,7 +AEAAQA static struct attribute +ACo-default+AF8-hw+AF8-ctx+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 +AD4 +AD4  	+ACY-blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-cpus.attr,
+AD4 +AD4 +AD4  	NULL,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4 +-ATTRIBUTE+AF8-GROUPS(default+AF8-hw+AF8-ctx)+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  static const struct sysfs+AF8-ops blk+AF8-mq+AF8-sysfs+AF8-ops +AD0 +AHs
+AD4 +AD4 +AD4  	.show	+AD0 blk+AF8-mq+AF8-sysfs+AF8-show,
+AD4 +AD4 +AD4 +AEAAQA -214,13 +-211,12 +AEAAQA static struct kobj+AF8-type blk+AF8-mq+AF8-ktype +AD0 +AHs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  static struct kobj+AF8-type blk+AF8-mq+AF8-ctx+AF8-ktype +AD0 +AHs
+AD4 +AD4 +AD4  	.sysfs+AF8-ops	+AD0 +ACY-blk+AF8-mq+AF8-sysfs+AF8-ops,
+AD4 +AD4 +AD4 -	.default+AF8-attrs	+AD0 default+AF8-ctx+AF8-attrs,
+AD4 +AD4 +AD4  	.release	+AD0 blk+AF8-mq+AF8-ctx+AF8-sysfs+AF8-release,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  static struct kobj+AF8-type blk+AF8-mq+AF8-hw+AF8-ktype +AD0 +AHs
+AD4 +AD4 +AD4  	.sysfs+AF8-ops	+AD0 +ACY-blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-ops,
+AD4 +AD4 +AD4 -	.default+AF8-attrs	+AD0 default+AF8-hw+AF8-ctx+AF8-attrs,
+AD4 +AD4 +AD4 +-	.default+AF8-groups +AD0 default+AF8-hw+AF8-ctx+AF8-groups,
+AD4 +AD4 +AD4  	.release	+AD0 blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-release,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
+AD4 +AD4 +AD4 index 422327089e0f..7a95a1eb27e1 100644
+AD4 +AD4 +AD4 --- a/block/blk-sysfs.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-sysfs.c
+AD4 +AD4 +AD4 +AEAAQA -769,6 +-769,7 +AEAAQA static struct attribute +ACo-default+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 +AD4 +AD4  +ACM-endif
+AD4 +AD4 +AD4  	NULL,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4 +-ATTRIBUTE+AF8-GROUPS(default)+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  +ACM-define to+AF8-queue(atr) container+AF8-of((atr), struct queue+AF8-sysfs+AF8-entry, attr)
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +AEAAQA -890,7 +-891,7 +AEAAQA static const struct sysfs+AF8-ops queue+AF8-sysfs+AF8-ops +AD0 +AHs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  struct kobj+AF8-type blk+AF8-queue+AF8-ktype +AD0 +AHs
+AD4 +AD4 +AD4  	.sysfs+AF8-ops	+AD0 +ACY-queue+AF8-sysfs+AF8-ops,
+AD4 +AD4 +AD4 -	.default+AF8-attrs	+AD0 default+AF8-attrs,
+AD4 +AD4 +AD4 +-	.default+AF8-groups +AD0 default+AF8-groups,
+AD4 +AD4 +AD4  	.release	+AD0 blk+AF8-release+AF8-queue,
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 
+AD4 +AD4 I think this should have been four patches instead of one.
+AD4 
+AD4 4?  I could maybe see 3, how would you make 4 patches out of this?

Hi Greg,

Not that it matters, but I see four changes in this patch: three conversions
from default+AF8-attrs into default+AF8-groups and also the removal of default+AF8-ctx+AF8-attrs.

Thanks,

Bart.
