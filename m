Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B81C77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjETLnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 07:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjETLnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 07:43:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B493DFE
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 04:43:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-645cfeead3cso188298b3a.1
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684583000; x=1687175000;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfKzQvy8FrGO4xzOZFqbsVHtAHz2bWDAXixj++ogOhM=;
        b=w+t6YLXMAvcJ3FfbHt4ekrnz+EkO5NPNcILDo8ZfCsoCtbMZN02EQ/aFH44UbqUBlZ
         CexJkSVWoM87SO6otiSqOdo1Pjeb/QVKxAc4SaB8bmb9UlcZO5kb9ZPNcQYnkBmnJM3J
         tvMSj+ixRsOAW1IzsbsPJNemxd3qcJ9du0or277FkrWLIz3g70YgghXRhEU2uK/c5m1d
         XVehSaWkwKtyXFoZHMJimYsR24KK9m463vJUMfGDJn3eKzjUp5baF/nyYY2v675XY5Bi
         m3xk7FSOO78X0A47KHXFyvXXgYAKyJ/MlQS7bxh8Aif3cpudc6Qy5e9AQ/1YGc2hbxMn
         XnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684583000; x=1687175000;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfKzQvy8FrGO4xzOZFqbsVHtAHz2bWDAXixj++ogOhM=;
        b=LHcjUBMDsn4rEtMOB7FajmRg6Gp5Goiqd+YBaxak/4Med9oUhQfoXXtP4s4eLdwKWN
         VC6NUiq6/xceYT18ppM6vWEewK078zNCx+UG5TeP+vvXIMdNw3zjQtCRUduk9JsGzfTd
         IED4bUrA9XicojwUAkPBkiVAhOYcazAF3XSZVx+cUlhvoXXjYcH6aqJL3nITWUDYz9/w
         Pt1KRffmtC2S2bj4jNhyiE9g7nr0HrPAHBIKKbk9yBSmcVOX5et1joyv0ZTUfnIhLt+l
         mirzhnGkf+kxBKk+2bdx+TxzqdRLz+gD7iaEhoHlVmjuCuYh9nbcHod0eMPJdej9bMLe
         8ijA==
X-Gm-Message-State: AC+VfDwZ8Z1i8GuMCY0fyaWIEEP4cW0EWXAm4rMdftdYCHjcJmWFHN4w
        d9xXW/Xn4wYuB4yqAqCr6x9NW7gL6btk0TPKcys=
X-Google-Smtp-Source: ACHHUZ4dTsc6mzuM56smeLSgCTlXrI3JolGJZD967+3C/SRkmhtgNjigjfJwUVAJfwtFfCWOkeyfnw==
X-Received: by 2002:a17:90b:3ecd:b0:24e:102c:10cc with SMTP id rm13-20020a17090b3ecd00b0024e102c10ccmr5643507pjb.4.1684582999801;
        Sat, 20 May 2023 04:43:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id fa3-20020a17090af0c300b002465a7fc0cfsm2871709pjb.44.2023.05.20.04.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 04:43:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230520044503.334444-1-hch@lst.de>
References: <20230520044503.334444-1-hch@lst.de>
Subject: Re: [PATCH] block: don't plug in blkdev_write_iter
Message-Id: <168458299881.539510.390312867594456210.b4-ty@kernel.dk>
Date:   Sat, 20 May 2023 05:43:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 20 May 2023 06:45:03 +0200, Christoph Hellwig wrote:
> For direct I/O writes that issues more than a single bio, the pluggin is
> already done in __blkdev_direct_IO.
> For synchronous buffered writes the plugging is done deep down in
> writeback_inodes_wb / wb_writeback.
> 
> For the other cases there is no point in plugging as as single bio or no
> bio at all is submitted.
> 
> [...]

Applied, thanks!

[1/1] block: don't plug in blkdev_write_iter
      commit: 712c7364655f69827d0b96f69594886ecbfb412f

Best regards,
-- 
Jens Axboe



