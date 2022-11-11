Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E7C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 15:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiKKPiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiKKPiz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 10:38:55 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C914097
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 07:38:53 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z3so3810957iof.3
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlHsWdECQ3tv3fcWIrqXb+HedmBJAx9FZPX5VGtHlJU=;
        b=06E4IE2EK4Xe7YJnb5xdW2QGv3nMsk7WXIBYseXjSBDuxkcOemdsx43M4AEUVfN+pp
         S28Kq2MsoSMYF0+fp1Jghtivtd27tJ2cDQuPjWOfmrVwmTyy3GUmRdRnyDxjAZ2BdRq/
         M26oAlxdPYxyAR2KQzFr6Ue0iAQpE9O6iKk/RL5E9QD023lfp5og0H9lT78dBrqFP5u3
         N3aafdTe0RAreWUsJ10QjCR74pd2JBXNkbrvUkiu7YWfVXVSEcXa7nAFmxuYrtMhgXXO
         qlUPqu+Jwz+s4kqadzjThpqgUXaB9acKCHCMgMDcXPu88NFe0IcuDY3KdPwhoPf1XFU/
         FQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlHsWdECQ3tv3fcWIrqXb+HedmBJAx9FZPX5VGtHlJU=;
        b=C44h4jINeQebcoQ7XfCAZHa5pjxB7fNbE5Cw7qiZuClTGXP8Aia3tC3EzmM8eVsGA9
         OPWNdC9D4KsdDqbb0pviJOCzL0BQv/55AQZQ3VVLcXaNyuP3MAsJOmH0Go/nxiMxyyPM
         J1ZgwscLS1cEd2Zp/hbP94sY0WzSS4mIuqhMXSzfY2HFVD6MjS60be9sQOcModJLWlWe
         +PCfrH/I2lUpNXw4SyhFwmncI1EqsnQyOVkCppyymq7N/d/d0hFdXs3mFU+u2hLbsAlk
         jgwjLaEao9xfGL05Eqf9x+IWvKLM17nMgrcJHq1LWg491yUmpCFcu/za/+2yMEBa6++e
         l8sw==
X-Gm-Message-State: ANoB5pnDUIjzMMqjdie6EtY+Z2GvCPE8XNWntM5TO8m2PMbefsGHo0WR
        F2E0/XudXljwSYOUPk0X3dCr4A==
X-Google-Smtp-Source: AA0mqf62/n8/c0Lbyw7i6gXxgtwSe5PEh/+r46m4qbOmL7CL/xHAVdWJn3E930xksqUa6ca85sInxA==
X-Received: by 2002:a05:6602:4188:b0:6d2:da5f:304c with SMTP id bx8-20020a056602418800b006d2da5f304cmr1258091iob.17.1668181132383;
        Fri, 11 Nov 2022 07:38:52 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id co17-20020a0566383e1100b00349deda465asm893160jab.39.2022.11.11.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:38:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Hugh Dickins <hughd@google.com>, Keith Busch <kbusch@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20221105231055.25953-1-krisman@suse.de>
References: <20221105231055.25953-1-krisman@suse.de>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued tags
Message-Id: <166818113152.9209.17718783188573289588.b4-ty@kernel.dk>
Date:   Fri, 11 Nov 2022 08:38:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 5 Nov 2022 19:10:55 -0400, Gabriel Krisman Bertazi wrote:
> sbitmap suffers from code complexity, as demonstrated by recent fixes,
> and eventual lost wake ups on nested I/O completion.  The later happens,
> from what I understand, due to the non-atomic nature of the updates to
> wait_cnt, which needs to be subtracted and eventually reset when equal
> to zero.  This two step process can eventually miss an update when a
> nested completion happens to interrupt the CPU in between the wait_cnt
> updates.  This is very hard to fix, as shown by the recent changes to
> this code.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: Use single per-bitmap counting to wake up queued tags
      commit: 4f8126bb2308066b877859e4b5923ffb54143630

Best regards,
-- 
Jens Axboe


