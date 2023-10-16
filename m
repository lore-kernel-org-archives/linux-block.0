Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B6BCDB465
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPVHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjJPVHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 17:07:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4F2F2
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 14:07:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40666aa674fso49184415e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1697490431; x=1698095231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDXNDAXEYDerEydfkLSexbTOlmVWmitFF6lrfBCh1Bk=;
        b=hnBYzKwLntn6mx2dBBno8ySDZk0U/xqoNuB59vZm5RY05ngfRbUDMvg5F8M4hk1zJS
         HP2sfsDQGtTw/mWuUh4nlq2ahLjkRY1v0sD8ZF2HLNVIvjn3CmxgSKkiqoiaqPS8SHW2
         FFy3aj+YhmP87zIdsIXzkkFVDw79KnlE4iNJYVQzlimDTyV6kbkkSg0GettZI+ulNhfO
         /uSvBFC+EPuu9CxbaJVmO2dCrI4dAItR/v5pt1o/3q3qXZs7kFIEBs20+CCRFjqSJYXZ
         agyGynh9TQ48eELv/kso8Cfb2pkT/b+oIqP92Yvm2rbiICOftUO9Eoa9uPdpw5ryqmPa
         m/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490431; x=1698095231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDXNDAXEYDerEydfkLSexbTOlmVWmitFF6lrfBCh1Bk=;
        b=e477yacQNXIGzl8YiI7n0LY8UuG1QAh9PjxYsn1mo2v+dDBdYqO00GTonsucPC3fcP
         uZtsz3b7hEwWkW7sAgXndqrXXLeW3RhzHJpBCQJiG4PaZDLf9FJPlFuqIDfEEZiCbwsL
         DiWAhGlAxDqkvxYYRWS7rw8GBMZYUjXnFk9wClOfcaKcyvSF4M3P8docPMsdKF2lIoTr
         jrk2ag/5E9jdA7ISbXYQD4eiEksAoUhkotoOVyiYq7VbZjKekTLkUwn3hVUpYWnrD/NE
         l/rqrk8XrRRnnYoUz+3Dvjq4iGNFSG36Qhb/6wi1RTU1A5hzfgCashP7gN2ChOcZjqrR
         a3tA==
X-Gm-Message-State: AOJu0YyWe7ITyiKMr8Fje9KEBCVYkqGQCpSvSDbA3+wJ5CL1P1NeEx3F
        KyrrNNq3CDH3351orXierJLacZlJbH/3FCYmXXwE0Q==
X-Google-Smtp-Source: AGHT+IFsEVZb5/oJi8Szdpyz9UI2xIfNB5TEvS5Zp5Hz7N3qHFUdtQiRkbdpl+JTMgPwpIk8y95fgw==
X-Received: by 2002:a05:600c:4f0d:b0:405:3885:490a with SMTP id l13-20020a05600c4f0d00b004053885490amr260413wmq.0.1697490430860;
        Mon, 16 Oct 2023 14:07:10 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b004063cced50bsm113720wmq.23.2023.10.16.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:07:10 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:07:09 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] cdrom: Add missing blank lines after declarations
Message-ID: <ZS2l/R2cBqhdVNkR@equinox>
References: <20231016204741.1014-1-phil@philpotter.co.uk>
 <20231016204741.1014-2-phil@philpotter.co.uk>
 <68a2a403-ab2c-4932-a12f-1751ff6ccd77@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a2a403-ab2c-4932-a12f-1751ff6ccd77@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 16, 2023 at 02:53:06PM -0600, Jens Axboe wrote:
> On 10/16/23 2:47 PM, Phillip Potter wrote:
> > From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> > 
> > Add missing blank lines after declarations to fix warning found by
> > checkpatch.pl script.
> 
> Let's please not do this. It's fine to run checkpatch on new patches to
> ensure that you don't make mistakes, but this is just useless churn.
> Even worse:
> 
Hi Jens,

So to be clear, I should not accept patches that do cleanup like this
in future unless there are other substantive changes? I also build
tested the patch as per normal.

> > @@ -1202,6 +1204,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
> >  {
> >          int ret;
> >  	tracktype tracks;
> > +
> >  	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
> >  	if (!(cdi->options & CDO_CHECK_TYPE))
> >  		return 0;
> 
> This int ret is using spaces and not a tab, why even make a newline
> change and not sort that out too?
> 

Yes, good point. Given the patch only consisted of new lines though, I
didn't think it a bad one. If this is the policy though, I will be
stricter in future of course.

> But it's all mostly moot as we should not be doing patches like this.
> 
> -- 
> Jens Axboe
> 

Regards,
Phil
