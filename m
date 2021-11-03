Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C5BC433F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DB960FC2
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKCTb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 15:31:28 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43507C061203
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 12:28:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c2-20020a056830348200b0055a46c889a8so4980598otu.5
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=b61kaA94Ee793GgceiiJmFJ4ShV9j6HR9f24wxuKQ8c=;
        b=T98f3VrIfGiesq2Z1XXhRSZk+N5YbD0SjQoDgIl2tEDteNdxswYV4QUq2MbYnmRZ9k
         7YcTBrJmq+u9Ba+a4S5548arcbTY4degLBnjzPd9VYyOyQ3Jlno/j9RGEY86eQeGpEre
         DbT2/CHOoLo3SuanWAMa6q22t3asL8yjCPYYTlnvBNxZGXxDYenueMaaejA07O3899bz
         eUidH78r2BLE0g4rfoe+yJi4NJgAPCjPiJ8a+7I5mhB5hjEm2UVu5Bq1iG38Q1p7TtMP
         1E9Zps9r38ryBNwD/RKD53QA9mft1fL5AvvIWAt6BxgN/XrALQMvL1mbhhMR/jLhJMDx
         l1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=b61kaA94Ee793GgceiiJmFJ4ShV9j6HR9f24wxuKQ8c=;
        b=Gf8FI6lwxsQ4C+rF83b9WW29smcsDs8qMxqeko4W9cTgvAqZ2LkcDiewZ8pHvGjFp7
         yNwcDjcdsv6ONaHaE6/Fy2F0rf+raGZH6PikoNVkaW5t/Q/+LqVE0bi3W+JggU79CFAg
         2Ii2wvkF9xii8jBHuXCFaPC+qOxUPpyKAWVJEiSShhPLOq/RMp7/f2zRvJeNBYSBPn+6
         g0bDt7rVgo6a8e4XWtbOKdGXgoja0hIlLKI3w17Lyyi3H/CjjJVry0B9LgjS/4+/Jetl
         9OInw0Jwsl4u/1jHwMDTnmnq90wa2pKJZAEPOiTpMJXlKMsDPfIhXxXF8rM40Se9e1vU
         273A==
X-Gm-Message-State: AOAM530xGJVE5BDcHuZW6tJjcjunSdz8Jg7rCDz5EPv28J/k11R4b49p
        Kw65IwUFHC/VVpRS435wB3/hzQ==
X-Google-Smtp-Source: ABdhPJxZNmzRvn9TAIPx2ko+UUajJ66iK1LzIcOX29RXqkWWpefaCi9UB3fGBgrRj8OKhlVi+qwvAA==
X-Received: by 2002:a05:6830:1d63:: with SMTP id l3mr2584587oti.9.1635967730638;
        Wed, 03 Nov 2021 12:28:50 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t22sm814853otd.25.2021.11.03.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:28:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>, hare@suse.de,
        hch@infradead.org
Cc:     linux-block@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211103164023.1384821-1-mcgrof@kernel.org>
References: <20211103164023.1384821-1-mcgrof@kernel.org>
Subject: Re: [PATCH] block: fix device_add_disk() kobject_create_and_add() error handling
Message-Id: <163596772995.186346.6961527014377680159.b4-ty@kernel.dk>
Date:   Wed, 03 Nov 2021 13:28:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 3 Nov 2021 09:40:23 -0700, Luis Chamberlain wrote:
> Commit 83cbce957446 ("block: add error handling for device_add_disk /
> add_disk") added error handling to device_add_disk(), however the goto
> label for the kobject_create_and_add() failure did not set the return
> value correctly, and so we can end up in a situation where
> kobject_create_and_add() fails but we report success.
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix device_add_disk() kobject_create_and_add() error handling
      commit: 3554ce121f632db1f56f4e28dfe37da846617c9c

Best regards,
-- 
Jens Axboe


