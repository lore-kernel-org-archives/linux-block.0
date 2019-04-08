Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BFC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C0D21473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OjsdRfb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDHPCM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:02:12 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37926 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDHPCM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:02:12 -0400
Received: by mail-pg1-f176.google.com with SMTP id j26so7488826pgl.5
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34eB7ao7GiHInHHuk1VESnZSB+YteSK1EIe6t2Qa8W4=;
        b=OjsdRfb3PqXBSava9JqTXALRD+oJLm/wDaC+q1f4gRX0AW9oWFSjEoK6sGUnUnC5zg
         bCyPDGi7ppsBMlf1eg14ruboyAr3lzr87/uSxSShiJnPByPFtDfSx76rbrS2keEYI7+t
         UjjAHzCvVXejbQ6lyxRG0ycB9XDhONFx7GOUskrhGnmjzl7frFcvC9q1CP9siXuEfKgO
         0IXONkPBa7aA0KUYjIlulpQEVAvQ0gEr+O3u1MGRl+n9zLDENijYclVRKc+uHJGqPpqT
         pIUCd71Ray+HOMKkblXgOefA2drVUB/rqbgEf60sLyLCqRjHsp4EjTyL6gV0RdeFzVJ4
         PlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34eB7ao7GiHInHHuk1VESnZSB+YteSK1EIe6t2Qa8W4=;
        b=Xbqf5fJOzWSGtuIlhmi68ERQggy0GLzpk7h7U3QzrfsotgUCqF5S4Hp02RMPzGRQH6
         ob4o2zH8lqLGt5hYcure2KW4f4hKglh+m4wFnxkGeE+LfgrGeVkq949bwmOGIkgSn4yB
         ZhrTBMBveO/n0bz/SVUxZdDpbE4dAF1gFdiWRWqQwCeHH+1JJu1+WMV50hykvm28p0VQ
         1N9/MkmvIBvW8umNUK+tmU/lePEs4vGEspwiyLm34oPzEz1Sexq48FGMray+zgMidQbY
         sv3/17wbSKVNIKDIAxhko3NALaXn22zdNoNsh6lZJxV8nVQjt7N4KOKf4br30r7D2HZN
         1AsQ==
X-Gm-Message-State: APjAAAXBMqpE67puBks4eubDqcaXeT17N3ppt/DKzYXBn0Cr7qLjck26
        TtGCKK665fVMEjk/tepA0RsBvQ==
X-Google-Smtp-Source: APXvYqx2i6jf8FSwHOZUN2v96blNJIu62lus/7CSCjMWAk1X/YOUYuOVb3wPLpsRnzAk4DiFE9s/6Q==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr28741512pfv.10.1554735731854;
        Mon, 08 Apr 2019 08:02:11 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c3sm42651028pfo.2.2019.04.08.08.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:02:10 -0700 (PDT)
Subject: Re: [PATCH] block: convert kmalloc_node to kzalloc_node
To:     Tian Xianting <xianting_tian@126.com>, linux-block@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <1554734902-8295-1-git-send-email-xianting_tian@126.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <407cb34e-c26a-b343-6433-5602ed4e666c@kernel.dk>
Date:   Mon, 8 Apr 2019 09:02:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554734902-8295-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 8:48 AM, Tian Xianting wrote:
> Use kzalloc_node to zero allocated buffer, as deadline and cfq I/O
> scheduler initialization function (deadline_init_queue, cfq_init_queue)
> did.

noop doesn't exist in current kernels.

-- 
Jens Axboe

