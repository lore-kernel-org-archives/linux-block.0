Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3780C4360C
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE84321835
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 16:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NjW5at2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfJJQKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:10:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35720 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfJJQKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 12:10:38 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so15044952iop.2
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wrYwrERmDmiKAtUxLx9j9CuwNoEO5b4Xw4QAaiqmT7Q=;
        b=NjW5at2iThys9IVGH/EPJtkNpT9KZzXrCv1dN4rQbs42qB/inJxfMwM0QgosZJ+vAg
         8iqayQIJP9o+xaEenXFCFWim+sjHDpbLKhsZC6v4dDJg0SfSkvqn+Ltkh+qksmvdq0Or
         wzWm/3v5UR9rePfF2tPuom3BivGIsUwmC0jbTc76gZWamCt/FRn3F356H5wS3vzzS10b
         97ijHA035pXkbVPXSmX/jvKhqI7N7iTxOCohp8RsZ5OacbaaAKUFrQPaMJ4QVf8Dx395
         tFxr+vc9GEsE+Xcn9GOzf4RSnp+cudcINRrQfdm0SvLyRLEhNvO95socDCAIe5SAdFmx
         wFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrYwrERmDmiKAtUxLx9j9CuwNoEO5b4Xw4QAaiqmT7Q=;
        b=Mj0DVxjSH6ZT3ZEf0rOvoo0j5fYAq0+emN8D5M0EDzYKgFq9Ge1i0jWkhm+1ZwGGZo
         u8a2306UIHFKah8/weWH82c8wYzXZQhiNIaNKoMSxinZPXnMwR67wc5bCvNxkJ2juF+f
         hV7STpPemzW9YQZntFfo2tr4mP2vB+/nZTUXCQAe14w8d2T8el43YVvppVvsq7QCjE5O
         xvQqvszSLNICYbtmgmI40qayuxOPxBCxOOe96TMFrZSWKIMelXp1D5gIzY879jnl0Tsf
         FPfpxwtUH6zzJoC89nKxO8fg2nCFT2CRakSd2DWjS5ubNm59iglcYPttKXwepWxQ2A0a
         NA1Q==
X-Gm-Message-State: APjAAAWGyx7847Jxy4zOTVXUAkmCwR8pR+EaXUNdxvmGv6nbiMBezE1d
        0OaAjiqpEy5hkqbL6WA/Pb6umlTZUUSW8w==
X-Google-Smtp-Source: APXvYqwj4PAeg1HhfgU7/7lr9mxe06nsgYJ4mqXOqeRPuaLHVQ5hadZNtCfekorqYMFwGVQVuXYCFg==
X-Received: by 2002:a5d:9386:: with SMTP id c6mr1525250iol.269.1570723837040;
        Thu, 10 Oct 2019 09:10:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i4sm3312743iop.6.2019.10.10.09.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:10:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] io_uring: replace s->needs_lock with s->in_async
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <20191009011959.2203-2-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be1be3c7-c8f9-f24d-95d2-cbdb64939c31@kernel.dk>
Date:   Thu, 10 Oct 2019 10:10:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009011959.2203-2-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 7:19 PM, Jackie Liu wrote:
> There is no function change, just to clean up the code, use s->in_async
> to make the code know where it is.

This seems to be a somewhat older code base, as it doesn't have
the changes done post 5.3 (io_rw_done -> kiocb_done, for example).
I hand applied it, thanks.

-- 
Jens Axboe

