Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD13C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347212AbiEaTBK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiEaTBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:01:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A553707
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:01:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso1686861wma.1
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mPEfXyjun4aQ6gkwMJLI2I5JtWWH7OC6kUgPVQfKdxQ=;
        b=A9gDEfvpYgPF0Q7OoWSV+lHxjdl60iuAMiKlY08ShS8VBNz42HXJwgSmk1FPL5UI7P
         D2ITPA0Z/ju0w4Q5vA8fBy/e8xdKJf4RjxUmeR014elZ9NN6zgBnZ02dqQrXqWdlI/T0
         yCqNJ4LjwsnrXa9FTa5cH58iIbBruuyQQzJ5lsuvg/+yO/mqr1Y78katz+WKhaPAyruZ
         7BCgoKuyF3jQk2YlikXN9HeaYrWGavbc6DCGHkuFK+zTSEsr1ssrdnLyVihsxHfdia+b
         M6L47XFUdbkiv1kBgvN00K/UZCmGrAaSc1bz4PCQQU36lfQ/9+qgix9VDOb1ZrmiFeRy
         snMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mPEfXyjun4aQ6gkwMJLI2I5JtWWH7OC6kUgPVQfKdxQ=;
        b=LkLYPPCEFCLoatIZUdLcK5wH+eM2ow9B5nrQVRSwctO558suZmpTClnzlY+BLlSg6+
         6j2kKv3Crx8W2i+/Kejk1RgFQz6jEQ2pae2QzxjJ16f6CBecnCAQD4y8SEYSM2c28K37
         KwxSDirJUuQArTOe9dOJ8shNL2VKdv68FGxkECQwJ2De0l5yHSuXVEcMbCirUos6J1DW
         5fDWxURYzzyOzA8RI+QztXFTdfkorBqmi0omYbi6abnf3loNQU2Qqg6bQo5UUWr3eHWw
         dnFZyChvFIyQvErM9pKOfj5VAG3pkvRvasIG1Dyp1F5B12Q1jz/ZXTyIX3bXExm9dVd+
         6D6w==
X-Gm-Message-State: AOAM531CXyX52JayNh788rD066Tm1I17wmzSSeAirZNwMMAuwDiNcxyf
        97xft8A8mWlBJmILCT4CQAaCjw==
X-Google-Smtp-Source: ABdhPJzh2KbBAMkk8MtAcoVgIZankz5ONM7gsZ/WOxgOKeOITtavXysER/SbpAnFFCwCK4T7DdAZEw==
X-Received: by 2002:a7b:c445:0:b0:397:28d3:d9cf with SMTP id l5-20020a7bc445000000b0039728d3d9cfmr24896122wmi.116.1654023667085;
        Tue, 31 May 2022 12:01:07 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b0021003082534sm14467305wrs.36.2022.05.31.12.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 12:01:06 -0700 (PDT)
Message-ID: <f0dadb60-c02d-d569-3004-81eafeebb95f@kernel.dk>
Date:   Tue, 31 May 2022 13:01:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] null_blk: add memory_backed module parameter
Content-Language: en-US
To:     Vincent Fu <vincent.fu@samsung.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
References: <CGME20220531185258uscas1p29fc501690df21576af035ef48af16daf@uscas1p2.samsung.com>
 <20220531185231.169102-1-vincent.fu@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220531185231.169102-1-vincent.fu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/22 12:52 PM, Vincent Fu wrote:
> Allow the memory_backed option to be set via a module parameter.
> Currently memory-backed null_blk devices can only be created using
> configfs. Having a module parameter makes it easier to create these
> devices.
> 
> This patch was originally submitted by Akinobu Mita in 2020 but received
> no response. I modified the original patch to apply cleanly and reworded
> the documentation from the original patch.

Ideally we'd have full parity between what can be set at module load
time and configfs setup, doesn't really make any sense to have them not
be identical.

Patch looks fine to me.

-- 
Jens Axboe

