Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B890C19F29
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGZSal (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiGZSaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:30:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB0B482
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:30:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so13952378pfd.9
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=FLXa0nbDXsZ+vL/FvW/ivGkItaQ8+NiszDubboZHV+4=;
        b=tBxl2XsnT0UvG7y63UlNq6ZaEUvROQ0MHYpaphHCFglPzqagwz3XImxX/ckF9kjV4c
         sAZF1rPVeT+zzl2imR+Zeb/9pb6BO/AQVRI7PlyU8GT8VZATbGP+LmtC6sytHEGnuG8l
         q9AD+G02jheCB+lEDSCiiS6+mRDLd/rMfMIpVa9+UJbACaefvEkMDOK3G65FaO+LBgJm
         v0xkwRRTWBf0wBn+sxo+Rrn+Zq2lj8DutZmt/J9NaVK0fPwPCIj04b+gQfX7kRWrwYZm
         85+QbuCpWILke2toxJVB/HPo/BW63W9atEx5PHKqQ+U5ReK/eDEkupbhx+AHA0tw4rOL
         fe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=FLXa0nbDXsZ+vL/FvW/ivGkItaQ8+NiszDubboZHV+4=;
        b=N+h7datGrmb/LG0mns3YrNdL34ywhNoiDbfRSCYeQVsZ2WQnFfPRQ8hpmWNKHrbk4d
         IxprMIOOfgbWy7jJI8ojhO4tSHtiPpnFnlqNHf0pvHguCmSSRJ0CYwrAgTtboYX3wCAD
         zXiZPPrd4ir9UvoEquEe5JBKR5b5R11h1M4pDeBfKpkrHXBvj7TBH8IYSPlXl6TueiGV
         WtOjpQDMA91/oP7plgUHnDsCJEKpFJ9sIZ+gF625RmkLF7ARZbDZJSku5/RX/NOnlcbl
         sQgKDutx+1j4impBmVRvdREryvqKJzGgyzCEtvsxfAr3XcDQYCL5+C/w02msPfTpYaPz
         2tVw==
X-Gm-Message-State: AJIora8iWrjmzoJkVdRjcgXeB7Mp05Ce9siU635+0hNMpp3Gsq7FzgMb
        aWP4IKBBHpQ9av64CwEzGgK9gpTVaU+j3w==
X-Google-Smtp-Source: AGRyM1vXugtp8/huehQJFWMzvdzFyJBHWnHc5ad7vEGtguX2DehQ2H+XmdBhJ+BmFFqDtuxuMcztsg==
X-Received: by 2002:a62:3086:0:b0:52b:fd6c:a49d with SMTP id w128-20020a623086000000b0052bfd6ca49dmr8916113pfw.26.1658860238108;
        Tue, 26 Jul 2022 11:30:38 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a054200b001f0ade18babsm13356932pjf.55.2022.07.26.11.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:30:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        dan.carpenter@oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <Yt/2R/+MJf/MSoyl@kili>
References: <Yt/2R/+MJf/MSoyl@kili>
Subject: Re: [PATCH] ublk_drv: fix double shift bug
Message-Id: <165886023723.1524809.5862125257342957251.b4-ty@kernel.dk>
Date:   Tue, 26 Jul 2022 12:30:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Jul 2022 17:12:23 +0300, Dan Carpenter wrote:
> The test/clear_bit() functions take a bit number, but this code is
> passing as shifted value.  It's the equivalent of saying BIT(BIT(0))
> instead of just BIT(0).
> 
> This doesn't affect runtime because numbers are small and it's done
> consistently.
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: fix double shift bug
      commit: 8d9fdb6011b4d413271eba3a62e10f89efecc419

Best regards,
-- 
Jens Axboe


