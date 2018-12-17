Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53776C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 02:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A622084A
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 02:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZggxcNKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeLQCy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:54:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36635 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeLQCy4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 21:54:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so5606229pfc.3
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 18:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8S6rOrx77lMpWQJfrLYoxOZ3xoShO48Wi6gt5SBjmvs=;
        b=ZggxcNKnnQhgviQ8KFdh2Cij/4Bynd5a2vOYeSHwqO0A+XRc8R7TcHkZtko49QsB5M
         MJpJz4oZucU8Ju74Cf0gtVGL+JP7tGpelTjkXGd7MBVzvs550oxDTnuA253mQvoN8ga2
         G3IxSzeKOPrTXMmzGkWhtBnjJfwVyHk/BBds5B2nARSuFzfHzJO5EV6yEU1dl9pLOjte
         Mj4jFtdIm74TUxSgiwTOZNsdr10PvdPQPgJIX5sQ8JL+DsQJ5rtUyHzfZBJK+h/3m7L9
         xYgE7vsGa9H/DCBQlnUbXAEZbvHhblLv/fD2fj0JpVdNg+Er4LFHXlb8sCl8ROCzAiP2
         qILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8S6rOrx77lMpWQJfrLYoxOZ3xoShO48Wi6gt5SBjmvs=;
        b=ZrpQ2F+iWC9bFg4SNV/3xIpDNHtHheIj+oRdKyQEYTMsJvJu33nqCigqGMTAnYf/7C
         01RKbqxZe33A16sz0xUdbI01ho4193NL147Jxaf4d/UrR/vGOaj5/EcYGuiDVDEg5prU
         1SFKeqEln+Hlu32trrS6fSvMbXzsUq87PSHtdQ42oOIzUOPXhwGo382+jHA3BuaWtfv0
         dZ7edzdtPh+oubPItVCY5jeMPHdkcSsjFpfgHwEl9YgNxA7yyMMKzthjWXsK1vSU7DAX
         zXutoyDQBEM2NdlZ0RQnpvdCZlnvESB9O2ZDK9+EfiRlEZ9bwdfa6H9Vzw9lxsdckqim
         IRxg==
X-Gm-Message-State: AA+aEWYXo7PLg0RjVOIjfTLRMv/QfOOo78PsqUo0QXMr7ZQzmXAWF8jZ
        WuClYHF4zx1wWlKtCQS7f6mHOg==
X-Google-Smtp-Source: AFSGD/UJQJh+1AYcv9z6WpTzHIdhJAO1nCxCgHGueNdhHiIRvLViiYbImth+EcbGj0B39WCONRkHFw==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr10993536pgo.264.1545015295782;
        Sun, 16 Dec 2018 18:54:55 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g65sm52245796pfa.63.2018.12.16.18.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 18:54:54 -0800 (PST)
Subject: Re: [PATCH V2 0/2] block: support debugfs on rq_qos & wbt
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
References: <20181217014601.11823-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d15ea8f0-7925-9e88-4ad0-5013af860356@kernel.dk>
Date:   Sun, 16 Dec 2018 19:54:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217014601.11823-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 6:45 PM, Ming Lei wrote:
> Hi,
> 
> The 1st patch provides debugfs support on rq_qos.
> 
> The 2nd patch exports blk-wbt's internal states via debugfs.
> 
> V2:
> 	- use 'const char *'
> 	- fix one comipile failure in case of !CONFIG_BLK_DEBUG_FS
> 	- don't output 'ns' in several attributes

Applied, thanks Ming.

-- 
Jens Axboe

