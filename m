Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC65DC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3FB208CB
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfF1U0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:26:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38597 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfF1U0D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:26:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so3078878pgz.5
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 13:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgunoje9YbXGMNCay1bN61kDNQcMxRFun4wlkSk4Mqs=;
        b=rNvVBG+ZlxMJc2A0QqKJiypb+nZiQaF9xZNGinFOp+fc+a+kkGT6qgglDMKZbtGrDr
         cvteV21GSikhziQnn+I3Fpm8x3wrj5+On1R53LBdw6ob6pHCIzIDpSI21m/OgV7UCiBk
         nUkw+aLgFLv5WnWu1n/jAQUyLWKyHQLfNz5nVbe2cU2Nxes+qEJzqj9a2X+L9T71qOp4
         0mcNqdVvap/2+28JQlFHJ2H2274mBwOe46+uv+YeWr8OumnlyW+vGngw3htvM2RxDqZw
         MxTm2YYSA1XNHYk3KZLB9K+ewhEIdfe3QKz/zvo7DFp+hg1W79j/yLs1Kfn3/rpukcHv
         LoAg==
X-Gm-Message-State: APjAAAXQHWYnloIOhljolxvVIto39Yl1L5Ann4cy5I1Wp2/5Yh5IQ+OP
        bF3Fvvm970LQB+Vz7LzRInc=
X-Google-Smtp-Source: APXvYqw4cEikbrWM0hg4EHP+wJ2ybsA4pH6aEh0gPxxbrptL9s/mHV31XCSxfKcvO0uM1V109IIWYg==
X-Received: by 2002:a65:5248:: with SMTP id q8mr2358109pgp.259.1561753562945;
        Fri, 28 Jun 2019 13:26:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t24sm3269361pfh.113.2019.06.28.13.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 13:26:02 -0700 (PDT)
Subject: Re: [PATCH] block: Rename hd_struct.policy into hd_struct.read_only
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>
References: <20190628195615.201990-1-bvanassche@acm.org>
 <yq1y31lh3pl.fsf@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <36038ce7-8cfe-4dc4-2a65-ff26ee7d1694@acm.org>
Date:   Fri, 28 Jun 2019 13:26:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <yq1y31lh3pl.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/19 1:09 PM, Martin K. Petersen wrote:
> 
> Bart,
> 
>> Since nobody knows what "policy" means, rename the field to "read_only"
>> for clarity. Martin Petersen proposed this earlier - see also his patch
>> "scsi: sd: block: Fix regressions in read-only block device handling"
>> (https://www.spinics.net/lists/linux-scsi/msg129146.html). This patch
>> is an extension of a subset of Martin's patch.
> 
> I'd rather we just get this one merged:
> 
> 	https://patchwork.kernel.org/patch/10967367/
> 
> It even comes with a shiny blktest.

Ah, I had overlooked that patch.

Jens, please drop my patch.

Bart.


