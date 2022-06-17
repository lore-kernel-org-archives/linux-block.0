Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CEC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 20:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiFQUuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383386AbiFQUuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 16:50:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB35DBED
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:50:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e11so5104889pfj.5
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=toItf0IXZ7I1iDyIh0/knHB+cyKz0D2C0hqI8q5y46k=;
        b=SsDLeIpi8UYj/7medafDUi0Yy1ze4PoqY9zNul2PVzYopjmfdw6wWYSykGx7w5KMmT
         phMh8peCU2OHx0Mh0o8KKaquTiZxt07gLot+dYfhwruacW2x9dlep/4n+q7ho7Pfw6bN
         2LOWMcC9XsQYPwzOn5cW5bvhilAhd3znPGRZXbTd2d0ugORPnAtHZ21W+AxbalYAXQuf
         UidWFu22hYdXDJ3vJ0vaarzoEVxDC+bDDs9PWTvXihQFGeKlFNPM3fdlqExKbZSfKKR6
         H1ApTUDFHgWjIiUynJ6rsu1s/ehqM4rzMf/q3anyYtBHQ13UC08BgcG3t+ckInVbrPJP
         +/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=toItf0IXZ7I1iDyIh0/knHB+cyKz0D2C0hqI8q5y46k=;
        b=QGK53Ec5VXLrl/LE4TC0OYTyQd+UrtH+az2JsmIjlD4ZCwbdwDMQsZYYzbVGiy77sD
         l2X7cgVlaNps8E9EoZkWoyk7+d07zsZTSzGnE3qZJi/GF/0s0hSnM6SI/TZgLhSicBGU
         3omn/m4Q4bElAjk413zCMEIxBdSAtSk3swhpvnS5VEi2XcyHPHgU0DHqE3+MpGAVZSTR
         ZCaNa2GBjaXd3X3kXjyKPc3KSH3hIIT3S9SPr5Iuo1GqKD2ZbeWfSiyLJNO4vUui8unf
         /F6AxIbh7WDQ0yIjr2qHHnrI75SeAzZ2nnwJvo/auZ6gjMBcJWGty1aFmO8WlYd7fRbs
         UfQQ==
X-Gm-Message-State: AJIora+zmsGRdmJfXo8N8LCOITZpSxU8i4hXMieFaILQhww8dcmUNQHv
        B+d40B5EdkTmkp5q+XgImoI16g==
X-Google-Smtp-Source: AGRyM1t7W0qaZLJF9nklLxlWjZq5UWxOZ1739GZuED1EJthoO5jT2FVJo6TY0YUDp4VAcXwCxlPB6Q==
X-Received: by 2002:a63:318d:0:b0:3fc:6683:b with SMTP id x135-20020a63318d000000b003fc6683000bmr10349946pgx.251.1655499009558;
        Fri, 17 Jun 2022 13:50:09 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i9-20020a056a00224900b00522b27ce8f0sm4161821pfu.1.2022.06.17.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:50:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        linux-block@vger.kernel.org
In-Reply-To: <20220617204433.102022-1-bvanassche@acm.org>
References: <20220617204433.102022-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: bfq: Remove an unused function definition
Message-Id: <165549900877.540843.6519539248026777457.b4-ty@kernel.dk>
Date:   Fri, 17 Jun 2022 14:50:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 17 Jun 2022 13:44:33 -0700, Bart Van Assche wrote:
> This patch is the result of the analysis of a sparse report.
> 
> 

Applied, thanks!

[1/1] block: bfq: Remove an unused function definition
      commit: 7a338b43ef4b023ce8eb9ee38cc78491b06b16a1

Best regards,
-- 
Jens Axboe


