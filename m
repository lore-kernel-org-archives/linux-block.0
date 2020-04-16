Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8896AC2BA2B
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E6022201
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="mj6s/bLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDPVob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgDPVoa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4786C061A0C
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 14:44:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so118453pll.8
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OryLINgas7uJoJtq7jDznffnst/7LZQHIeD/alxLwSk=;
        b=mj6s/bLHtFotH/1T8+9oW4x4gflXbb43SQtKcWLsfiKP0Lui14K87A5/eRjXA0WsLQ
         GPhXkxs9ttviVTihP//w82eLWdwGTEa/Sj/AkJN7TEeCMKqYCKqcytw3yRBOXY3dKg8J
         jvagsUjw+bSTOL+INIR14a/vrHZH3X7QYCl4kkDTy7lkGc2letPOTDdJWgqPt41cONrs
         qMxSWTvFZiLCvFfwtX7AraZvg9ReRi3/qEUBiAZxnVSDDHj97K8zyZoVbq1wJsG4OQpN
         5gHdhyocl6wHNYDPWho4FqxMRj5GvAXPq0ZwXu3sBbrQcvwo7W+zbo8cIAJxWx480xW8
         iZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OryLINgas7uJoJtq7jDznffnst/7LZQHIeD/alxLwSk=;
        b=Y+eha1esfYDQr4lHtUhRKXc2DCoV1NQfruI7CMxktdfcRE3VNTjETv1CQ5/CfTECYU
         P3N3OwVn6VDVZunudYf5Raa6T9EpUYdr8q1as+GI/PjgRooFkx1YaeOTJp9EJKLB43gQ
         diyIc7IWjKQdi5lrutZGosJagU052K6aQazHZMjcmmJU8AQO5cYWothoJ/6WPFkDXzfE
         Ok3MQl4CcB4yy4TIiWGBvTre+TvogsTaipO78uRDaWm31G2Th2IthzmQ+czYz5v2FJX1
         fDOFlQ9GPLIQkzQt8NNJsSs81W9iD144TpfmKB6t5USBGSQ0oPB9OXZapOdsX9aEKtTK
         Dbog==
X-Gm-Message-State: AGi0PuaUgMi8H7HAM8BR5tKuiFqS1uVe+AUR13NMgbV40UWaeAxWGN2d
        BH9X8woABAba5IZZPlXQUa2Pcg==
X-Google-Smtp-Source: APiQypLhzuinkTaLQHw7N+zDRG04t/5ZTehLIbQYOaLAYwzLRnCbSi4AbrXfUMBuEZBu2q8ljpCXvg==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr297927plb.148.1587073470074;
        Thu, 16 Apr 2020 14:44:30 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id z63sm17589247pfb.20.2020.04.16.14.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:44:29 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:44:28 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Fix unintended skipping of tests
Message-ID: <20200416214428.GD701157@vader>
References: <20200414221151.449946-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414221151.449946-1-its@irrelevant.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 15, 2020 at 12:11:51AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
> handful of tests in the block group.
> 
> For example, block/005 uses _test_dev_is_rotational to check if the
> device is rotational and uses the result to size up the fio run. As a
> side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
> commit cd11d001fe86) causes the test to print out a "[not run]" even
> through the test actually ran successfully.

Oof, I thought I checked for this sort of thing, but clearly I missed
this one. It might be better to rename the existing helpers _require_foo
(e.g., _require_test_dev_is_rotational), and have the variant without
the _require whenever it's needed. Would you mind writing a patch for
that?

Thanks,
Omar
