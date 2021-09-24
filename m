Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29860C433FE
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C06961250
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbhIXRGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbhIXRGa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 13:06:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D895C061571
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 10:04:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v16so11159946ilg.3
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QMsoMTe88s3i55EW11Dq47WQEVppwO10AQq1jVa2vSI=;
        b=qLI22M72wxG/nUFCTNN4fQJSZJAEYzPpE/SAiR4ZAAVXZXV82NndapK+kEFMBzmD/N
         QAi78uImJjG1s07psAC1ZHnHLD8vbv1IQ+ou+091OQIzZ61E7uUPllwXWgKFwY0RQnGB
         W8sSkU85peAKCdWvVN9x6SxHlYaTY0VMKyb+OQwi5Y854thXoMOnMXIs1MDbkIVZVC2h
         hJhXB4jImd4j/Ft6zK2vyH6yAbInRb6tct3yrWXDzNL6NSbZovqoEPhjSXQZCOsRAkEX
         poCXuq9Iraq9izTBz4aTj7jCLpIqbd6fX/+c/g0APl4UzFNbwCor05NVpfdA0yKvhrk1
         9BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QMsoMTe88s3i55EW11Dq47WQEVppwO10AQq1jVa2vSI=;
        b=TS9vdDHpZnCNJhTlcQFkOWnKLf9ODoXYh8dnUG+FUcMlSpGdiL9OPpp+NXWcxa1zFZ
         khR5VZxTfbfQ78IN3ufFZW2RENgJ8yn2IgvdLu1AgeW4W0BmbP7sOuPg1Roi/CKxPFNq
         phsEBK8sb16QJgpE4R9arnxXBWTqaF90tZBHztxH0vC8A5fZinmsKquoHJuW9lNXTqzQ
         nt1QRQiy2GWbP08q6J45yvjxwtE89CJ4nkdKkCtqfVnB+uJpJnTKnfFrGZus2CkNLNFS
         kbo2a/r7xY+bNYokqQWFHttTu4gbx1rM2X5/LxgIAcd7Pi7FcoHs3wJvKQy/HpYUtXCY
         4FbA==
X-Gm-Message-State: AOAM533+v0OpotGDbZCCN7zlgQtDxBLUmbBmzBdbRa2efsEb/2Jf5H48
        TAwvdnEPYvYITBkVrApISAG1Lw==
X-Google-Smtp-Source: ABdhPJwUgVh7miUoGAQULFEtRjAlZzeQrWmjTzz4JVLy50mJV0YDopAykM/ncXZ4BxlM/87+56LnGQ==
X-Received: by 2002:a05:6e02:cc5:: with SMTP id c5mr9298469ilj.110.1632503095792;
        Fri, 24 Sep 2021 10:04:55 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h23sm4405977ila.32.2021.09.24.10.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:04:55 -0700 (PDT)
Subject: Re: [PATCH] block: don't call rq_qos_ops->done_bio if the bio isn't
 tracked
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        tj@kernel.org
References: <20210924110704.1541818-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c4fb487-0230-6fa4-085d-9da745ec536b@kernel.dk>
Date:   Fri, 24 Sep 2021 11:04:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210924110704.1541818-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/21 5:07 AM, Ming Lei wrote:
> rq_qos framework is only applied on request based driver, so:
> 
> 1) rq_qos_done_bio() needn't to be called for bio based driver
> 
> 2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
> such as bios ended from error handling code.
> 
> Especially in bio_endio():
> 
> 1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
> may be gone since request queue refcount may not be held in above two
> cases
> 
> 2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
> __rq_qos_done_bio()
> 
> Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
> the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
> and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.

Applied, thanks.

-- 
Jens Axboe

