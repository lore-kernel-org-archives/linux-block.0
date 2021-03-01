Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277D3C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BFC65053
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 17:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhCARUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbhCARQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 12:16:47 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82BC06178C
        for <linux-block@vger.kernel.org>; Mon,  1 Mar 2021 09:16:02 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h18so15343540ils.2
        for <linux-block@vger.kernel.org>; Mon, 01 Mar 2021 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3b+9xfQ3i3dcB8RYtniu4ZRljRD43FwK2Tz7Gg/ahJQ=;
        b=OcJ43NvS/MnhZTl4L4AwdDmK+aOfEdKG6FIcmnN2uXaQSJUqz2Wr2Cl3KehHqIWKWI
         1Qv4LCSrYxgSKr9IITn57HaJc2Tq7+LlnEBkg744EvkKob5tfTsOYF6sDa9WGcgi0Cu5
         kO9MlPtHcerGQW8Fs7PtLTj8Vm23crDvj/n02nK9mPEDDqiIc5+GytWLtzS1hMe/B1N5
         KorR9ikGi2Jl89u7UcaRJQIvhE6/0Ky6n5beeXbyz+k0BuWxFtVDrHg8t8RO4wzxlDiA
         2WZwjnpQ7Y+90eT+ngtsmdXrVwp4Q3E5dZ/jsPKhjU6qqY3S54u6q8ENRjdYnV+OPTV4
         7xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3b+9xfQ3i3dcB8RYtniu4ZRljRD43FwK2Tz7Gg/ahJQ=;
        b=YZ9HOt+kvHjj2OFsgBEDSySlxWPMUMJdTt3FN5kJLZFiRcHfduvuwB149wcdgRK9Ev
         DmQNYSizmZPaD4bM8DKkvRq+wTrUmeLYuBkbSOzYAQSUx9viVAS0yOqPKoz4t8gblhep
         RaeTYtB1RvEScytyrgzQjP3rctFricMm2ftaD4UWJbAwgXB694OY1Tp1cmKATqKPIrHZ
         jG6dCpC3M1mOOPbuqd+nHsJBSTn2hjCnL4/8g/4ba9kAPub05D0teK9nwyyDCQDvnhXK
         MbBII5LxTLw9zcllBgjcRLHuZsZyDNkhbWhtEpLu8FPec0IgSBS/SPmd4S6U2Y334p96
         pIVQ==
X-Gm-Message-State: AOAM533jpCW1Ek55gtJlK/0JGsGxQibgAOktcvqIBHsFSHQsZACNQLg2
        ajs6O4ycC/Jmm1kmM2+e8fV7lw==
X-Google-Smtp-Source: ABdhPJwOWrLvxVqr07BcFaMhPsZa3/dODLF1rUUHsnEGBwz3abPDxjLP+Co2xSVu1/g4jU+5zTeSgA==
X-Received: by 2002:a92:d18e:: with SMTP id z14mr14110035ilz.130.1614618962214;
        Mon, 01 Mar 2021 09:16:02 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r9sm9165974ill.72.2021.03.01.09.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 09:16:01 -0800 (PST)
Subject: Re: [PATCH v2] block: Drop leftover references to RQF_SORTED
To:     Jean Delvare <jdelvare@suse.de>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>
References: <20210301172325.1b2a16fe@endymion>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61594cb9-06dd-acda-9205-e1b88839e343@kernel.dk>
Date:   Mon, 1 Mar 2021 10:16:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301172325.1b2a16fe@endymion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/21 9:23 AM, Jean Delvare wrote:
> Commit a1ce35fa49852db60fc6e268038530be533c5b15 ("block: remove dead
> elevator code") removed all users of RQF_SORTED. However it is still
> defined, and there is one reference left to it (which in effect is
> dead code). Clear it all up.

Thanks - hand applied, since it didn't apply without fuzz on the current
tree, looks like you generated it against 5.11.

-- 
Jens Axboe

