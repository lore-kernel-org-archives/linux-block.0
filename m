Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4764C32754
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 02:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FBA20840
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 02:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WVlsnLCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfHBC4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:56:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40864 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfHBC4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 22:56:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so34378971oie.7
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SZXg7MkvG8X4G/e4/KyUmpRLOzGXiJZkoKc+bGigKJY=;
        b=WVlsnLCY9reULBgfQIA4QFxuBSbdil0JyDx29QmZCA6kdJbwhCqsOqYJZk9tzPrutG
         g2TVFIt3Mqow/U9r82MOuUJFDOGd1+MUL0CbPgXfX0uKm34PjjpPOkdE5/Io9NLGSA++
         i80s6/ZUY1qR1SarBjuFykXltCia6AzsWUvSJI7tkYYspXOL5URCE3EpG3aFI+UzMjuJ
         oJ/D8nA5ZD0q0OTaZe9tbq8uE+ehrHRhRkvsUpnfXJpQq4bVJ6STpUmaIdPiOTI2NNhl
         gmJ0VzWFdRb3pWCooVk+sPiN8qV5df5GHakCsIgnEjl7M1WfrWIxF8Z9+6IrBEPyddYf
         d1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SZXg7MkvG8X4G/e4/KyUmpRLOzGXiJZkoKc+bGigKJY=;
        b=YL3GRveONg+c9CdCb6KoTmyOSzYSWgE+xWHh4+w9SOIfORUYbR0Byz2jR3uol/vzVF
         ejvN0vywFnckah1pPVvWNKHzzj8yRniG5jrskTLh+rt9mpS+YzHh5qErZE7Y9vi8wWxr
         ByyNi1zztjTYfQ76wmq11twNmYlMRlhJnIj0/yKrhxb8nLk0rqND6MmkAFGPbSHO5oBK
         yxIFcsI/jdl+HtE7DcnDRyCGXSmwHBWeTNEv5lRQgaJuKxYo6OTO1y1+qGA4F0y62N8D
         a1MGKwSxOO3MkgPGvgIGOxw9JKv/FAwai4Hw077SqfsPFW/OS9Cx0bj2UvYr2m1Bej4D
         xyXw==
X-Gm-Message-State: APjAAAUXSMad5GlW4m+Voe1nrq/7YpNts3L0SijcNUDMqZOck1BHrMhN
        hcRJPq6JHyVZ2OYhrILcU58Cg9WXJwc=
X-Google-Smtp-Source: APXvYqxMAwM7gRmuihJFSYVFiyid8C3J+3mI4xgjPNsp/9po6iCu1laSZtFXCPcmwZrzuwtRAq4Umw==
X-Received: by 2002:a63:1046:: with SMTP id 6mr125224852pgq.111.1564714049618;
        Thu, 01 Aug 2019 19:47:29 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id p68sm85467533pfb.80.2019.08.01.19.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 19:47:28 -0700 (PDT)
Subject: Re: [PATCH 0/1] sending DASD patches through linux-block
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com
References: <20190801110630.82432-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c66977ae-7a17-5a54-0519-a69d8f825070@kernel.dk>
Date:   Thu, 1 Aug 2019 20:47:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801110630.82432-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 5:06 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> we would like to get our DASD related patches upstream through your
> linux-block git tree in the future.
> We hope to get a better integration and that we are able to identify
> potential conflicts with generic blocklayer changes earlier.
> 
> I hope this is OK for you. I have attached a first patch that fixes a
> bug in the DASD driver. This patch is based on the master branch of your
> linux-block git tree.

Certainly. No extra hassle for me, and if it makes it easier for you,
then by all means.

> Please let me know if I should change something in my workflow.

Looks fine to me, I generally prefer patches (individual or series)
to git trees, unless it's a huge series.

-- 
Jens Axboe

