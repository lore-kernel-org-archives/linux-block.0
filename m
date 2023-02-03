Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A1CC636D3
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 00:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjBCANA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjBCAM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 19:12:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238E29158;
        Thu,  2 Feb 2023 16:12:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so3410763pjb.5;
        Thu, 02 Feb 2023 16:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWrxRvXYkO0FIHGpgnvF1HbU2gb6xyHIhFjdJfXiDL8=;
        b=jefwpmuUIXNHiDEXoWrz0zwJUkVE2aApHuVeZJ+yR9RdPv/1qhJSf2LMP0ddT6Fdv+
         5HgK381bL5ilSxbhhSD+w4clm0Kywl59IIQ98bTdgzZoBAYSxzLvu/tdrEI8dd8ICNSP
         fH8WZDgizFOEz5MEbCVLq5TJfoE6bb+Y1hsviBA/IaZ//ZuAPx4cyzZ8etfz8yBuDVII
         A+RmdA6OQldCinFvHn2d+0YXyfNr+fYq7mFlXq5mBfCpVPpJm4ws3V6HAH5S9YjA5h9U
         dIc0qf7nfUF3qt6+f8JyaTK2klhmDNWGp2DNlt3MZuQnNazV1V+sSufpcbceho0ptfB8
         SlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWrxRvXYkO0FIHGpgnvF1HbU2gb6xyHIhFjdJfXiDL8=;
        b=oqp/xF2mm0qgVwHxFsK+Ch/xsZ21Zs16VLNTEOiivlGHhN36gPtjRJPPz/efTBMz4V
         I/knGjJiL5CwBqCbHLJyFa1tUutMC0seQXXlSql5ydMhV/otoj8ObR4TmLtnQfl9hfjv
         elttIyRwFmOtzss/ig1wK+6na56mfIoKj+VKV47Cuabbyf56gLXUxXsKmh/zkZn6Iysw
         eZom9w1bG7dY46WlShU3vajMUKFUb0OU/PYoCArD5+2kEjf/M5G/2l/k7rApkqT7sZwi
         BR6kt4cdXpa0nPTTeIyhTWaRvDnK4QDUX1/PVnJ9FH6UqA01jLARw+78OaBIitCvETK+
         8xbw==
X-Gm-Message-State: AO0yUKVCps2+mqiq8XDeMFonzCZJ7GcQVA1dKGajwrkYWeHcqazEG/Ch
        Zzb0jNYBPFx5jHS88lIY9Oc=
X-Google-Smtp-Source: AK7set/KFUYGhzKmBigIwW38dTZef3pu7roa991Fu0747zL17CsLOON/jetcjg+4SR8KEbz0sGkNnQ==
X-Received: by 2002:a17:902:f30d:b0:196:1d89:7002 with SMTP id c13-20020a170902f30d00b001961d897002mr2260761ple.31.1675383176753;
        Thu, 02 Feb 2023 16:12:56 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b00198a96c6b7csm225638plk.305.2023.02.02.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:12:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 14:12:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 04/19] blk-cgroup: simplify blkg freeing from
 initialization failure paths
Message-ID: <Y9xRhm12BtP0opKL@slm.duckdns.org>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134123.2656505-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 01, 2023 at 02:41:08PM +0100, Christoph Hellwig wrote:
> There is no need to delay freeing a blkg to a workqueue when freeing it
> after an initialization failure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ditto, ack but I'm not sure this is necessarily better.

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
