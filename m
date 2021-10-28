Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FCBC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D126108F
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhJ1OiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhJ1OiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 10:38:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889BC061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 07:35:43 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y17so7075115ilb.9
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HdOnGgqdLoCyU34bqJgaOEfvztTrDictBqijAyk0E64=;
        b=y+sGzDgzGP2VflVeg0IIejzEplQHJnV/sPnc2aDcLRsvNkhIr6Bd6B1rKY+tgBcZcq
         VueZlHWgl6p2dHKf8RpKZp8BuED9Vj9uLTk3/tPg2zDZKu67swBSUi+UrAW2feDqX1Pg
         lVoW2MQD9ALyM54vuIdGsSCvy7PUnnrCrbEzwv28DDVYTrSaQsH03oTgvGy2s2zaawYq
         RnLzqJiAW35fIDMFIPbJZ570v5XA2YJE/v3lbZivn+Cl65ndYpnSygkYUsrHdN/lOngA
         1hdtoSaJ5slBglkhfqQRQeJK3Il3iuXlhE7JgARKgfRyxk84EcncCPz/37OeCW88Mlzn
         r2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HdOnGgqdLoCyU34bqJgaOEfvztTrDictBqijAyk0E64=;
        b=mlPRfSLhH/W3dbxgwVrJ+WAsbsbzDAeHY1RtvCEZlqAR4V9eJ0zWFlW8/m0TLv6IzB
         XIsjCSYSYv+TXfTq8iLZmGqbw3qx2v1bg4iK+K/0nhkQfrl5qiI8ZE6+TiRubsdn/Kp0
         6nHibILpC8K+Uo/wAArPWQAdexIlrwW5x0Sf8RBvG0GJTcyXsz5a0hY8XX4MY56dzD2E
         7rmZB9gGkVWw3xOE73VkH18TDeCdJ8VHt/DSxDNXSQj9x4ZZxuR80DTaAIsANVFLVcE+
         fnjGFL+KuMnhZQ0C8txztAD4uJT9FWLk2Dc4PemcKsGjKpSrNplzgEkgUrVcbQHu4W3T
         1Xdg==
X-Gm-Message-State: AOAM530mpN9Nl42AgoOpbkCcAru3JVtKeTCwE963UBYJLWQnz2L4zZFo
        v0y40SnMlTW/IZGtKl6kSD5tmw==
X-Google-Smtp-Source: ABdhPJw0nVFFjdBeM4GU37FAwbAHTvRxUD0Miy7CvjmLpFDK54qDAZQAhcgbjcr4/C1mdkBmW/16cw==
X-Received: by 2002:a92:ca0e:: with SMTP id j14mr3605427ils.131.1635431742907;
        Thu, 28 Oct 2021 07:35:42 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17sm1622556ile.76.2021.10.28.07.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 07:35:42 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.16
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YXqzb6dj0DCrIbGY@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b21a606-d582-ad3b-54d3-d8b8e7b247c8@kernel.dk>
Date:   Thu, 28 Oct 2021 08:35:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXqzb6dj0DCrIbGY@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 8:27 AM, Christoph Hellwig wrote:
> The following changes since commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17:
> 
>   block: ataflop: more blk-mq refactoring fixes (2021-10-25 07:54:32 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-28

Pulled, thanks.

-- 
Jens Axboe

