Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D20C433F5
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D863561284
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 10:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhKEKD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhKEKD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Nov 2021 06:03:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2210C061714
        for <linux-block@vger.kernel.org>; Fri,  5 Nov 2021 03:01:19 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bi29so8255624qkb.5
        for <linux-block@vger.kernel.org>; Fri, 05 Nov 2021 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y0eDc1jsGrKn0VCcbF5H7UdX+4+t91wUmaywlQWMyXM=;
        b=x1pfM0wbbNiyvInFur0jftbrRutkUjUhdoopeMJQxyUwHRBM6bmAYk7mJgw0MtmSk8
         WkfHRu2bmBkXFxR+iqBzXTN6FSm9Lh5cH01zeYorVX9n4rQrNemN75ZItRntBgxHpZUD
         oENXsa8kTdXdjCAosLc1b//UHi+xSdHYW+cTP1d0NgVFgQI7TKirj2AFAeZH6Rsjwbvi
         u/sYrBn5Ge/s9e43QATW23JoRGqe0bZBZXkHWJrgLxrEsBdMLZWKaU/lQzI/a6vf+2pn
         Zie+UNvz5wEH5J476yv+YvAjsArCjp68Nf5bptEEPBDk+YyhivL6drdCu2GIJlulLZd2
         23wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y0eDc1jsGrKn0VCcbF5H7UdX+4+t91wUmaywlQWMyXM=;
        b=bGbUfKMTG+az4kY0xQNYiBMpQQnq4/IobNByZGbVgSoSCvs3bV4ISafgAIMhuOre9q
         oHWdbKlkKefeLuT2o8chcNn2QWshquWTRZT0wH4Mg/2yMouaSt5sLTEgRVB4i1Vw+bFa
         xGYcswFtHP+PX+Wp1IWWzYqhXz/SFj2wE6g/S/eOFynqwOPPPBluf2IOlJ3ZRcPL0UOH
         AANejmhQADMuhG2jOrnDHSdWQRcx1gNlFZDo6zCt/U8xWJd+ZdB0VPKFlWkX+0C7bp3m
         IXKoNTMLKAbZeeREBIC8q2CBuV+vTJLxkCOIIWVnhN6bHAN/b/8EBe4tb2cw3r94sYAK
         398g==
X-Gm-Message-State: AOAM532Lt6vYq00hXv/jo2tNygh9x69JEt+Fd1E9B6WNNO8YHOm92GXw
        FGWya9dayv3ZFx973uhuK0JPdgpNbY1Lzg==
X-Google-Smtp-Source: ABdhPJyyimvuYtaakCbOwKmFLmiZ5qQtUn+EWJseG+kohZBRl+epslqTJXYEcqwq+0e5UW6mCItUCQ==
X-Received: by 2002:a05:620a:28ce:: with SMTP id l14mr30074240qkp.456.1636106478693;
        Fri, 05 Nov 2021 03:01:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm5276109qkl.53.2021.11.05.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:01:16 -0700 (PDT)
Date:   Fri, 5 Nov 2021 06:01:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Wu Bo <wubo40@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH RESEND] nbd: code clean for nbd_genl_status()
Message-ID: <YYUA67rq5VHea2HV@localhost.localdomain>
References: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 12:38:23PM +0800, Wu Bo wrote:
> A simple code clean for nbd_genl_status()
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>

This isn't ok, genlmsg_reply() free's the reply, this introduces a double free.
Thanks,

Josef
