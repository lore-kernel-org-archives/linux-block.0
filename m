Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E8C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E78C20705
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gquOn/Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbgLAOG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbgLAOG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 09:06:28 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F1DC0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 06:05:43 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id r20so1286080pjp.1
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 06:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qbc9MbzyU2rrGPS6kr7szf8duaLj3Tc36yZl5Cf5ftY=;
        b=gquOn/PaH3sQENvP10cBp2mfR/s43GYUAvK3nNzo3QspKXlgvPZTL0eECdWQZui6w6
         J/HHcOBBlCNEXlnoznM1F6Ogy8uR52PXWhwsq9TR3XF/3FKLQatoUaBakO5EkoiFfNbK
         ro6OZT3vDy8YSvL2vZ0qBxpltwEj1H/Wm7OtM40AOAfCDncrEQzkrayC0klGqrk8nqbb
         s1PeIDvoNZ5YsdhE+0bGv5QgYrJnm4sdzeuLdylGyJeGgdgi7iI+S9Bf3aMwP8dRNjmi
         0kjuTck6gN054i1S5q98SyMMPfi/L5Ay0JCoHtplfZtSNM3qgtWKiVxye5yZPXtbLtZc
         HDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qbc9MbzyU2rrGPS6kr7szf8duaLj3Tc36yZl5Cf5ftY=;
        b=rjzpZDOpVFakVT+XUsChRbHaw5evDJQ6oaPG4JyjjYk3PzVpGljJPjXlqtV51muGB7
         Fvmx02gM2Lok9IKKo8Ge4zLlz9xuj/pX9eFaLWh3N/s3uBniP4VP3uOzh+qV88YpT0Uz
         GOCo/ukD9mDihfLva5DRWSfrmrL8DNjAdkgBhhZLot0+Gd5otsQRxIJHvgYeLHxCq4zm
         4NGHMcdH2hGUMvMJmwfdE67YMA1BpsHfzy8zR/5P3ZdJMrPptGZvG+E3V7xkC2lnRB/S
         D2VKDd95yufeNEZG4lfrWWHygwSHvQ+oqeg03hinoYTabbA0rV7UG4mrsLPlk1vtZGCY
         Z/kg==
X-Gm-Message-State: AOAM533MRhH3FriRMiaGwYZXAD4infNBI8g05IaXv+RVo11BKDkdSN42
        tJ0J7dZAaUPtAwStxJHw0UH4jNinYRskeQ==
X-Google-Smtp-Source: ABdhPJxxVmbJRBt8GpXCp9dnX1Sd91q8ua+WL3bDHTNbE+7xQwv61/exOpk9+1dfBmnSBs1c/lRBLw==
X-Received: by 2002:a17:90a:2d6:: with SMTP id d22mr2907206pjd.38.1606831542692;
        Tue, 01 Dec 2020 06:05:42 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id k9sm2931093pfp.68.2020.12.01.06.05.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 06:05:42 -0800 (PST)
Date:   Tue, 1 Dec 2020 23:05:39 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/4] nvme: rename controller base dev_t char device
Message-ID: <20201201140539.GC5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-3-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201125610.17138-3-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 20-12-01 13:56:08, javier@javigon.com wrote:
> From: Javier González <javier.gonz@samsung.com>
> 
> Rename controller base dev_t char device in preparation for adding a
> namespace char device.
> 
> Signed-off-by: Javier González <javier.gonz@samsung.com>

I think it would be better to describe things about following patches
which represent why this kind of renaming is needed in this patch.

Anyway, looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
