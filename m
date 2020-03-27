Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62291C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2393520748
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tFubIApj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0Pui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:50:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0Pui (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 11:50:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id d37so4252164pgl.1
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Z4KzirpomMMMhl9nOPqIO3FAaOYjrwN/VP7m1zkLkQ=;
        b=tFubIApjZ2uEVFJ1kQrO+t2FZAL/Fwyvk/5pUXBICbB0tzqqcH7FgPWxGy01LLgoVw
         PwTQ4lhgO2qkW/LbW1ULqB+X2WEIt1ELEqdfpn2GNrdH1wFjfHCs8H+Y6qoviX3mzHNa
         Us3fo+1yuPjOc0S195RT89UhX7iZCjl86gGy5GJrx9T3cqaH/0FwJcgcMBrxx3/LOj8C
         hGdltFBZPEdNWRnLtCLOxF3NTe4lVb4dWTQk0kXoutLdNt9Jjjqfq1RcV9UOIIbwqwDm
         6o0AWscN05hz5d6cTtQrXHHItlxsAIEMhBUDtzLZpCENn6JIHNuuC09TSawRkEUhCwtR
         tFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Z4KzirpomMMMhl9nOPqIO3FAaOYjrwN/VP7m1zkLkQ=;
        b=SD+7TcmDdRmsKNbQpAjZ/SX/CFav02Vsol3E5bWbWOjjdwDtohav4KlFRvIJt9LgKR
         fC32N5JnV/NyIjuFXmqX6rvnjj4qKIn+wWC7dS7cd+5CindttWno5mZ8lE4LPPydFUoR
         cWviTiBqOEGX0x8MFPFGD0DUvirwLgEFzhBCiNrv9X12wSzgeSPxqoDXBOuiqtS5HB8D
         h0V9BVvClOQeNJDkgAm+fuEIdaiCFTiEajGRaJac1gUX4o5oe2RQMoURwg2OeSIekQ2y
         vnCzNhogu6kixO8KN+dKCVNy+ZptYdr1uWPofH7e6NornS1R+VWHPmqZvwWcksY9Fe5Z
         oJUw==
X-Gm-Message-State: ANhLgQ1h2RACeTXpXuihgvE38/3cg/O/GejP5ZRj1Y2Un5A/WeQbQGK2
        ZPk/XuIJLGl9PiBp6BZjfiGDrSJ1rltfRg==
X-Google-Smtp-Source: ADFU+vv6EeAV8ruNVAb1C8Q00OP3s0TlNu1vwBu3nKGrvNWsHQzRJkM69VmdCOuFzNhgkkqvsHBfSQ==
X-Received: by 2002:a63:5050:: with SMTP id q16mr14367230pgl.118.1585324236745;
        Fri, 27 Mar 2020 08:50:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y22sm4400511pfr.68.2020.03.27.08.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 08:50:36 -0700 (PDT)
Subject: Re: [PATCH] block: move the ->devnode callback to struct
 block_device_operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200327080717.1574048-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f742618-1bb5-3ffd-801e-47f88d0c4816@kernel.dk>
Date:   Fri, 27 Mar 2020 09:50:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327080717.1574048-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 2:07 AM, Christoph Hellwig wrote:
> There really isn't any good reason to stash a method directly into
> struct gendisk.  Move it together with the other block device
> operations.

Applied, thanks.

-- 
Jens Axboe

