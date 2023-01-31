Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F6DC636D4
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 18:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAaSDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjAaSDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 13:03:02 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0B8B47F
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 10:02:55 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m13so3998129plx.13
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF5FBVNGpjtgxLS+bV3TsuLS5czo6abFNJe3eVmeQhM=;
        b=PongnsqZrFWa+7otFndotY2MGP9DEsZFJlPJX5CWuujuLb+Mi8aAXK4tZ6Oeg90O5V
         0j5mZad1meeJgu2FCFyt46ddqs/NYA/3jGvrV02oB34cwsCxrvsofLOBZXpK6AnnTUdn
         KD6pMDzDVzR6BbDCBYhSjFosYFLNRmN/s9R8lVZTlGKhGLSCYd+2rvu+69yT3qCRrhQU
         F97t6zzBXoWhW+VbBFkqHIrkk5lFzMd9O/1O5YtTwAUTtbJumbUhJf/wYyFp+5PRkEgJ
         6v0ghDut1HgGcNed1suhlEaTrdg7ZyT82F2Ll4ssPEhB5Bis51EZj9oYv8PGHaYoi8mH
         2JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF5FBVNGpjtgxLS+bV3TsuLS5czo6abFNJe3eVmeQhM=;
        b=qoX2J3+PGsFfeBzeUqek3On6GE8ufCBEK+5Y6ncdZC/w4qMispn/dbMBgj8b70UsvW
         kMIzuX1ilkdDOiWfMFP6EYBDCWS0ro2/dJh6Rdj4kQN6hb/7XnIVOBJd1rFytm2qLEh0
         DSIBH1AkobC5cZBc8c1Z8THh8I/mlnRBln+4AxQcu0VFF3tGDLDOfxMXKr7O90LYvjlZ
         V9HkOyeduXT4WBH+ZYtqgwTbgSQRnU/ILeQ30Dox6hoLRM77H7LsyGykL1WjZxHOF3xR
         EGUs8vmgShS6XX2WohehWfUPoFu82kfndKubgc2U8UIbtxnJueKlCtOPiJ2LM/H0B0bx
         c4BA==
X-Gm-Message-State: AFqh2kpmRQhlR7c6GFbtItyahajO1p7Iw5RSBdDZ2CT/OXATeGcMH0IB
        AfrkKgkC8qGkdnQ/yYl8Ow4RXQ==
X-Google-Smtp-Source: AMrXdXvezqFwgLDeT6M06pfBrzmly8Jw4gE3tWkEi9LAhdjldWOIDY8v0K3SeZi+fLsG8SDpqjSnqw==
X-Received: by 2002:a05:6a20:2d12:b0:b8:b9e7:6d4 with SMTP id g18-20020a056a202d1200b000b8b9e706d4mr16854163pzl.0.1675188175049;
        Tue, 31 Jan 2023 10:02:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z92-20020a17090a6d6500b0022c2e29cadbsm8825260pjj.45.2023.01.31.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:02:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
In-Reply-To: <20230131050132.2627124-1-willy@infradead.org>
References: <20230131050132.2627124-1-willy@infradead.org>
Subject: Re: [PATCH] block: Remove mm.h from bvec.h
Message-Id: <167518817431.121439.15195663136772829300.b4-ty@kernel.dk>
Date:   Tue, 31 Jan 2023 11:02:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 31 Jan 2023 05:01:32 +0000, Matthew Wilcox (Oracle) wrote:
> This was originally added for the definition of nth_page(), but we no
> longer use nth_page() in this header, so we can drop the heavyweight
> mm.h now.
> 
> 

Applied, thanks!

[1/1] block: Remove mm.h from bvec.h
      commit: 2d97930d74b12467fd5f48d8560e48c1cf5edcb1

Best regards,
-- 
Jens Axboe



