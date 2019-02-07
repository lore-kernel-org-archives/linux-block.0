Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F6C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231A821721
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfBGWLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:11:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37998 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 17:11:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so634806plb.5;
        Thu, 07 Feb 2019 14:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJ4mz0w10OFINyYWvX/VHaEdIoKahzYqBX9QIEaXvH0=;
        b=RHwgy5FbtHaIfAVdGN4G6ZR3bAL+6Iufl9JXDfhX8QiDefBiSi3dyzBnaLbKrixJ40
         GzR+iKEay2YVsq0omTNWoGaoR5FrR5rI5t+oL+8UPvt/N0fstfxVJSMwrzWf/Wcp3rh3
         Z8R1Wyssl09HV0R3Nhf/HpudpsBmuu6VwDQSf0ea4c/TCOFS7uKtnYCYcY1FN9M5bIs6
         bUKEvTEf2FSo/4+vu1369oMzCcDlnq6K6KphRwr/wDS4C9eKJuC7sDNQjhZVN6tgy7uE
         /PCW01ctb0flVNbYucI4cfmIhwk/7fWzXd+WpcabyAyrkKaxwx3ziwxNE1zR8sIR4WhN
         PgZQ==
X-Gm-Message-State: AHQUAubQQI+uEXa6pmsH0V9F90GnPUiBxhIjbay5V7JuaSnQ4pL4yLPs
        pA/nX1AZZaMaYY/vKseEwW8=
X-Google-Smtp-Source: AHgI3IawoDcM/Pzl0vMaoREy8aAPwBYVuJu1zIFoLwCeuinlp98Dj0cjCrxdr1A1Hfm0iKC0uGB41w==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr19330897plb.335.1549577506194;
        Thu, 07 Feb 2019 14:11:46 -0800 (PST)
Received: from [10.178.123.65] ([192.55.54.60])
        by smtp.gmail.com with ESMTPSA id y184sm121370pgd.71.2019.02.07.14.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:11:45 -0800 (PST)
Message-ID: <1549577503.153283.0.camel@acm.org>
Subject: Re: [PATCH v2 1/2] loop: Report EOPNOTSUPP properly
From:   Bart Van Assche <bvanassche@acm.org>
To:     Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Feb 2019 14:11:43 -0800
In-Reply-To: <20190207205730.199332-2-evgreen@chromium.org>
References: <20190207205730.199332-1-evgreen@chromium.org>
         <20190207205730.199332-2-evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-02-07 at 12:57 -0800, Evan Green wrote:
+AD4 Properly plumb out EOPNOTSUPP from loop driver operations, which may
+AD4 get returned when for instance a discard operation is attempted but not
+AD4 supported by the underlying block device. Before this change, everything
+AD4 was reported in the log as an I/O error, which is scary and not
+AD4 helpful in debugging.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


