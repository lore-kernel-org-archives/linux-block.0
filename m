Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94F8C433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A419F61221
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 13:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhKSNaH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 08:30:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE39C061748
        for <linux-block@vger.kernel.org>; Fri, 19 Nov 2021 05:27:05 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c3so12757993iob.6
        for <linux-block@vger.kernel.org>; Fri, 19 Nov 2021 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=tTFVd1nWcx3/XcFWQghei7zJBEBnxYkZz8vTHO1fGeE=;
        b=AUEqQdV3wtCQoHQw3uXtTZQMCIea9TPMKqSH9B1cD/8co4jzDGxflGe06I87v4A9qZ
         jc5tKvG64fJDptVFDLqT/yBxbv9cKwLkJOodF0z3YLG+EqKKJaXV8iU3GqeisaoIL0Mw
         TBanQ1f2qFDNkSwU2cn14jYVXl5OlB64IXXKchqXlVGlLk7sLzh1Jar1N9guEthfUUwT
         yXlX078M0Xbx0RnCnFAkRDhxr4wxRw+wU3RjbSgt58pAwmsRDnxk+ZCQP9yQm0MCS4SN
         Biu6Cr5RGg7EiSSW28CI+jbgqzijwh5imiGNmDkypWlXexx752rNPvboyYI+NIW+FqBM
         rIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=tTFVd1nWcx3/XcFWQghei7zJBEBnxYkZz8vTHO1fGeE=;
        b=PN6PbIgK6CuiKpHS3EmpiruUZ1Kv/xoMf1VXU3l+UghKmLEe2PVv+Wt/qebGa2kIat
         gCwVRQCKtZn+pQJAgzrrsVPUe1KIRiB9yG8kp9i9r8t1f4+izkGeqLtkRWYuZBL98oFt
         cnq+5iROHSTV27qTXXD37z9mnambw4IHe43sGjrDAtgyo7GHihW/CRMXchXn6zDtZd3A
         oJ5FT1SHI9goxEVB/jjNat6PhggEbBJCOuHPoCitQy59n/FG5FL28aa0VStRVoBdEG2W
         cJz7aDzGip9/Mx1r6I6PEZRG1bLt7HzGVmx7YQKAF9WNTZ9rbIGLjY02PPXL/Jqc3Ko8
         ZyJQ==
X-Gm-Message-State: AOAM532u1XNToppnhjNvnhildMnMXq2ZaiodBFW5SDEW9HVNBVYmqCpG
        5l51PhpwiHhqN2dG+L0Q5FzXvlrsy/aVw4nf
X-Google-Smtp-Source: ABdhPJwdxk/QYrODedQdeDW6RHtyFLfIZTB8qh42VRCoIaNIJD7RZfljKbgcdEogIBxcUWxGA8GhDw==
X-Received: by 2002:a05:6602:164a:: with SMTP id y10mr5237113iow.123.1637328424840;
        Fri, 19 Nov 2021 05:27:04 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n12sm2027960ilk.80.2021.11.19.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:27:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com
In-Reply-To: <20211102020705.2321858-1-yukuai3@huawei.com>
References: <20211102020705.2321858-1-yukuai3@huawei.com>
Subject: Re: [PATCH] blk-cgroup: fix missing put device in error path from blkg_conf_pref()
Message-Id: <163732842185.43918.10012034831708951012.b4-ty@kernel.dk>
Date:   Fri, 19 Nov 2021 06:27:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2 Nov 2021 10:07:05 +0800, Yu Kuai wrote:
> If blk_queue_enter() failed due to queue is dying, the
> blkdev_put_no_open() is needed because blkcg_conf_open_bdev() succeeded.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: fix missing put device in error path from blkg_conf_pref()
      commit: 15c30104965101b8e76b24d27035569d6613a7d6

Best regards,
-- 
Jens Axboe


