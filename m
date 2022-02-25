Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D380C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Feb 2022 20:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiBYUbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 15:31:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297B1F0834
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 12:31:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso9409800pju.4
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 12:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=oUbHaF+p8HNQnZsEJ1OMU9/sPgUhUESZCkaD/tCgJ7I=;
        b=BWO/JBc6J1OodcvYkY2U28XEFeFn13bdXmWFfKe9smc47W5NkRoio71qauOLD1qWXe
         GRJKEbi5QG7+HFLWHXnKA4waTpjBxJLv3o5CZLVMFGfV32rk3KVKc7hm6ysU0uKwX5CI
         9V6FwS2MKYl4p5iJb0COFse82lQRwJ4szOs2AiMcPqBjFKCmO8ILu7yLtVpPMfDKP/YF
         MoMYMTQozD4uVqRhYkkt2BM40V6A2R5aileT5vFy2bsh1hybMqlOPSLR8JFb6zqO43WG
         UlH5kgJdDj5o7X/QsDWzIWsW4kOL/KKqwzh3avvJDznDGKrtPttx7bNSSN2GtOqgKGoD
         Lt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=oUbHaF+p8HNQnZsEJ1OMU9/sPgUhUESZCkaD/tCgJ7I=;
        b=uflRzVzY+FTfa1wwMg2kQ8kZH24Jw6XSWyD1dTtDzuMcxg8qjH+I5mSjbfpBMCp5sx
         kwH7geqHkPKxsq5sm4jVRcaJ1pUIQWRUUBDtTPlCBAsqhpp8BAkHcSx1fuyLvQvs3xaz
         WCAmiNUGigj2UPYkouVlgEB84vr6iKs2G77vKqXkyTbaujyAGFZ1v/6KHAAbQv5o+AIg
         S/Vgf++ZgdgF4SAlz/GFUOgqx/6rbNMiFMBI/jXjwp4G82J1FkI+gy3uD+Dk/H4MX2aH
         zHhMwAg8tKsVPSXUnhiGypC2X77LqOwrgSd4H0MwWvkBDpkC5nweSFr6aclpEZiYTkzI
         sAEw==
X-Gm-Message-State: AOAM532aAqSe1v3qbYRL27AWoF/AP2bEx/EFqJRAdA4dzvJFMyJ9GpJs
        /LQGm5CeZCW0PFcmZ8zlSbBlAFnjduMVwg==
X-Google-Smtp-Source: ABdhPJz+4VjHNuvuHt5nuWlgSPPdZDzjhq9+6/vOOQ6rYx/5YAgEFrGBhtNCmvTaRqny+ono+M8duw==
X-Received: by 2002:a17:902:a38f:b0:14f:c36f:afd with SMTP id x15-20020a170902a38f00b0014fc36f0afdmr9022073pla.63.1645821075720;
        Fri, 25 Feb 2022 12:31:15 -0800 (PST)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm3566037pjb.5.2022.02.25.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:31:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20220225181440.1351591-1-hch@lst.de>
References: <20220225181440.1351591-1-hch@lst.de>
Subject: Re: [PATCH] block: default BLOCK_LEGACY_AUTOLOAD to y
Message-Id: <164582107494.4274.5815747547755695601.b4-ty@kernel.dk>
Date:   Fri, 25 Feb 2022 13:31:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 25 Feb 2022 19:14:40 +0100, Christoph Hellwig wrote:
> As Luis reported, losetup currently doesn't properly create the loop
> device without this if the device node already exists because old
> scripts created it manually.  So default to y for now and remove the
> aggressive removal schedule.
> 
> 

Applied, thanks!

[1/1] block: default BLOCK_LEGACY_AUTOLOAD to y
      commit: 23c8d32e573c97177eb51c1384b774cfa7fa3710

Best regards,
-- 
Jens Axboe


