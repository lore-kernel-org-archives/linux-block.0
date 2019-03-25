Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D502C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E020820830
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kM1bDTqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfCYQFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:05:50 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51222 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfCYQFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:05:50 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so14799781itl.1
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GUFOU35B7Gwb+O4xskamxpAhcSVh6PbVKYXgEQZRO+Q=;
        b=kM1bDTqX+FdEgontXPPC6ql34nIFdD/piaDRq0c/Cs2rKWiCOhnFJW5Lm5ptAS8SyD
         6Qs4XdfgxFfd3pxNTH/XqahXowd6jHWotlBI67CMaXhVwVl8UY6GFmxevIaCOzO+cjU9
         20TOaUpKyKruMyZDdR6fdGeOkkRfkO2oL4nN0S++VXtUvgUxs4VXmgWb4VrT+QnneYyL
         mxziuRyJqgNr+hAP1/xfh1II/vuMILF8GCi/n0gKg1NW9kvez5xi3ZX3EF3aUdSKTUN/
         01WES8nwQ2jqrtcVhWbZRw9XKxylLbI9RQPyFWwFmuMuaJfeAVmEIPK7WsITLTH35GkM
         jvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GUFOU35B7Gwb+O4xskamxpAhcSVh6PbVKYXgEQZRO+Q=;
        b=VGyYPh1vO+SF/FDMJ7BonffuBRtVULF5IW2ulIAIP86sRgB2VdCT/BoWDWJanXHTPB
         NyIRBwKlNOpaOYGc5jCMTXig+NfNMOK/DkeAf8iVHjsAFzGlAXJVEELUToHxtzvT5+Nt
         yQyYSxrAr9WeQmZxvp3Oyx8+vvUhPreYJdluDwWEOc3aJzBsrBOPwfbo2jSpOyzRuN56
         9QebZkK+zecui7InfzuSQf3nn4IBR3PJj1gkoam/05qgev+aIRfbveVIShdaKYBNiTJ4
         c5fi4Fd7F4p13U9f9pi8AghNhSIbW14LMuWg4Trm4IZ/04wZJcW0pa6wNA5s8+xnARtM
         a9fw==
X-Gm-Message-State: APjAAAUy/VZXRS2PqlUVI1E549ry4dK4C2g02CGhfCX2WXpN7QHgKhmn
        oZYQx/3z0ooFvJioCI+zEGEJrg==
X-Google-Smtp-Source: APXvYqxS56INjeKLDTNRuTu+ckQ00rmslbDoij1E90Td+4AqDD384cKRSx3Nevu0YXARPVl4BcYAjw==
X-Received: by 2002:a02:b55d:: with SMTP id z29mr18751043jaj.49.1553529949326;
        Mon, 25 Mar 2019 09:05:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s124sm5911042itb.42.2019.03.25.09.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:05:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190325143521.34928-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a29338b9-60ad-a4da-da9d-a0c522a5b9df@kernel.dk>
Date:   Mon, 25 Mar 2019 10:05:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325143521.34928-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 8:34 AM, Arnd Bergmann wrote:
> On big-endian architectures, the signal masks are differnet
> between 32-bit and 64-bit tasks, so we have to use a different
> function for reading them from user space.
> 
> io_cqring_wait() initially got this wrong, and always interprets
> this as a native structure. This is ok on x86 and most arm64,
> but not on s390, ppc64be, mips64be, sparc64 and parisc.

Thanks Arnd, applied.

Was there a 2/2 patch? I only received this one, 1/2.

-- 
Jens Axboe

