Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA51C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE9218D2
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WYCEcnUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBIQuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:50:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44934 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfBIQuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 11:50:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so3113195pfh.11
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nYIVMZwOc5fSWaoNF9YJzrnb/Ndc0Ky1UfhNCCUYfaw=;
        b=WYCEcnUfm3F/66c0Ze19+Z5JImomlIXB/KdjEZ6Mk4PegS9q/t7sa/5GYTRypIKADf
         4DT6uccf/pHp7DDG9SW2pzjvpq5aXK4l//Fezo4Ql2Kufu0tziM42fM4eqkOWMGcwgQe
         69/t2p7qKEyGKOn643GiWbHJip/5ssULrPWRQV+YL6rXyW4zHR5s+a5c1kXlWWlgFxvw
         SnGmKIjObfOVOUde6qw7FaueoDi3dHwhX5QG+R8+hA8Dlbrt3pVp7zc5k7g9rsY0zek2
         HEKlrHPe7vkC3DS3Q2qZsiAUev03rPQ+/QmggQUm855SWLaIEQNi/uBqvGw4las10FrI
         wjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYIVMZwOc5fSWaoNF9YJzrnb/Ndc0Ky1UfhNCCUYfaw=;
        b=ms1MdLaG3y4S9QJGFGM5ecM3MwbA4JbVExz1H7w8IeIfq2nKLiUK3nouM74YuPNx+E
         qgrP2nhA4MHZrQErCIFbSTn3Zc++Y5KFFz1ODCwG06y79wYDSxa8KZOV/0iUP+sBY97F
         tBX+/4enSSBZbPElp03o4cdRtJ0c4yJMurpoXdHN2MYvM22UttA7KO6A/JIeLj2jhsOu
         jWcuBFEURHKaPThjkAx7gGKmVXph5RQIZZti41wxqag15Ec1gy6kVbQaaY6Ck4taKv7G
         kfbgIf+6tHGjtFkhaynrV9LVv5gTALHlj6/feQdJBTiaYpAzf8JszVRr4Yf/3Jh+d8W8
         lrmw==
X-Gm-Message-State: AHQUAuZB6r0rNAeXZH7I1yJIPqCKxQPy3ZmaNm1Cab52ofXMfSlfxQ2G
        ZbjE+dQin2JJjP3ey6Z32Axo0Q==
X-Google-Smtp-Source: AHgI3IYewTQ2vR6QFQXmC0DwO5KaddNXBIC5igeHP2C/h+TsNYB8FDhacTLV+iAGbcpunX5nPbLoqQ==
X-Received: by 2002:a62:59d0:: with SMTP id k77mr4169308pfj.211.1549731006532;
        Sat, 09 Feb 2019 08:50:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l8sm15604612pgf.60.2019.02.09.08.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 08:50:05 -0800 (PST)
Subject: Re: [PATCH 12/19] io_uring: add support for pre-mapped user IO
 buffers
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-13-axboe@kernel.dk>
 <CAG48ez0uH_muHobzpwFzdyBWCcWDxbnfpuxABntph6Te+tYxGg@mail.gmail.com>
 <2ef04b12-6a4b-af25-cbf8-9dde79b0ec1e@kernel.dk>
Message-ID: <7cb5df70-1179-c566-7c13-31e96c32d66b@kernel.dk>
Date:   Sat, 9 Feb 2019 09:50:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2ef04b12-6a4b-af25-cbf8-9dde79b0ec1e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 4:38 PM, Jens Axboe wrote:
>> Technically, this accounting is probably a bit off; I think if you
>> pass in a vector of 4K areas from 1G hugepages, you're going to pin
>> factor 0x40000 more memory than you think you're pinning.
>> (get_user_pages() counts references against the head page of a
>> compound page; nothing in the kernel can tell afterwards which part of
>> the hugepage you're using.) I'm not sure how much of a problem that
>> is, but it should probably at least be documented. Unless I'm just
>> missing something?
> 
> No I think you are right, it doesn't account for the hugepage size if
> you pass in huge pages. I'll fix that up.

I made a note of it in the man page, I don't think this is unreasonable
(or unexpected) behavior.

-- 
Jens Axboe

