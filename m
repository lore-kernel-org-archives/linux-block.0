Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7FC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 17:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjE3RNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjE3RNX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 13:13:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A414F10D
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:13:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-338bd590bc1so751235ab.1
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685466795; x=1688058795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9lZV7bV7fcpjfbgqIwMWLtZa7MEtpBcanyjWNz9SA4=;
        b=xyLFhYk7xI5CYPvLeQkuOD1Z89KueAAajRiTaDrZh07ITGjo9jHqbiKMRbYZNbWzv+
         HmqqhLHdAzzjmAJTVdhuSMPg3cI9nGuwVAMhg2Ep8MLU9EtD+G4iOjxIA/b6N7IM1sao
         PUThVWll/0JIgxIiHuGwZ2BSuxITRKUZZ5Solv/TPxkLNQEJxplaEMDGjCPJQ/1zJdrn
         lDN4I0wagYiQuROt+XpyZZ5vDDKUrX3tum8wJOej2yoID/95poYBmxfHyD5pe8dx3SKX
         Eap3C+aY+sOde5CJZi+AqyFha0Lw1FxVoxW7//8A0MyKUyVK9TZA1KwGojvFzrLhWzce
         4P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466795; x=1688058795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9lZV7bV7fcpjfbgqIwMWLtZa7MEtpBcanyjWNz9SA4=;
        b=c4a9MMyOfHk+Y2VQ3nht+b9CUM0HEvQmM0x3XbS3aP56VJhZnWcc8+7X3L+kUFryII
         meDWaZ+EWgVTki4sh0f/2nEhr4JQ8ef4OLVqUoI/VS30jPUNFNSlgl9cdIdXZd1h5RON
         FnzDAHksyUESu5+FAqorUD21r1I/PtjCrYzE5a9AUakrpeM6ZPh898h2MvqnpIxwQUXZ
         NkydCm3ERl9nl+mIjM+Eui0bW411ihCF5FjCM3y6rDJbcNnrmLRjPeQwUouqMOcE474A
         bQDVAUdl1BACil2yp+49bDZwZwYUmVvjTU1y+0tp6PvWd5A0dYsw2GwTW5jGGA8HcW1y
         qqVg==
X-Gm-Message-State: AC+VfDxpuo0nQI9h5gbwTb79N64j7mGwS+/P30E1AUkkEoWiVPLtwAo4
        zWggWQIPstjHQC4ayWxS/hiEDUUXndctQYGtZCQ=
X-Google-Smtp-Source: ACHHUZ4H0t7i48FfHuwAM9EvQXL2x+v9wdYmg8vgH6Bl+e7aisaRBhtMo7bNHYR/aHixz5BEUVFlkw==
X-Received: by 2002:a92:c568:0:b0:33b:c4c:f425 with SMTP id b8-20020a92c568000000b0033b0c4cf425mr60590ilj.3.1685466794987;
        Tue, 30 May 2023 10:13:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y59-20020a029541000000b0040fa32ccb0bsm817352jah.79.2023.05.30.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:13:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
References: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
Subject: Re: [PATCH v3 0/4] block: constify some structures of
 partitions/core.c
Message-Id: <168546679410.36719.118353258344450301.b4-ty@kernel.dk>
Date:   Tue, 30 May 2023 11:13:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 30 May 2023 19:09:56 +0200, Thomas Weißschuh wrote:
> A few structures containing function pointers that could and should be
> const are not. Change that.
> 
> 

Applied, thanks!

[1/4] block: constify partition prober array
      commit: 539050f92ea7666bca17c2c380d8071d2f93dcde
[2/4] block: constify struct part_type part_type
      commit: cdb37f73cf05631c4f7401f2cd99878733c0c3d9
[3/4] block: constify struct part_attr_group
      commit: 0bd478005cfc7f50ccb769744d952e9687ee75b4
[4/4] block: constify the whole_disk device_attribute
      commit: a378f6a40fac4a2f1812adea7017613d2bd5dab6

Best regards,
-- 
Jens Axboe



