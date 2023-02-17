Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A7C05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBQUiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBQUiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 15:38:11 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC72055C
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 12:38:09 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b66so437839iof.2
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QW1U0BdBx7Jx8kPGyXfr0Re3UnOpioEFLwDuydQbjM=;
        b=03Qqa8iulXI39rGuZGvUnr1cd60q0K6fePLUgetpk/SjU81oBjlBQpzV/77WUPU928
         lO5N0nk8iKBudMAGpCzboTfrxNFL1VVF08fpkHFT0hwHf1pLKxLNBoLZrdJJHJlqS7sJ
         CIVsowbrrq87cc/k6aM2wwakwL4S6Z5y++4RF9cyTqeFwV+ZveU76zEYw9J4vLJ9Pt4Q
         JZ7WqzMIAos1A+oS9NmCEXzFT/GcxJEQ8KghXYNcw2kZF6kfiaByHbdSZsJ9ahLZLuPy
         KBDkvLW7qZSEVY2Q5A8B3gygAkijQZNJ9YdqKojPCSc1fvI9fU6E04t6PBqGnxG7ItNY
         +m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QW1U0BdBx7Jx8kPGyXfr0Re3UnOpioEFLwDuydQbjM=;
        b=oSCflOun305ahImdYA0X4/x3iGd/0Y1FIO1exQugMcQNQJCob1OeBDmNFfCAT6ca0s
         f4BIa9Nl57hmchRFJHx4r0vesmbZ9wWXFive5aQ1uKeR4p7rVhiv/qwWQ5KKRv7yncjm
         I2CegG9JaEXu+tnYmlXcmy3xHyb5qfPA6fKV4bfLY67EGVkPi3119Oo7ZjYjyyOD3eJT
         rw4uoK6/5UjUZy36BG5du0eSUfIg6007eRradCf0QDTOJtozr2lBT/oMpl06c75cHS9n
         cspN7yXg+7ocOxx3e4jbAYPYRqFKqe3SNGjb9s2XspPqcA7djivLOELIV8IK9vphETQ1
         FoHQ==
X-Gm-Message-State: AO0yUKVCKZmbYl8fqWXffpPGSJxjeSmRmLef/DShGNQeaX4KfB7LnF/d
        FsUULwE4F9YhJiFLrzRjEyMNmw==
X-Google-Smtp-Source: AK7set8hN4MPWUVNlWZduo6D5QmHgRQl2zP/sHLvJowbKiJcCnsTqE0hGcGJTzdO40QqrbiSa0r6Lw==
X-Received: by 2002:a05:6602:26d3:b0:70a:9fce:853c with SMTP id g19-20020a05660226d300b0070a9fce853cmr2300877ioo.2.1676666288852;
        Fri, 17 Feb 2023 12:38:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bh25-20020a056602371900b00740710c0a65sm1709811iob.47.2023.02.17.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:38:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <6f249f9b02a3490283ef0278096556de41aa0cf0.1676626130.git.christophe.jaillet@wanadoo.fr>
References: <6f249f9b02a3490283ef0278096556de41aa0cf0.1676626130.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] blk-mq: Reorder fields in 'struct blk_mq_tag_set'
Message-Id: <167666628814.273360.17235110926752683174.b4-ty@kernel.dk>
Date:   Fri, 17 Feb 2023 13:38:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 17 Feb 2023 10:29:10 +0100, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct blk_mq_tag_set'
> from 304 to 296 bytes.
> 
> 

Applied, thanks!

[1/1] blk-mq: Reorder fields in 'struct blk_mq_tag_set'
      commit: d88cbbb39b4db057feb1552de31f22c02a21b36f

Best regards,
-- 
Jens Axboe



