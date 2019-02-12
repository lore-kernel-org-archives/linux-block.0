Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C61C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EC420842
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfBLQ1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:27:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36480 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfBLQ1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:27:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so1491132pgr.3;
        Tue, 12 Feb 2019 08:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hi34Lv6aCME11eE04JEM+wiyPLK4KZl+2OwrOXJ10vI=;
        b=m65589nDlcISiTazCR/b0x0+dYJFRfz4ld+Eau9njdXrnoD07khOBC+RxfFerciM+n
         Arjnkz/zcdHTLX8TCOzP6culWnnSOSjUuEagPpQWhQTpHwmbERZtTR9JOaRScBRI/fGx
         K4BTxQCekbrGAyi50azM+M9F3hAaWqCffsieaqXSlfzsASW5GAOwele3NbtJwDh4dPO2
         MUiF/JMbOAfc+j4K54j1fxrbyEasEGKQ3B+ZOg6SgqKTMK6xgc4Sp3e1kH0+MEJTQ711
         b+7nehGRDXF3ViIvns5vVFzWNJR1id43s/We4S5f4Bb5gd+qWs7dw4cM2vef6TaYuwq2
         Wm4A==
X-Gm-Message-State: AHQUAuaoEN1UuLlApRPM1aSG0HXCfXjMMt0JwUZfMZOU/XutgetEG9XH
        YwR+NinhmTssj0BmSYmsu34=
X-Google-Smtp-Source: AHgI3IZ40pPFdcZLVxHhaBMGvhVzCKUVNGMySt0e6vG6BNjMYE8l2D6Q5HOFpSK2IXoDs+PevV9THg==
X-Received: by 2002:a63:1013:: with SMTP id f19mr4416022pgl.38.1549988838000;
        Tue, 12 Feb 2019 08:27:18 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n68sm35116569pfb.62.2019.02.12.08.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:27:17 -0800 (PST)
Message-ID: <1549988835.19311.29.camel@acm.org>
Subject: Re: [PATCH] scsi: sd: block: Handle cases where devices come online
 read-only
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>
Date:   Tue, 12 Feb 2019 08:27:15 -0800
In-Reply-To: <20190208233831.31377-1-martin.petersen@oracle.com>
References: <20190208233831.31377-1-martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-02-08 at 18:38 -0500, Martin K. Petersen wrote:
+AD4 diff --git a/block/genhd.c b/block/genhd.c
+AD4 index 1dd8fd6613b8..e29805bfa989 100644
+AD4 --- a/block/genhd.c
+AD4 +-+-+- b/block/genhd.c
+AD4 +AEAAQA -1549,11 +-1549,22 +AEAAQA void set+AF8-disk+AF8-ro(struct gendisk +ACo-disk, int flag)

Hi Martin,

Please change the data type of flag from 'int' into enum disk+AF8-policy. Please
also change the return type of get+AF8-disk+AF8-ro() and please also update the data
type of the policy member in struct gendisk.

Thanks,

Bart.

