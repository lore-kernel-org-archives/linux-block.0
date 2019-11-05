Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516FCC5DF60
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163C9214D8
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S0EGHZnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbfKEPNS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:13:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44155 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389081AbfKEPNS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 10:13:18 -0500
Received: by mail-io1-f67.google.com with SMTP id w12so22995825iol.11
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 07:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lSjuVMFZgm6pD7hbPn9MNdrnAabV5m0l1O2BpSE3Ba8=;
        b=S0EGHZnBX7OVSk/zdyO56SOX740JSe0McMBEf3Wxs940C6hLwN67rEN2/z9IXZnIZB
         0k6sTafjkFWUwzLSh7EQ6eUv6mU3eKZhtAGa8GvbDcb3m11kSlIuSQFpcJKx1PUGGEGA
         zSnuY+mcYQ12UhruRRmMWsRDtWkaq0vWvFOYOJnquW/gnKHCgjU+DmgZ0xRBDzHMmKTi
         IfnJY29ClyHAfRaTzZRAEmGBKEiHcajJYuynd9g+qTs8//xlAkyt7cOPiCEy1OkTfeuu
         L90DgkpkIQEg+I8L2QjcpVVB3QdYfckrTHnOxN2I1vAan3uwRpJI37uIB/mVXBmsLGvn
         l4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lSjuVMFZgm6pD7hbPn9MNdrnAabV5m0l1O2BpSE3Ba8=;
        b=bdbu4KjgbIwyEHFS88ucx49B+IbJQqN0E6HG7JCD68s83JrL/2vzYgoqAipbZEh1WR
         wdJlYpeyubJumGs+VfgDwcLNMVSBLzSXG/vjplS9ESLoOi2xyotPBRgWe6YpB4EbQ1im
         QO5VRCYhzWfFNCieHfWo793VMNc3ITVH+xBnIFlz1xnN7vunbUBfxMt4NV8GcDx8kTCf
         sdfSyvo9N3KmmwIF31Q04I2AS3d2+6UBB3wreVLL3DVXU4QYkQGsREZzQFU5Bdza4ID7
         pA1qGLbHIzJIrsRHohPm9xekIz9jpYWZgmWzM37eYfX3jQawyb3yAKS05jwHqTgs7SS8
         h+/w==
X-Gm-Message-State: APjAAAVGQ/fPpnc1CexAh7nHwvTcKzboj27b0NVEk1nvA9lWYl34VzyC
        mBRYcEFTzqqa0fjdepJb+Bunl7hUs7M=
X-Google-Smtp-Source: APXvYqwQ78Mc/xG/F0SSV2Z8ANsIx1VImI5gIVpqiHWJb8TzjKIICxA+y0UsHex+iNwZmLO3qhrEeA==
X-Received: by 2002:a5e:870c:: with SMTP id y12mr206088ioj.215.1572966796965;
        Tue, 05 Nov 2019 07:13:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p19sm2953939ili.56.2019.11.05.07.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:13:15 -0800 (PST)
Subject: Re: [PATCH liburing v3 0/3] Fedora 31 RPM improvements
To:     Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org
References: <20191105073917.62557-1-stefanha@redhat.com>
 <x494kzibhbh.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a039c944-f282-f9cd-6ddf-6ffb49228f17@kernel.dk>
Date:   Tue, 5 Nov 2019 08:13:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x494kzibhbh.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 6:09 AM, Jeff Moyer wrote:
> Acked-by: Jeff Moyer<jmoyer@redhat.com>

Patch 3 is attributed to you, but not signed off by you. Can
I add your SOB to it?

-- 
Jens Axboe

