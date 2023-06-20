Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E75AEB64D8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFTSvJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFTSvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 14:51:08 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E010D2
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 11:51:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77e429fc6d5so29324939f.1
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687287066; x=1689879066;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyqVGNKadG/R7AVs5M6Apzil9bNyNNjSghUhi9cT+1Y=;
        b=5pfP/bkC5TqAaYcYBrl2RHZm5ueGoqH8Xgc6Ty+6+oTf2S3ZVTJPCAlKVsgCY7hkAf
         OUBd9bXSETljqNkTHPmq5oTddl8v331gJZ3x6SMpZzUJ0ghH/dkPHqd+UlpIhXziy1Yn
         qEoOg09jOauRPy6Tso/PZCK9wjUwXBrnqbIPTZtrew24b+mPlZ24i+LYhQdxVMguZ6q3
         d+5zgaOUrWsWFBcQ1PgAMusC1E0QYkJUiHa1/0HAzgw351sHurbAWIEOOIlEly3AUqUb
         bDlzxUNdGh2uztR6rZJeECi+IeaqrZeGSIeiN1HC4ENYkVZxud4FTIDginDHF9zvehIy
         4rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287066; x=1689879066;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyqVGNKadG/R7AVs5M6Apzil9bNyNNjSghUhi9cT+1Y=;
        b=a7BoCP3yNij30G476UsrkyjEBBQm1yAGFezcGwGDjm9i54w/uq0weSK/AguJoq91K7
         1vbfLcyt1NbKY9TyfAu9fGODyhy8JqwOY+hhXQOvfmp2asVT/NHO7t2fNkpN6WpAQo/J
         6n3FClOr5bTNwK8b8ozHTNk3hU7v+geuJEa/Du0nK+YfYQ0BgjsKwH0kCsEbDqVj3OfZ
         oP9pneKA7afhxsVEu3Nvq0ijgns6ZLTdITOgOBKSw3ISVXAvFpxIh4eXDG0PhlFh0E6/
         8ZPYdvlKsSl8l2LvF/QSeH5PDwtdgeQqFbzLZfN+QIQFFOjltddlKki1g6J+u9O3l45K
         o7rQ==
X-Gm-Message-State: AC+VfDzLdwJLuEPDnBy3TuyBiGISnzkkuKFldxkEZPgTx45j1KnaJ5Yn
        bq26TJ2/1M8TQV7oI+z95aDjCQlyEyAOxbd9ZCk=
X-Google-Smtp-Source: ACHHUZ6DuQRoEasGGC66ipeAXJColUrW4MQPjW//N2R1HqK3GtZ2Zkueo7vchlMMaDoZDF6iMyXK8A==
X-Received: by 2002:a6b:5804:0:b0:77d:f413:3c95 with SMTP id m4-20020a6b5804000000b0077df4133c95mr10855345iob.0.1687287066563;
        Tue, 20 Jun 2023 11:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g8-20020a02c548000000b004266ca33533sm781009jaj.108.2023.06.20.11.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:51:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     willy@infradead.org, hch@lst.de, dlemoal@kernel.org,
        gregkh@linuxfoundation.org, wsa@kernel.org, vkoul@kernel.org,
        Min Li <min15.li@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230619091214.31615-1-min15.li@samsung.com>
References: <CGME20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268@epcas5p3.samsung.com>
 <20230619091214.31615-1-min15.li@samsung.com>
Subject: Re: [PATCH v4] block: add capacity validation in
 bdev_add_partition()
Message-Id: <168728706526.3766608.418595838646923782.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 12:51:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 19 Jun 2023 09:12:14 +0000, Min Li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> 
> 
> [...]

Applied, thanks!

[1/1] block: add capacity validation in bdev_add_partition()
      commit: 6d4e80db4ebe76c4a4b6ffb6547cb168275204ef

Best regards,
-- 
Jens Axboe



