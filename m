Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E78C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjDKSKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDKSJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:09:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03D165B0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:09:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6323e359826so1114719b3a.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236265; x=1683828265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fElYY36BcGMnr92dnkC2t2TfcEfEyBE1DT7D+OFoS5g=;
        b=OfqGISPnOtTHK7jlAH+yrXn7t0Mz+ps5cpojmTD4AWMVzAlhKctKVXcuNxnjuuYh4S
         /judqCZX3vZcfCz9k0FMnqZ3sYCFHtDhh4tLb5MfGVJ4PqacFHt5OS9XNynl18qyWWJD
         qatTZ08jQfTMWh9cOow4N+udP+Xc4+2kUVfLSDU9oH04UsBF939Cbx3imlVpKZLqGbmt
         yBjZDIiRKg7UpLiIvTGjYFQ/RvQK666PZ+6+Qxy5BMefxKet8f6cZ57/4jv7KwdrvnWh
         AD4iGlYg6U0s3a8wJPe7idQ1wT0JVsmU43cZ3zT0gPuB9RS7BsKiKuUZEfjOrE4tHtcM
         Yv5Q==
X-Gm-Message-State: AAQBX9eMNuakjAD3DplS648JCrj7sVQ3GIQRUoj83JG0vP+rLd5mZSyU
        LLL7fVUFGdzPUHPG2vBoxqo7pnsWZBQ=
X-Google-Smtp-Source: AKy350bv2TgF1X9pBk5HV9o+qBDhjQpR6QDNNNptQtI/YTaFh3vWek/mPR6hpV5mWYsayBB31D/GGg==
X-Received: by 2002:a62:6405:0:b0:636:dea4:234a with SMTP id y5-20020a626405000000b00636dea4234amr3583038pfb.22.1681236264525;
        Tue, 11 Apr 2023 11:04:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id w11-20020a63d74b000000b00513cc8c9597sm8922962pgi.10.2023.04.11.11.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:04:24 -0700 (PDT)
Message-ID: <cd010467-8ea6-3949-bd2e-e22252854668@acm.org>
Date:   Tue, 11 Apr 2023 11:04:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 11/16] blk-mq: fold __blk_mq_try_issue_directly into its
 two callers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-12-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Due the wildly different behavior beased on the bypass_insert

beased -> based

> argument not a whole lot of code in __blk_mq_try_issue_directly is
> actually shared between blk_mq_try_issue_directly and
> blk_mq_request_issue_directly.  Remove __blk_mq_try_issue_directly and
> fold the code into the two callers instead.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
