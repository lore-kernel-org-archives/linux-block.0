Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBDC7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 01:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjDFBpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 21:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjDFBpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 21:45:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39D76BD
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 18:44:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q2so58660pll.7
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 18:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680745494; x=1683337494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0PiB0tAf7EnUQK50jROY9tFKPhzxKKBfwhOcqZeQM8=;
        b=i9OYFl4pWn5xcxgzFxmIitPIzpwW+v9g0OYpD+y0bp6Vd+9PYz7urK5e8tMB69JBCU
         pK6Vdm/nuHrf3bRRJnu/O+NAnxsHOMNcHsPbB+G0qePMiVu+m8n6xo/M+rOkelowQr/O
         3mIyw5ZOVQjqOSC06UZK30q745tqmbwHbYJwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680745494; x=1683337494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0PiB0tAf7EnUQK50jROY9tFKPhzxKKBfwhOcqZeQM8=;
        b=eVmP9Qw/0LF8AzcKSl/jkWLXpWwQoXwMg02ExLfHtu45MuoI7tCYRnU6SiLg/SGss1
         JgySaVi0Gd8EoFPp0NiT8qKft8GXzpaRO2J0CmhDNwjYT50AfGADuo2F5fyZO7UABOQU
         P/XhxklrJ8iRu1TRGWyOLh5t9hOz9PqRHkMIwdsHcl1rpJgdDJ9EYz8vT/seW7LRV63e
         YrYz5fROsHtjmJgUAxOueUj+J/x8ub0EiAoXq25MMs+D+bCWv52fpS0SE6JYemBaEQMF
         caJvGaIyNbR25k/qmJLZ89Gz9lDS/pFv/GVSWBBmaLtt8pA9c9iNmX6NIdsA3Owm+0Dt
         oX8w==
X-Gm-Message-State: AAQBX9cZYwvaxUlaJcCtyDmEAOpJ12B0poE4iPgdxnLak6yMsoivlwoN
        HqZ/t4YHEK4uwXdTRZfda5JvEw==
X-Google-Smtp-Source: AKy350bO/7JV+NOlLw6ctcf/3tbwYZJGd52feDLIHriRADZpq8jurTmSkVpAKCPUOIqRupN/U/4Oig==
X-Received: by 2002:a17:90b:314a:b0:23d:4ffc:43e with SMTP id ip10-20020a17090b314a00b0023d4ffc043emr8968148pjb.38.1680745494628;
        Wed, 05 Apr 2023 18:44:54 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id gp19-20020a17090adf1300b0023c8a23005asm10974pjb.49.2023.04.05.18.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:44:53 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:44:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/16] zram: remove valid_io_request
Message-ID: <20230406014449.GM12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> All bios hande to drivers from the block layer are checked against the
> device size and for logical block alignment already, so don't duplicate
> those checks.

Has this changed "recently"? I can trace that valid_io() function back
to initial zram commit 306b0c957f3f0e7 (Staging: virtual block device
driver (ramzswap)). Was that check always redundant?
