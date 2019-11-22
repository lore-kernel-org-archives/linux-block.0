Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE48C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76542071C
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 18:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/Agl4II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKVS5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:57:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40436 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfKVS5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 13:57:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep1so3405832pjb.7
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 10:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vD+kTqNKNFaJHHlnS5aCOrni7KxxMunXRiver5To2T0=;
        b=g/Agl4II1MX+BTTCUS+ZZ4/rAMJxc9T3/gbAxCPvdkQ9nefWpWsM6/QnJE0rpovvat
         7hON3Yt/r0+/LsKce0ErN0oI6JTIDYsNLwRC0D2lIWV51VozpVdXuNXNpOz8hhdp/I2g
         YuXzTGI+pXJpxUPwt77bXdlEESJwTNClpLIY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vD+kTqNKNFaJHHlnS5aCOrni7KxxMunXRiver5To2T0=;
        b=oQC7hv353U1DE8sVWmUKKxpeTtEoeDOcKBv+TkxZA3OHfYIt3ce/WODiX1gY+QMWlW
         a8b7z/FLO4lllfWqF4t2kPcEUYeq2EKP/1Zc/JU64hlwRDepg8aQgI2dSxGyH8HpuCSc
         2TtKJKsjBF3T+6OwkEKfOIy22cCtr+E2O/oJoPwPRVNwLbmZFITLNEN7Q4JwPceHV/ci
         liBFPh5igFNWEYfmiTMHOPlLzyKHUm79kTFtpeYzBhDpzQvx5c6Or1hcLIVdsgIlvxbD
         M0gCunYcRI2VknUsVnnAE+PiWuwwklHT6C78WEs2E9F9SxUqGPzrcDqajpMAx0qdNCOd
         xSug==
X-Gm-Message-State: APjAAAW6HdPjfj+Vz4I/10nTg7L69ez8YTkOcKYZ5P8e6dx7HOhCZ0UV
        9EB6wnmq8vxFB2sc++FgaYLRgKJyUqw=
X-Google-Smtp-Source: APXvYqy4i51ZomUDiUmgqotvybJkRWcwGT2mjCe9qNMep2IAr0W6vYTafi4bgH/WkbxpKRz1qvkfOg==
X-Received: by 2002:a17:90a:b385:: with SMTP id e5mr21272476pjr.115.1574449073600;
        Fri, 22 Nov 2019 10:57:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm7986059pfo.71.2019.11.22.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:57:52 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:57:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <201911221057.2B0E5696C@keescook>
References: <20180824211535.GA22251@beast>
 <201911221052.0FDE1A1@keescook>
 <181810c8-657d-d603-a833-215f753be5be@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181810c8-657d-d603-a833-215f753be5be@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 11:55:11AM -0700, Jens Axboe wrote:
> On 11/22/19 11:53 AM, Kees Cook wrote:
> > Friendly ping! I keep tripping over this. Can this please get applied so
> > we can silence syzbot and avoid needless WARNs? :)
> 
> I'll get it applied, I did see syzbot complain about this again.

Awesome; thanks! :)

-- 
Kees Cook
