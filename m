Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC35C678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 23:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCGXlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCGXlK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 18:41:10 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7085B01
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 15:41:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so15997506pla.2
        for <linux-block@vger.kernel.org>; Tue, 07 Mar 2023 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678232467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJDOs+yx2SWmXYevTPopcDHiVZDlJiA2mU9elmu7DUI=;
        b=tKsnLSRkm79SgBNLvMAgCWMnAN9SX2VvEwxWV2gTNxsSLaNlXrabAG5/Px4kjW05DU
         oVTTHyEcCdiepG1hYL12mErp+ZuMw7F94wQYMkDdxnm/JV/g6XAk58V/m9gWto+wyC7U
         LVLePL91ojnCfQ+PpUSBAtJwYe+9eut10vZgD14NxeD8o0mNtASch8/HR1C8VVz8uTXg
         1qlxfdPMVg8Maql4/ZWENWiO+V7IslYjfbIaQbSCUGn5Mgg3Fm/ntN4vZOrbWKN4LmP2
         131wSX3DViVwSDl57hlhnY74hsmZOnmqVf9moLyiMqD5qQfguihe9OVils/Z7Y75GUs4
         GQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJDOs+yx2SWmXYevTPopcDHiVZDlJiA2mU9elmu7DUI=;
        b=UTvOCPC3V/2scxv7KjqCdBTp1iNiphMeYHFbwfy3bJ2t6Kqva82dOH2lW0D3Mcx02w
         dQ+sMK8G8wi5PmSy+S+gjurpmJI9r2NBsIXvYk03pbcDyptQifRzStctZPjy3KGn7Foo
         8I9X47xk/FP4VQ9AzQJwpbHVpvDMwPvoEZUmghyKHXYgvIKQSuQpGfTSf9KWQvazVar8
         /wR4XOimcelVp/N0tgwOkNQQqIKj5gXcGeOlFiBDp+LAJyxiOCUljLYlDSZtxEfaNm+D
         n6jPwUUzgCO4WHqkeiQtJ4ctMntNu8qneL4J/VIv/FqsNhYWrdLbxXwtBBTiSTTOO2H+
         MQyw==
X-Gm-Message-State: AO0yUKW87yck+t40GYJQZYYXlAFxWzU+K+MLbdJGB8nVlAW/SVHqvACF
        5WatYE5xvrmjefGNaM4mrvCiaA==
X-Google-Smtp-Source: AK7set8a+BT4u7/u/zZVMXsr3fpQhiJ4tZvJBBO/XfhnoX6e/fKjPTuP6Z+3LfO3AQl6AW2n9vuOdA==
X-Received: by 2002:a17:903:32ca:b0:19a:723a:8405 with SMTP id i10-20020a17090332ca00b0019a723a8405mr17731246plr.6.1678232466715;
        Tue, 07 Mar 2023 15:41:06 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id fz3-20020a17090b024300b00233567a978csm9680033pjb.42.2023.03.07.15.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:41:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230303084323.228098-1-sagi@grimberg.me>
References: <20230303084323.228098-1-sagi@grimberg.me>
Subject: Re: [PATCH] docs: sysfs-block: document hidden sysfs entry
Message-Id: <167823246591.62837.10657118034782025874.b4-ty@kernel.dk>
Date:   Tue, 07 Mar 2023 16:41:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 03 Mar 2023 10:43:23 +0200, Sagi Grimberg wrote:
> /sys/block/<disk>/hidden is undocumented. Document it.
> 
> 

Applied, thanks!

[1/1] docs: sysfs-block: document hidden sysfs entry
      commit: e33062213ff2f9151e0d125e1c00f524c2b7acfe

Best regards,
-- 
Jens Axboe



