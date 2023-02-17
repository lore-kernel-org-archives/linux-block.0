Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C36C636CC
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 03:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBQDJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQDJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 22:09:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D015381A
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 19:09:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l9so1656479plk.3
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 19:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676603348;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZbsMf5FS/wcztSBDbukM9NlnWOqH5/sTi2irFhLnfw=;
        b=upt2/AkVKfiGqBF4Lc6DaJwICknhOyXXRJuK51Acofk8B6o2t0392N48jLd/XCztCs
         8WkHCNJymI/iu+9PC0nD8JY5TF3/o7F+iyoVT4GfVVNmYUVx2pfTjfVf8KyowuwrCs7R
         Y+4aeyIsk0fPlMENZq+BCsyxtDpLhx2D6hcvbGoo8AHd+7T0QSNg47zly09fxzIo8P+u
         FzuhIWgawhB3XWXpalv1hFU9tJvrfnkyzVMSDifeztOpBkT5n5xjKyn9TNl+ij20+140
         /4Ksie9FZbSwTXBNEOVD3bVbbBGfsPYG2UlTP3NNwMb1xYWJTpRki1/2sh5xK32OIfMm
         DjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676603348;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZbsMf5FS/wcztSBDbukM9NlnWOqH5/sTi2irFhLnfw=;
        b=fj7dZFD0IcQSTqK2xOZCaHCJBpaqYc5eEQp2XNsJPVVZTKyunDEfF2ek5I8cnqnOqu
         MnmNtkC+ikDVzWM4BtASuJlxoIdXLMwhpQBTFH9QUq+YW5nuoGt1B8rjfCLyCMmi2mde
         dnjSp3ysCI//70CfIQPkHMXc0cxGbx7PRyIYB8fZxaZ6HOrOchHYerFhstNaT/Ean+g2
         9LrMb9K2i9wAEr6ASo72LjEM/LvnW2oxF+CLfcTdHC1nm4uIepPsN1dX/GU0HsCnJhwy
         hmAKl+545h8/e1hT1AYkn+KSSjXCEKlyTK4fYeKK5HShKVVHkKCHKue6jjDJkDXeTYOP
         90Yw==
X-Gm-Message-State: AO0yUKWgW+gq3bOdH9An6+UyhwQ7AXcFh3Wt2+GIChLp2FRzT5N0Oz1/
        ukh28wj6Ljp674T5MvkyB1jgpw==
X-Google-Smtp-Source: AK7set+wBQ+n4l3F1WF/BvjVgqgYMgqkdVk6L546hBEkXR4UT2vwRwVuYx9Xdvy6CuiKkTJMNafRKQ==
X-Received: by 2002:a17:902:6847:b0:19a:af51:c27b with SMTP id f7-20020a170902684700b0019aaf51c27bmr39098pln.2.1676603348184;
        Thu, 16 Feb 2023 19:09:08 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001962858f990sm1976557pls.164.2023.02.16.19.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:09:07 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, luca.boccassi@gmail.com
Cc:     jonathan.derrick@linux.dev
In-Reply-To: <20230210010612.28729-1-luca.boccassi@gmail.com>
References: <20230210010612.28729-1-luca.boccassi@gmail.com>
Subject: Re: [PATCH] sed-opal: add support flag for SUM in status ioctl
Message-Id: <167660334756.42715.6958568674619044394.b4-ty@kernel.dk>
Date:   Thu, 16 Feb 2023 20:09:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 10 Feb 2023 01:06:12 +0000, luca.boccassi@gmail.com wrote:
> Not every OPAL drive supports SUM (Single User Mode), so report this
> information to userspace via the get-status ioctl so that we can adjust
> the formatting options accordingly.
> Tested on a kingston drive (which supports it) and a samsung one
> (which does not).
> 
> 
> [...]

Applied, thanks!

[1/1] sed-opal: add support flag for SUM in status ioctl
      commit: 0ac12f4afb4d0a6a2c4e42b350b6b9d71b88fa35

Best regards,
-- 
Jens Axboe



