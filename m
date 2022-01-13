Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84BDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiAMUAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiAMUAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 15:00:48 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FDC06173E
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 12:00:48 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id a12so4981894iod.9
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 12:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=+bXcVsuUppNYKhF9ZtC6Trbv8FtRnS305N6GIULbySM=;
        b=R5DKTup50Gfl9IeMM2VI0sXMqVCI6jAQ1VCCrulnjDdxtBlxd2jnkFCiaMivfhwbvH
         22r1SW7pjHYmHZKN4rsBsJrFm2NU8krSUBPRUerLberQyIkQkuJX6Kwz0uLubLSyjQy/
         46RChVlrUEsZNIloLoJ8GGbbXCXqrMVIolV6pfEZwcdEQsCeDGSr8Klr+l/yW+xOM7Td
         BUaHx980l8luPOqghwwo92UOi+HVcCi0Dq+ivpGK90EkzermJ45Vk/RrjuO1WADJUUus
         m8SRmsnmRZHKzmW/p/4NfoIByeZjUjaIEbBkva4X4WVI3Pgh3XqV4n3A3KBHzQC5JnPZ
         XChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=+bXcVsuUppNYKhF9ZtC6Trbv8FtRnS305N6GIULbySM=;
        b=M6EYZohFvNFGylaYtZ2TdJQwcNc5GBzK1yYZg21qGi1+isN+e8QvKq4uPSTsqmtrfz
         1tPNipDZTlNjaViLjkpbkAunz4Y8R6y1WLStlLqVgf83HMk+SJoNRyaQIpzNcg6bXvIX
         GmaM+7TUQvkT8b/XLPRahHCJrgrqlUr49fM/u06B4Que3OojxY/4xig1RF8iUSXpPgEE
         h6ba4UxdI0vsjyd4Kro+nm60Cy2fhgt916/2VMvXCcRM8HzLSiHMrwAtpC0ZFvNvqJq8
         M/WK9XFUsJT+BuYexVltgRef89NMMh/bxrcJUnkr51LocCY0ZeTbEKHJw7OswKwoIe+q
         fsBg==
X-Gm-Message-State: AOAM530Stm3XMR/AOnFx6EwEoBCedO2YAIomaRbk/0tQj+tiGuuocRte
        VGZGO5Bf7FG93v/LarGmpO9mCg==
X-Google-Smtp-Source: ABdhPJwqANTtW8FxiE2ZK0CCdiycPJ1uIvNavWUQqzW2r03sG7uU/KIYOsUbGKs+I+4yN0BdsqPNpw==
X-Received: by 2002:a05:6602:1409:: with SMTP id t9mr2808021iov.166.1642104048027;
        Thu, 13 Jan 2022 12:00:48 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n5sm3887025ilk.44.2022.01.13.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:00:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Justin Sanders <justin@coraid.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-block@vger.kernel.org
Cc:     llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220113000545.1307091-1-colin.i.king@gmail.com>
References: <20220113000545.1307091-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] aoe: remove redundant assignment on variable n
Message-Id: <164210404746.172546.12306036907222392441.b4-ty@kernel.dk>
Date:   Thu, 13 Jan 2022 13:00:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 13 Jan 2022 00:05:45 +0000, Colin Ian King wrote:
> The variable n is being bit-wise or'd with a value and reassigned
> before being returned. The update of n is redundant, replace
> the |= operator with | instead. Cleans up clang scan warning:
> 
> drivers/block/aoe/aoecmd.c:125:9: warning: Although the value stored
> to 'n' is used in the enclosing expression, the value is never
> actually read from 'n' [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] aoe: remove redundant assignment on variable n
      commit: a6431e351c6ec5bb6800787d259b343088f369a3

Best regards,
-- 
Jens Axboe


