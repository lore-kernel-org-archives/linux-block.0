Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C407C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36DB20834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36DB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLAERs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:17:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33363 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLAERs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:17:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so3114485plo.0;
        Fri, 30 Nov 2018 09:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7W0zgl+vr00Il/EpkBuPOMHALk5lkdMX/ABfHsyALbg=;
        b=R+EfiH8puGnKLiY13xJguOaezNcPxVF5Kzs1K86Chb6WdWlWujHvsoMdefoKChte2k
         hQcUez5xIP7FnzJhvPgGuAn/uWp79+bF36lKoiaETyWc7eWHL4R4FXkLuzA16Q2La1iR
         67a4cXOUWRnbPvYqm/rW9vafU7JygFGkkExQh03PE9Scn3Y0cbtNd1gvjQszP1UnJgvn
         FavhPWS+m8ImlfYDIe6lwWVGqQJ6gtGi/EKOWzBkQxHpkU+surmSw9NX2WpDA/XaSr2O
         E2BkdBZmOY7I9Vi+ih2SaCaJLPSAQ06C0xQXyxwCygEYBgurTPHMmD5Ge4/CFn9dkD9s
         vEMg==
X-Gm-Message-State: AA+aEWYIvt4lNK3wPgOzpHmuvS3U0FSmb6uQbutwo66uKONVhhQe4Sxy
        +OtmTxye+heRoSfVpOzE+mTqGVvR
X-Google-Smtp-Source: AFSGD/VmbWOC5jaU202LNAxemEMILVbO+9c3Ya6dXRoyVtGvejELLMP4VgG0VSq1+wF9/2M1oC0xoQ==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr6325889pln.324.1543597670323;
        Fri, 30 Nov 2018 09:07:50 -0800 (PST)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id x26sm7084562pfn.50.2018.11.30.09.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:07:48 -0800 (PST)
Message-ID: <1543597666.4347.1.camel@acm.org>
Subject: Re: [PATCH 01/27] aio: fix failure to put the file pointer
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de
Date:   Fri, 30 Nov 2018 09:07:46 -0800
In-Reply-To: <20181130165646.27341-2-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
         <20181130165646.27341-2-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-11-30 at 09:56 -0700, Jens Axboe wrote:
+AD4 If the ioprio capability check fails, we return without putting
+AD4 the file pointer.
+AD4 
+AD4 Fixes: d9a08a9e616b (+ACI-fs: Add aio iopriority support+ACI)
+AD4 Reviewed-by: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4
+AD4 Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 ---
+AD4  fs/aio.c +AHw 1 +-
+AD4  1 file changed, 1 insertion(+-)
+AD4 
+AD4 diff --git a/fs/aio.c b/fs/aio.c
+AD4 index b984918be4b7..205390c0c1bb 100644
+AD4 --- a/fs/aio.c
+AD4 +-+-+- b/fs/aio.c
+AD4 +AEAAQA -1436,6 +-1436,7 +AEAAQA static int aio+AF8-prep+AF8-rw(struct kiocb +ACo-req, struct iocb +ACo-iocb)
+AD4  		ret +AD0 ioprio+AF8-check+AF8-cap(iocb-+AD4-aio+AF8-reqprio)+ADs
+AD4  		if (ret) +AHs
+AD4  			pr+AF8-debug(+ACI-aio ioprio check cap error: +ACU-d+AFw-n+ACI, ret)+ADs
+AD4 +-			fput(req-+AD4-ki+AF8-filp)+ADs
+AD4  			return ret+ADs
+AD4  		+AH0

Since this patch fixes a bug that was introduced in kernel v4.18, does this
patch need a +ACI-Cc: stable+ACI tag?

Thanks,

Bart.
