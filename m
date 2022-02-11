Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D9C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 17:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351878AbiBKRC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 12:02:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiBKRCy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 12:02:54 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD8102
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 09:02:53 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d188so12153526iof.7
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 09:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ekzdkokdLQymcTi9BqbUpoFHaXrlpGPqx3QS7/g6HiA=;
        b=boZj3fRHPw7vLr1+SeUSEw/N+I7zVXm1YxrELc0on1ONG5jvJKVsQCKk/S2LUXhGo+
         C/Jd3CkVcEGWm1VRKuiYaSmd6qi3zx5sSp6sTODMrKTyAzPZpE5oT8l9AOfwKtvapC74
         Di8Ee+BTCNM+jwHDKqxC5lTFIFyOeOqvBRlYyErAP/lHQI0LE/QwBLs+ZzlI54a1Xom8
         zxqrZSjgvO39KfJiyzGlseruNKmjSULGpYZFj7KmwwZWK+5wKV1IiA5MXUS4eHaMUlCO
         51aXzVcuYgsWlwqOTQHnDGMm5kbKjyj7dmcP9Txm5ohTVJN6CAarObmZrpw0L66LAs4M
         Im0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ekzdkokdLQymcTi9BqbUpoFHaXrlpGPqx3QS7/g6HiA=;
        b=nonbsKccMEREMa6vJgvrG6iv1BXbyki1PPeK8R8fni1cHE2ZBObEizw94wgt/c6Q5h
         +0aC0TFLoQlgci1NXmjz2boyISUZjOSIk4rtJkcD0t4P9+1kDwFqfhad4ozcboAqNd/T
         2LDbotodoFjd0IX1pGBEeXZVo7B7YmqCbzXmhl/I54sp4OrHdvDTkNdgbN6e2iN0q9i2
         7XJgzkyMPNZ7aIvCO8UBWVUhd0YlFzfa8MRKNWgYGzv+OE1i8Zr/E9HkXgq+NSTftDZg
         XcpZe2MrLDk0+KPTdstjmwmZMPQog/8ZAolrtdBYqQ69SlL5gzq/ZjRo7shjT33dZHSa
         8DEw==
X-Gm-Message-State: AOAM5336lje+gideU0vly3Cp22xM1o9ILITbjMe2GiIFHp1msJrI+q5K
        bIIeLO/T13kIToUIi2yhcTsfxA==
X-Google-Smtp-Source: ABdhPJw2soilQ74w2uqAn/C4r9mnikx/bzy+CB13FlWXgPghV5/PAGGqlVN2yPlE7A1DTWk/2IU3OA==
X-Received: by 2002:a02:b1d1:: with SMTP id u17mr1322356jah.238.1644598972801;
        Fri, 11 Feb 2022 09:02:52 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f13sm13792996ion.18.2022.02.11.09.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:02:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220211101149.2368042-1-ming.lei@redhat.com>
References: <20220211101149.2368042-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] block: cleanup cgroup
Message-Id: <164459897210.122978.7665922634590222597.b4-ty@kernel.dk>
Date:   Fri, 11 Feb 2022 10:02:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 11 Feb 2022 18:11:46 +0800, Ming Lei wrote:
> The 1st two patches cleans up blk-cgroup code a bit.
> 
> The 3rd patch moves block layer internal definition into one private
> header of block/blk-cgroup.h, as suggested by Christoph, and the idea
> is that just small amount of structures & functions need to be exported,
> and most of them are block layer internal structures and functions.
> 
> [...]

Applied, thanks!

[1/3] block: remove THROTL_IOPS_MAX
      commit: 0e51e2ab49a99bc5077760aa083dfa1c3bf9899b
[2/3] block: move initialization of q->blkg_list into blkcg_init_queue
      commit: 472e4314c039d6cf36e28783b1c63f87b5b394c2
[3/3] block: partition include/linux/blk-cgroup.h
      commit: 672fdcf0e7de3b1e39416ac85abf178f023271f1

Best regards,
-- 
Jens Axboe


