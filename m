Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6514AC636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 14:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjBHOPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjBHOPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 09:15:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3443A84F
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 06:15:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso1554745wmp.3
        for <linux-block@vger.kernel.org>; Wed, 08 Feb 2023 06:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+M/dlWViL2qJC81/WGRRzmOaMfQHy8AA7DgG5nxAmQ=;
        b=TQkqCGSn7Fmen4Jr4+FXp72aBEbtS1VCQhWbBM6KnVooG/X5N5N55tDC8ZxWa3oDGw
         8V4mt+ZX8Mb/GJB35r0omRlEZpNjj+Gj5HWe9qkFmkMPAs++8RR4mozK4/AHc7Kk4s0/
         1P2s9XjZTRBuHfbBpHjXjQd6GM/m/bgjAwIG/ytpZSjzGCYEDVHIswuElyhHaf/9xw48
         uSUQHiiAs/rCyIN9CUeDMxlqvQLS9UM4/y3bECla0AOlYupVgkq6ozmSYMENLZQLe4Ue
         xSXfVtLLSbf0A89EvKbjs5QNaoknMRgh0svzdwLqwwuD0daRZaqxVgZQlgkFI78hTNRj
         Mn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+M/dlWViL2qJC81/WGRRzmOaMfQHy8AA7DgG5nxAmQ=;
        b=rIeS08qbV+/582V/WX6vtcc3iDh0uPTSp82cmIl2FUckm+oU9jXpxISk01ogmeTguw
         +e1Whx9gHlduANtjmxpWGO5gJXbzNdeqeUkAULgW8z/mVEh0eEDcFK/zO9Uce/BnWTrn
         j4QuCc/DkYea5Yi7M03XK+EY6b6NVSM5/Iv+9UMesANEHNqxPA+CdkvI1WIrWweyeS9h
         cLHrFvhH2EpvZQ6CoEoTUC6ZTZYMCdxYWjx8SaCo+xVZlff0vkrA70PYRTE4pQq1uSce
         KnKs0nUC3yKWtSrl5N1xjG/nRtCy8Sg+tqtw1YwK4G7no0B1YUfU0aYCl7F4W16jitUR
         3cmg==
X-Gm-Message-State: AO0yUKXXOl4CXkqMF0SR5Zn3ojBRECLiQqAXnumAkuPOAEqmG3+fPxm6
        2isX6CRkxaDpWVjXl4x2TfimxNjvWRM=
X-Google-Smtp-Source: AK7set+xrJMFS87hIF+7uPZdnqBcLnLSfO+4QUge3gt+o/3FID6NSjAdYyV/NnQTjeSRIKFZdACBqw==
X-Received: by 2002:a05:600c:30d2:b0:3dc:4fd7:31f7 with SMTP id h18-20020a05600c30d200b003dc4fd731f7mr6329709wmn.41.1675865709155;
        Wed, 08 Feb 2023 06:15:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003dc433355aasm2049295wmq.18.2023.02.08.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:15:08 -0800 (PST)
Date:   Wed, 8 Feb 2023 17:15:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     hch@lst.de
Cc:     linux-block@vger.kernel.org
Subject: [bug report] blk-cgroup: simplify blkg freeing from initialization
 failure paths
Message-ID: <Y+OuadIcbqX4n6tG@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Christoph Hellwig,

The patch 27b642b07a4a: "blk-cgroup: simplify blkg freeing from
initialization failure paths" from Feb 3, 2023, leads to the
following Smatch static checker warning:

block/blk-cgroup.c:762 blkg_conf_prep() warn: sleeping in atomic context
block/blk-cgroup.c:769 blkg_conf_prep() warn: sleeping in atomic context
blkg_conf_prep() 
	[ takes a lock and calls blkg_free() in the same function. ]

block/blk-cgroup.c:387 blkg_create() warn: sleeping in atomic context
blkg_lookup_create() <- disables preempt
blkg_conf_prep() <- disables preempt
blkcg_init_disk() <- disables preempt
-> blkg_create()

	[ The first call tree is a false positive but blkg_conf_prep()
          and blkcg_init_disk() have issues. ]

regards,
dan carpenter
