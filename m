Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACDC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13562146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13562146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLAEeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:34:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33689 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAEeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:34:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so3141363pfb.0;
        Fri, 30 Nov 2018 09:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhknZVvHAWi4NnKosLSr9TAIriD3mac9Wb+I53iUqtM=;
        b=f8U6Zuc8XSPjHQ5atwm+z2ZL20fW9wpzw/Wgaea4xh28E9eaZw1IG2zgY37VhWTNmW
         USH5SN6rGSioqVNM35CNiQEKab1nHeU1ksEGe6mzfa5zHk5/bDa3bcNNIvfaK5QKykWT
         am8lcBbzPFGxq3YvIYCblDq/pb1IBTrjZ3eF2qUjuuL9yXEYkB2cDm+IM13gsHfgqYO4
         dQiZwKo/qM9OYEXuTd8JnncaPkzYj6CsVx+k2KNycHgzLwNBz/lFwMOSmSBLae5Y2vT4
         gflJl8qjDajqg+EClzYimiTQlNiLL20JhvJZrfbm8Df2ISBaBqWX4KQe1N6elS3eXcRL
         TgGQ==
X-Gm-Message-State: AA+aEWa5J4P1WJblFlzajjhxAzzZYY8YmQECIJ5BokBo9iQ+eUDVdPtW
        De29irApmSkc7Wj+fSkKCgw=
X-Google-Smtp-Source: AFSGD/X+Ff2Mbd/wVGSSlgO2wboT0bAJrgeEhkEW3ABPeM+yaGMYHdM6Z6e+gd1zl+4kkyG6G9upxA==
X-Received: by 2002:a63:134f:: with SMTP id 15mr5494196pgt.19.1543598662961;
        Fri, 30 Nov 2018 09:24:22 -0800 (PST)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id 128sm10819518pfu.129.2018.11.30.09.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:24:22 -0800 (PST)
Message-ID: <1543598661.4347.8.camel@acm.org>
Subject: Re: [PATCH 01/27] aio: fix failure to put the file pointer
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de
Date:   Fri, 30 Nov 2018 09:24:21 -0800
In-Reply-To: <52910028-205c-adc5-acc0-3f03e35ece66@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
         <20181130165646.27341-2-axboe@kernel.dk> <1543597666.4347.1.camel@acm.org>
         <52910028-205c-adc5-acc0-3f03e35ece66@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-11-30 at 10:08 -0700, Jens Axboe wrote:
+AD4 On 11/30/18 10:07 AM, Bart Van Assche wrote:
+AD4 +AD4 On Fri, 2018-11-30 at 09:56 -0700, Jens Axboe wrote:
+AD4 +AD4 +AD4 If the ioprio capability check fails, we return without putting
+AD4 +AD4 +AD4 the file pointer.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Fixes: d9a08a9e616b (+ACI-fs: Add aio iopriority support+ACI)
+AD4 +AD4 +AD4 Reviewed-by: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4
+AD4 +AD4 +AD4 Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 +AD4 +AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  fs/aio.c +AHw 1 +-
+AD4 +AD4 +AD4  1 file changed, 1 insertion(+-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/fs/aio.c b/fs/aio.c
+AD4 +AD4 +AD4 index b984918be4b7..205390c0c1bb 100644
+AD4 +AD4 +AD4 --- a/fs/aio.c
+AD4 +AD4 +AD4 +-+-+- b/fs/aio.c
+AD4 +AD4 +AD4 +AEAAQA -1436,6 +-1436,7 +AEAAQA static int aio+AF8-prep+AF8-rw(struct kiocb +ACo-req, struct iocb +ACo-iocb)
+AD4 +AD4 +AD4  		ret +AD0 ioprio+AF8-check+AF8-cap(iocb-+AD4-aio+AF8-reqprio)+ADs
+AD4 +AD4 +AD4  		if (ret) +AHs
+AD4 +AD4 +AD4  			pr+AF8-debug(+ACI-aio ioprio check cap error: +ACU-d+AFw-n+ACI, ret)+ADs
+AD4 +AD4 +AD4 +-			fput(req-+AD4-ki+AF8-filp)+ADs
+AD4 +AD4 +AD4  			return ret+ADs
+AD4 +AD4 +AD4  		+AH0
+AD4 +AD4 
+AD4 +AD4 Since this patch fixes a bug that was introduced in kernel v4.18, does this
+AD4 +AD4 patch need a +ACI-Cc: stable+ACI tag?
+AD4 
+AD4 The fixes should take care of that by itself, I hope.

Hi Jens,

My understanding is that patches that have a +ACI-Cc: stable+ACI tag are guaranteed to
be integrated in a stable kernel sooner or later. Without that tag it depends on
the stable kernel maintainer whether or not these patches get picked up. I think
the +ACI-AUTOSEL+ACI tag Sasha Levin uses indicates that a patch was picked up for one
of his stable kernels and that it did not have a +ACI-Cc: stable+ACI tag. I'm not sure
Greg KH picks up patches that only have a +ACI-Fixes:+ACI tag but no +ACI-Cc: stable+ACI tag.

Bart.
