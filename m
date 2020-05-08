Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C5C47247
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8829221841
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XZ7DQiFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgEHPmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgEHPmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 11:42:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8FC061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 08:42:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x2so1792426ilp.13
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsc0r+5+ZjurzhOSjY4Y4lgMibKJ6WxK1U7G5gxIfG8=;
        b=XZ7DQiFAjFR4nQHlDaw40CKmYcpLCFegUPvkAfGrjAmgtNZ+5fzyq0iHzJtEkfdMbS
         IvD/tgUQJNjMCaOy1OqPw6s2ABZjbZiWoVWwwIF9azyhPPFbOE20HP7thOwa0acqLhdq
         PHpex97hM8yoMtRN0ehacCJ2d+4Fm49T63zz0XvXrrEmTuyHFwMElTYqShxoeZrnXt3f
         /YEh09jMp9ZiCYMx49Ds+b2J9I4Ui60C0gzy0ectvVelokPU/sK/J/VG82TyxNOtv8RG
         7PDZjeIUn8D2OLeMsiqUtxDR9zFue8V6D8qbR6SUVKmbr0ib1OyCN3Y2z3GmkOI/+bOP
         TTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsc0r+5+ZjurzhOSjY4Y4lgMibKJ6WxK1U7G5gxIfG8=;
        b=UMx/vUfB6X8fv1uriAXCfXx+STEGDrynSdUPF52kCGVztyD6gTbfAKsnn5SPoeIJFy
         qMH8SEcysnqYVGklWwR/w5Vn/wDGRkO5TTdO7y5UHTZ5DvybLZQBxXUOpPmO/jYbhlfB
         MqZb9VXOx4FjClhbJ71xcB4rRvz2b959lvHMZg5cHzUfeeea7+vg58ju6anZAfHaBR9d
         0gNqPMko2e4+q3L0Md2FcN4q+Zn4gRT8OQtMlHGBR1+W4JSfgtCbCUO6vp8UYORsr4KM
         iFNYp1auYuldzGfG8ASh3/M8O9PZSHIgK2v2MKCyVJKOeZLz8faA9bevSVtxb7eVpVUT
         dK2A==
X-Gm-Message-State: AGi0PuagbayJgYmWBA7HS5Ga7EjnxqQdZpsdwbCOHBY7Gyo52EqVHxna
        AamU2mkavGGAN/WtqIdOEaqDHw==
X-Google-Smtp-Source: APiQypLHAanSroDF/FH4Tm79CLceEZR7JGIioYNd3m0MytZ6QPPskUL2RZ+Ia2VRaJRuFv64YDjc0Q==
X-Received: by 2002:a92:89d5:: with SMTP id w82mr3393607ilk.153.1588952571841;
        Fri, 08 May 2020 08:42:51 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o22sm818896iow.25.2020.05.08.08.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:51 -0700 (PDT)
Subject: Re: [PATCH] hfs: stop using ioctl_by_bdev
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200508081828.590158-1-hch@lst.de>
 <20200508081828.590158-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1629593-587f-476d-a534-9336cb9e6d43@kernel.dk>
Date:   Fri, 8 May 2020 09:42:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508081828.590158-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/8/20 2:18 AM, Christoph Hellwig wrote:
> Instead just call the CDROM layer functionality directly.

Applied, thanks.

-- 
Jens Axboe

