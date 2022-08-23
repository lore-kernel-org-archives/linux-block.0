Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABABC32772
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 17:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbiHWRLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbiHWRKl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 13:10:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123E15B169
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 06:37:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 202so12288420pgc.8
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=n7iR6psZ0iOUa2Hyhot7GU8syOFqaZ9ER5oGtEDczdg=;
        b=gzwKQkZXZT1UZ65SM/9R7Cl/ZDlYyhZQznytLr5Xu3snKGW/n6vebjP7SWs+snSeJZ
         LOqBtED5BU9MJhTK4LHepgdwhSfNq6yrJySt3Og5p50NhnanNKmYZB88beBshEgcCjA4
         ja9+yF6oNDFw8UK1TWra5d0nKp0+x6ic/UgdqwVk0wJTTt0HmmyVOptAm2cKZ3SZ6am8
         6sr6hG2k9GisAKOAu69KMupuHuX5DMNsU4MuMkvJqtkdMNBQ9yr36vZ6b+exebrF364R
         HCdrrR9J8dr6HnWMTWm1diPzzC5mUrQsM1qDkRa8YyZm1SJE+dniIod67iMCnhD32pNc
         /edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=n7iR6psZ0iOUa2Hyhot7GU8syOFqaZ9ER5oGtEDczdg=;
        b=HJsG/FqvnTKdD3gVQizgpTBinYyablMxkIigHna+wFkd8OWJ3rKGuSd01aMQQWi3P/
         e8y10tpDIFtZbtR9dzyunvmkW6T2uWyOBEogHM+3xaPYoWIf26y9nK7QYVNbevNPhYJQ
         djR+0KQCSUljzv5LyfbG0lLCDUdNzOwD3sXz7Hw2KDDKBuUcgNewCqCJHtaySbDyI+5E
         o6XZfOOJVlbhevtbla09iwxaPjqxW4k24UB2z8aISEna8fcuf8kXJ3Kf9/DdF4lDS/j2
         t3Ha+A80mTEZ70Lv96mSmTVGy2t7/ybSLazcXa1egV1t2eafdBvcKC3LRe3PDwC7dvtR
         A44Q==
X-Gm-Message-State: ACgBeo1y+oFECtFfHmo43YPEPdQtnh0fS6tcNdsLc2nTtP0Gu2ai1JVg
        K/+Sgq1I6lftVzgL3l08dpc5Hw==
X-Google-Smtp-Source: AA6agR43WZ/zqeBIRZ1JCqy6cCBGpWEy4XEWjFD62cNl4VC+iQfzRPpGQ8X0bfc8NEw4vlV4qrBnbQ==
X-Received: by 2002:a62:1b12:0:b0:536:715c:4d96 with SMTP id b18-20020a621b12000000b00536715c4d96mr12590248pfb.77.1661261869924;
        Tue, 23 Aug 2022 06:37:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b0016d88dc7745sm10512985plf.259.2022.08.23.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:37:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, osandov@fb.com, yukuai1@huaweicloud.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
In-Reply-To: <20220803121504.212071-1-yukuai1@huaweicloud.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-Id: <166126186831.27028.2544657181662350295.b4-ty@kernel.dk>
Date:   Tue, 23 Aug 2022 07:37:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 3 Aug 2022 20:15:04 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are two problems can lead to lost wakeup:
> 
> 1) invalid wakeup on the wrong waitqueue:
> 
> For example, 2 * wake_batch tags are put, while only wake_batch threads
> are woken:
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix possible io hung due to lost wakeup
      commit: 040b83fcecfb86f3225d3a5de7fd9b3fbccf83b4

Best regards,
-- 
Jens Axboe


