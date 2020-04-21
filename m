Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70609C54FCC
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A97206E9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 15:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgDUP00 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:26:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38433 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDUP00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 11:26:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id p8so6898645pgi.5;
        Tue, 21 Apr 2020 08:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZoAlc7VTUrpcd1kNRj5A6zpWc6WzY7omp1v+WZzPafQ=;
        b=hSiYE7XczJOQgiXTJ2saiTfIArhvg9pVRSWSojfu4bgpo4MRpHRU+k0tF4MBUescPV
         q4v1Oe5p6poH8Lb1ROcjjZKnVtfr3/K5TwG3I+RAwqGH6MIObioUsDCFUHQBriRklk+Q
         AdhOhW0L0JniBvo/za7a3QMz1ky5m+5nrahMqChaUdHwv5zLmOmkZ7P6BfXavF8D1fR6
         5MeotPsLaNGWfKu7g9O83QAuUufoyLPD5lkBr+bAplEWryPth4WSe0alt835D/dOzY3T
         6YZ9wmTJBp93Ha3Q11bTUQC6bdH+0TKAbJczfWvLSNeCKJZT/lmIgGXQcgzp/Vlx4tT7
         9e4A==
X-Gm-Message-State: AGi0Pubza+LXXWF1pKeF3SDxVeM4I8q7jBLxf4iMuUgQc2R/JV0V5nuR
        IpIzh7ocsdQATivqVAfhLxk=
X-Google-Smtp-Source: APiQypL5ML0n0kEj+B/B+d1l8zNw3oKHsp8jcJEG7P50+2EB0m6PFrXSZF/3mUr25jP9R7X1nVFgOA==
X-Received: by 2002:a63:610a:: with SMTP id v10mr1533278pgb.49.1587482785367;
        Tue, 21 Apr 2020 08:26:25 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.3])
        by smtp.gmail.com with ESMTPSA id y10sm2719929pfb.53.2020.04.21.08.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 08:26:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] loop: Refactor size calculation.
To:     Martijn Coenen <maco@android.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200420080409.111693-1-maco@android.com>
 <20200420080409.111693-2-maco@android.com>
 <b546eff4-616a-8488-fc11-9b7e23d44bcf@acm.org>
 <CAB0TPYHXCRq-SVGsNBviyCAyP75oKam77W9vdsyri9fzA2tp+g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <398b9d9e-bb7c-6b95-4766-3e9bf2769a61@acm.org>
Date:   Tue, 21 Apr 2020 08:26:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAB0TPYHXCRq-SVGsNBviyCAyP75oKam77W9vdsyri9fzA2tp+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/20 4:48 AM, Martijn Coenen wrote:
> On Mon, Apr 20, 2020 at 3:22 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> Please also change the "kill_bdev should have truncated all the pages"
>> comment into something like "return -EAGAIN if any pages have been
>> dirtied after kill_bdev() returned".
> 
> Sure - would you prefer this to be in a separate change?

Since the comment "kill_bdev should have truncated all the pages" has to 
be moved, I think that it's fine to integrate the fix for that comment 
in this patch.

Thanks,

Bart.
