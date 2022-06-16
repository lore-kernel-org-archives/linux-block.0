Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC678C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiFPUup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiFPUuo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 16:50:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE765FF3F
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:50:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d6so1729569ilm.4
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1VAhdyCVaRWB+KcQ9ffe2u2oFbE22lTiJN7vci5cUO0=;
        b=U0GQYig+p+vqJS/RTlads+vDY0Bo31qNz1i0+olxfFS5X2VQCUHzgcgqahQ3+nrH5r
         Ydp1lFkB2x6f6257vfPdJcasBvJi/MhNew5MN5LcTEPkg1rnfONxzoL1K05DcK2ldkW/
         bmCqGv8IabhuP1bNcOXdXNNyBIbT3lAGXnIY+BYJ9O1mRhJ+62cv3AIzddqEa62z3IDc
         M2oFNIgdySZzzcfF92iGA2oDgjGVyQs5uKfX/TQBDuTomp4njcwrCONUYBt+933rlfKL
         9PSmUQ1+lXDjTEmXIOwhM90xzABNk5MlxcRc/LIMFfL/aEvkMv2RsWfT7BIDHTDcjN6t
         SqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1VAhdyCVaRWB+KcQ9ffe2u2oFbE22lTiJN7vci5cUO0=;
        b=odjNn1n4oSLjmV/K6L9zZgTXAS4dC8ReiVQxdj6UwOpQ7mQh/lXIrgXLvldWttfEz2
         X0haQ4XgACoCU6fEZdsCrR62o/xVTQiIfrbB3fuhfuFsgP0t+YuMDr02raP4lvZrPJMk
         TpQPmDIpyj962azwtAtPV1pdnBlCFr3pnu00zI4c3GkUKdKv6QVXM9de4Z1mriVGjfu2
         h/QMbNmidGdkcbRj+u22BasDebV1e2ZtEXGINNlSE6ZGlqHWQNaC+CMSs5IfoUXaJ06m
         BBSoD22E/xTllQbAws8oSq5trOlX/ExdRU8AL90LQZRhXx3zJhZ8AF96JDc6cXDgfFJY
         +2rw==
X-Gm-Message-State: AJIora8VfaGvarKLD0mS+54v81hVb53GGB1kxXNOLODWJkXxRqRdSBYC
        Z28aGyb/fmofJpLb8T/ISjixvA==
X-Google-Smtp-Source: AGRyM1tSlAN/gxJk1SBu99mkNDCw6lkkkYiepqrBvbAp1fkfDCcyqBAcikXoFMlQXzFlJaV2cg4BjQ==
X-Received: by 2002:a05:6e02:1c45:b0:2d3:bb0c:9559 with SMTP id d5-20020a056e021c4500b002d3bb0c9559mr3932700ilg.251.1655412601564;
        Thu, 16 Jun 2022 13:50:01 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a4-20020a6bca04000000b0066961821575sm1604003iog.34.2022.06.16.13.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 13:50:01 -0700 (PDT)
Message-ID: <6704edef-8c60-9fb8-ea45-1a350fdd9bf6@kernel.dk>
Date:   Thu, 16 Jun 2022 14:50:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block/bfq: Enable I/O statistics
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Cixi Geng <cixi.geng1@unisoc.com>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@unimore.it>
References: <20220613163234.3593026-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220613163234.3593026-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/22 10:32 AM, Bart Van Assche wrote:
> BFQ uses io_start_time_ns. That member variable is only set if I/O
> statistics are enabled. Hence this patch that enables I/O statistics
> at the time BFQ is associated with a request queue.
> 
> Compile-tested only.

Have you runtime tested it now?

-- 
Jens Axboe

