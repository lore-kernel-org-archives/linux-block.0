Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E2DC001DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 19:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGXTFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 15:05:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F9F10E3
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 12:05:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-346434c7793so4818365ab.0
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690225541; x=1690830341;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91UKxlfTSnaMbaW/apnz0nI/lJIYybDgXR1NhSsktZk=;
        b=cDQElZRNq87SQfCS9Dne+S7r9rLW42GDYXw5tSMycErKtNWyKthcnMpirNMVQ/rCk8
         gXLJ+yPlEZGfQ98tu5xlzJuWzGQSZxSW80bSwOVwEUV9wLa8Q7MYG96SO5HgmcpGnqd0
         58TYTfEQajhQFpcI0iXKGzzQwlB8hvdSTbAxRjbqkJJnXnbbIkG4/xCFBzPOXQz9EXOQ
         eRTvjOmrEW4LTzU99edjO+IKP7FrTbIkvUBkK3o4s/ZzWmW6WxVXYrMzU8PG2ttITTJW
         b4sZ7VMI5FFhleDzbcm6eYVjbXlYD7/FTl8NQ9BlqH47VoRj2hjCTg8OtVRHk0dM1SPt
         F/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690225541; x=1690830341;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91UKxlfTSnaMbaW/apnz0nI/lJIYybDgXR1NhSsktZk=;
        b=GN4EGnxJcW3Pr4D33ZszYz2fDgBV+3wOrGK9MINxJdz4jDQWHmlbE4XhmvPQHxSurQ
         /7x0RwyYOhWEBtRDlzHyawG16j063ocRJmY7Id2FskJCKVntHpAtM1X5AkW/I75X/ns/
         EHA8ERC4MdOUKSkrahwejD6Cb+4pNqRd0YJ/qQFEp4fmhnHCsogMS9h4q8Vy5W9kSmVp
         CF0Tna3U04CPKLPLDBvNqKCAQ8sWFIIMIzxOoy7vVH4N+v6WYCc2z6/jDNJHmBOpjuBQ
         lwKKK0QhRICKK1T5h+s8qK/OVXV3KU8aphIs1hiN4FKTM78ne384zobld6vtszef8/Jg
         NmuQ==
X-Gm-Message-State: ABy/qLamcb0ZWtoTjUuynoDmFogyIwgcaGG3ZMrUQudhqbL9nAM0HTGL
        KOPKQuZx5C2+EhsCqAqoOT07LdAAzRJ56ait+JQ=
X-Google-Smtp-Source: APBJJlFUfkHlhGh3mSIkfzh9CqDHODwY7OAbqHHbAELgK1Nf9+2y8hOsB7RyVkymzplCpcxfKZXIJg==
X-Received: by 2002:a05:6e02:111:b0:346:3173:2374 with SMTP id t17-20020a056e02011100b0034631732374mr6872673ilm.0.1690225541041;
        Mon, 24 Jul 2023 12:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s16-20020a92d910000000b003425eeb2e17sm3216856iln.26.2023.07.24.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 12:05:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/4] dasd fixes
Message-Id: <169022554025.491471.2398286190331067754.b4-ty@kernel.dk>
Date:   Mon, 24 Jul 2023 13:05:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 21 Jul 2023 21:36:43 +0200, Stefan Haberland wrote:
> please apply the following patches that fix some errors in the DASD device
> driver. Thanks.
> 
> regards,
> Stefan
> 
> Stefan Haberland (4):
>   s390/dasd: fix hanging device after quiesce/resume
>   s390/dasd: use correct number of retries for ERP requests
>   s390/dasd: fix hanging device after request requeue
>   s390/dasd: print copy pair message only for the correct error
> 
> [...]

Applied, thanks!

[1/4] s390/dasd: fix hanging device after quiesce/resume
      commit: 05f1d8ed03f547054efbc4d29bb7991c958ede95
[2/4] s390/dasd: use correct number of retries for ERP requests
      commit: acea28a6b74f458defda7417d2217b051ba7d444
[3/4] s390/dasd: fix hanging device after request requeue
      commit: 8a2278ce9c25048d999fe1a3561def75d963f471
[4/4] s390/dasd: print copy pair message only for the correct error
      commit: 856d8e3c633b183df23549ce760ae84478a7098d

Best regards,
-- 
Jens Axboe



