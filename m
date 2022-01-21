Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BCC433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382024AbiAURss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381866AbiAURsH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 12:48:07 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712ECC061756
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 09:48:06 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p7so11687707iod.2
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 09:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=BvgJ1KhQ09zgjMCeIf9WRh/NdcZGH1G7T7wldmYjdSE=;
        b=cNENdJj9VCARwTzDZtisAhMuzRAldSqAvbGoQbnJu32rHz0Q1fS52L8cwBPwk6voZU
         dMUT7Gpa3TD8uvgwbpI5R5rHhp0CQspe1jE4mdX9yocZtgmKiKpdZC5U9/9EkgW3HOc/
         w+ACPfBlyX+zmaNQnqLEedOWd+iA6Dpgdlqcncu4Pk6EM7VKuZTaS2OKWdnaC/Aqvdih
         cGZZc/y2zEQr1hC9BX5DfDPBk9ULLQWsDB70O5+iM1iUvdf0S+eX/Cy1Tv0pkoL976dX
         W77cuSpyDlMW2gpriOkOEVtNUqoc0fly/P3AcRB0QS2FqZk/VHVOwu8++g1u/WVC/N6u
         CqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=BvgJ1KhQ09zgjMCeIf9WRh/NdcZGH1G7T7wldmYjdSE=;
        b=fyQYLTaFcv9CuJ0tpTjHg7SiFhr+wPvf5sYPRvj/FRuWPjEH8hiIkOCu0+JN/8e4tZ
         5qAeofExRBigZe6Ai3ndCQ9buB7Es2CQeQ/7TvbZYYHSeU0AFy5PSx9JFJdFLlMdionI
         rrKrfvFeLIxIu4GIfmp99+FqZ9lDkf/+zFBbb+Yu+KlrZs0tt323ZRqyggVkQ7bWkPnb
         SzHy8tTOZUhiRW2aALIEL35V2iOBIFYXIminaTqT6kBzVFbvX/W+d8796w/QDmUBS/4f
         CYgC5RgE3CvX/m4pkMxSk/msF+po+lZ8t5632j+/hHSfpxcizS/R06tgoM8at2BkR3X8
         fxQQ==
X-Gm-Message-State: AOAM530Ct1APTGaJhqXc1/mGNkP7SOVAbh0PXYgsc2wK8sqvxpRU5lLi
        ZoWYVr4E9V7nKBid1a67hVsT/w==
X-Google-Smtp-Source: ABdhPJwb1HnQ9ro85HHm7p9EGFys4Nphpx6yExOfHsGC6ziznix/qKRunIQxVlDaDPiFTugQ23IK7w==
X-Received: by 2002:a05:6638:a3c:: with SMTP id 28mr2396405jao.281.1642787285706;
        Fri, 21 Jan 2022 09:48:05 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h12sm1549324iok.25.2022.01.21.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:48:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        Miaoqian Lin <linmq006@gmail.com>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
In-Reply-To: <20220120101025.22411-1-linmq006@gmail.com>
References: <20220120101025.22411-1-linmq006@gmail.com>
Subject: Re: [PATCH] block: fix memory leak in disk_register_independent_access_ranges
Message-Id: <164278728249.232198.7158002983506256334.b4-ty@kernel.dk>
Date:   Fri, 21 Jan 2022 10:48:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 20 Jan 2022 10:10:25 +0000, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix this issue by adding kobject_put().
> Callback function blk_ia_ranges_sysfs_release() in kobject_put()
> can handle the pointer "iars" properly.
> 
> [...]

Applied, thanks!

[1/1] block: fix memory leak in disk_register_independent_access_ranges
      commit: c321e650a45c4228cce1107680ac74e06f014906

Best regards,
-- 
Jens Axboe


