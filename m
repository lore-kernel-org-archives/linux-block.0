Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF9C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 20:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617802171F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 20:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WynEQvhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfABUcz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:32:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33320 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfABUcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 15:32:55 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so39607924itk.0
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2O0kcjHGnO09HGlUrXXwcY+Fn6d7BmBRrn1AD5iYQw=;
        b=WynEQvhecZPVVrZRfs8Dp03UaPt/edl1Wso4OuZ72ocP9KQaBkjhXhkAtEHbx7nMZG
         LeUstbo0Lm68dGnzm1ClxP+XVbKQe+ORBzZ425gBPlBgRtpTRwO+mq+2SvoDrTB/Uhn0
         e+Bzjg50J26+mxZU6Z73KHN58PTACHY4syStdCHPTtZYfUHYTHpSH+h8S2mpAuo4kZgQ
         rtV5hb6Svg6FaYZIaFdyLYcYafXeqpAjeI6h844UyE3RGRcNNGk5E8hilimHbhw9oXMd
         vT43RiWouErX2FH6svJx0Yvy6oYubfoKQRieglawL4iXEwV2MJJ3cyQAtlT39xSzbSZk
         SDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2O0kcjHGnO09HGlUrXXwcY+Fn6d7BmBRrn1AD5iYQw=;
        b=BZ89LhSV6TjG//7Apnxw3FfJcIZH3z+ZPqhwV8dKeBU8UM4aMJqmliKP/dHzhZDysc
         jEsooQ+UzHCihqZUO0iTl6hN+gIBWX3qkYiFnLJlkfbE5aUkrEMr283EFR8GF8MOoBSd
         AOmJ5ZQrx3RTTJK1YjAEk9VVKWAVq+MPjjr+iEaEDkK+UuqR42JC078Swy8UjJOdDuwr
         YdQwGlNsf54shCS2b5FE4lfIucJDQcBNapmNuxkwmIPdEiEGF8+DEWD82ckAT6UK39Jq
         qW1c+QiyeBruMBSd/4obKAIeO0T4cCayeqZJehhvjDKrbYJaROI0fFOU6qeMCqUzyyEk
         qtQw==
X-Gm-Message-State: AA+aEWap1RJG+81IBX+1gQaUejy5g32qkxcKofmk/tA9v5y/26gvMbJt
        GaqDJsJRZ/U15f8hugUUJabUWA==
X-Google-Smtp-Source: AFSGD/WhLzXxdJ27JxtEqJo/nJf1omQcQdz2srCDX6BdCaPRPdmmwWIZ0LKsBlfD6596D2hRRbfSaw==
X-Received: by 2002:a24:6ac7:: with SMTP id l190mr31465091itc.135.1546461174659;
        Wed, 02 Jan 2019 12:32:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 81sm26138915itz.15.2019.01.02.12.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 12:32:53 -0800 (PST)
Subject: Re: [PATCH 16/22] aio: add support for submission/completion rings
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-17-axboe@kernel.dk>
 <20181227134737.GA24160@infradead.org>
 <91c8d717-37ab-9696-ff41-700f339a1960@kernel.dk>
Message-ID: <ff1d6ba7-e99f-a6e4-e3f8-aacb114befed@kernel.dk>
Date:   Wed, 2 Jan 2019 13:32:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <91c8d717-37ab-9696-ff41-700f339a1960@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/2/19 9:28 AM, Jens Axboe wrote:
>> We'd much rather allocate a file descriptor using anon_inode_getfd
>> and operate on that.  That also means we can just close that fd
>> instead of needing the magic io_destroy, and save all the checks for
>> which kind of FD we operate on.
> 
> I'm not against doing something else for setup, but we still need some
> way of passing in information about what we want. Things like ring
> sizing. The actual rings we could mmap from known offsets if we went the
> anon route. 

OK, so we could go the anon_inode_getfd() route and make it ioctls. Move
the gup stuff to mmap off that inode. I'll try and play with it a bit.

-- 
Jens Axboe

