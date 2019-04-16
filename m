Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26EC10F14
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1920674
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDPO70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:59:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34697 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbfDPO7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 10:59:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so10556863pfd.1;
        Tue, 16 Apr 2019 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu9Z/EyNWp/U8dL+P8qHuhZD1ld40sA1sHPO6SGI6ok=;
        b=qsI97xtDmxX8qbW/v6B3ETVPE9++QHW5DfLflKQq4P3IUa2LynL94vffzdaJWOhTNT
         +Db2VMX5T7Ce+7ik8ITJGjhyx7fIVPEIQBJF5cMMxLpUuE7xIDATiHd7zHfst3n6Yh+F
         C9TRNRkNM/0m4dkPWhLQPqfC0jDL/6Ja+FUKN8Zb30rzGXOwAPsuLJSI1xqI8OYQ8Yav
         JenzY+4F0d7J09ICTvDfKHFTGxWfbyDFrD9k1lBBN54iHTPCJpWiXYMlqI2pdju56pOU
         XgcxNR3O3yspiWzN9SBhUSxDQQW76YVAAI3SQr7jE5AN2NISGyXecLdbG5UAVXGzbFX3
         GSwQ==
X-Gm-Message-State: APjAAAWBP8JUSMtF574nsNU5zBtle74bH3iPV7lK48CQ4fNS26/I2IyJ
        Aj05s7SfJJVUMl/cyKvrCMc=
X-Google-Smtp-Source: APXvYqyC4K8SMb/lpcsPV3/59yelHHy8Z+8+zfBNakYSXP04DrKu90LbF2wVIg3xGCFRoFHH+wyHkA==
X-Received: by 2002:a62:424f:: with SMTP id p76mr83227665pfa.141.1555426763480;
        Tue, 16 Apr 2019 07:59:23 -0700 (PDT)
Received: from [10.128.207.50] ([66.201.36.5])
        by smtp.gmail.com with ESMTPSA id v82sm118614912pfa.170.2019.04.16.07.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 07:59:22 -0700 (PDT)
Message-ID: <1555426760.35423.0.camel@acm.org>
Subject: Re: [PATCH v2 2/3] blk-mq.c: Rework documention of
 blk_mq_init_sq_queue function
From:   Bart Van Assche <bvanassche@acm.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com
Date:   Tue, 16 Apr 2019 07:59:20 -0700
In-Reply-To: <20190416032801.200694-2-marcos.souza.org@gmail.com>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
         <20190416032801.200694-2-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-16 at 00:28 -0300, Marcos Paulo de Souza wrote:
+AD4  +ACo +AEA-set+AF8-flags: flags of +AEA-set

The above does not look very helpful to me ...

Bart.
