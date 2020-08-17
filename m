Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD7C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313A620772
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 07:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX/IqmDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHQH5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgHQH5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 03:57:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C673C061388;
        Mon, 17 Aug 2020 00:57:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so7838406pfb.6;
        Mon, 17 Aug 2020 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgcMEmFz5a7sMCTpSzKDmtRdo2JPO50vEmzZ5iT3c5k=;
        b=eX/IqmDgBKGkWhzJxWQru9Re5WUxDkYOOsxDFIY4SDAUKS+qA86iTJZZyjGKHfpDeM
         Q1gQyQxKZXZq7ZnW/rMG2BbQ5eNZ1LmrifcBbG4wwgdbDTZWPBXO8tjhKF6YDhtR71dr
         imypRoL2U9ri9esTtELWOWVSh28wV/JYzGam1CcNZHfpI0+DqO3pxOFXTc4uHQcAb0gF
         69okLt6klykESSxmvVFW1KWlw3ON6FrLXN7xeKT4iaxLIHe5sMiX+P0+HbtrGlczRkQa
         cwmUqgcMNbHSgwk7v1qCLQebZzoIJTtsoNmtq9r78fvh9imeuwgxR1PJynrU9N1Hf0s6
         ew6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgcMEmFz5a7sMCTpSzKDmtRdo2JPO50vEmzZ5iT3c5k=;
        b=BDDlU2CA3ngfi1MUWUNQ9Z9YpDNOgyLFzOM1COajVhEA3Cxk9qGhxbhZY06ckxHlqH
         jP92S6LNwmt0xJkJfc8z2/FfAZSvyVziDwrABHPJ+xMxNvrYQgAYc6OjfRDrfN5Zogs9
         +Kib4tMuZiiNBMqbEQUvTTyRRHBUz0Bl67N6wU+Eq4cdS3RLkW9xaX4pz1Rv4DCIu2ax
         iYi5RxEGhR7oEYE6bXowKYrrCEnJf8ahM3PPd8nZKlGJyw2aszcSMPz0s6Hrj4Dbf7t3
         922DOM1fEk0b6l1soh0iC6M6DEuucLGSPVP+O6i7zQl6jLd2QWxIaEfE/esptIIX6Ivm
         6CEw==
X-Gm-Message-State: AOAM530p6SjiHVRjwOzMMVgClmyWPKPq6OPehyPCP0TrURralsQoL6FI
        BcDehcUDzLk/jk13/ktqDhY=
X-Google-Smtp-Source: ABdhPJxTKNYKpwRNVQy4HgazCr7RIuZmqPyOs2Iv08vRbbmKGVHfnwGU1eMmIpFh7U8yktusCBM3KQ==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr9312090pga.142.1597651059515;
        Mon, 17 Aug 2020 00:57:39 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id r186sm19781628pfr.162.2020.08.17.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 00:57:38 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:25:56 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] block: use generic power management
Message-ID: <20200817075530.GF5869@gmail.com>
References: <ea5881cdfd4d612193feed646ce89f253a36db69.camel@wdc.com>
 <20200722083335.50068-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722083335.50068-1-vaibhavgupta40@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 02:03:32PM +0530, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to upgrade power management in block
> drivers. This has been done by upgrading .suspend() and .resume() callbacks.
> 
> The upgrade makes sure that the involvement of PCI Core does not change the
> order of operations executed in a driver. Thus, does not change its behavior.
> 
> In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
> helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
> pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
> their job.
> 
> The conversion requires the removal of those function calls, change the
> callbacks' definition accordingly and make use of dev_pm_ops structure.
> 
> All patches are compile-tested only.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> v3: v2 needed some changes in commit messages.
> 
> Vaibhav Gupta (3):
>   mtip32xx: use generic power management
>   rsxx: use generic power management
>   skd: use generic power management
> 
>  drivers/block/mtip32xx/mtip32xx.c | 54 +++++++------------------------
>  drivers/block/rsxx/core.c         |  9 ++++--
>  drivers/block/skd_main.c          | 30 +++++------------
>  3 files changed, 27 insertions(+), 66 deletions(-)
> 
> -- 
> 2.27.0
> 
