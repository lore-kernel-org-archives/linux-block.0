Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8642BC636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 15:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBMPgz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBMPgy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 10:36:54 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5015569
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:36:52 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id b9so5165663ila.0
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676302611;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UyDU4MXdtcc3tPXUF91DR09nLEipLuz0x/ndWCd0Uo=;
        b=4lFt/ogHTlwnZIXVLIkV8bgFRCeSSwEh+zi7NGrdnuHeCeXVVTGgYZGgoSAdf3XAHs
         11zm8Egmm5E7+DrMqBsTQuSEH1FwcHa9aCORPu3ESeFhe3cCt0hkLTGYadH0sjDShRUL
         fb+2ulZofBB0S9oe/QrG2mJLBrCseMGr+4VAQdRtKe49ir7iqhoUk7yU1psH9SGcBcgi
         eYVB82KHYK9yUj674/LV0S3Q2HHTpFBTlDfaovIHz0h9o0IGDV8u6+xaDt3gON9vs/FG
         6kNnhB33/tRWuqxwo68WON2p73xV9wiNdFGyqcmj453MqNIhXxExDGYhOJ/LBrXCIzv9
         i8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676302611;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UyDU4MXdtcc3tPXUF91DR09nLEipLuz0x/ndWCd0Uo=;
        b=1TAttaR2b4pVnhgCx7NpeZREg/FDmAIjtPED0lm3wkiTO+CkuR2+2SUPIV0hiBNLi2
         zbyxYIDHaDJn3OO272mNRQBR20WmyiXBbwHd+1cKXM21IlpGhp4hNDUC3Gn5eCAgDphb
         7foHT09vCPQhb0EQ4NfJRFh/moAFHmlwOf+Hz/4ZBR2p7aHbLmM42ZBncOqdpJqBmoht
         BNHIxPbrzvzGt3/uLaz+O73ibRkA13mRCUVJOJa7dv6x7Xf3R0sbpL4Vzck4teXpCYYL
         uXyRLlyeSCyRUCCNBP6kZTn4fITRSLFZmrbkrPPF5SLxDx/qcyZSOVaf/SGqNbjiMThk
         d1ZA==
X-Gm-Message-State: AO0yUKUX7ZLKO/fTpqRZokLPB2O0sm63np41E0q1aa2DBP3fsYwUu3KD
        SfUPvY18BaYHTbj+KAwA9OBaWw==
X-Google-Smtp-Source: AK7set+BeomEo/V9FsYyesBa0xKvkKn3cC6JBPZ+9tDcK/WyTLrd2sHqTa4xKLWJ8YwZBxtG5ea2/w==
X-Received: by 2002:a05:6e02:1c24:b0:315:39d2:d5e8 with SMTP id m4-20020a056e021c2400b0031539d2d5e8mr4567402ilh.2.1676302611483;
        Mon, 13 Feb 2023 07:36:51 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k18-20020a02c652000000b003a4e6b1e064sm3996935jan.90.2023.02.13.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:36:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>
In-Reply-To: <20230210141356.112321-1-xiaodong.liu@intel.com>
References: <20230210141356.112321-1-xiaodong.liu@intel.com>
Subject: Re: [PATCH] block: ublk: check IO buffer based on flag
 need_get_data
Message-Id: <167630261065.98786.1863973416590406572.b4-ty@kernel.dk>
Date:   Mon, 13 Feb 2023 08:36:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 10 Feb 2023 09:13:56 -0500, Liu Xiaodong wrote:
> Currently, uring_cmd with UBLK_IO_FETCH_REQ or
> UBLK_IO_COMMIT_AND_FETCH_REQ is always checked whether
> userspace server has provided IO buffer even flag
> UBLK_F_NEED_GET_DATA is configured.
> 
> This is a excessive check. If UBLK_F_NEED_GET_DATA is
> configured, FETCH_RQ doesn't need to provide IO buffer;
> COMMIT_AND_FETCH_REQ also doesn't need to do that if
> the IO type is not READ.
> 
> [...]

Applied, thanks!

[1/1] block: ublk: check IO buffer based on flag need_get_data
      commit: 2f1e07dda1e1310873647abc40bbc49eaf3b10e3

Best regards,
-- 
Jens Axboe



