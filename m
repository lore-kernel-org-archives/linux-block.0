Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80617CA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501D9218BA
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S55ZBFGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDOHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:07:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40714 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDOHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 09:07:03 -0500
Received: by mail-io1-f65.google.com with SMTP id p6so18536420iod.7
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pAdyc+2ZHTphCpX/I5PaO1scsGv1OveQdawA4MGnLXI=;
        b=S55ZBFGwJzbCQUQQfJQOPoK4egNhV0DlIvASZEnuoUWRUM/B9EMxrUU5Dxy8+PHkrf
         qMlR4SwFyMP6MbXEB50PW+EsXdJwpwpJAQY/r1xNw95wnq7QC/K1EvRqnKtbjN95BFAZ
         fUyU0mwTh0AwspFT0cpdLWyzYHzmcllnR6lURkLmhCstUHikUR1rnEt07tZlwUyUMSoo
         PWFkJuGj7vmUnVGiPB061jwwGGzjLKlToJD0JYBo22qgZRqAUjC98Vg7my0uxVh7kmv7
         9hQ6LPrj1A/fep1vfNhHEleBcl6pZoBKX91hFhoOq2971czOcy2S22We89c57o0PyOkv
         L9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pAdyc+2ZHTphCpX/I5PaO1scsGv1OveQdawA4MGnLXI=;
        b=eTtrq2k5CT7JQpBsBi2zDFzln5YBA6u2KMr159VOiRRBpryyY21KXop8zSQ8ht/szx
         iDxF8yrNCk6kP32PR+tXl0JXZ03skEzR031458ZaRbWmKh/pqGXufKhFhFLfnvJ1H0Jz
         T5jFeLLaIGQzXFmIapslmz97gEzAYosqFxd4sClqlvYRMGXin1VhdFkjmozOdyoVMdaw
         GhFtEahggmzuLaVTRxsPYaUChkukka5uzHul0oPabv42iuugmUYhPjrotKnqMdgoUSny
         M1Hy/oblnPH6si6X6XIyV5+/ODTSJ7K3qizlO72wayB8N6ep00VDCx/YppPlWOReOU+L
         so5g==
X-Gm-Message-State: APjAAAUFVizAVrit9GHISSJiWAA0V1YsXxkWIf3LnEdwGbzIGQODJwlZ
        fuzYzZAfYQ3rSNciljO/wveUlw==
X-Google-Smtp-Source: APXvYqxDMPLWveYYUSQi1IVguvU2t8V+/z76VitMMbwxzDMqXzRdmescjt1vkfd5wwP8JXtf/WNQmQ==
X-Received: by 2002:a5e:c010:: with SMTP id u16mr15243968iol.275.1572876422722;
        Mon, 04 Nov 2019 06:07:02 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b18sm1520604ioj.28.2019.11.04.06.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:07:01 -0800 (PST)
Subject: Re: [PATCH liburing 3/3] spec: Fedora RPM cleanups
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20191104120532.32839-1-stefanha@redhat.com>
 <20191104120532.32839-4-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91fbe88c-5574-847e-12f0-992710bbb544@kernel.dk>
Date:   Mon, 4 Nov 2019 07:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104120532.32839-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 5:05 AM, Stefan Hajnoczi wrote:
> From: Jeff Moyer <jmoyer@redhat.com>
> 
> Cole Robinson and Fabio Valenti made a number of suggestions for the
> .spec file:
> https://bugzilla.redhat.com/show_bug.cgi?id=1766157
> 
>   * Release should be Release: 1%{?dist} so the .fcXX bits get appended to the version string
>   * Source: should be a pointer to the upstream URL that hosts the release. In this case I think it should be https://github.com/axboe/liburing/archive/%{name}-%{version}.tar.gz#%{name}-%{name}-%{version}.tar.gz, the ending weirdness is due to github renaming the archive strangely. You might need to pass '-n %{name}-%{name}-%{version}' to %setup/%autosetup to tell it what the extracted archive name is
>   * The %defattr lines should be removed: https://pagure.io/packaging-committee/issue/77
>   * The Group: lines should be removed
>   * All the BuildRoot and RPM_BUILD_ROOT lines should be removed. %clean should be removed
>   * The ./configure line should be replaced with just %configure
>   * The 'make' call should be %make_build
>   * The 'make install' call should be %make_install
>   * The %pre and %post sections can be entirely removed, ldconfig is done automatically: https://fedoraproject.org/wiki/Changes/Removing_ldconfig_scriptlets
>   * The devel package 'Requires: liburing' should instead be: Requires: %{name} = %{version}-%{release}
>   * The devel package should also have Requires: pkgconfig
>   * I think all the %attr usage can be entirely removed, unless they are doing something that the build system isn't doing.
>   * The Provides: liburing.so.1 shouldn't be necessary, I'm pretty sure RPM automatically adds annotations like this
>   * Replace %setup with %autosetup, which will automatically apply any listed Patch: in the spec if anything is backported in the future. It's a small maintenace optimization
> 
> These changes work on Fedora 31 and openSUSE Leap 15.1.  Therefore they
> are likely to work on other rpm-based distributions too.

This looks like a spec file changelog. Nothing wrong with that, but it
should be no wider than 72 characters to avoid making git log look like
a mess. Normally I'd just fix that up, but another comment below.

> -URL: http://git.kernel.dk/cgit/liburing/
> +URL: http://brick.kernel.dk/snaps/%{name}-%{version}.tar.gz
> +BuildRequires: gcc

I enabled snapshots in cgit, so maybe we can just point at those?
Something like:

URL: https://git.kernel.dk/cgit/liburing/snapshot/%{name}-%{version}.tar.gz

Yes, and there's also https now, finally got that enabled on kernel.dk
after running that site for more than two decades.

>   %changelog
> +* Thu Oct 31 2019 Jeff Moyer <jmoyer@redhat.com> - 0.2-1
> +- Initial fedora package.
> +

Maybe keep this distro agnostic?

-- 
Jens Axboe

