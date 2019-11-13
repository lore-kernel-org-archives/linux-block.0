Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275EEC432C3
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 20:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2837206EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 20:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="SRELxV+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfKMUUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:20:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45921 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKMUUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 15:20:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so741886pgg.12
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2019 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aqnwoLXj4aTU647Trh7ucS8PTcgIl0Nsn6Av0kJcwjU=;
        b=SRELxV+hJy3cKn9ky1WlAPmSkXiUVuyZ3HA+zj2hOaiKezdCfMtP90OE2CtLUkte50
         OoCCZeW6y72v2zaAoDkJPS4dY7RPCB/lju9b206y7fNg2sPKYfXGXtDIVqYSEs051rck
         WDyVGEARhfJeJoZiodN5CcDcOQ1WrxGtbsLyxhKqt3xDlLlzBmtyKhDSZ+0qW3wPM9th
         DIhQ+W2wXuIjNOTPxVwoZUPfFPUpFAIkmWBvghPXLmsqrLrJ/LBjifst3Huvuv9WPBkg
         RS5EJKDQUiyVOcaystJ8szyGUcknSC2Or+iB+OvxqF5qOxtN0P8fESsdfEEleMtQoy2m
         tkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aqnwoLXj4aTU647Trh7ucS8PTcgIl0Nsn6Av0kJcwjU=;
        b=Ug1H/QM97Q9DwKw7RFTlmeIfucZlLycZw/bthIM4m2XmF7p0pXvrGUQHh4NDS8aG6q
         ttPQG2eb4wqNyvNkALqwy3sMaNVwe6Oa9O32/sccyQv7T1ISHt2LsGP6Uw766c1tVoNJ
         o5/Dh3Eg5T9aN1oiPBeXaxLccMB1WotEVCTtoFtwhBmXOn0XlBhZIFxN7kE1ntNwPvms
         F4Xgo16/PZpG2k/1RQNn5excAJj4Pp3wGv4LNxCSWbZGlNRsLDjb0FLfxHbUJ49KRotd
         PeJyZW1owbtBvfeLmAFkABlb2AEmRPJ99U20t6eHGUoxDa4s5HtE9+7N1wFZUWlvqkVe
         FRBg==
X-Gm-Message-State: APjAAAXzS+jMDKMBlE8tP51XKMi7XVkJKiEuF+MNNGkyMJYNf1t1H40M
        Hyfm04Ntn5xYlR9t3thO/PcJaA==
X-Google-Smtp-Source: APXvYqz2u539ews3byk9Wj70c/vBR2nAh5K8Cth6uSnFZo4mZZZUpeEm6IOcwtYxEXfModSJLlaHqA==
X-Received: by 2002:aa7:9f89:: with SMTP id z9mr6795248pfr.123.1573676411224;
        Wed, 13 Nov 2019 12:20:11 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id x25sm3321219pfq.73.2019.11.13.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 12:20:10 -0800 (PST)
Date:   Wed, 13 Nov 2019 12:20:09 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, kernel@collabora.com,
        krisman@collabora.com
Subject: Re: [PATCH blktests v2 0/3] Add --config argument for custom config
 filenames
Message-ID: <20191113202009.GA61960@vader>
References: <20191030222707.10142-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191030222707.10142-1-andrealmeid@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 30, 2019 at 07:27:04PM -0300, André Almeida wrote:
> Instead of just using the default config file, one may also find useful to
> specify which configuration file would like to use without editing the config
> file, like this:
> 
> $ ./check --config=tests_nvme
> ...
> $ ./check -c tests_scsi
> 
> This pull request solves this. This change means to be optional, in the sense
> that the default behavior should not be modified and current setups will not be
> affect by this. To check if this is true, I have done the following test:
> 
> - Print the value of variables $DEVICE_ONLY, $QUICK_RUN, $TIMEOUT,
>   $RUN_ZONED_TESTS, $OUTPUT, $EXCLUDE
>   
> - Run with the following setups:
>     - with a config file in the dir
>     - without a config file in the dir
>     - configuring using command line arguments
> 
> With both original code and with my changes, I validated that the values
> remained the same. Then, I used the argument --config=test_config to check that
> the values of variables are indeed changing.
> 
> This patchset add this feature, update the docs and fix a minor issue with a
> command line argument. Also, I have changed "# shellcheck disable=SC1091" to
> "# shellcheck source=/dev/null", since it seems the proper way to disable this
> check according to shellcheck documentation[1].
> 
> Thanks,
> André
> 
> Changes since v1:
> - Reorder commit, so bug fix comes first
> - Document multiple -c options behavior
> 
> 
> [1] https://github.com/koalaman/shellcheck/wiki/SC1090#exceptions
> 
> This patch is also avaible at GitHub:
> https://github.com/osandov/blktests/pull/56
> 
> André Almeida (3):
>   check: Make "device-only" option a valid option
>   check: Add configuration file option
>   Documentation: Add information about `--config` argument
> 
>  Documentation/running-tests.md |  4 +++-
>  check                          | 30 +++++++++++++++++++++++++-----
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> -- 
> 2.23.0
> 

Thanks, applied! I had to rework it a bit so that command line options
would still take precedence over the configuration file, but it should
work now.
