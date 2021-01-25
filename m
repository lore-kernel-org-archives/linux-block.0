Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B5C433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942AD2067B
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhAYSqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbhAYSqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 13:46:09 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B9CC061573
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:45:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so8201011plr.9
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNSUf+1zQH7Gb9CW24gntEAO1TIhL5fiTlJD9nXzmD0=;
        b=IrcM+urqitTP2zvIteu0JcZDpfhw+3IZA2nICpT/bvktfxMtT14kcKU+/73FeT8E08
         HSmfP7oTJA5ivZgNG+XF4TV2Mp52PPVxaZ0jsZ3p1cDl+SVCGqBCGVMRSzYTtm2HMQdY
         QrdUIuM9I0x1YCutZpMnFeVPplrBp1dddUTuuQLnnPVrJ54Pv0ZhDepwl6FNghgjdlyg
         8e7Zx4vSY1lKeEDjqVNYcya5mg93scmPfBTjkVSG3F+aDZZTdCKWqjrITdOWUeWf6xLW
         vPO3G0wyLX6KKvEe16PNe7Rir2LYJcc+MzfsPfS8bSKbYLYxzlJjMgOY6k3ChS9+NjQK
         xlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNSUf+1zQH7Gb9CW24gntEAO1TIhL5fiTlJD9nXzmD0=;
        b=NB7y3MWtkPlZ0AXbd+69a0iceMhDFi+JW3z/w6nzECLDb8CTYpRfa7QELLmMzug046
         SCf08mTSqfa7W5w6a7smJbTdQKpO/D1IFZEWQ6gzhfZcz5sHFWKlW9vK+y/MDj91ZC1w
         kvcJjgyc4B5wWLiIxYDGOTKWcgK3HJkZ8cDhJWx1LuKcstlk8WF4j8pXr4scOGv7sgSK
         Q50/45FP3DzhsSWGfTNqb0IQZjW8eBrKq6rQFe7mH2LAoSfPKqeeVCHtVv9Vz8FoFhTn
         urndd5W0/MiaGX+aaNHpz+tUvXyWr0zNof2y7Zqx2nZyBA5mDsZ8nLiY4DAEnG/DVZqY
         1BWg==
X-Gm-Message-State: AOAM533GeMLgv/JCMy0iLActt8GLJh0b/8F3r7NAVfOfbGqqgR9lPw86
        dgYBYyO4z7E+mkohR7cY+NeeQA==
X-Google-Smtp-Source: ABdhPJxZfWfeeDN2Cu2LoI10QoUms2vkVcJrkiyo3YRVaVghtezGKR38Cp5xV1iHCWYlHhpWz5T1+Q==
X-Received: by 2002:a17:90b:3751:: with SMTP id ne17mr1656688pjb.174.1611600325792;
        Mon, 25 Jan 2021 10:45:25 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::703])
        by smtp.gmail.com with ESMTPSA id c11sm15803972pfl.185.2021.01.25.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:45:24 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:45:23 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     osandov@fb.com, bvanassche@acm.org, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] nvmeof-mp/rc: fix nvmeof-mp failure when
 NVME_TARGET_PASSTHRU enabled
Message-ID: <YA8Rw4MGrg0P8hZ/@relinquished.localdomain>
References: <20210124052644.6925-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124052644.6925-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 24, 2021 at 01:26:44PM +0800, Yi Zhang wrote:
> $ ./check nvmeof-mp/001
> nvmeof-mp/001 (Log in and log out)                           [passed]
>     runtime  0.400s  ...  0.457s
> rmdir: failed to remove 'subsystems/nvme-test/passthru/admin_timeout': Not a directory
> rmdir: failed to remove 'subsystems/nvme-test/passthru/device_path': Not a directory
> rmdir: failed to remove 'subsystems/nvme-test/passthru/enable': Not a directory
> rmdir: failed to remove 'subsystems/nvme-test/passthru/io_timeout': Not a directory
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks, applied.
