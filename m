Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE2C433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74752076A
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MyNehvmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGPPhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgGPPhL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 11:37:11 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A698C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 08:37:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id i4so6431436iov.11
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Me3NwTY3eUmf3k9GPfqBPZ0YwkIleLvEt4nUFWagbgE=;
        b=MyNehvmjknv0F14qDeMVcmtZfTJ79jls1E53demXp1AdpYY521GaPOt/nFDBU0nQRX
         JsJq3RG496YRjT1mvI37gL1gD2Xj8gd2QYKn77ZsGPFMBc79AdEROyDOdPBjZ6X0fMlQ
         /CqZ7Rnpfc16gbxI5VFx7XVKE7r0BK2i+lwJ2RejewRNulZkG0U8N/yIILcZOaBlzHCF
         l2DwKfgQkf6lA1Jinv0vkbllsBNOerbfaPsf1kR4iU1OYTnM7GFxoRAP8GxIuxTaY28D
         htkvUOSiZILadu9Z27KHmJA/Qfv698qpYiwSvaupjhbqZIHu+Nl7NMtCaIawA39A7Cvk
         pi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Me3NwTY3eUmf3k9GPfqBPZ0YwkIleLvEt4nUFWagbgE=;
        b=r9/Lwl3HuCc18hpW7CRs0oSCAb6/z9rYlNnNRYOWpQuRk/s4zMtfcs3lDrwi1xEalw
         hHWNjNdT/efkNGtUUEEzu3iRb57GN/qTxGgBJFg0e9Ss6AOJBXQLMmNNcY+qcGdfkTm8
         oJnFgxhMu3zKr/5oUnGwPxEDGapxHoR/StJ2I50AK5mdZddT+irJcvosB263yMco1sJt
         XAqEw4dAMzNXiHx9OKh2wJc2X7h5lULesZOLUeO0oeKfAdEUkcYpznxuB5Gs4k50B1pF
         CUWQJL3fAsLhLlD8Mm8Gp175FNFeerG30ZygpqNr1c5vUxCcWnTlqtMJPL2GTYgmPXSl
         Mtpg==
X-Gm-Message-State: AOAM530QN70ReaSgsGrWJT2miMyt5M8aL+PZLkG0HrHulTCLgWi/bFOf
        I6fpGpwMhZOy53pG/5jppZVu4hdk/CmiiQ==
X-Google-Smtp-Source: ABdhPJxJjVwK9xd2XBao+BhAOVbsEuiiZnkx0qKx2/TUlMANVLSJyoKMgjbFADKUJgZP1DvtpDpVbw==
X-Received: by 2002:a02:cb59:: with SMTP id k25mr5803925jap.112.1594913830379;
        Thu, 16 Jul 2020 08:37:10 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t83sm2905984ilb.47.2020.07.16.08.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 08:37:09 -0700 (PDT)
Subject: Re: simplify block device claiming (resend)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20200716143310.473136-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e78b964-a014-0c8d-a123-5fdcc74abb9b@kernel.dk>
Date:   Thu, 16 Jul 2020 09:37:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716143310.473136-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 8:33 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series simplifies how we claim block devices for exclusive opens.

Applied, thanks.

-- 
Jens Axboe

