Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14756C77B7D
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEMWLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 18:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEMWLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 18:11:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CBE69
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 15:11:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f39600f9b8so32953631cf.3
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684015900; x=1686607900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OmxjGDfjF/mdsU98I37esgs4VenxbTsH7hU7po07tU=;
        b=BSSPtXG8kQJ1Jm5sPNLCViqbC0PXyQDgHmnTd8t+j8yd6sQnWMi4v5t2cDDdMUE9jJ
         Jt4Lw60yeoCByOoQfgpsGGZB+Pq0kg87OdBvDDGYmMLjimLSQuDu120a3nRXa3PTRbhi
         zLseThj4id+9V6IZJjB39XpnD21Ce5nR4RjA+//Fg+DdpRlzs+bODDgjub/vNIYjFaEU
         Av2KKgDAXibJUPdExjyn0b2FWKr8TKQnQ/90g4KOJskYBoZZnBJcrbpyME8/pQDEtwI4
         QCqyToJqJ8E9IgGdtDWaBont8THuOzqcwDM2v2QTybXR76Nvk+9zN7Z6/ENBBpiMRZ/6
         nuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684015900; x=1686607900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OmxjGDfjF/mdsU98I37esgs4VenxbTsH7hU7po07tU=;
        b=C0zzypvzCt/FyiG4uE6JscHKVCPt0K+yxDsJnqPgreD1N61VA469ZMtJyFwXdWwiNv
         OnHyelBGR6CC/QS4weZBiY4vAr3exvcJINqpoRSuxRIUxl3BttM4yiPGx7413cit8GzX
         mZtLJfo+AjWp2wiS/M8l6W3G5WG+N1OpXWMEDzRNWR4MJFc65j0x6+EQPXljKUbGaDff
         LAhFGoPYM59uoO8SfC+HVb6jnmaI9HZFdbofr7QSnMXmOvwCdRDTUH93FQhInHIQZfpU
         ptwy+fvSRKOkqLjATaEsJ8HamD59chPj8UZd5bpIJRZ2aWzB3qtj0T2WH5lN3evZsUeX
         OWJQ==
X-Gm-Message-State: AC+VfDx94jNN9yIS/aYShuJDhwSlk/SvBmFshieqDh/iWPtAkGj3wnM/
        E1rrkcmRkR/hW163q3KCM43iCktzfCdzMg==
X-Google-Smtp-Source: ACHHUZ7Jo+jb2jm6BP/QiHgDNobYYQbUGXXY5tzSmLY8qoeVPsb37mTbAH7eHQSEwZzw0nNy2M6DZA==
X-Received: by 2002:a05:622a:188d:b0:3f5:aa3:acf9 with SMTP id v13-20020a05622a188d00b003f50aa3acf9mr5239511qtc.56.1684015900411;
        Sat, 13 May 2023 15:11:40 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85f92000000b003f51b00ad87sm268174qta.35.2023.05.13.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 15:11:40 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk
Cc:     horms@kernel.org, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, tilan7663@gmail.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sat, 13 May 2023 18:11:38 -0400
Message-Id: <20230513221138.497270-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
References: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Simon and Jens, I will remove the unused reference. 

And I'm sorry again, I'm very fresh in kernel development and still 
trying to learn the whole process. Hopefully this is the last time I will 
have to make the change (previously, I was compiling the entire kernel and
missed the warning message). Thank you all for being patient with me and 
tolerate all the silly mistakes.

Tian

