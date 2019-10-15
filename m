Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C2ECE59D
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81382084B
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="GUKi1g8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbfJOXVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:21:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43814 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfJOXVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 19:21:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so13058789pgl.10
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGCX5o7m6p3J1t9y4lcDR7dD/WPgHW+LCnwIRETuDZs=;
        b=GUKi1g8n57ATnmtPHMHxGH1Hbry2CRgXVCwsqItQXIJZ/OhN2sqYzWefpcXDIqw4b2
         rntCR2TKnpgrQYDruDBXmnvZQ9tqVBBK+NJLHTOUNdHySF8W4JP5c2TeixLgoB52FFDe
         PXdIpuQP84cLTxPQkL6+fM77fRf8/Q8ibnI/jWi+rW5N8A3PMHplMZ73aASoqrgKXPLB
         3xB82thKa8Kv90EJbJ355Zj3ZDghgjDN7L0l5yWu8WXsy3T6EBBhwk04yEC0+m3SKsEv
         Xe27nCGy8iDZtpAG41U9JxvlOmAHOf1n2R0ODBfOFxsPP8HfCCIFMe+Rdl5qEG0f2JJI
         eO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGCX5o7m6p3J1t9y4lcDR7dD/WPgHW+LCnwIRETuDZs=;
        b=iaoU+CoUl/FX0IVjwR5u9cfmXpykNan2R0iV787z33X+CyIMGaviAQ1wITCXeSHcUX
         A7BgNxeFxTr4nvmis16WOfl6L/Hl0xu6MSvRHr4+R13guogLao7VKianjAg/BpPbiqZI
         iXTBeRvYzahnkXoqKyqrYvV9hF5T7fFqif29LS9Bd6rbQDV3OOeITxSdVc3C95ZUKhcm
         Tq3kTukrjPXHs8dSEkusAW40/NXOw3ozb35b6GbTnSo1v2fjGdxBFe0Ib3Nj/iPWiZPh
         79nio3GUra2OfMYPODu7R+LVIPr6qyIlTxufeaWh65EVRNuxn683JJVH6uDyewZfVl5c
         RvLQ==
X-Gm-Message-State: APjAAAWvUj4sWcCtrZ1gqVZ0AbQ3KucFQoqt7+JXapj/2a/uucz7TFPU
        mr0ZixYfrRGrpjsd7jqRMolnEg==
X-Google-Smtp-Source: APXvYqyM+vMNTNWTdFlEdpQGTwp/8bzfCBTb+/2zQ0Uh0pyy2/2kIQzeZFyKpyOzvr9VXF2PHvgTrw==
X-Received: by 2002:a17:90a:db12:: with SMTP id g18mr1229643pjv.32.1571181705618;
        Tue, 15 Oct 2019 16:21:45 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id p190sm27521832pfb.160.2019.10.15.16.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 16:21:44 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:21:44 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com,
        ming.lei@redhat.com
Subject: Re: [PATCH V3 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Message-ID: <20191015232144.GB483958@vader>
References: <20190911085343.32355-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911085343.32355-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 11, 2019 at 04:53:43PM +0800, Yi Zhang wrote:
> Add one test to cover NVMe SSD rescan/reset/remove operation during
> IO, the steps found several issues during my previous testing, check
> them here:
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> 
> ---
> 
> changes from v2:
>  - add check_sysfs function for rescan/reset/remove operation
>  - declare all local variables at the start
>  - alignment fix
>  - add udevadm settle
>  - change to QUICK=1
> changes from v1:
>  - add variable for "/sys/bus/pci/devices/${pdev}"
>  - add kill $!; wait; for background fio
>  - add rescan/reset/remove sysfs node check
>  - add loop checking for nvme reinitialized

Looks like I don't have the remove attribute, either. I made the check
less strict and folded the check_sysfs function into test().
