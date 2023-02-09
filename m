Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B88AC636D7
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 15:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjBIPNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjBIPNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 10:13:13 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11735B76F
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 07:13:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n3so1747056pgr.9
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWv7BODOF1fkqLX3kehHlit9Q8z2cpX8fnGa126EwXE=;
        b=lf+RxUcHNmEe9Up4XWHBBu43rvxXI01rSVOIXhxcuQdU1l1GDOTRrTSmXxInaI5JLL
         ZwztvlyfGySYfvxieOgtEnTKlb58myb78mloShHcEUql5OHPITC3y/D37X3XdVAL+wSX
         GrUoNDhX0vEtFRQlKs9SLiPw7TxhiHXFI/64s7THEbbo0PmmkzhqnLCp3ztbmEYo8N+G
         kiYUfuFW5illociHSNjWlyUIP4pMSLaUKIc8d/ZOYxbXgd023sL8FbcUKDJMBrC8uA6H
         ALxc96sUjDfyT8x4+Fbae77WTrhO7iKYGpTMoytc7Sa2HhhtTL/FcDtJQ8vgmhWq28+r
         VSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWv7BODOF1fkqLX3kehHlit9Q8z2cpX8fnGa126EwXE=;
        b=DI/PTTLQv9DP4KFdwER4s9/ZcVM53k/yKsUcNOD94X2wzGrzx3sSBJDlvthiHOyJDE
         rxcyk47VmtvL79ewlvVvIiZgFdiStQjssATX4nIZU5o7VwRJVIi4lsx3RvlHbxAjMITW
         i2zW4q8aQ6VuxI8O4F2hE8LHb8XTtJG33rR8MQQ/6L7qHiY2xRAWH+/dEhImeBcou3s5
         xOxXzR56Kxe43+2b5/pbP7264TV8kO7GLkXHKotBjJ0qH4tz0q+OYHb/6ClnpegNr4ha
         QVESIws9eO+E3LskRF/LKi7Y1Xr0oeyVdbdn3oBPq7xsA0HpxZO+UzneLcpAFKy1r7p+
         RfmQ==
X-Gm-Message-State: AO0yUKUWh4Ydy+AbuF9/NpbVtb6sHwfMcNJSONvL/Try9PQkH1/xrI+w
        gwL8AQBz9ryDahrVXL/NGuctSGfXBI2osRvR
X-Google-Smtp-Source: AK7set943pC1RC1ChgM1XjW9VYePxnCGLNSaebZ2iKUVjvtgx8moqcHAKdL6Esjszj7wRehofTCdAw==
X-Received: by 2002:a62:82c6:0:b0:5a8:4c4e:fc01 with SMTP id w189-20020a6282c6000000b005a84c4efc01mr4249932pfd.2.1675955578796;
        Thu, 09 Feb 2023 07:12:58 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b00593906a8843sm1585716pfe.176.2023.02.09.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:12:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     error27@gmail.com, linux-block@vger.kernel.org
In-Reply-To: <20230209053523.437927-1-hch@lst.de>
References: <20230209053523.437927-1-hch@lst.de>
Subject: Re: [PATCH] Revert "blk-cgroup: simplify blkg freeing from
 initialization failure paths"
Message-Id: <167595557784.325128.7846630476415969413.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 08:12:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 09 Feb 2023 06:35:23 +0100, Christoph Hellwig wrote:
> It turns out this was too soon.  blkg_conf_prep does to funky locking games
> with the queue lock for this to work properly.
> 
> This reverts commit 27b642b07a4a5eb44dffa94a5171ce468bdc46f9.
> 
> 

Applied, thanks!

[1/1] Revert "blk-cgroup: simplify blkg freeing from initialization failure paths"
      commit: dcb52201435197c56154ff7c8cb139284d254bda

Best regards,
-- 
Jens Axboe



