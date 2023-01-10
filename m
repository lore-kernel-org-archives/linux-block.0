Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC74C5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjAJAsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbjAJAsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:48:12 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3CD186E5
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:48:08 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c9so7543557pfj.5
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSMUVg/HGrysYwnbuLGJkjgD4ezWIKJ2nAJYbO2DGy4=;
        b=AmhEGuTFCVPM5rEDAmfpq2YAdk6bP+GPcBWm0gmwVEUcbcrA60yf0lF1jsV63ypGVR
         bpJiqsnFuUXylULPlLrr+32KWw3hZskynlymrW0GToTzy7V5VG7kLu2Kj+12eSjdZSeJ
         VnkhgWnkysVMXQu869nbgBqi/L2TUGgSXXITAoPgfzKs1jblzdW19t3094Jh2TpI9WWO
         muUvK5n0q6dfbHrPdA95Pz5zidKilZVWCMRL0WJrZjxtKocWhne6QlSbXD+ta1aOfmj+
         eJHRlVFZGS8DfgUNRTP4pnTjJtlSu/a2Ftb1afpolFxrNa/LxQ5lDT96y6b0ZWr2zFuJ
         YNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSMUVg/HGrysYwnbuLGJkjgD4ezWIKJ2nAJYbO2DGy4=;
        b=nfCNkpkJeCNB4W4IIt3ydGJ3UNFg3bpkocuTjWSDgw67gh2QKlgAPZ1aoqY97xvrtb
         nApg4J1wkStZ0c79DFwRa+reHmEsBYLnBjNh8hOsuhyl71DtGjpAvCl9Z1kAqq+FiFR5
         bzc+7mZesnRm39Il8z5wLx9PK8QKvvvEp+tdKqomGT2fLhY+vzHthhKFLdBhmOL+JWRf
         HmDyM3ajkEEkmhX4OQbvK+QzjsoOmtYgn4hJCPE4rF20MtWQfgeGptG1LZafcVlcH8bj
         61n9z/d74o++f6B+xXp1HXVBUxHvM4a7TFhZHs5h8h4mjypZhhwNcuLiRuuZOYSBsgOL
         IShQ==
X-Gm-Message-State: AFqh2kpDo/iBIZ5D0wMjmEdh00piKbjO/1KWYRcPv6/tENmPWozuytyV
        LSBtBQ5weUvktX+w9CFYNgcnxQ==
X-Google-Smtp-Source: AMrXdXu/Jmmyza3z+XDRcgpDS7GCQUAR2GX2+ZwfocA782InwbWuPAk1bt5WlJz8WdFyYct8ekKwZw==
X-Received: by 2002:a05:6a00:2a0b:b0:585:4ca7:5c4b with SMTP id ce11-20020a056a002a0b00b005854ca75c4bmr2673017pfb.2.1673311688273;
        Mon, 09 Jan 2023 16:48:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g28-20020aa79ddc000000b00575b6d7c458sm6693177pfq.21.2023.01.09.16.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:48:07 -0800 (PST)
Message-ID: <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
Date:   Mon, 9 Jan 2023 17:48:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <07084f70-00a7-d142-479c-52c75af28246@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 5:44?PM, Bart Van Assche wrote:
> On 1/9/23 16:41, Jens Axboe wrote:
>> Or, probably better, a stacked scheduler where the bottom one can be zone
>> away. Then we can get rid of littering the entire stack and IO schedulers
>> with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.
> 
> Hi Jens,
> 
> Isn't one of Damien's viewpoints that an I/O scheduler should not do
> the reordering of write requests since reordering of write requests
> may involve waiting for write requests, write request that will never
> be received if all tags have been allocated?

It should be work conservering, it should not wait for anything. If
there are holes or gaps, then there's nothing the scheduler can do.

My point is that the strict ordering was pretty hacky when it went in,
and rather than get better, it's proliferating. That's not a good
direction.

-- 
Jens Axboe

