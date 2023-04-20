Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11370C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDTMyf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDTMyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 08:54:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2F2108
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 05:54:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66e6160easo1612225ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681995272; x=1684587272;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVzO15Juxs8nOOxJ1geYyFLICHAljZ7K0IVifP9hASU=;
        b=MZrxYXq35oDsBPI0vKz0kL9+8URg5FjmRtTUuKQQlvPWCezaWL6BzUmJeHeLxO7l0R
         Maw959cUkEwJShZkOVkPEDun8hgNilaDtiSA8dDVa9/punzIsWlW+Z3UEQiFUWVQP21c
         hvwYnSY3yHNId+2DC+3AcxHAUEhGm++dC+5QjvoFvu2BkCGF+b0BGjisbfeXpjWGtWES
         0Gi0ZLKOMWoyf8YFufrJ+BcpZ3EUKL0SXtdzzPmHtadkOdBI7qwJjP8Zg+vm1a1N524q
         bO9xc2jh+apSoHI3ziWCEAIMTPWO1fLzVvKhbY2m4V4NbH3Y/QqKB3bysfOeTV6+JXVU
         9cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995272; x=1684587272;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVzO15Juxs8nOOxJ1geYyFLICHAljZ7K0IVifP9hASU=;
        b=BHtf/Hnt7h/DZ2KDfUUR3v0P4hjnJef+BY+129WdaX9UCpxXcECP+FrbaRMQ43uh/o
         b1qGR6FtL2TpEH61uvQ98AQf2iaJGhVLm7PknmMVI8CrmJwXukA3H14F4GvUI/LHI1lQ
         lfXbezQI8EtJi0pUDKyPlfzDcAQeBV/n1iLG3skJqOjggfv6Ddh+j2xNzB5vrVck4Zu+
         5BRrqpwPArAhr0HMov4jwbGTcy10fo/1fFpUud+xrPi+CN6MNAEldRPgiEMXfAtXguId
         YoI5iMbgkBGqEPqn+ZR7y1UODV/stMw3Zrm60fScao9t+A7+vhngZ3ZtOmHYs6mf1KF+
         KG9A==
X-Gm-Message-State: AAQBX9fb2EdgH+KuyQpP4ALp9sB08j+dqNBlTM2ihUy9n5rSnOSliCMh
        UT893p0LxZh/hEOlg/2t6QIyCb6acQIPs1aW2jE=
X-Google-Smtp-Source: AKy350ZURFc1RYbCKW/5MwYAP+oCjydxAjpbHjuJEC2yk6M2f/fV2wNOd6Kh0ac0C0hfrNfUyHGlnw==
X-Received: by 2002:a17:902:c94f:b0:19d:2a3:f019 with SMTP id i15-20020a170902c94f00b0019d02a3f019mr1755883pla.1.1681995272137;
        Thu, 20 Apr 2023 05:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902728100b001a6b02659c0sm1130771pll.159.2023.04.20.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:54:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20230420112018.1108058-1-ming.lei@redhat.com>
References: <20230420112018.1108058-1-ming.lei@redhat.com>
Subject: Re: [PATCH] Revert "block: Merge bio before checking ->cached_rq"
Message-Id: <168199527140.701888.5216274415727018945.b4-ty@kernel.dk>
Date:   Thu, 20 Apr 2023 06:54:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 20 Apr 2023 19:20:18 +0800, Ming Lei wrote:
> This reverts commit 23f3e3272e7a4d9fb870485cd6df1e4f9539282c.
> 
> blk-mq sched bio merge still needs request to grab queue usage counter,
> so we can't simply call blk_mq_attempt_bio_merge() when queue usage
> counter isn't held.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "block: Merge bio before checking ->cached_rq"
      commit: 81ea1222f2fa5006f4b9759c2fe1ec154109622d

Best regards,
-- 
Jens Axboe



