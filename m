Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E0C282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA84222CC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="liRizbmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfDSS04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56232 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfDSS04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:56 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so9467207itc.5
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2019 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wOQIBPkV+aXF2dPzJRLFRYADIk+XtTZ9v8+WrilvYN8=;
        b=liRizbmhxefwt5cXWNKH9cNrkPmLG2W3b3ZBV+A6f7jURPChgHvMJjvDivporGoxoI
         u9aJbYvYLUvCqDWkodg9Fu1AF/PLCIF8YYMuRnZeU6SPznzh2ZCNmLD0/OA0rSijrpcs
         fDWsV8Cn+/3I6NX8ZweDjIEOFCcCNq0IySmcP0T33swMZCcaRNVs0LkxMQ4j20ao+4Y/
         RxQlF/2wNKvtGXcbZR5cR/RY3suuXONB4pDthDtJ4W0XjefxF5sQNI8woRfMCkYWm3SI
         cFXbny76LrSItYMSfhamdv/0BDGXJR45LkatDGVJmqtC2UQHFRYgWT+op4VFJgyjToGK
         0C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOQIBPkV+aXF2dPzJRLFRYADIk+XtTZ9v8+WrilvYN8=;
        b=a1TQDeaa90BmDcw9azi/d+UASXAFGrqR/rc4UIuKsdVUwQJqOsVXHryTyD/l9i5zBA
         +eYD5CxWeqcuBG+pIn3T0gmPBhyEYF6eRZKDsvEXCVPUTpKyFKBOTB2vSNJ7NLxDLrj/
         Hc5il5PCwuUF5ASYYoxI1NgrUPJU2Z/whQI8il4POaQpfGk9G3bh+39nmczDAo3fVXv8
         JuEOh2o2UPtOltf7D9W0rSzlfJkuYlOYiC9gauk9fuEXFQ/SQ8q89YE32dmlYCQiwWxZ
         6Ds5vhTwU+Zr1PGxVDlmE+gLSHZ/vI054GHowI4BjCJ5+i0R+H1Hs+NZhRS2OnNmOieq
         +uAg==
X-Gm-Message-State: APjAAAUq+C+WK99vOHM1wSAEtQV+/Syx99tWxS/rA6DhEsW/72LhBkF2
        RlLwxyGDDzdFHI52AVnxJf4UwglyPDC/4Q==
X-Google-Smtp-Source: APXvYqyTMpZK23RaXHZBi5DOxMlzjkPHkiUPDLmER+mZxPLgPuNzSUHYm68Zy78g2yiNNo+nAFb7KA==
X-Received: by 2002:a02:a39a:: with SMTP id y26mr3281384jak.135.1555695113355;
        Fri, 19 Apr 2019 10:31:53 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s17sm1366814ioj.76.2019.04.19.10.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 10:31:52 -0700 (PDT)
Subject: Re: [PATCH] block: kill all_q_node in request_queue
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
Cc:     hch@lst.de
References: <20190419023127.71085-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9e3ce4ab-3b5f-8b24-fe4c-0bf570355874@kernel.dk>
Date:   Fri, 19 Apr 2019 11:31:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419023127.71085-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/19 8:31 PM, Hou Tao wrote:
> all_q_node has not been used since commit 4b855ad37194 ("blk-mq: Create
> hctx for each present CPU"), so remove it.

Applied, thanks.

-- 
Jens Axboe

