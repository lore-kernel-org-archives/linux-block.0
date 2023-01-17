Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310FC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 13:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAQNzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjAQNyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 08:54:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED909A5EA
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 05:54:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so30649660wrv.7
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 05:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/25DhdAmRN9effrRikf/37uSs969leXr6Z842JBsFSE=;
        b=isS2Nzz24HP8jhAnoW3s1Ii9rmUyPRs+ycGkL3xiqlG+MTbXNoaTBM2wtHZIUz9wQd
         DT8lzIrL1Cm8uP7vUZ+EJGLXXyyXB7qieoKOtzsC3rXFjKisf05pmw69JWKmxnVL9jjL
         eRMynO5Ri6MVcJwhVkIX0VNBpcsvngVCXYXoHUU1A6JoScdU4U9WZLW9WQBKslOHae30
         LGZ7Zi3V1o77y5GLgqJNGvIOjJlwNyAStz4/4Fbjuwrje8NHQ0F3xW6G5+TD7tRrkl49
         YPN/gSN0nt8ZAYncMJcRqqqpRRoc+pNxqk4lw7uPn9fwdsvrFyLNqZeK/EN0mTaPbSTH
         lzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/25DhdAmRN9effrRikf/37uSs969leXr6Z842JBsFSE=;
        b=ZPcm4CVHHyYH3EfrkEQR+kBm6yM2nlUQIG47y5pd5gqUSCIAkowJMaR8r32R8eJ2Ap
         CY77UeHz4Mrl3oSZx3nBKYGvIvKcofrbpt/DhgPHioPMonD9ZI1BinPGyWJEO/5tClu5
         01UgF1YVxLJqslbaq3+n38eelQnaJBl0cx6VtLDhhZJjm6cjkMJxoHkgCtf2LWy6Csxo
         lpkiau/ASGDDdy+l8JUW47B8NkmUB24wpCeV3YeayrDBnm+GHqe1rT9YNkl6rrWzImL6
         U8E17UZcExaJkoA/D91AYEV4R7/KBwqqPEBE7m+CVX8ZjFT1+Bq5q/6bHmZpUQ+oCJl8
         w7fw==
X-Gm-Message-State: AFqh2kqwGa6s+9XbfFPV+VKFyomMalKX57sXHAHNXfum1WO53LpKy9F4
        vzMTgEVJ3jQUErNlkDl4oCWBmyF+K1s=
X-Google-Smtp-Source: AMrXdXu1Y5LTg+QQ5CWxR23GvNhJMkKrsOlCT59lEnHow5f08uO9KBUljv2OLG0wv6lKG3Syv0NymA==
X-Received: by 2002:a5d:59c3:0:b0:2be:1535:e5b3 with SMTP id v3-20020a5d59c3000000b002be1535e5b3mr3384380wry.41.1673963655222;
        Tue, 17 Jan 2023 05:54:15 -0800 (PST)
Received: from DESKTOP-53HLT22 ([39.42.178.198])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b002423dc3b1a9sm28391178wrm.52.2023.01.17.05.54.14
        for <linux-block@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 17 Jan 2023 05:54:14 -0800 (PST)
Message-ID: <63c6a886.df0a0220.70e39.e3d4@mx.google.com>
Date:   Tue, 17 Jan 2023 05:54:14 -0800 (PST)
X-Google-Original-Date: 17 Jan 2023 08:55:49 -0500
MIME-Version: 1.0
From:   glennharland437@gmail.com
To:     linux-block@vger.kernel.org
Subject: TakeOff
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=0D=0AHi,=0D=0A=0D=0ADo you have any estimating projects for us=0D=0A=
=0D=0AIf you are holding a project, please send over the plans in=
 PDF format for getting a firm quote on your project.=0D=0A=0D=0A=
Let me know if you have any questions or if you would like to see=
 some samples.=0D=0A=0D=0AWe will be happy to answer any question=
s you have. Thank you=0D=0A=0D=0ARegards,=0D=0AGlenn Harland=0D=0A=
Crossland Estimation, INC

