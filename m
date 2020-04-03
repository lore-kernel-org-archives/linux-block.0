Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04456C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF0F206CC
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="QsMz4m68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgDCSUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:20:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38484 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgDCSUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 14:20:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id c21so3897098pfo.5
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2020 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XF3ZeZOL2t4oYgjRhd4eSSx4KcdfxIn9+yJDlDGw2BQ=;
        b=QsMz4m68wIn7Y7QO7/rav1KKtdHf5+17Zfx/q3sgIQ0OGXkey0fkelLMNtjJUJuXpd
         3/2T5Md2PWICAT8gJ4GOyWgj3FiLUjZAQZH+TEUsDPW3pd7RriJvV/BSYB/NaxPydI6Z
         nBWNvy09CYA3XXF25T/TWkVVuSHjkhL95IzmiXKzEMLR4y4ddEt0W8BqB/tNRz8fho3G
         JWC8A/YFOd2u3yRnHLkmuFOrbo5aGrsA+1wRo5MtBDgu8ljG1N7K7qEYgSioz5VMuPFZ
         +otVk+q9z9t93ThrAAyLhfXk4JNqy/JOcXmSUvR2oTd5DAJVtVTO4I07yoMnTf/iBMTn
         476A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XF3ZeZOL2t4oYgjRhd4eSSx4KcdfxIn9+yJDlDGw2BQ=;
        b=OU67EM4nZQ14wdaZNGDbH5xVgXc7jILvkL33YuhHxWi1EQ/MvfQghL/ZlXiZuH+6Rz
         ozT04oI0p7BoDDz7fOZkB5312uHO63nD8C3rHw4lpC4I/4yS7sNbAAkZGKWP8xM62wWM
         zzH+3mfq/+qkyTX19hhEvRbuWvfVdsAETtf5DdbD2ASjvo3VEgZXjC0X5fTCb25S0wc+
         YsrnzxX7SlLf3MeO8279f7NUdRX8GEti6s2M3AruqZjP4AQgAMQU75wACNa9aD0O+Qz4
         oCWt/MD4LqVAkbjGrJ2BUUm8EjsUbLLoMm/WbDbR8mIH46O3mrMCYrYATF2IbrznY4l0
         0mpA==
X-Gm-Message-State: AGi0PubUd6Yw44t8z18dqce4A33jtp7sKYGdbr2AIaMq1aOwsHTM7jkH
        J3pcubvu2FOTnOeufGDJ612ZPO3OduI=
X-Google-Smtp-Source: APiQypK/y0OsVUvuSX4AUW5fy9cmo9NPMc7YEvic5Won+uu0TgePQxJW3Z3S7S4hFBmoJ7eucG2R/A==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr9680021pgd.417.1585938040189;
        Fri, 03 Apr 2020 11:20:40 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:30ea])
        by smtp.gmail.com with ESMTPSA id v185sm6191084pfv.32.2020.04.03.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:20:39 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:20:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Klaus Birkelund Jensen <its@irrelevant.dk>
Cc:     Klaus Jensen <k.jensen@samsung.com>, linux-block@vger.kernel.org,
        osandov@fb.com
Subject: Re: [PATCH blktests] common/fio: do not use norandommap with verify
Message-ID: <20200403182036.GB189126@vader>
References: <CGME20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81@eucas1p2.samsung.com>
 <20200130084941.60943-1-k.jensen@samsung.com>
 <20200203214320.GB1025074@vader>
 <20200402112458.bpcadafgkqf6eq6j@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402112458.bpcadafgkqf6eq6j@apples.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 02, 2020 at 01:25:09PM +0200, Klaus Birkelund Jensen wrote:
> On Feb  3 13:43, Omar Sandoval wrote:
> > On Thu, Jan 30, 2020 at 09:49:41AM +0100, Klaus Jensen wrote:
> > > As per the fio documentation, using norandommap with an async I/O engine
> > > and I/O depth > 1, can cause verification errors.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Good catch, applied. Thanks!
> 
> Hi Omar,
> 
> Looks like this got lost somewhere?

You're right, not sure what happened there. Applied and pushed this
time.
