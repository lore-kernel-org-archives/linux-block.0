Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B0C2BCA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72975208E3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgrTSQKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfFGMXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:23:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37125 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfFGMXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 08:23:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so1103143pgr.4
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2019 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJGsfmZwNViYi6AeKllcvkiG3cGcirkMED1J/QPJA4Y=;
        b=FgrTSQKsesJV5MveJ2Rqho/60Hl/2fRCQ9KmAN651oJ9yzrxTtrp067JP+Sbh8DC7U
         FC7AclQM9oQFW66WEDFi2uf6k8iOFWHWVZSxul0ZaivYOL6waryPXhlc6Wl5Ss4k8tdt
         ++BLX2dZNhgXHjx6KZOiBNsMQl/G7pcLVmkFUINrNYkD8fEpVcheNh5gcCfrTt8gaGW0
         EJ+VnF1oR4oIcSERoq8tRE608IkqowDRF/R4GVaf1HTIfnqvVtkd3UZOnGyOYkxDed5c
         jqGVBmCBNTkVURezOFZyOh5qVLg9L9gGdQaxw+YyIVOGFOBGkTDYRgjFMtKQTxngIfbw
         VhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJGsfmZwNViYi6AeKllcvkiG3cGcirkMED1J/QPJA4Y=;
        b=od/Iira7h1HptbO5wZXk9ARD4eA1UfycGnXYURHOo9IGYU0qvY4+V/n1VgTlmuIER7
         V3f6yZa7vk45Bjp+ozrAaFOGoEIAzjt9PeUpyvVdoQXqvaToolHEBWtgSG1I1l49CmJ2
         Es7/KiN4WYxWXyM9bfwLDRG0ZiXj/WZOelmTSrjzCT1jOPwpivU7w0N3QEivrkA1R95C
         J2ddKLwHo24p3VRD6ng+HJe70zrLvXRMo1De/MEN10AUAWhdTk7ZuKxPXaFChEO02DGs
         hiUnWsdH3K7QURbMwMymGfATwEP1FZ/5gQS22RQ3cPt25AIzE7X3UW4wjHn8TYMdEg87
         /J3Q==
X-Gm-Message-State: APjAAAUzvCT/zW0Q5M/SD+7Thd1ZFdH0oyF8p477cy1Ft55AKAS2U02Z
        LZOw50jES1bl3RK53X9IE60=
X-Google-Smtp-Source: APXvYqwiO8P7jj4EW2rN7JmIY/DyGRLvktO9s8j20zJGLBHkMVnyPl11t9C1hDQC1tdT1afTVXfO0w==
X-Received: by 2002:a17:90a:2224:: with SMTP id c33mr5128618pje.22.1559910221023;
        Fri, 07 Jun 2019 05:23:41 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id n1sm1818663pgv.15.2019.06.07.05.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:23:40 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:23:38 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/6] block: remove blk_init_request_from_bio
Message-ID: <20190607122338.GB1276@minwooim-desktop>
References: <20190606102904.4024-1-hch@lst.de>
 <20190606102904.4024-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606102904.4024-3-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
