Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15588C636D4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBQNQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBQNQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 08:16:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26D3D0A3
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:16:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l9so2973862plk.3
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676639799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K0akdtqajPllo5ScKnvujdeLBphCx9T2fsnMIt5ZP8=;
        b=upGVA4Mp117b59Pfk2iccuQdFPLyrCvXYU228PcO3R3/TOZaiVYVlB6gVwyuM1N2+5
         2qSpNc9k0pSgNAEQlD1yRMSClu3hmEV/0hH6BKmqGkl42G+eEI+s+knoEDSj7xZ2l03e
         RiW0hidyLX8LABGkn/l5E2gw/cgGLyvaCHanRVkv4CfZ0a6caLDnnnx5a36UZegnuM8O
         /fdyvt6IoOpXecGTv9BV/ABdtDOAe1JY6xaT0Au+0h71i1ANg8/wOxse9ZjqfzquIB+U
         VNvvAdX6ZrZ5ltbbWBlwNxU7/YDLG8wtK1CBom8MPDeNYUaOUvuHfLB53e3SwgzAx1xz
         731w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676639799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K0akdtqajPllo5ScKnvujdeLBphCx9T2fsnMIt5ZP8=;
        b=e9zRmahkI8Jl6M4gXS9NgmsQioVr5iG8trz0/uiyPNzi3nZkiId2NJBHXxC2P2RlRP
         3dTcOfjCSYphdJW3Z2btgq0SvLaX73dwNOrHTzxuMoWNT36utPUIg/GQnAnBxOhO8rUV
         b+TwcTFn7XEGC4nAe0mooG6ahCtHAKqXX2aeYN0Scy6TczypnSX+QyUPQTYTXCRc/3lU
         KkGQJC8dgv8La6TBWOhijrHoXD+BKeVwhT1hoJ3sFIErblltEMMrokuxJZIelCmsMF6U
         UqHJTrdcwWJfp95E1lTYyHw3TaN/0GyBVW+p+9B/leko0tZQHz/u7qbn6nYrv3RqHwTZ
         RY4Q==
X-Gm-Message-State: AO0yUKWrAw8y2BfyYZqyCBQ8nvjLknjGRHG8ibD5TkPkNIeQie9s9lbB
        vt/Pnt3poDrdglaz5qv1G/Edaw==
X-Google-Smtp-Source: AK7set/6AZMY7K0y5hGyd8CgV6VexmHNKifzn1k+3IpHscyl7MqBukO9NyOHnlBwrCJ4X1WVFa4Gtw==
X-Received: by 2002:a17:902:ecce:b0:196:56c8:cfab with SMTP id a14-20020a170902ecce00b0019656c8cfabmr1748808plh.1.1676639799097;
        Fri, 17 Feb 2023 05:16:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001991f07f41dsm3103259plb.297.2023.02.17.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:16:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, hare@suse.de, hch@infradead.org,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively
 open device again
Message-Id: <167663979814.50803.631094084616425348.b4-ty@kernel.dk>
Date:   Fri, 17 Feb 2023 06:16:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 17 Feb 2023 10:21:58 +0800, Yu Kuai wrote:
> Changes from RFC:
>  - remove the patch to factor out GD_NEED_PART_SCAN
> 
> Yu Kuai (2):
>   block: Revert "block: Do not reread partition table on exclusively
>     open device"
>   block: fix scan partition for exclusively open device again
> 
> [...]

Applied, thanks!

[1/2] block: Revert "block: Do not reread partition table on exclusively open device"
      commit: 0f77b29ad14e34a89961f32edc87b92db623bb37
[2/2] block: fix scan partition for exclusively open device again
      commit: e5cfefa97bccf956ea0bb6464c1f6c84fd7a8d9f

Best regards,
-- 
Jens Axboe



