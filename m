Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C38C282CE
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E093A20863
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 12:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ng7dcnqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfEYMhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 08:37:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42274 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfEYMhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 08:37:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id r22so4045897pfh.9
        for <linux-block@vger.kernel.org>; Sat, 25 May 2019 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D9WKL44IZrCsHLcC8RuyO2OF6TnrExBu2BCbGDIrgZk=;
        b=ng7dcnqmA0ESY2Yoq9I7Y39MlfmfoH8r8LAYOT7OGjDKTwneqoaq8lCQQBt8Qd5TRy
         YkC3r66eHvXACQeWb/rRwyA4f0ADc/iX67KTMJf9o4j2f+9WfthfqVyAsjeaxCJWMeja
         S9iZoSGhXe6eYs2IMbgooFlOjOfyA4BjAtbQ/BUEduO/a0Q8nMR2JnWTlYIzbmp6PExt
         OXFg/0GCJ0y1tRUY21zlI/guQMq0m+dKM6x2YmqZgKzUnsDFQxSjZKRnLD4xlVb1olZv
         OZwT9+Uoz6Rp3Ufu5RZzYAOSRkyfrd3P6qdycFXlSJD3L4R07Zl0od1JNzH9BEsHU8IR
         45qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D9WKL44IZrCsHLcC8RuyO2OF6TnrExBu2BCbGDIrgZk=;
        b=Ol88tC7tnfcsqA0sCOSmbEPpU/OzzVPRGgWfVuX2IMMLU3d3OuRm9F0jLJeGZQMh3z
         vHc++NsOS8zDZkieb9UMA2xsTUhFeSyslzO/aWs5PwkwPlXRAiisrww6OfxFvHs3B9jQ
         CAP+ouQtfVdqScl860bS18OWZe5lBezccpnLZ8RY+tjlp/yab6agB6YYVKCpB/QXy3ub
         nHGqCjLcsALnzYafkgYK+yNYTlGdaca4YTDMPt12tnnPO5Y5IZwgkEbuTiDrUJSQEOtt
         +yHl0pG5T68jbEQLXYVbdy6wiU/ftsRWshn7x90gEPM/3dYgX/3woidRo8/lo3P4bULQ
         By3A==
X-Gm-Message-State: APjAAAWNY3Sb6kIZZiS0i7QCFCdLrkENiDAyoPNr9GqqPhwbyK3qFQ+I
        bxSPXOwWMi5sXr9xvROpCUEtsA==
X-Google-Smtp-Source: APXvYqxVO8E5kQApQ6DvJXNKhwzv8WBr5YEqQmsAeYIxURe178NvpamPYVI21o9ANwFU1BAOTQ4kfQ==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr99425303pfa.49.1558787837277;
        Sat, 25 May 2019 05:37:17 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id e66sm6878673pfe.50.2019.05.25.05.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 05:37:15 -0700 (PDT)
Subject: Re: [PATCH liburing 0/2] pkg-config support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
References: <20190525085830.31577-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39f03e48-086b-533f-b233-a722d55437c6@kernel.dk>
Date:   Sat, 25 May 2019 06:37:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525085830.31577-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/19 2:58 AM, Stefan Hajnoczi wrote:
> Patch 1 adds pkg-config support so that applications are not required to
> hardcode compiler flags that may change depending on the distro.
> 
> Patch 2 moves installation paths to ./configure so they are adjustable from the
> command-line and do not require modifying the makefile.  This is necessary so
> Fedora x86_64 can set libdir to /usr/lib64.
> 
> I have tested this by building Aarushi Mehta's QEMU io_uring support
> using pkg-config on a Fedora x86_64 host.

Applied, thanks.

-- 
Jens Axboe

