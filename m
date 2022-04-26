Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3882C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Apr 2022 02:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiDZCer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 22:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbiDZCeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 22:34:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A2126353
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 19:31:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fv2so1629072pjb.4
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=HYfqHIhGpF7h06NPUNks3StayBg+7Ba4Glt42nafQ6c=;
        b=m/aFJlQouYbRDOGTpcr3fc2wpt542FoVPjIolTelK+zIKMya1dIjHiXtjf52WnQ4f3
         0alGlQdiic+RtQDtYANB+5VeVbW7h2El8i2q5Uon6BTkUMKXrE2g1819Nvu9dgUbjjJL
         QSJHKP/taBEEU2qG4Vpm/XGmdeHBzjdEXYpGHsLAoNAB9tQy69ya0RPYpQyqFSnMOR3S
         vdf85SOcOKjaXgH5J5fTPJzo/HdxPqfURBJZTTca2z6FLZ4OyyP4Mrf6mcD1BOFj2u2Z
         +/sOLqxErsIZE/eqRCNroZ3+exVDZMyewR55mgoU4DQ91buUa4C36J4WV5SdldzL8TX/
         z1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=HYfqHIhGpF7h06NPUNks3StayBg+7Ba4Glt42nafQ6c=;
        b=OUElQ9EyiZDiCtAJ1y1l1hueHrfgIcTzU8BJQknvt/quX+VN3WBR/2CGTABlxQLPVO
         r5raxL8aWnYmsk/hoEAXLh43oqaNrn0+JOuRrQ7kd0FbM4j60I86dLUaQ4P2x1Dtw1fJ
         QxKT7FQyZSNJWlUfTTj9aXZWBhsGh3KskgPxQ1Yoahr/4MV0uJAmWlWoAXZ8TKr+ld7U
         oY8fjAx9ukU0YT8m4IqL7T5vZl+Do2TNebinIWAyF5ePbXnOeK35X+S8ydzkMfEbe7tO
         +PkBxjDWHjffq2GEw9qiAK9EWVlgJ9o3HGkOzDNI1rS/ymgR5/PRAmFdYeEYFjdl/x+K
         pf2g==
X-Gm-Message-State: AOAM530O4scAMbBH+g7LIymD6d+vJTiCobN0+Z3GRUZRy9A9SMtnnPwl
        bE1FHqhhf+2StAEOvdMTCOwAsQ==
X-Google-Smtp-Source: ABdhPJxvTvc7QIqFoQYPK5fpEOgE2RM5Gz48WDV6YRIgcHkrFcdt/JQ9fCENJM/OR21vt/OkpJM3Ig==
X-Received: by 2002:a17:902:bd0c:b0:158:f864:4d9d with SMTP id p12-20020a170902bd0c00b00158f8644d9dmr20763991pls.13.1650940299757;
        Mon, 25 Apr 2022 19:31:39 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090adc8100b001d9424e49c1sm676371pjv.44.2022.04.25.19.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 19:31:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     chaitanya.kulkarni@wdc.com, shinichiro.kawasaki@wdc.com,
        yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220426022133.3999006-1-yukuai3@huawei.com>
References: <20220426022133.3999006-1-yukuai3@huawei.com>
Subject: Re: [PATCH] null-blk: save memory footprint for struct nullb_cmd
Message-Id: <165094029875.72509.3390339725421776639.b4-ty@kernel.dk>
Date:   Mon, 25 Apr 2022 20:31:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Apr 2022 10:21:33 +0800, Yu Kuai wrote:
> Total 16 bytes can be saved in two ways:
> 
> 1) The field 'bio' will only be used in bio based mode, and the field
>    'rq' will only be used in mq mode. Since they won't be used in the
>    same time, declare a union for them.
> 2) The field 'bool fake_timeout' can be placed in the hole after the
>    field 'error'.
> 
> [...]

Applied, thanks!

[1/1] null-blk: save memory footprint for struct nullb_cmd
      commit: 8ba816b23abd2a9a05705f3d00b8653f8be73015

Best regards,
-- 
Jens Axboe


