Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A6FC7EE23
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjECPjy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjECPjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:39:53 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BE6E9E
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 08:39:52 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-763af6790a3so27401039f.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683128391; x=1685720391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3Bu7CLRceCJ0f58gepieRJsDkCu2NRqEpURYZ4h/SU=;
        b=uyffBe2HFPp6ic2ZUNHAiy5DOvrcl/StqHDXDGni5VAqFHECPGoo2KMvgCsFTuLL8C
         0g/wANXPg9tRUmbKEQfCVXrPM6518KoLiJAFRcP4vfy3Ayiw+LCCzvkLvNAJzi3MDyma
         nN7tm9fU05PdWOCYiIYs+pWprPlSQtZqDyCfNBMZ1hjtVu0df7I2vp/08z5azj8vZqJ+
         9d8CQ82nBWtHBqx3Hx4fBoO+OrCU+n7gitip9g8E1Bq3zVyLW4eVuKFaApXsupfSvhqS
         CpHAZR91Ff0nmMMw6b+ESc0hnCqHeqQaJTS9FCMjHLmgOSLkdDe2VTuTyQqpiNx1QAi7
         v6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128391; x=1685720391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3Bu7CLRceCJ0f58gepieRJsDkCu2NRqEpURYZ4h/SU=;
        b=mCN+tABTnH9HzrirC42qT4erD6hs+qdcLrH7HMRfksCYImANrnOhjRveBF85QxOZdg
         jmb/zEUiO0TM/8hbg76pHm9zVOA3RzbuJNv+lkweWFewhIulHBEnTN6T/T2fhvGSG1OL
         T/vMD6daAVasL6gtjglwJQR/zqEx0hIRzWY1lkKlCPFoZp0ncSYZtXld5OoVROBnrJib
         zqyVo2uS6tGcax5/6FTac1hTNbdwItqeoQoG2EheVxQZnNLQiV+b1cCWeQh96xon1xub
         JXS6Sw3pR8bcLffYXMt5HI02Mau+P4tg8SmWXIC8Mrtt+6MPn6WpUzMxUkLkdkB0RGAL
         k0Yg==
X-Gm-Message-State: AC+VfDz4/adl3ZzDPHV0br/SHGl21IYJwvedRe4rkVpyQml8dDKpcGVZ
        o4h3nZIAWXyQW0n8fIZQAKQJ4QTeDb6nvtust5g=
X-Google-Smtp-Source: ACHHUZ5/AYwFH33DyjdeeWsbYBYLtrh5iJgaOOE5GpeIeB6mIXYteBfKm13CsFNFz2/0YaOq+iAjJw==
X-Received: by 2002:a05:6602:5c5:b0:760:ea9d:4af6 with SMTP id w5-20020a05660205c500b00760ea9d4af6mr8808665iox.1.1683128391106;
        Wed, 03 May 2023 08:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cd23-20020a0566381a1700b00406147dad72sm10232284jab.104.2023.05.03.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:39:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230502024231.888498-1-ming.lei@redhat.com>
References: <20230502024231.888498-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: add timeout handler
Message-Id: <168312838993.941317.13384111151531306709.b4-ty@kernel.dk>
Date:   Wed, 03 May 2023 09:39:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 02 May 2023 10:42:31 +0800, Ming Lei wrote:
> Add timeout handler, so that we can provide forward progress guarantee for
> unprivileged ublk, which can't be trusted.
> 
> One thing is that sync() calls sync_bdevs(wait) for all block devices after
> running sync_bdevs(no_wait), and if one device can't move on, the sync() won't
> return any more.
> 
> [...]

Applied, thanks!

[1/1] ublk: add timeout handler
      commit: c0b79b0ff53be5b05be98e3caaa6a39de1fe9520

Best regards,
-- 
Jens Axboe



