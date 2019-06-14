Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0EC31E4C
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A912168B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="gY8OMr7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFNNlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:41:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37598 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfFNNlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:41:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so2473573qtk.4
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZR/EKmu5gWkoNUBhKpXkUDUjfp2N+yxxCefDqkXhc2k=;
        b=gY8OMr7BO35CDdoLUsDArY+W5z7EkRkN8AGq0dhi/gK6t+98bkfUbhJeUYUMBxtq+E
         g/Xqmry39VK37V6HcDuOlZVZdFScnNlI5fO22ZjQAxXKe8UxoQaTYQdYHu9NWssVJh09
         oQKm2CnNGBnYzpdV/hzWHXwBLN0fD60gYqJER5Y1wmA5i+s/1pZ1w5+Vsa+6X/IEpVo4
         4DwFbeGOWDMdnnUzU79UmAhVu8HCPM3pSWNcoxEciJpp2cxbWwhpvdVvy9nHYaBDyDXg
         ApDcHnYRFm/c0Vnxbt/lDNoUai9VByA89l35kZjTMomAM3HeFl5Cckoxu3XJbeh6ZuDO
         dfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZR/EKmu5gWkoNUBhKpXkUDUjfp2N+yxxCefDqkXhc2k=;
        b=BwJQk2MdG1NZ26dAvl0ff6WZ5WlFF1/IHHEZkPWQE1Hm0cMVIDEBMGQDvKEIRDycw3
         ErIv/UBN+AB+PNCVL8NAie3bTkDmqG5IMd4HKimtG3sbJmpSAvR6mW2kqoVG4FmJMYcM
         YOuGQgPF+YWWsgYX92jIvFhDbI6iH3pJkGKgIBffVTl66La5TABjJNo7flpiUT6bLk3O
         n9nSJWC4A940EM5w9Q6bF7veF7r4FPG3eG/TZwZQBPQF4X84LSpCvEGV3LvAYsuDZaFW
         g/g+VcfF4UhgMnrmBuguQH3bpX/+yCRsO2kIennLb64CZw9b+UI63Wm4lADWQe6cMOi7
         CtJA==
X-Gm-Message-State: APjAAAXlM5SqKSCjxf5pU9j1+GBZokCvNgUul0B82PlHIsbrceDPUgFk
        c61mFdxgMSOgbtAvmJbzpJGmeg==
X-Google-Smtp-Source: APXvYqws96+Oa1Yx5sGxA4g4gfNEVNQGDUhXxTBNVV5tp7vpSzt17KeuRr00AjHyuAVlm/HgeGIJRQ==
X-Received: by 2002:ac8:2d19:: with SMTP id n25mr42440329qta.180.1560519680205;
        Fri, 14 Jun 2019 06:41:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id p37sm1685047qtc.35.2019.06.14.06.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:41:19 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:41:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/8] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190614134117.pngediuiim7ktcvi@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-2-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:43PM -0700, Tejun Heo wrote:
> When writeback IOs are bounced through async layers, the IOs should
> only be accounted against the wbc from the original bdi writeback to
> avoid confusing cgroup inode ownership arbitration.  Add
> wbc->no_wbc_acct to allow disabling wbc accounting.  This will be used
> make btfs compression work well with cgroup IO control.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
