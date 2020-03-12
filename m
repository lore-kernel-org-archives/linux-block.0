Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D1C1975A
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F44D206E7
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FcsGjv1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCLNn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:43:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33041 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgCLNn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:43:28 -0400
Received: by mail-il1-f196.google.com with SMTP id k29so5520913ilg.0
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NPTa2DflPeoozczKhuwuYiSso61K4dwMqagMX+owpOk=;
        b=FcsGjv1N8FbgLKFIzemkUq6qvx6M4AUtbc52XKP4njti7Mhk2ihmO93yXTIAhtHbA4
         6p/Qzmq373EQViBOfbdEr1kuH9lHH5z9acBfB33ltkv20iCtjU/AfrFj3E28tPfEUFv0
         j5geE0+zpf1pbFeNGD7Jn0Dq5Zz+aN2rC60b2Q8p7/v5zY8u1GyvReSkiuG2Ny6+FhG0
         0gtWvv9lbqt9VY1mByEtVzqVtgb5CMay6ay/71/hPep4N1wmg3kcyxrC2UJGFROsIlM8
         CQwXeyLjwlzz47rJrk0kKfnnME7BgNQ/+yt9HWiuFcXnG5yWxLRR3ZRK01K6Z2TPgfsf
         W+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NPTa2DflPeoozczKhuwuYiSso61K4dwMqagMX+owpOk=;
        b=BmxuSGz3SPYuErLdzf982MLXIfQcGlx2gGLJz+eq2+S7EJuP8sSeR1nlaCd8oV4pE6
         i94CDgS3HRnRLcU6FRIvFk6XpbjWZZ3WRG2PrJ7sc7GFxkxQ8G+GIavd5dDdAxIebCXA
         8Lyp+dYVWu3DbE+s6oKMT0BsOJ8DmWawkjj21eygY+vCJzBp2BGppMls/GSMYnD3IMvz
         8sqd0NDuCI0Sit+s88MBbs4jJpEMdYKfDjFuCbzFUksG86Y6QsjN7Bo4aUjWdzdzsyCg
         juubQgcFo3J1JSThOAyh1ESuuiBWvAaEqvfwdrT1PLA1u2neCgA7PdI2o69EPkDw3Bjw
         KZrg==
X-Gm-Message-State: ANhLgQ0zohxpojN6tVeCyKebGxCNGjlgfKbc6jGJJZQS7X5rDv+G3K42
        ux+nKJMUwU5+ViUoFG3SCyNOhC4aRRSO2g==
X-Google-Smtp-Source: ADFU+vsQ2AjzK/w62Bef1ByMc472YwZpWRSNP5xoWoZT2TxEmXPd9MbfIwCImEh+plBbFI2+Ov0cGA==
X-Received: by 2002:a92:1b59:: with SMTP id b86mr7981254ilb.291.1584020608005;
        Thu, 12 Mar 2020 06:43:28 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m18sm19516468ila.54.2020.03.12.06.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:43:27 -0700 (PDT)
Subject: Re: [PATCH V2 0/6] Some cleanups for blk-core.c and blk-flush.c
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ebef2ce-7a28-c256-f0b0-720cbd3a2636@kernel.dk>
Date:   Thu, 12 Mar 2020 07:43:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/20 3:41 PM, Guoqing Jiang wrote:
> V2:
> 
> * collected Reviewed-by tags for some patches.
> * remove __blk_rq_prep_clone and move the impletation to the only caller.
> 
> V1:
> 
> Hi,
> 
> This patchset updates code and comment in blk-core.c and blk-flush.c.
> The first patch had been sent before, now update it with the Reviewed-by
> tag from Bart.

Applied for 5.7, thanks.

-- 
Jens Axboe

