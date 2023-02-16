Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C690C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 03:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBPDZ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPDZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 22:25:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA3540DC
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:25:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso5221766pju.0
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1kOUaE0EiKmZk9jWga/4Ri5+1QBKa/W13AHkjPQiM4=;
        b=wpu1digYWAfQFn4RXL4rbyNWKLk5iDpnEC/V582dT91O6cGU1C7O/EV3CznVhlScQH
         rD8PetDj6R8zuCuBAsV7DQcBAxsR6ur/Ug5JclsSeH7ULIg66kD5ZrA2bxmZeSPdhIKr
         jKlVLgFMvCXo7s+o+G2zcz1ts8vlOCAfcQ4ylIw6wkya8q1u/5Y+v1M23b6eSjQFCoLF
         rihGDjrMNIzKb+NMqkVJOccMNnlh6aBkvT1X4JnS0Y1I3jCB0DnDydEBvv/cy387hYdA
         kjyGDn7FFncYmN6O9ZvnToUSDxi8/E6vuGr+cnuQinxfuDTzDObz7p4or1jg5l9FCUhZ
         MnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1kOUaE0EiKmZk9jWga/4Ri5+1QBKa/W13AHkjPQiM4=;
        b=cJzTpDpEfJUqJjM5Tv08SoJwcEacMmOkCoAwFSu0+0NKFT6HVgDrhw4t8bxi7c455M
         SgfWSCW03flp1mH+FPRUNPA6jOdyWDXtIHtp5TMmAufQGT7DquIYPmffNVTa6OLO4Ghx
         1aE7CERJAlw6FmKIKUhgOwx8BBb6rxxWKCG4C0BSowI6CSYp/Oy5dg/1I/adOScskmvY
         ETGj8ofwTfByyVVmu6ZVkO5ywD1k0RhjGSxlQwBD1Bf8HHGQrGOCMAStgWLoDGy8CK/N
         VCTB30b2+Hci7RHdMNgsJLZD0IOKo3CpClDQJZv7mgHQH1nUXMzYN+gY5b+DxtyhZEmC
         wMvQ==
X-Gm-Message-State: AO0yUKUBzoNc6pc40Dfk6a/a3IbRttGd6p0HDFNwEhY5V5vhvxniZuYh
        S5JbRtWL9oh54Pg21bsl5HbKbg==
X-Google-Smtp-Source: AK7set8GbKfFb7nuzK8sp8QOC27EkkD3yZHaUl5JQdqnBciQX4jwm80ekOPBQ5uUtY06rN/LBr3NPA==
X-Received: by 2002:a05:6a21:7891:b0:be:adc8:96c8 with SMTP id bf17-20020a056a21789100b000beadc896c8mr5227369pzc.3.1676517955979;
        Wed, 15 Feb 2023 19:25:55 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c130-20020a633588000000b004fb26a80875sm146674pga.22.2023.02.15.19.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 19:25:55 -0800 (PST)
Message-ID: <efffdb82-85f4-af8c-6866-a643a7a16ad4@kernel.dk>
Date:   Wed, 15 Feb 2023 20:25:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y+0hqoUKkv1fMMzk@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+0hqoUKkv1fMMzk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/15/23 11:17 AM, Christoph Hellwig wrote:
> The following changes since commit 2f1e07dda1e1310873647abc40bbc49eaf3b10e3:
> 
>   block: ublk: check IO buffer based on flag need_get_data (2023-02-13 08:36:23 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-15
> 
> for you to fetch changes up to b6c0c237bea191fb99b6c2de093262402b0159a6:
> 
>   nvme-pci: remove iod use_sgls (2023-02-14 06:40:57 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - fix and cleanup freeing single sgl (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe


