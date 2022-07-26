Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F9C19F28
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 23:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiGZX6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 19:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiGZX6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 19:58:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96FC3AB08;
        Tue, 26 Jul 2022 16:58:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 12so14266430pga.1;
        Tue, 26 Jul 2022 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=tMv9j7W/oMj++3at+j+rDnYFnyNKWJlUFVNInGsG7RA=;
        b=aBfbcRJZ+Jw954t/Ml7rA1YCDj2TyCuBsMErzqJN07epLOv4tOfmWZCzugwfzvuK0w
         075uo7HuN08P1Ov707mSrfQnxI+ODXymIx0idUIEGNGj2Sg6ajevbvu/VdYfapJ7VYd6
         yU8GdMNBPIz4h+mCqAORZYWA1TBQ+fYYYEH6H8oPLAId5vC45Vp6k0T4rdWbda4ZCcV7
         F0rSKodMKqXa0TaE8PM6DurJ0FytyjgbduDd92zWPy/0w/8Mh+V9DGa0sQ5uorwILEHg
         vQmkktSV6IYP8becVo+rSlFVXOb+M732PRYW4x56WsmFWBry5UVF0JhDYqZTX5YpXy5Q
         QCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tMv9j7W/oMj++3at+j+rDnYFnyNKWJlUFVNInGsG7RA=;
        b=dEZxyfV8YdNOJYlWoUq/Z5NZRIj5VuLprlLxmuOGGso9W/UStvXz6zS04r2TsBK5jL
         KTcR1UHw1hHEZR8AXYK+64DDj0MvSSK0svy7mxODVIpUM+xtZHoINvyFDFgqmRMGrifk
         AtCdkZQhSmhcFGNM8NB7YewtZQNGsmYiLfJlUCxErN1NxAuqGhwcvQONq7mTNhTnyKc6
         l3g0O9ghsRTVH6OFR/t39iTmiqcyu/o5eKNl0yIhMrJoI2J4ZD4FglP9hgZMjbu1VWlB
         FAp4RfYICYbcDn6KJw6zWRXR+NXTp7li/GnCDQfmE2oQITMZYFczHmpU9fc8/D+W51OQ
         vMrA==
X-Gm-Message-State: AJIora9Qc3fqNOtQnL1GZlj+XnluPXwx+FfCMFWTEEgBRq3r6II2VciU
        pz9d/AI27paNVuKvvBrLWvkfqWcWCZw=
X-Google-Smtp-Source: AGRyM1tbXQEBcfrJwrmUS744n1ZETvr7umtc42DBFNPrTkvlqIbJ6EZ98I/mP862ojuYT2DcWf/n4A==
X-Received: by 2002:a63:8841:0:b0:412:b40b:cfb5 with SMTP id l62-20020a638841000000b00412b40bcfb5mr17233453pgd.197.1658879896121;
        Tue, 26 Jul 2022 16:58:16 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090301cc00b0016d10267927sm12218421plh.203.2022.07.26.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:58:15 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 296F436020D; Wed, 27 Jul 2022 11:58:12 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de
Subject: [PATCH v9 0/2] Amiga RDB partition support fixes
Date:   Wed, 27 Jul 2022 11:58:07 +1200
Message-Id: <20220726235809.15215-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The simple fix still leaves ample room for overflows in calculating start
address and size of a RDB partition, though such overflows should only be 
seen in rather unusual cases. To address these potential overflows, checks
are added in the second patch of this series. Comments by Geert have been   
addressed in full. 

Reviewed-by tags by Geert and Christoph (patch 1 only) added. 

Cheers,

        Michael


