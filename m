Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE968C73C63
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F342073D
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GFGK3hC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGJCzZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:55:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34054 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGJCzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 22:55:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so456716pgn.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2019 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8+Q6mG3/ZGpry498ISHZ/wD38Uvq0i4LqqbAl3VOro8=;
        b=GFGK3hC51Y3sfytxOq9sTL1KY7vI0GIEHKB47fPVXOglpWzC7zF5vNg6lY6wT+bu4C
         EG2QJ6dswSmFDp6S5ysxUf3g3cFRG1yXH3PggO6fUVvKedboAeU4jD/IrsVkHfCUp7d/
         lAgX8w4E3OGmxs704NpKKmARK49PGydVu5Lef6GZ8lqkYyBObnVe3JREruFv/WgQ1vFK
         VDXTZ6+T8h+8e4VxNLsasG0L2hXyuS+mnLPSnYBTDUFqo4UyXttwkoANA16kzu1CLJ4l
         S2Cy3DpjCbt2XIO7NKnZsvdQ6Qo3BVTnxb+9n2Z8+NslnR5ny/RbEgN16dTjp5EnxH/r
         6/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8+Q6mG3/ZGpry498ISHZ/wD38Uvq0i4LqqbAl3VOro8=;
        b=svE6824hGVahWe4eJYkZuWkPJj6F2POJzm+CupKVg2iMs8cHD79rNn/YHqiZWka4yG
         SxCra8KY/VLrSVQhxZJQVNyoF4WIJSLyqChLwa4PT20ezO1AN16zRybVOynKc2pabRgW
         bJ8S1jEhHa1LgHGekBFeXrzdGk1QcEOXuaIghCShrKGbdZCoEPr4FDi+LYQyPUn7UwJH
         IgnfdFbfxGXyb7Tm5qZyOc9Vr2sdJjIJxLQHZ1pZnU7whWfOAR7VZkpgNLxgr58gybqO
         AXt5pD2z+7bmKA+hEZICoEtKlh0asHbOFjEH1K5apwm3y26Nd/Hg0Av0HRgQlfXfO0rt
         JsOA==
X-Gm-Message-State: APjAAAUBBQfIay0YJq4JNBuh8ZyfdUPtpeYaiKOAaZnPTCNJUYeSGaas
        06r8iiYRfK+oltGAaIwvhqdVIw==
X-Google-Smtp-Source: APXvYqzhlKVhfG4T0dvotHjy4f9EMO1M1z7pK84PZoIFoHfU9WVJGMF7tNp9SSrVdK96JhYbGpWMyA==
X-Received: by 2002:a63:5823:: with SMTP id m35mr19395657pgb.329.1562727324715;
        Tue, 09 Jul 2019 19:55:24 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g92sm421039pje.11.2019.07.09.19.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:55:23 -0700 (PDT)
Subject: Re: [PATCH] blk-cgroup: turn on psi memstall stuff
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
References: <20190709214129.GK657710@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b0aaabd-a2f4-c6ce-2630-4a348cd46eb9@kernel.dk>
Date:   Tue, 9 Jul 2019 20:55:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709214129.GK657710@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/19 3:41 PM, Tejun Heo wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> With the psi stuff in place we can use the memstall flag to indicate
> pressure that happens from throttling.

Applied, thanks.

-- 
Jens Axboe

