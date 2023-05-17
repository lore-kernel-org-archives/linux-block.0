Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62DC77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 00:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjEQAAd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjEQAAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 20:00:32 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A455A6
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 17:00:31 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1aae5c2423dso2615045ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 17:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684281631; x=1686873631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCaJJOxhPjCPJUIUTvSbXXjWTqnQqKAmmnB3/WOFAxc=;
        b=L/tDYCzfdAdKKbcd9sTP509cUZF1WPynK1veX3BXyz1EUOu/1Av+OibNZZGHY3QGf1
         +3l+eou2ufaNayakKWRpBExiCx7jIJ5Yx1kv2IyNfcQzsh2Y/q+i9+ESPb0PHwxoIFec
         9Y0twcDphHDuwIZbRD3E6t5bhKSHWnM7DPngFF3qG6Kt2se53kP54cPWT2Vmd/kWuuDH
         yu0pxJIoR/PfJR+zhD4ZR17BeUBAJHkMENnOfNo4mcwCH1CBLrLrXIPFBUaC6TZmgt0R
         W3VVCnf+HLsoVNhBZhPPNCmaW78TyPJdF+QFTTkt5beY0PVUom4rFS9mcbDgYPUjM26u
         fO+w==
X-Gm-Message-State: AC+VfDx5jD18L0NO0B9ZTyrPxZjtG0zz/FC5jpl71MRPmbm6NPvKC2nB
        3l+bUVPlAi4KFdZAsxY1pbpX9uHdSzQ=
X-Google-Smtp-Source: ACHHUZ7XPGNZT+JW97VmBSK+fUxkYIe/9yESrNLnD8fIwOxOWHfjFZO0FjxCk849L09ht2qsjbO6fw==
X-Received: by 2002:a17:903:2445:b0:1ad:c627:87de with SMTP id l5-20020a170903244500b001adc62787demr27051694pls.32.1684281630718;
        Tue, 16 May 2023 17:00:30 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709027e8600b001ae469ca0c0sm1126725pla.245.2023.05.16.17.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:00:30 -0700 (PDT)
Message-ID: <3cba6052-69ed-4ec4-dcbb-c0347a9ebd48@acm.org>
Date:   Tue, 16 May 2023 17:00:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 03/11] block: Introduce op_is_zoned_write()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-4-bvanassche@acm.org>
 <84348f20-6849-549c-5113-2faf1a6b40ad@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <84348f20-6849-549c-5113-2faf1a6b40ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 16:30, Damien Le Moal wrote:
> Or if you really want to rewrite this, may be something like:
> 
> static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
>    					  enum req_op op)
> {
> 	return bdev_is_zoned(bdev) &&
> 	       (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES);
> }
> 
> which is very easy to understand.

The op_is_zoned_write() function was introduced to use it in patch 4/11 
of this series. Anyway, I will look into open-coding it.

Bart.
