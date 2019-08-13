Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AED4C433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243432067D
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="yEPX69/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfHMNLX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:11:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41386 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfHMNLX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 09:11:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so8876685qkk.8
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4LJQU2T7khQGAQyztlLnjvvbm1bXtIGlHnyeBk5YCk=;
        b=yEPX69/OCzgn40EiFA1fEI8CIA3zYztcH0KMxCTs8CjZDVuAd8gADih8EnbeP9F4y3
         7M3+HCRiLGmQ8ZhZdxcmNoJOOddscsUrsmgfSyt3NdyVe8g5Wv5f6RuyNr0CNiLrEM4m
         ONXOKzkv5oyYSSfAo/FcURUGxr0+4BXQe9izXwRxOipQM3Zrer8gJvBk+k+ImkEpK+jw
         0/9gI/fDm5kn1fm+fcw9qRWymBJti58arNDlnDHRX4/IdaijGooVjffBHDUXE6/8zdcw
         SjEnDu2zMqo4g7sNGhKPfdU6CoZYcGoLH//etS5NrjWEilQrghX4jUNYpm/mEQSC+g6P
         vMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4LJQU2T7khQGAQyztlLnjvvbm1bXtIGlHnyeBk5YCk=;
        b=pb1kovUd4NNrkA9HkT+HqjD4x+sh8YahddTlXKpHgzENsuxIl5AXlbJeTH/9woQUGe
         LlOKLlVX5/Ac0GAaVosOaLbXVQ5UmpEGVFIZpF25V0KN3VqpXKHJ2EZZmpVadCa2pUtd
         DZ+xaGS8pwaUGT/MvlKy6zXu5/d/MjoN5qLgaZ3Q217DlT5nNXcteGaOtpEGmDYtLStG
         bQ/sAlVK9+X45uxtaONeZ/tIc3C5VMiu1eresfnp9e11JrdgobM59PQz9/jxaysWj11j
         BeIk3tW3Nk8x/IgX9No/beo4QiWYr6i6WiCQQuKaJf+tH9qEMV8nHuE3cj3BW+o2KPHt
         zdwA==
X-Gm-Message-State: APjAAAV8U7Bjlgh+67flkz0y35HDfDXVhxTuYRFQgUucKAPiAaP1FWiH
        sWHhFixw/Ypipi65F10A+hexmA==
X-Google-Smtp-Source: APXvYqwTFDG1IECzxVaIqp0AZZYLCOZx3400N6QRjrDoIESDz1NLVjmOybRGdgYlFGndbTkbEyTBew==
X-Received: by 2002:a37:6646:: with SMTP id a67mr33956012qkc.216.1565701882549;
        Tue, 13 Aug 2019 06:11:22 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p59sm48659470qtd.75.2019.08.13.06.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:11:21 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:11:20 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] nbd: add function to convert blk req op to nbd cmd
Message-ID: <20190813131119.gmuasrbium56i4oi@MacBook-Pro-91.local>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-3-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809212610.19412-3-mchristi@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 09, 2019 at 04:26:08PM -0500, Mike Christie wrote:
> This adds a helper function to convert a block req op to a nbd cmd type.
> It will be used in the last patch to log the type in the timeout
> handler.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
