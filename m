Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A2C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 15:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjC2PYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2PYT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 11:24:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D8191
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:24:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id n1so7552203ili.10
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680103458; x=1682695458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftKQpq09kV48mTosw8MuVfkl6ibvcMmwUw3C74m9F9c=;
        b=El5IxoDBZaZpKgKf21blrwvSYXcNSsf9KHYGo95K3yTrLbUznW0TuU/h8QLOOsybde
         D1snhQE9+aXlc/a4uVLaaCu4g9TpXNY6y8/upqcm1QTvPe8qVefxmfTBzrLNYnnH/z64
         GQUK9lue1nRjIHtcRw5uQRdhc2NCXYSikT7HXKBGGpJsdmbF+7yvoSYkvpprSE2b2lhN
         /v1pz4PnGZAGA69YldTqT3rA4uzMeSC3j0+SvbPbwMDbMOL53OKgV1B929t1iZHopXMR
         Nkdl1w1hX1B/R7dIwJfR9lA5h2YV0i25531x/DKJjLuCeuyaZ/Kp7SskSTVret1VCPOc
         Ptrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680103458; x=1682695458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftKQpq09kV48mTosw8MuVfkl6ibvcMmwUw3C74m9F9c=;
        b=VXYi31LKO5lNHRjpZmH1vi+TVHA5DmO+di6AdcECBnUefdWQdk/mB5ptNwLHP8/gbk
         dI8Ap/6O1/lJMIvovlPsbhmY5kt+eIH6C7uAJnd4xWqJWqiv1gkhG2JrPRMK5ZNpbGpv
         xsy9Y2XTBX6tTIuOntcxBINm44Ell0PcIZMS4FGEEedlcj9pHYd99S7mUOlf4/E8CCKu
         5BQLpelI8IdI4NMFZUsYSoM519ha05yFOcf+pT/XezAV5n/UTJdclgn9jOPlxYYr2zUs
         b26ptkt52ezYjRdI2Zcon0LQAWIA81u4zqxUZK5hWMSOAITdtbMciUajBrhjvGKhGnca
         TwCQ==
X-Gm-Message-State: AAQBX9f8qy1K59sgci+TATJR4Zcu0esXGV06C/IUtO8/YkYYyhDtEi5W
        Y6Q32Bj2tS6hWDcGdCA5mkxy/KUOv84WREsE9yhtyw==
X-Google-Smtp-Source: AKy350Ylq4RJerXSRHOCWBPY6Y7tu8075OPeXVbuZewiJUfirP14Y1ffg8JL/ATGqPkZjCkXfh/bZw==
X-Received: by 2002:a05:6e02:b43:b0:317:94ad:a724 with SMTP id f3-20020a056e020b4300b0031794ada724mr12081749ilu.2.1680103458130;
        Wed, 29 Mar 2023 08:24:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a14-20020a921a0e000000b00322fd960361sm9238644ila.53.2023.03.29.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:24:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     hi@alyssa.is, linux-block@vger.kernel.org
In-Reply-To: <20230320125430.55367-1-hch@lst.de>
References: <20230320125430.55367-1-hch@lst.de>
Subject: Re: [PATCH] loop: LOOP_CONFIGURE: send uevents for partitions
Message-Id: <168010345750.1105147.5489453052618290734.b4-ty@kernel.dk>
Date:   Wed, 29 Mar 2023 09:24:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-20972
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 20 Mar 2023 13:54:30 +0100, Christoph Hellwig wrote:
> LOOP_CONFIGURE is, as far as I understand it, supposed to be a way to
> combine LOOP_SET_FD and LOOP_SET_STATUS64 into a single syscall.  When
> using LOOP_SET_FD+LOOP_SET_STATUS64, a single uevent would be sent for
> each partition found on the loop device after the second ioctl(), but
> when using LOOP_CONFIGURE, no such uevent was being sent.
> 
> In the old setup, uevents are disabled for LOOP_SET_FD, but not for
> LOOP_SET_STATUS64.  This makes sense, as it prevents uevents being
> sent for a partially configured device during LOOP_SET_FD - they're
> only sent at the end of LOOP_SET_STATUS64.  But for LOOP_CONFIGURE,
> uevents were disabled for the entire operation, so that final
> notification was never issued.  To fix this, reduce the critical
> section to exclude the loop_reread_partitions() call, which causes
> the uevents to be issued, to after uevents are re-enabled, matching
> the behaviour of the LOOP_SET_FD+LOOP_SET_STATUS64 combination.
> 
> [...]

Applied, thanks!

[1/1] loop: LOOP_CONFIGURE: send uevents for partitions
      (no commit info)

Best regards,
-- 
Jens Axboe



