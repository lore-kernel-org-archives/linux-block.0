Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAC5C433FE
	for <linux-block@archiver.kernel.org>; Fri, 25 Feb 2022 14:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiBYO1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Feb 2022 09:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiBYO1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 09:27:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965EDE2EE
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 06:27:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m11so4959589pls.5
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CueWZXVwpZqdL5pKcLH+mDQMXSj/tgq8h6dqyMSiTWc=;
        b=PfpjwGmuxVMO98b9FDuDLsLE9btC0WBH7LhsJ8t4TpjmMe2OedybHGRFlbaMxvYueI
         GLqc6LyVGQuJqh2jy8NIWPv0N0tKhYKhSghFrdptUgkE7MxEqeWrePJD0232xturOP2i
         df8DJgH6f6Jr0nFGXKB7PXidirxCjRPva+wV9HkYaIj524bMF5Slt5aPVJh4G/B9xohN
         yS6/VWCFrOF0R5IASe5MFC60DxuRiDjAhaKPiK2d+udCx4FGyiMGBw5knhW0hY8Cx1j7
         tRFkY6hwSHgmjZy1IprRmpUfS8AE64hOqjHRilR3OGHIem0SxKWFJIyhdmRxNcjZ094D
         FUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CueWZXVwpZqdL5pKcLH+mDQMXSj/tgq8h6dqyMSiTWc=;
        b=hLuICtwF+me0mnP59xKI3fCiLyakGguUYSskhMUoa3XfZKCc/xZ6hp7wWX7uomopRo
         Rew7+lEdviW4hhOWoUXfO2zQ35k9WTdvdGjIE9HWsUbQ1tURImTcpKImrz/9geTt23BX
         VEHU8KXkq6DzjpaW1oAoQMPMkw+22AfUAfGe49CgBNHPh/pHA8APMTXi5jm2ko6Xu+pK
         ESALyauf+TesRFOHQDq/RjsaJzhlBFZsrlUiW3MngQA6w6FwI1pAz0jqXcXDzdHhApCS
         Dc7hspml7zk9wcNQtlatAo08OWXafemPhyK1dWNNubos1VH/eA2BdEdsnVNKZtODA7Ge
         6J/Q==
X-Gm-Message-State: AOAM530G0bue2pSngTFUOaafmv/L+M2s2e/Q1FcWP+MoztTvXzfwCilc
        ZCRghlp/JpcRej+FNA+21cpCYg==
X-Google-Smtp-Source: ABdhPJyrLKbOQ8eTWPLV/0scGMnACkwjuJFvTJHTGBtWwoynPikelwG7k7xTp6UTIKeE64ve7G24pQ==
X-Received: by 2002:a17:90a:fe86:b0:1bc:6935:346 with SMTP id co6-20020a17090afe8600b001bc69350346mr3457979pjb.150.1645799233170;
        Fri, 25 Feb 2022 06:27:13 -0800 (PST)
Received: from [192.168.4.157] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id na5-20020a17090b4c0500b001bc9301f316sm2669492pjb.42.2022.02.25.06.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 06:27:12 -0800 (PST)
Message-ID: <6db54b86-4f25-af15-692b-af067823d77e@kernel.dk>
Date:   Fri, 25 Feb 2022 07:27:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, ming.lei@redhat.com, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220210115637.1074927-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220210115637.1074927-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/22 4:56 AM, Yu Kuai wrote:
> Throttled bios can't be issued after del_gendisk() is done, thus
> it's better to cancel them immediately rather than waiting for
> throttle is done.
> 
> For example, if user thread is throttled with low bps while it's
> issuing large io, and the device is deleted. The user thread will
> wait for a long time for io to return.

I hand applied this for 5.18 as it's conflicting with other
changes. Please double check the end result.

-- 
Jens Axboe

