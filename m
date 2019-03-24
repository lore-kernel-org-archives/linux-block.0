Return-Path: <SRS0=54qS=R3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1BC43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991F420883
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 16:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h4IZR0Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCXQZq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:25:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46677 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXQZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Mar 2019 12:25:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so4719998pgg.13
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a413qc4UWdxcy1b4xS2ceHgjk5uQtS1GJU8cEu0SkNI=;
        b=h4IZR0GqIJ3Gun0vgSJjVqrWsfbBmx7U4Ufl1RBhWptz80zo1cUK9qGC/34bOWRO6h
         kY/tXufk86JTKSXHMO7o/D97XHJL3iT3UkAmWUL+5H2Rhm/UQh5CUOJeROJ+Xn1+hoNB
         exTfHsDwETTcZaJ8ByFtwYZkB2e5yzTEb/a9kI3ZeoQ+R0jOClGmA/QBECl94sFjm1YC
         A6dDDg7ssIu8LwLaahXCWPh92A+yi8ZfldqYDXaX4sHXRzVHtUP612jL+rb+hc9XUXbq
         tChMudvTvbCZC8QP+rPp552GhvdxhmX4zZNL91sl+RGXrWb3mrXKe00rjdSSx53tC5ok
         Pttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a413qc4UWdxcy1b4xS2ceHgjk5uQtS1GJU8cEu0SkNI=;
        b=auhsRclEBubWdmmiCnQ1u393c0MGxZPadq05HW+vFiLMUx69Pjk3LKwHgnClCuns9H
         m0LBuP+QY/WQ9zcXfXn5Bh7gKeFKa/7MFmkyTIz6CxnPL3lBMca5Y/WwQxuuvbfYjZs0
         LTv3N9Ev6HuKzLmWrorjHlc66IPoqrlbDsKohwzu8qc4IQ4m9Nh+5ZxmljRMICv5+asW
         YkpYzER17sqJKk7gpDj/lnf0iI1dAPuHUmYteEvjG87lTFrc6BcIdjsQbRWqq2IYpzit
         wu8Y74jHYphGMPWXlxhlLrRRwQzSssyBD4WCf7891549ZYbSsJH+U9jPzi2LH+3dOXGC
         v8cA==
X-Gm-Message-State: APjAAAUmJrVoGDhSyl9Sch1sAXxqJmYsEB5xbuoYMjbrvfQvzUKdqtxa
        XtDBz55B2jRRGGcjxhXZN4Jmk39VmAuybS0f
X-Google-Smtp-Source: APXvYqzAskbk3HgEzTPlN3Q4HUQbOMwzSd8RMkSlZFVCeKbLURzDaqySMX+ciaD6bMn9oPsrY+V3qA==
X-Received: by 2002:a62:29c6:: with SMTP id p189mr20247474pfp.194.1553444745431;
        Sun, 24 Mar 2019 09:25:45 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x11sm18075071pfa.154.2019.03.24.09.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:25:44 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-mq: cleaup code and update comment
To:     Yufen Yu <yuyufen@huawei.com>, linux-block@vger.kernel.org
References: <20190324095708.77658-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fee7f93a-0c28-36ad-89d5-c89051295319@kernel.dk>
Date:   Sun, 24 Mar 2019 10:25:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190324095708.77658-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/19 3:57 AM, Yufen Yu wrote:
> Hi,
> 
> This patchset replace blk_mq_put_driver_tag_hctx() by blk_mq_put_driver_tag(),
> and update comment for blk_mq_hctx_has_pending().

Both look good to me, and it's nice to get rid of the _hctx() tag put variant.

-- 
Jens Axboe

