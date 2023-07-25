Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20650EB64DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGYCMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 22:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYCMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 22:12:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EB7A1
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 19:12:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b867f9198dso10323175ad.0
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 19:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690251124; x=1690855924;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg3YrlXj2GocemRkmbXSAXZ0s5CvfOuefETA2tZbGqo=;
        b=Fcu+rN8FG7cLBSlultWjwntpn6ACSha+tnO4UxsIsroA0tBwFcrK8UAeaEUKgMnF8c
         aiWV3uOhQBNFRaMNYo5zC0k54BetvRZC/C5hawrlytPdAtkDgVcPNZWL2zcGi1JL3VZ5
         +hEeUlBG/c2dK5r/emIxDNdH28EKaJQeJewazh0L+IYklbFuOU8RNB7juEBEr8KGASuu
         1Xa7wd6fXPbDgn1J7n00cH5QblDigLmW2UOCUYezbti6C4t3/KqGDlyk4xpxtsKUdw9d
         CvTJzXxY0LziT9Aatssk58vdyAchh/yBp0Lo79eg26th3OYZcUUnEwa1htXJKtThyMuf
         W7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690251124; x=1690855924;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg3YrlXj2GocemRkmbXSAXZ0s5CvfOuefETA2tZbGqo=;
        b=KLj9GRdL8uK72tDENFH25nKwyBX9xrKcPWHnqpkXFknU4UqHgpE0cnVkc+SHDl3448
         NF2cmhIBeaXAQQ0ajozXZthywPs+IAoWBmXlL4C5FCtdb7eh9vx7rN1kXDco4e/6+2qi
         3OOvSfimlr3ExVMJglqBk4r5OYZNlGt/oDGhR5eouhHDuZoqmBrHRvAkR81X+6hyOk3j
         Lu6eREZ+acfrQMhRHwmhGtWM32TCmj/hH+G+i3/EU65z9yqlu1J5HRlCxTgPSCzlu6jV
         7QPqrTw1CiLfBfsO5tnCPYkTPl8K3V1Az/a1rLUEqGhQGFM2XIk6Xvk45S7/mfPqXrQX
         eMeQ==
X-Gm-Message-State: ABy/qLbeDORx3V5EF1h4yfIT++igE88FRIlz/OWsvxfV8c9N8+RRgfOw
        3z1lyF5CiYCMO3xawzdRPbo0YGbjlnbODU0ae20=
X-Google-Smtp-Source: APBJJlEUxtU2KDsnWHcTDem3u5Ulb28Rs0SneRLE1w+0cxmElu/iTHferdFWyTM77LUoPKRUUdpeGg==
X-Received: by 2002:a17:902:e80a:b0:1b8:50a9:6874 with SMTP id u10-20020a170902e80a00b001b850a96874mr15091390plg.5.1690251124436;
        Mon, 24 Jul 2023 19:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709028a9800b001b85a56597bsm9622296plo.185.2023.07.24.19.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 19:12:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20230706201422.3987341-1-bvanassche@acm.org>
References: <20230706201422.3987341-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Fix a source code comment in
 include/uapi/linux/blkzoned.h
Message-Id: <169025112343.656662.13264728701773970662.b4-ty@kernel.dk>
Date:   Mon, 24 Jul 2023 20:12:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 06 Jul 2023 13:14:12 -0700, Bart Van Assche wrote:
> Fix the symbolic names for zone conditions in the blkzoned.h header
> file.
> 
> 

Applied, thanks!

[1/1] block: Fix a source code comment in include/uapi/linux/blkzoned.h
      commit: e0933b526fbfd937c4a8f4e35fcdd49f0e22d411

Best regards,
-- 
Jens Axboe



