Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC6AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 13:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiBQNeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:34:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiBQNeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 08:34:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE4219219
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 05:34:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so9423746pjv.5
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nl/CXCqtF6bgjuDOpYj/nKZvXJa3Myf2j95QgB+Y6hg=;
        b=H+f7fbhkIultmxuncLN/vA4rts/WA/vFJrJzirJbeK/FfiN16lXVyw9caNmlihcT1M
         nuaTb+MO5je8JRJrJ74wAg1Fk4XUMUye2WdCf0yAWS72gMmOGWx6Me2xiLiOqG8XBnOS
         nxATFes3UXZxvLWSrxFaJL4xSyiEXD0P7rdkA9E8h7JGyFFX6LIbVLzAW8/W9lLPLstS
         IlWLO8VTN4080D7hL4f4gZ/Adsj1hClrHjkca7wzQ7GEnqksuhLuVhGPqW+j/hH4l8a4
         1v0kiElfdmtQC8TKzGT2XRNKsGlOooXn5bYtn+FyWhYvwRSct0Vr9LIh/bEueNIiz64n
         zUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nl/CXCqtF6bgjuDOpYj/nKZvXJa3Myf2j95QgB+Y6hg=;
        b=GcFOVE5bv937lGc/fUrd8z1sNTkKumyUil5p4tagueNup9jWuLp1jhTWTDFZ55noUW
         L9EW2nqNoe8hKfE1ty0pXUrJnivHM2jIftNxdm7Z0E3854wnQNGbxCS3mx6XxUvLKNM9
         ObGju7yMVd9BsxHUBEdMNpv4AnXrDoQrMCm6yitQZAkCQHDoeVlvQtZVxzrT8bZsaCNi
         4Kpelzy9kQ/f/+wipdPY8q20a7HLuH3gv55AjqZUtydvYYi4gqSYyQrcPRA3ZqlXkHD1
         Th4fPiq8eL35ZUAT1+Mf+nFds2Ac6lQnE/T/vNrpzFNsc8slHADsbs7Qv8Lbu/eKbz3z
         pGOQ==
X-Gm-Message-State: AOAM530ZyabzN+ByvSrt7Mj5ivIhF+DuRGfJSlIXaGFST0t2L3O9GGf4
        Z09HNCcRv3bfPgUQWcm8ryWZyQ==
X-Google-Smtp-Source: ABdhPJzn+LzkIoWOOCAjun6oXUaztDCVZAtBkluyqu6tGJXy3JeJg9BO1H+Grp0fRJoxFI2wm2N2Mg==
X-Received: by 2002:a17:902:e949:b0:14b:1f32:e926 with SMTP id b9-20020a170902e94900b0014b1f32e926mr2992274pll.170.1645104844307;
        Thu, 17 Feb 2022 05:34:04 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s2sm16072530pfk.3.2022.02.17.05.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 05:34:03 -0800 (PST)
Message-ID: <96deb063-f4ef-fadd-543b-e905495898f6@kernel.dk>
Date:   Thu, 17 Feb 2022 06:34:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
 <Yg392sqFydj9p3My@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yg392sqFydj9p3My@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/22 12:48 AM, Christoph Hellwig wrote:
> On Wed, Feb 16, 2022 at 07:32:12PM +0800, Wang Jianchao (Kuaishou) wrote:
>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>
>> When __alloc_disk_node() failed, there will not not del_gendisk()
>> any more, then resource in rqos policies is leaked. Add rq_qos_exit()
>> into blk_cleanup_queue(). rqos is removed from the list, so needn't
>> to worry .exit is called twice.
>>
>> Fixes: commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
>> Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> Ming had a pending patch to move it into disk_release instead, which
> I think is the right place.

I missed that patch and can't seem to find it, do you have a link?

-- 
Jens Axboe

