Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2606C05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBQQHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBQQHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 11:07:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A76E678
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 08:07:42 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s10so574187iop.4
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWpCTwblPDWaV+/VWYnkjaoyriCQssfHrdSwncVglsI=;
        b=2NEaslRv/SKgJNf8hZu5zfHekODk1PkZC5mH5b/rmGTxRTuzkQEu1awTkrL8tGLSvq
         GhTzWozzmIqwEeZkclGo20T2CH7TJYaNA/ezjTLduWVJ9q3mAcgBbeJsOnliRjYrnipk
         CNOqUwkFiJNAIBHYLApH+kZevftCXKq2zuSO93X1pNSSbq0G7padez2iO7aK/6tqHuei
         d/xFFUy7pxyAHVH9G3IWI30DKUYAyEBRhF39q4OAawAwguPwkfoz5+PuSJYFhcwZ4OLh
         UaSHXUetpZWtamUbHM8ptxU1fu/WG9nvL9J+zSKfa2tQcdbpRcL8H4yJ9ubgTJjVBl0p
         NKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWpCTwblPDWaV+/VWYnkjaoyriCQssfHrdSwncVglsI=;
        b=0z3AihCiFErYQ/uHAk06KgXEvilJ+QQGoYOUoigrq7njwetDH9Sw0OxBe+9AjPsmf1
         mqTovTGkUuXV49mpXvHpSpaccP1HNwWAbLJI1NezgA7ySrIh9ebJ98xkoA2XlVxElI5c
         kMUdzRke1xcZ8JH3m2io/COWM2UH6DySuQf4eSbNlvCMqtuf0ynN57o8QdHsc1K7S2Af
         sYCZwXcVycgGRI0U+BVZPPlRst9WcTy+nr8XNGkxD1xjIBnoTPhtPZP+Gat7ZY8gupMe
         XvSQpYhysovh2VtOJScMah4NbIVw288vn9mejEQkGW/lPAj+K0ztIiS1k8nH1VxKo/LD
         40Iw==
X-Gm-Message-State: AO0yUKW7JcpW+dl5aOyo3eesjCmgBgVU2NqV12UogPtBaKZ7tClTZiJ9
        88Ua/M+bu+prn1VNfjWIAoZlFFYzhoJJ2DCN
X-Google-Smtp-Source: AK7set9h3hDOpTqtiuorBjgnvE8VHzSVpOAGyY50grRHzp9ZxPSh/NqXUy5tR9Cuq4fDYEAa0tg0dg==
X-Received: by 2002:a6b:da07:0:b0:740:7d21:d96f with SMTP id x7-20020a6bda07000000b007407d21d96fmr1335845iob.1.1676650061491;
        Fri, 17 Feb 2023 08:07:41 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p10-20020a0566022b0a00b006e2f2369d3csm1522616iov.50.2023.02.17.08.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 08:07:40 -0800 (PST)
Message-ID: <cfdb886c-bfdd-e82a-2c47-0e0b8a7f444a@kernel.dk>
Date:   Fri, 17 Feb 2023 09:07:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] nvme fix for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y++ARzuse5GE4UCL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y++ARzuse5GE4UCL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/23 6:25 AM, Christoph Hellwig wrote:
> The following changes since commit 9a28b92cc21e8445c25b18e46f41634539938a91:
> 
>   Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2 (2023-02-15 13:47:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-02-17
> 
> for you to fetch changes up to e917a849c3fc317c4a5f82bb18726000173d39e6:
> 
>   nvme-pci: refresh visible attrs for cmb attributes (2023-02-17 08:31:05 +0100)
> 
> ----------------------------------------------------------------
> nvme fix for Linux 6.2
> 
>  - fix visibility of the CMB sysfs attributes (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe


