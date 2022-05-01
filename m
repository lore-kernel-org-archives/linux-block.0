Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5316C433F5
	for <linux-block@archiver.kernel.org>; Sun,  1 May 2022 12:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiEAMps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 May 2022 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEAMpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 May 2022 08:45:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A706A038
        for <linux-block@vger.kernel.org>; Sun,  1 May 2022 05:42:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso14147659pjb.1
        for <linux-block@vger.kernel.org>; Sun, 01 May 2022 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=bzlxiMZohVGsFIdCE5Il6xl3m/Eic7TE04Uyk2xslOI=;
        b=pu8TCw04rD50IGtK6lHpBpF5sj5AkNCr/rSt8irNyT1BoASbuxtW4UrhbXl+5ernRe
         /q4CJneBosbc+7Rvob0Wfh1e2xkG/TrG/Ouc9J5IPDRqMdmtlZDaEQZJHELqeYqgIfsK
         kUA+eGgftUpSTuwKClARvNqE7Xv3ijAPFi6LdV2UvnIUmz2uR2SuCEMkYAMT/8tiMYRC
         emDuxPCSCOGs6KBxMZF3gMOho2TML9yYjodooovPqOXYyxDLbLzUEH5xNQunh5ahoRP7
         hckxzAT48ZFLwXELkWzibJ/k981ptUpIhP8a4/MQV1KxBG1BATXSQD27rGvjbCa5jTT/
         9Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=bzlxiMZohVGsFIdCE5Il6xl3m/Eic7TE04Uyk2xslOI=;
        b=m3s5fofTj+dO/TcAN2EYHX3p3deuipot+VH+pl7SoJhvPwzGJocsjt0B3EMiUYKoHi
         cwP80Z3v3XPBgF1vBgVj/nHOCsWDDbP3uLPnelzaQ8T+IFDvCfXWEc2pPbXTKS5X/5G1
         G0/OB3rAESqEtu3UyF2o1CA/Q9Kno+e1kMrU3fAuRh8kAY1/2QFcQu0bAJQCvGAniPoh
         h9cXEfpQ2suI4+P94zU08gJ31w4BNQg3528TiISy/VbZfjamsaTFfBozhEHZAeLAcI4Q
         xlaWoFS39UYO2gtAoCq2u2mIqPvn+mjkyR0L9AImNp4OX+LOT7UrtQkdgfbmfU6DLk5e
         ir2Q==
X-Gm-Message-State: AOAM532pZpq7UXnDV928k5Zk7e8gchkB0p6JZjWGf2ACv06PZqjGEj8G
        BI0dO4TJl5F2bAkLH1czFf9yWGqj4gXzGvA6
X-Google-Smtp-Source: ABdhPJwHhImnXWW5Nb3aAwehPcPMXJwfytWArOjkqVq4ltU3XIHIcit+uNHi1LrdEtaor2qOBDRt+A==
X-Received: by 2002:a17:903:1211:b0:15e:8208:8cc0 with SMTP id l17-20020a170903121100b0015e82088cc0mr7456243plh.52.1651408938083;
        Sun, 01 May 2022 05:42:18 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0015e8d4eb2cfsm2833624pla.281.2022.05.01.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 05:42:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     justin@coraid.com, penguin-kernel@I-love.SAKURA.ne.jp
Cc:     linux-block@vger.kernel.org
In-Reply-To: <abb37616-eec9-2794-e21e-7c623085d987@I-love.SAKURA.ne.jp>
References: <9d1759e0-2f93-d49f-48b3-12b8d47e95cd@I-love.SAKURA.ne.jp> <abb37616-eec9-2794-e21e-7c623085d987@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v2] aoe: Avoid flush_scheduled_work() usage
Message-Id: <165140893730.11424.121282785247987505.b4-ty@kernel.dk>
Date:   Sun, 01 May 2022 06:42:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Apr 2022 08:31:55 +0900, Tetsuo Handa wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_wq with local aoe_wq.
> 
> 

Applied, thanks!

[1/1] aoe: Avoid flush_scheduled_work() usage
      commit: 0b8d7622ab1859bec082bd01c5e11137195f3d52

Best regards,
-- 
Jens Axboe


