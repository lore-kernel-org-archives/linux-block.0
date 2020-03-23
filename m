Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE9DC54FCE
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066602073E
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbyqDhdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgCWT75 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:59:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43166 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCWT75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 15:59:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id g27so7270501ljn.10;
        Mon, 23 Mar 2020 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dbO9AMgv2C3q3wUDDoD6CSYAM2+vrjv9y3H8u+4ZnFk=;
        b=VbyqDhdmtu1qDNYwk412YWO11Exes5+3Tbpn9dyrqH8rA4FST2Mmw57mVUUdXqETrq
         3czM7De1zTFuS3Mr3yve7kzyd4RBh5vHUsmtejnJA/REpAtlcpULSkKfJcGmdm3XO88l
         X+d5o78Uk/LDxT2wpAPPjhbDgJm+9p/znfdteIDwCTTm9Baoi1SMRcLJBHY94Y08914a
         ui8LDs/96Tu7ScP9kdocgm9eZ1TLrvVlWCCT0lCi2gRCpitCWvliYWGIr1uqEDqueWiB
         UI+TPjxRMuiP+nGvb26XIDQn4dBrIYe5s5t6+mU4EZf2Cz+4B5m+GVd7TU/eoseddF7w
         5+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dbO9AMgv2C3q3wUDDoD6CSYAM2+vrjv9y3H8u+4ZnFk=;
        b=l9PsH2Vji8B97O1gdsjfzQBzYSTQzBu35eVWZc5Kjfve6HPtj2lZg2WYolopB6keB8
         +d/CXD1kF92VDCiV95dKhjqQQm6idC0e8xHussgag7MaJWCBGPXrDL8Y+cd+L3l3lA8i
         LWh49B4RTYgrumY6YR5nf4GrrlutKdj/TJkiCZLseia8kezs3ebDw4SUAkS759lY1pj5
         EVyLmDhpL2mxATHQIZZk2mMZtzBdjRW7t5R0hmnCizeXhjUBxqfa/waN5yXN56+YAGFW
         eaDdLRjmnrP0DAvbhKT9A8AmGltCmF5O7iVNPn2lsEwyrR8wUG3QHbKkwsLUZ4GlZ61w
         tuWQ==
X-Gm-Message-State: ANhLgQ3GrbaQ+HQH2X9FiqFdsAL1ywo5i+askTgN8MTtlYl8VyYfPFG6
        YjjeHJegwLLLyk//zc+61sWrI0GL
X-Google-Smtp-Source: ADFU+vvxc3Pnf8dsypolZV8SPKqREwTrzUhihQIubesluJG79gKWfF5VhPPWmJ8InGnZv1b/rXQ7hA==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr15041191ljh.28.1584993593897;
        Mon, 23 Mar 2020 12:59:53 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id 127sm8831243lfl.29.2020.03.23.12.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:59:53 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] partitions: Introduce NVIDIA Tegra Partition
 Table
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200323163431.7678-1-digetx@gmail.com>
 <20200323163431.7678-4-digetx@gmail.com>
 <20200323191748.GB30585@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67140755-c829-5c58-3fbf-efd496e225df@gmail.com>
Date:   Mon, 23 Mar 2020 22:59:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323191748.GB30585@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

23.03.2020 22:17, Michał Mirosław пишет:
> On Mon, Mar 23, 2020 at 07:34:24PM +0300, Dmitry Osipenko wrote:
>> All NVIDIA Tegra devices use a special partition table format for the
>> internal storage partitioning. Most of Tegra devices have GPT partition
>> in addition to TegraPT, but some older Android consumer-grade devices do
>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
>> in order to support these devices properly in the upstream kernel. This
>> patch adds support for NVIDIA Tegra Partition Table format that is used
>> at least by all NVIDIA Tegra20 and Tegra30 devices.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/tegra.c   |  54 ++++
> [...]
> 
> Please split off this part and make the information available to
> userspace (pt_addr + pt_size) if found. This would make it easier
> to support use the partition table later in initrd instead.

Please clarify what do you mean by "use the partition table later in
initrd instead".
