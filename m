Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B34C4741F
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 14:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482052071A
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 14:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZR+QuP+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgKEOL1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEOL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 09:11:27 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18144C0613CF
        for <linux-block@vger.kernel.org>; Thu,  5 Nov 2020 06:11:27 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id n5so1480957ile.7
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2020 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6EAeut+BnNwdiVFa/Nqg0Qb0vB29gbQLvEOprNqRU54=;
        b=ZR+QuP+BTgpJ9EU7FmG/1siLp/UgI1vBeH+m2DidlPr8jvkptmTG+yiAJLK9V6p00R
         8aw37g8E4MPLAmLkol5B0j0b/HrVgPuEFfBTMBHVAd+f4L9Q9J4IaMilIM0Qc6bU8WVq
         khEsayOsfebf8kfjAcpEC3dez0CiIgQFiPoxkFU44SjlU950OoTGwbgpPYxGVT8t2ScK
         F8TYnlgXZP0+VNnc/N8qJ5REXkW2anvtzOrO4n6TIDGtbU6aVW3hWhilnWq06x69XDAA
         vX7vYmvrTXSNl4md3NtoQ7nMhXufAgi7+YW4yLynjJKKa+E9IETvLvQFkdCan8p2XqiJ
         0g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EAeut+BnNwdiVFa/Nqg0Qb0vB29gbQLvEOprNqRU54=;
        b=apXdeGcnYqli2vyCQQCSWk5GGisfu+FgziQhtZy9qps4WinUz6K7JuHntK4+do3hlJ
         7+En6Z08nnzagRTNiRhYUHcH1PccRXR7YtvuGax6jeFj0DxFyg9XnslJ8Tb9fCKpMV+w
         ZwXhtYD7MmwC0sjHXFbJc6TR+lgkS2NPUmyY0k33SnPcISfgh4LDiG7s7Wvig2uGdoe2
         dTcGlay1PGG6R1tUn3HTewC5D4yAqwdhSXnbWmqB65hrXw4ROw0eBO2nV0IErPYfQIbV
         pJOK0cynKm2+XnvueYAfz3MDUYGKzp0KJ7CMMhbwbmLEB56rsaEX6/e00hSBqSHQ+AUC
         wi+Q==
X-Gm-Message-State: AOAM530glwM0ALfAl+yJ1jqRsc0jITQyx+1rG7LwCI+5poGyaCNIvHRG
        rNVoddrFUB8EBz4+ucz3YdqXoH6TYhXeIA==
X-Google-Smtp-Source: ABdhPJwy55OanQ8jU65gd3iWT47QaTuHOvloyGDZvNDYL0EruvHmw3hOf5K45yJHytd/LOMJ7S0vRQ==
X-Received: by 2002:a05:6e02:14ca:: with SMTP id o10mr1837408ilk.143.1604585486500;
        Thu, 05 Nov 2020 06:11:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 9sm1342134ila.61.2020.11.05.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 06:11:25 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201105075604.GA1690984@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0295c3b-dda6-01c9-cdd2-3f1ecf9facb6@kernel.dk>
Date:   Thu, 5 Nov 2020 07:11:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105075604.GA1690984@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/20 12:56 AM, Christoph Hellwig wrote:
> The following changes since commit 65ff5cd04551daf2c11c7928e48fc3483391c900:
> 
>   blk-mq: mark flush request as IDLE in flush_end_io() (2020-10-30 08:33:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-05

Pulled, thanks.

-- 
Jens Axboe

