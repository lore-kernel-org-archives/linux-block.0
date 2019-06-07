Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E6C2BCA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11FE20665
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaycM+KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfFGMUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:20:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35472 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfFGMUs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 08:20:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1118008pfd.2
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2019 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbzYyUDp1dRjn3H+usjWi3D9EIfYCLIg8vMo1iKLxOE=;
        b=HaycM+KFcDgiJlncwoG6tvmJdKtIUsLxOGp+XGhwERHnEV7r6/5OeA4zuQ+LaicjxX
         74+3x8YRElbdhQvlOl5MnPYSO6VEZep31f3E4F8i/W+mZ07pCGZxgwM0zSwxN2scHNgt
         6Cc/PoHlV3C3oSJo2dgsrhVaVl3UqQsoYsUqe1pg+Rac6Z1ectJWLCXdLkpgiy7MnXPg
         6Y9bwhrMwmKOgrBOO+PDICKiYonIKuT8FL/pGTm06GFpSsuAaxIE7FpnA0viitWM1wTX
         ynijZKKhplrBQFSwlkIh4uVFxdM8NstswmO9GTfD+rTdrwgJXUDfsB6ZT7cHQ0nmQ+6/
         FOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbzYyUDp1dRjn3H+usjWi3D9EIfYCLIg8vMo1iKLxOE=;
        b=hlf9QSQ+Hql+FX/3oUWaeORyNwaX+ItlLhzettxvqcEOmLm6WaZH6gvNI3/awK/WYU
         OjfGL3zSTMe3cAqAYzcoa3176ODvLiQcU7gsrTtY+DM3xCLvxj64sEBGNL2sfvU9kMSj
         fFRIft6vgnhmVizoq326gKut3Ul5PsUUwMRL9K15bDTKUHlf2iOtYS6LlaE/ANf3nBMX
         T9bV+FvsIV/WJXj8d5lIVTqIPxeoyRh/VAe9gY/g82ZZKmvQGg/va/JhbR3CH/wDaUUt
         to4LVew2Kr0Ap4ixWcNdV7b2UU8qPmK4HlDqnAhEs7UR879oc1SmzvrKpYUfVWNxZDE3
         H9Aw==
X-Gm-Message-State: APjAAAVdV9NMPfyu/NZOFiF8bIAjouX7aN8WgzqX/I7fN3h76A5uQrXa
        Pu2GETxQdJyNMiggeEhYx2I=
X-Google-Smtp-Source: APXvYqwxfDjXBYFHlw8cyLanFrOf8MHYFS4SszFUGKoHN/HmwCHALCMrani6Yxhx0suXxf0VdSa9gQ==
X-Received: by 2002:a62:1b85:: with SMTP id b127mr58620340pfb.165.1559910047337;
        Fri, 07 Jun 2019 05:20:47 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j5sm1879261pfa.15.2019.06.07.05.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:20:46 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:20:43 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/6] block: initialize the write priority in
 blk_rq_bio_prep
Message-ID: <20190607122043.GA1276@minwooim-desktop>
References: <20190606102904.4024-1-hch@lst.de>
 <20190606102904.4024-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606102904.4024-2-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It looks good to me:

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
