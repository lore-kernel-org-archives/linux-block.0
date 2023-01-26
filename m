Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7DC05027
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 14:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjAZOzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZOzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 09:55:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3010D6
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 06:55:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g23so2001660plq.12
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9euscf6YEZq/wBvSSdq7YjpQtN65Hp67SV2eTNjePko=;
        b=UYxPqxNdE3WEyI2w5QQNX1Tpp5KRCi+2dGGlyYH5Jb8kK3SY3ixfqPCooqmdCDTQUw
         Y7rMzMPyUoFivVOlpkx6c65LsaoHfUO7dooMXr2xgLYBDgV5h9yZETFJPKcT4ZgQ82IX
         n0TiSiKUoXoBXSROJDuSVGWXsb5b20ALEEjOBiEzh4Al7x+VTWH7mUH71wD3OMH7G+A5
         P80XgGjQy3DvYFcCLECXDMK7I8NRLmCgjZaqJpVBvLuv4pMwAto8OGo7epDwKulVby6f
         3pFxKM1O+Ta43C73DErN4gYZkNuzJd3agGtzp2AcwPJhFQmKuOB0nf7YUfuqB5WNFXEW
         lzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9euscf6YEZq/wBvSSdq7YjpQtN65Hp67SV2eTNjePko=;
        b=1LJ4X9ME/c+8iJ7zbCPVNT5gHDgp9oZDP12HKLr8TNUeQRhQ9fQ/GGs/rE2cArlRTp
         sgg/lq+/JXsSlTT/U5hmdwK3dOL7+odwQuMLiFcadc+WM8m4XkUfUjuLopSSd0YcJsrJ
         j23YPLEI4MnlxEgD2AJUnb0Zp7HN5QyVfaUWXvMMcKpPJzHsNdS/lA9WDwJtWUqfWxmb
         AdbWP/RaASwLcgvWsvQ0pwjEa7iTRgwGMXnQJTy3AQ9EVCqxzlvbJraL9dZFgSjJWixe
         H9r90m26/3luRE2AUv5eiCMBFpXPx4boERqvMLaWrydHSdMuilWBtKwpPQGyL97djG4g
         ljvg==
X-Gm-Message-State: AFqh2kozzMfs9JUsLVYEJEC5BXOob4w5iaHeN3XAdM24FSC9gXbke3hN
        nFTB+n8L5TIA0AvANJ0cqinjtLkQvS64lA4D
X-Google-Smtp-Source: AMrXdXt30qaAwOQXb/8YVr1ouJBx1S4EmqzCii4kiGXh1zKhpeUu2GfWacyNINoS88asbwKzzFEX3Q==
X-Received: by 2002:a17:902:db08:b0:186:639f:6338 with SMTP id m8-20020a170902db0800b00186639f6338mr8721228plx.6.1674744936590;
        Thu, 26 Jan 2023 06:55:36 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b00195f249e688sm1072257plb.248.2023.01.26.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:55:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        "Harris, James R" <james.r.harris@intel.com>
In-Reply-To: <20230126115346.263344-1-ming.lei@redhat.com>
References: <20230126115346.263344-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: ublk: move ublk_chr_class destroying after
 devices are removed
Message-Id: <167474493569.599887.13601231550715228983.b4-ty@kernel.dk>
Date:   Thu, 26 Jan 2023 07:55:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 26 Jan 2023 19:53:46 +0800, Ming Lei wrote:
> The 'ublk_chr_class' is needed when deleting ublk char devices in
> ublk_exit(), so move it after devices(idle) are removed.
> 
> Fixes the following warning reported by Harris, James R:
> 
> [  859.178950] sysfs group 'power' not found for kobject 'ublkc0'
> [  859.178962] WARNING: CPU: 3 PID: 1109 at fs/sysfs/group.c:278 sysfs_remove_group+0x9c/0xb0
> 
> [...]

Applied, thanks!

[1/1] block: ublk: move ublk_chr_class destroying after devices are removed
      commit: 8e4ff684762b6503db45e8906e258faee080c336

Best regards,
-- 
Jens Axboe



