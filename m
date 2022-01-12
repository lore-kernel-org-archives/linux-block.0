Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0742C433EF
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 22:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiALWGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 17:06:18 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40554 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiALWGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 17:06:18 -0500
Received: by mail-ed1-f43.google.com with SMTP id a18so15505311edj.7
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 14:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DoxA/HZ6Hqtl2AG7gqghNwbzIr4xoTtN3O39GeX/hkU=;
        b=RFe8AY7Le+LFfyXfxpmZ6cgQZ3FUqNIy6OV+tJ4hy9wZuyezaxjeQKd3kPuwT7x90t
         6YS0lNdFlyJlHYg5DPb6/9f4ugi/G6HFk8G/5gGyooCd7AqWdLrBahGHGSmvoGNjJiQK
         PJJ0b4ZrviMkkNXO+LhmKidubxM003241Q5FEuKDIAJZLZcblpygcfE4pk53Dl+4S0eX
         7Hks2edmukwUtcu2DzgAu6WJ6UUwqEzfky8tC3LcS+j0NWCZpfhrdeaE7bqFLawaDuvX
         JbB0On6X2glkIam6nzSLpXsA2koK8IR1LmP4cJiVrpUENfi2B0+dg4SBEjX8uGYjuxj6
         VQLQ==
X-Gm-Message-State: AOAM533d4qvx3eaXECWQ3I4EYC5YzG1IzB83CSvQpDjSqiCK1uInA4hT
        1pl5zUZfPh89n/zFENdwiQ25EROIhZM=
X-Google-Smtp-Source: ABdhPJzNvVHaMEZO4bfIHWaYzPSAgNqefBClGfMoKJKHzAsOwmddGfQBNigAG4UszpMf80ZPWJ6EUQ==
X-Received: by 2002:a17:906:1145:: with SMTP id i5mr1296525eja.317.1642025176807;
        Wed, 12 Jan 2022 14:06:16 -0800 (PST)
Received: from [10.100.102.14] (85.65.254.89.dynamic.barak-online.net. [85.65.254.89])
        by smtp.gmail.com with ESMTPSA id w3sm384642edd.63.2022.01.12.14.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 14:06:16 -0800 (PST)
Subject: Re: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "osandov@fb.com" <osandov@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220112060614.73015-1-chaitanyak@nvidia.com>
 <dabc21d2-6431-67e0-8ce5-62c74c76bc99@grimberg.me>
 <0dfab539-c85b-68da-0a2e-3765d7d3903e@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29ec2611-ad72-051d-7725-5d07fda70c04@grimberg.me>
Date:   Thu, 13 Jan 2022 00:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0dfab539-c85b-68da-0a2e-3765d7d3903e@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Sagi,
> 
> On 1/12/22 12:38 AM, Sagi Grimberg wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> What is preventing this to break again?
>>
>> Can we modify the tests to not rely on a consistent
>> output here. Perhaps just search/match the expected nvm subsystems
>> in the log page?
> 
> Do we expect to change the output of the log page again ?

Yes, I don't expect that we will lock down the discovery output
in both the target and nvme-cli.

> It is important to match the disc subsysnqn i.e.
> "nqn.2014-08.org.nvmexpress.discovery" and gencounter,
> only matching the nvm subsystems not going to get us good
> coverage.

I'm just saying that it is not sustainable. Nothing prevents
anyone from changing the log page again.
