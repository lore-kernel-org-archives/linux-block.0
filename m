Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84572C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BE161A17
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhCYMdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCYMdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 08:33:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1122C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 05:33:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q5so1892373pfh.10
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KktxKyKGelQgcFPIDO5e1S/J3rfhBJ49hV8MaJBU4dk=;
        b=rWEIbq+++v1UuZrd75mrg1rmM+nvqDsfDOn2UKyVzY0XZGG7oRPKUQjiD8KOh3nw3z
         P1Gr1L/K7L7sk4ESPJ5XW5OYXJfXLNRe6vpw00a8HKpEkHLnU1q1LEAdkMrSJw+IYo3h
         NFLVq4bC5rigCjyE8+k1Z5/vBG8k9065Nb6qAF9FiL7ftor8PWuySMUgyPOTDG6z+fD1
         KlmdKEGPu8IHpVXOUKZXxT7JUD6K6IDDwmvhO/kghTvBjArl2UAeTEj+sPMGmUk8jZgM
         qqtQatiE8ZFE3FWcUpxqFetkxziDMWVAak9gcUtYUIG0rn5f8b73F+bMc/piG3/4ZBc1
         Rl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KktxKyKGelQgcFPIDO5e1S/J3rfhBJ49hV8MaJBU4dk=;
        b=Wje5PICx/WN6KTsNVq4Cge3GBWkH/Y7S8c6Ql7QH3yVfhszRHmDv5LhR7me5dBktiY
         AWzEnlAbkTls8/BcXl4qKZDrcs+UB/WYIirwohvpPjH1CxnyBYqGONQ91M98OvTGaTDD
         pK3/Z2c83AeORk5Ofr+IfGHfrD6nksK1QILdbMEOKy+0bPojRckFJhpkEj7Jav+q0EYE
         33NY/cKddDE/liVy8W/LTHTW46TsMJE9SLv7rXbeIIY5p2tvNazjLJQPUOOKKm7wzU4M
         BAmmMNiEwHGOJ9NdlsaUuLnHWTsEYVevdswrBcM2vfHZO2zLh9Y070dtWj48xc9vZWyg
         EGoA==
X-Gm-Message-State: AOAM533twlcHbOgdPvPWltOi6DYn/dQoaSFCtcVerERjjSnneY8u9YK+
        QGNw1nnHH3b9395AfFBPAvM=
X-Google-Smtp-Source: ABdhPJyc15D3EFn6gprEFDfqD/4hhRaU92zL/wilIwXfEsQZ+kkBiBNoig6lvtUuPDqyFUmm7roqYQ==
X-Received: by 2002:a17:902:8685:b029:e6:5ff6:f7df with SMTP id g5-20020a1709028685b02900e65ff6f7dfmr9426404plo.40.1616675611172;
        Thu, 25 Mar 2021 05:33:31 -0700 (PDT)
Received: from localhost ([58.127.46.74])
        by smtp.gmail.com with ESMTPSA id d11sm6388387pfd.43.2021.03.25.05.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 05:33:30 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:33:29 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325123329.GA3850@localhost>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFyBM1qq+AmYQvdl@x1-carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFyBM1qq+AmYQvdl@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-03-25 12:25:24, Niklas Cassel wrote:
> On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> > From: Javier González <javier.gonz@samsung.com>
> > 
> > Create a char device per NVMe namespace. This char device is always
> > initialized, independently of whether the features implemented by the
> > device are supported by the kernel. User-space can therefore always
> > issue IOCTLs to the NVMe driver using the char device.
> > 
> > The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> > scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> > for multipath will follow.
> 
> Do we perhaps want to put these new character devices inside a subdir?
> e.g. /dev/nvme/nvme-generic-XcYnZ ?
> 
> Otherwise it feels like doing such a simple thing as ls -al /dev/nvme*
> will show a lot of devices because of these new specialized char devices.

Good point.  If we have thousands of namespaces, it will create 2 times
of the blkdevs.  I would hear what maintainers say about this :)

FYI: new version has been posted with V1 by re-create this series with
Javier.  Please have a discuss there:

    https://lore.kernel.org/linux-nvme/20210325123048.94784-1-minwoo.im.dev@gmail.com/T/#u

Thanks!

> 
> 
> Kind regards,
> Niklas
