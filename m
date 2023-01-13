Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E0C54EBE
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjAMPvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjAMPuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 10:50:22 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904883E07
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 07:43:30 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id x6so6329695ill.10
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMDRFQNMM2p+WOSwQ9Dba5m08/eqZCwGnutuShqS2I0=;
        b=bGjx8gC+nt5yLHeWJhR7JzVbtjLaL40agjy66eW4Tk8RWtrhc12wcNn6fkhEG6y/jZ
         6cLWZWJan3dr7e+4w59+lgy7w4UqMn8/VcQcjyA2XFPiw6l3CjNs5ROH9ZgdtVZQ054l
         AWyM1p0sXu1xbdZIg2jHm+WliH2vi36pirBaH4JXl653dlRY8hOEacTlvv37Qe0KQBVp
         bQDpPqVMM6bPM9apFNY1dfUiHT8AKyn/laJrmIja8wn3E8R43uky+Fffh/QrEodPu645
         pGejc3dIerQZjDuPALpaGhI3JcztfmmoziUlHgAh4nzPhnR+AMmfQISrWzN3+k22k0Sk
         clQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMDRFQNMM2p+WOSwQ9Dba5m08/eqZCwGnutuShqS2I0=;
        b=FW7Icg76EZ9aX470VZ7ijiyMYRmNBZ+MMUr7zZ0SPytRUlKBgRWvza8Px2L5RMSc08
         YqbLApooX5qSxraABRStbd1E//Bygy4o7qaHTzeVlBmzQzoRtxstn4+rinDiInsRJdSy
         rftnIDfNG2eQprmABK8DBZXnI4LMS1boIhaVNZGKZ5r8SgcOWLJGYTeC4pR5asi8i1tJ
         M2Kd9FuhIsNrwVi0l2c9gnDdDs9aXQnLc7Y6CdWWG8SPFdpc0sVtMrfPFfVboRVZ0TU5
         EJK4xuE0+bCMmCt3mlVkL26Ibld+fwQezHBy99Eph3FE29a+wrxMHyIjO1n9Er7ZR/Qz
         qlgw==
X-Gm-Message-State: AFqh2krgRKXLkKPQRG4EnawCL9tHpxsX75xhHwI1kJSsLuR+kMHi4bMC
        gRB1K4BpfacOzE6Q8YdTHew8xA==
X-Google-Smtp-Source: AMrXdXtxFHd2A+4/Ksfx8D+/irZoy4dYAzcM0F/2HZJcXPHxaCnvJignIzh+g3mVFjIGPbgOFqaGLg==
X-Received: by 2002:a92:b703:0:b0:30c:1dda:42dd with SMTP id k3-20020a92b703000000b0030c1dda42ddmr7873529ili.1.1673624609549;
        Fri, 13 Jan 2023 07:43:29 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 125-20020a020a83000000b0039dc4d26bd2sm6193106jaw.58.2023.01.13.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:43:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
References: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
Subject: Re: [RESEND PATCH 0/3] DRBD file structure reorganization
Message-Id: <167362460873.11790.14664102108857579461.b4-ty@kernel.dk>
Date:   Fri, 13 Jan 2023 08:43:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 13 Jan 2023 13:35:03 +0100, Christoph Böhmwalder wrote:
> To make our lives easier when sending future, more complex patches,
> we want to align the file structure as best as possible with what we
> have in the out-of-tree module.
> 
> Christoph Böhmwalder (3):
>   drbd: split off drbd_buildtag into separate file
>   drbd: drop API_VERSION define
>   drbd: split off drbd_config into separate file
> 
> [...]

Applied, thanks!

[1/3] drbd: split off drbd_buildtag into separate file
      commit: c058c9c9dcb137f395e1946b0f3595538479b3fd
[2/3] drbd: drop API_VERSION define
      commit: a68176e0f7cf1b68a84c3b7c08271af0d3d2e796
[3/3] drbd: split off drbd_config into separate file
      commit: 26547cb41a9f459535300275a319681a70cf69fe

Best regards,
-- 
Jens Axboe



