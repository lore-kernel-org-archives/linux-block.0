Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C700EC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 04:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E93206EE
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 04:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xtL40d0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRENL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:13:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36780 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRENL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 23:13:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so251586pjb.1
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 20:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fbLhmuaqifnlBXcKNoIYBJjaitWTr1hKe+OSHqVS17c=;
        b=xtL40d0wqvO52YpgRiX4RryoeFgllaYUjSR5VlHWKfsvPZ97rM/YE7Ld1deaXCacU+
         iJJQRq1vZD1Agl03eQ9rDbhzdQm1PxqU5WHwEnxiOmpQA3gwc5jCpGPNcEcD41K+vG91
         S2qoa2bGDd9ZO94jX1qC0hS+DvzQ+1pZGNU5QYZkNyZBzs7774Dz9+XcpGwBkDTsjPQG
         xyLWFKsPrdJd6MneiuL60xZBN5gh7SwrMts24AyupvJ46bMwpN5aA4GvSuBth6cMKLqS
         UjjIvvcB8SwQjKV4kwri7mC+jtQWr/GAFJ9s6bnN6a/pI48tdj/jIh37l1ns3dhkkT6v
         raQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbLhmuaqifnlBXcKNoIYBJjaitWTr1hKe+OSHqVS17c=;
        b=NH3E8pQW8U6oSXSafh6Lnefv2cyHru3aeZjwbiECsz1ULU5opNsDKaogx23+37wsR+
         bvqG+b5UoQC8cogmFqdiVf9oZ4WfJ2i8aq2xn9VLOjhVjM4seJC5BQbXFGl4czKoexRJ
         o1DKOqVSCIdkNbjGjFf8j0BVh1Z8bcZ2oXFoLib8GHz2wE6LRO2rr9Um3R4bV0ZRvQsp
         3KBoRqK+trzsVwfmqdNbAinimOz6+IWXT0FZYVIhy72UuNnmqvCEVw0YMLQb/G0rUpz3
         YSNIAVIFLiR8UCjjY35W6tKKt/rxRGeJqJ0eVE4gXUfnOOJWacHurwljKfLg2ChseS2w
         MNtg==
X-Gm-Message-State: APjAAAWOsjtyq+hkIHmMuc2ZMvnCTtUs/lAnoRKbMudNuzvVzaX/a9lU
        2XbZm9+nPhM+o/6dK7Td5n1npw==
X-Google-Smtp-Source: APXvYqztp59AetJ2eo6bjOAKUJTis1B/ue0qtNgQRcPz9TKoTK6QwpNY7QHiJ3/ffsJ0z/mDiPw/ag==
X-Received: by 2002:a17:90a:1992:: with SMTP id 18mr291988pji.46.1576642390132;
        Tue, 17 Dec 2019 20:13:10 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w66sm729645pfw.102.2019.12.17.20.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 20:13:09 -0800 (PST)
Subject: Re: [PATCH liburing] spec: additional Fedora RPM cleanups
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
References: <20191213101640.1180590-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6da4640-9fba-15c8-dee0-6feb48e66f5a@kernel.dk>
Date:   Tue, 17 Dec 2019 21:13:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213101640.1180590-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/19 3:16 AM, Stefan Hajnoczi wrote:
> Cole Robinson made some more suggestions:
> 
>  * Use %set_build_flags before ./configure to get the default compiler
>    flags.
> 
>  * Use '%license COPYING' instead of %doc.
> 
>  * Do not ship the static library.  This is distro policy and Fedora
>    would ship a separate -static package if static libraries are
>    desired.
> 
>  * Source: should be the URL to the sources.  URL: should be the URL of
>    the website or git repo.
> 
>  * The devel package needs
>    Requires: %{name}%{?_isa} = %{version}-%{release}

Applied, thanks.

-- 
Jens Axboe

