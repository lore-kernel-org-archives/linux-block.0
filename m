Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiE3NM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiE3NM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:12:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875504B1D6
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:12:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so3131746pjs.1
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/qzlYZwyFYtiTYE+K3kc+/W094/EdWLYCtmCtDncW8w=;
        b=LhkLGFXtl+K0vBQSoYP6IJTJ84UQawn/b6l7zCw/Adzv7UsULbxYtlnOOomSVzsF7g
         6qZJb01BCGibrPFsIFEd7VmyYve4nXlKXPkfAq6QlFH7qqZV5dk9JUyRCwV6NQMiplgI
         y9ojBWC9BYhUU18oShVLswsJuvyyp+ktOgZqclrh4TxpF8TTnTVpnShuuYMDJYDpOVfr
         vapLg4QURwJV6Woz3gXfEPa7acrWJ3p16h04K9fYuNUjzOZdatVmgywbpmrELNVzMZ0Z
         o/m5u+1vFqREmI6PTR292BxPIAfnr/JBwNj+aTzz4W/TbLHMXUQ0DEbomDzwZE5cqja4
         NO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/qzlYZwyFYtiTYE+K3kc+/W094/EdWLYCtmCtDncW8w=;
        b=yoHniAqWkxyAAN55O4/i5ZblgqzKnrRahdrb+Uz/XA4KvhyyVG3WyJXeEg2gKstCaU
         ArbXPXsusBCUcV6tMFD5A4wt0v0jmGMvKSpBNl6IDIGHVS4msjfINTUnG3HSX8i1dU3v
         YvkuAK4snO3hg4OHJgDErg6UcJ0qrC2qwPmlQ2av57FKd3SdZxDR9Jwd0cg1dEaTXnQr
         55QAAkRAXoW0mAA5XG0jBQLBxKul60RPnaRjVCGO8/gNOWV7b9RYVNeWwllbZcsPwYJ7
         4ZyuKW8YNeIT4PJbpCOP2Z+CHQX4XhsJmTRTVUzBJ/Zi7MBsNgefMf0hgUnYTP1DfhME
         3Etw==
X-Gm-Message-State: AOAM531PtLCxi0GK8DLnNAoZnBEZdxPonHD3xmL9xU7y1KINRfB8hrXp
        cxU5eyAxAMwHIl9LYhXschxEP6qsPyBXMw==
X-Google-Smtp-Source: ABdhPJwd/ti/Bu37obZM3LN0o0xKW9jyyT9LMBXhWeihAuxTbG8U2lR7QeB6Ux425wLUaIs4opKDCQ==
X-Received: by 2002:a17:90a:c202:b0:1e2:e772:5f0a with SMTP id e2-20020a17090ac20200b001e2e7725f0amr7612330pjt.109.1653916343985;
        Mon, 30 May 2022 06:12:23 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902c1d100b001617caa6018sm9107497plc.25.2022.05.30.06.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 06:12:23 -0700 (PDT)
Message-ID: <ca206223-112f-2d60-34a3-bb7e6295de7a@kernel.dk>
Date:   Mon, 30 May 2022 07:12:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: reduce the dependency on modules
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
References: <20220530130811.3006554-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/22 7:08 AM, Christoph Hellwig wrote:
> Hi Shin'ichiro,
> 
> this series reduces the dependency of blktests on modular builds
> of various block drivers.  There are still plenty of tests that
> do require modules, mostly because a lot of scsi_debug and null_blk
> can only be set at load time, but I plan to address those in the
> kernel soon.

Which null_blk options can only be set at load time? If there are some,
we should get them fixed up / added to the configfs side. Yes, the
configfs side also kind of sucks, but at least it's there.

-- 
Jens Axboe

