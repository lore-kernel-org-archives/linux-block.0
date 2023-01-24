Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F0C05027
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 02:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjAXCfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 21:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 21:35:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5282DE57
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 18:35:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso17146258pjg.2
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 18:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFFdm/8SdflDgDT7EHL5t8PZiOZhtttydMh8UNhprb4=;
        b=DljXljeHIhfa+59LOJ4hAD3ygoSHfdrZaGVnay69zUOXkdfICsXb4cgMhpwqNnjhCG
         y9vC1K1TNs5HTGrMEx1Cdz41tV19YBCyRFuHZmFTKWZIWZa8hFZgoW6IroqQfVGp34Do
         3PAiAhFcA8bXF7E/efxSdwBUE6f/rOMUIqF6Oqe/eJ01aHJbnsIxCIQmeTSSgoaYrvUa
         gawICKGlxeAO2geNu5dXDu9H6E4XXAveeayTuxr3dTuSlzUaB5Wd5+Jp482gguDAk5lz
         kidzECHxOj7x93qv4z6iRRdC/EjV9aX6qjrSgw2LBrUul8iAv0kvUy1HLs64r/0VWJF1
         J7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFFdm/8SdflDgDT7EHL5t8PZiOZhtttydMh8UNhprb4=;
        b=IkToQ69KVTmmoK/sF92vIWYCVqpgiJFdwWCh06ynehT78xYxWaGUY1eSAd/RqawJbU
         ZSQR5m8FCuLu8gtID74kVrlM4REECVHxEqHyJEFlmWwvqAB6880tCuKwtMwTNg83hYG9
         75GWxiszsvbAPdaTbct2b3u+j69L0BWnkMCKxiBJncx3YRcC15jSJ6IBlExIsou3og0G
         brOjIs9kuE4NVEOq0p3RNOuJU/P/Wb0nhULX1VPNZJyn7fMXt+mcJmAFZEX2DR/1CuPf
         MxotUU29gGQK/49I2sRTXtyefw8Lchu1cSjOAkEj3j1f7E67kYZ0/beKdKtNol+1qs6k
         /POA==
X-Gm-Message-State: AFqh2koou/+qOcoaR5Gv9/mJqoB/6RfL7H3+WucWOAIxEL8ZLaPrczAx
        FhmODv74jzKBFnKBGQcX6Eiott2jmljnramL
X-Google-Smtp-Source: AMrXdXtc20Q7yx6l6YE87GqKscKRmcgi78OC52SesuBzKXuKXRmKb26Xa1weIba0d1gATTGi5V9Jig==
X-Received: by 2002:a17:902:7041:b0:194:5b98:4342 with SMTP id h1-20020a170902704100b001945b984342mr6614596plt.5.1674527734868;
        Mon, 23 Jan 2023 18:35:34 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0019460ac7c6asm376254plr.283.2023.01.23.18.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 18:35:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jim@jtan.com, geoff@infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230123074718.57951-1-hch@lst.de>
References: <20230123074718.57951-1-hch@lst.de>
Subject: Re: [PATCH] ps3vram: remove bio splitting
Message-Id: <167452773403.209579.6087653213240480442.b4-ty@kernel.dk>
Date:   Mon, 23 Jan 2023 19:35:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 23 Jan 2023 08:47:18 +0100, Christoph Hellwig wrote:
> ps3vram iterates over the bio one segment, that is page aligned and max
> page sized chunk, a time.  Because of that there is no point in
> calling bio_split_to_limits, or explicitly setting the default limits
> that are only used by bio_split_to_limits.
> 
> 

Applied, thanks!

[1/1] ps3vram: remove bio splitting
      commit: 2192a93eb4ac63eeb37ec5ec5cfa0db92ded5e3c

Best regards,
-- 
Jens Axboe



