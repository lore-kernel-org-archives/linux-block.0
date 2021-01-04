Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6152EC433E6
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D65A20789
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 23:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhADX0l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbhADX0l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 18:26:41 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0FC061793
        for <linux-block@vger.kernel.org>; Mon,  4 Jan 2021 15:26:01 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id x4so15439358vsp.7
        for <linux-block@vger.kernel.org>; Mon, 04 Jan 2021 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dy/ye9TiZq4lJL+DRiv0coXwbLy9CL2mFPnMwzQ1evU=;
        b=xZsX41vdh4MTnX4NEOraHQryWgWAryobfLPE6U7R/raSJ9S7oRBdssxZQgmd5IpNAS
         QJA4vdNG7bpoRfNInzKyE4jg1DCVWuwNdTmfsY6EIU1hh507/FhODmI7C3RLp2B6SbC8
         kMhAFIZFNhAwwG6yeLlEPWet5DKyel3gdK6Srq3oImPNOz65IGuQ1SNIrnvVHfTgFxlC
         5Kc8KX3It0N1lmouPaAEGcW7co7veBTcAn5FXXvrCR5o3s8MCoSwFuwUWGoNpz70LbqA
         2Eaa4bLyQqycca6xom+OXoU1nPnncSYIACVHaJeCG+VH1pdgNoYDIiMPbaQR3xeZtxTX
         jpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dy/ye9TiZq4lJL+DRiv0coXwbLy9CL2mFPnMwzQ1evU=;
        b=Esh+eijHpsL0qi6Qnajt4XuT4B8WjdpfRyypTGHM73CROvDIaBTbVZg5v3LnVGgslU
         /QrYXub4r5tr66lAOVwkGRoO+a7nnPRfC56vQzE/6TJQEsH7ufOeOESZq/r21cPCYKbK
         YCojZ1kqTNbrKXFJXDUQOhcDXW/amNcuC+2O2+ZCxvGJVcDa/2av04P5r+6x/wByal4E
         bhUdG8RhVT0ASJTN2eSPl9Qeo5z4ZwvmAp3VDOQM4rRN0SBo5iIIieBUdL3NN3Py1uME
         STjcJF3GZlurCq4yVwrqME6/hDLWOasdB+qMVSE2fX38xjPwC491aHTzHK0GCvTRwSAS
         o60Q==
X-Gm-Message-State: AOAM530ktQ2Hbke3CEhyW66ETVGHhIav+sUlQnItqmwGP+QK9KCDrgvJ
        O/29tE8I3LdJCa2eMgvsSdU+WvoBEevTkQ==
X-Google-Smtp-Source: ABdhPJwCjZfBylHNuClr2EUiMdnE5kwEKsZt+hJJksptRoDedShViaIIB2BPfNx9h5t5fRVkcLfTkg==
X-Received: by 2002:a17:902:e9d2:b029:db:d4f6:b581 with SMTP id 18-20020a170902e9d2b02900dbd4f6b581mr50833390plk.34.1609800941423;
        Mon, 04 Jan 2021 14:55:41 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a87e])
        by smtp.gmail.com with ESMTPSA id b22sm55965229pfo.163.2021.01.04.14.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:55:40 -0800 (PST)
Date:   Mon, 4 Jan 2021 14:55:39 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] common/rc: confirm pcie hotplug capabilities
Message-ID: <X/Oc6xVfE+ioo9ZD@relinquished.localdomain>
References: <20201125154952.2871261-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125154952.2871261-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 25, 2020 at 07:49:52AM -0800, Keith Busch wrote:
> It turns out some PCIe slots report hotplug surprise but are not hotplug
> capable. Despite the contridiction, the spec seems to allow that.
> 
> The linux pciehp driver needs hotplug capable to bind to the slot, and
> the block/019 test requires hotplug surprise to handle the unannounced
> link-down. Verify both bits in the slot capabilities register are set.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.
