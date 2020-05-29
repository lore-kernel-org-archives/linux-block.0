Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49276C433E1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FDD20707
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eMbcpyG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2OSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 10:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgE2OSN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:18:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6415C08C5C6
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 07:18:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 5so1391948pjd.0
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFk86EXtsKCeDly7uqWscsOEe4rJYmK/9rM41/0cNNo=;
        b=eMbcpyG0JJ8IpczRGqAHzEDKTqvpsH3s/ka7bm8PoFKGgb13AJ74aqjJkqs4HFnQeI
         9Ftiv/KTLFgD6wDD2GI2o4zhGKhq7ItgUl30BcPrUofBUbRhx0n6jJkWjhkN9eV3Gyzc
         MWsG291YGwV+RCpLzy/zkXsuTVhGKwFzL4ACZOCKmPa9Re0FH49dTxjCQnh3/WfmEuZd
         7SdLtFirUMgub6BFRTOuNSvuFG3iEQZ+FwL2Z+hadm/I/rrL3IHaYB7G528vhDF5b0h1
         oCl9K7QUu3w/E9PXc2XnZzXoKgOpkymfnUuwosmkd0i401889fIzrBhY8PwN1l9fEIuo
         rxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFk86EXtsKCeDly7uqWscsOEe4rJYmK/9rM41/0cNNo=;
        b=eOFZsfQqud+s74Ci0lU4GYD1ejEeLtfj69f1nksg2h3P6V4GXaF0ouDs3CCGPBymFh
         rNvoYmmC1SCo7jhH+p3qwgOu5zgbFaLR7V2jb4rgHgbf6h0+Y6sdPTq2UdsxKALEKhSx
         6ObcSvdOyr/trTmmnp9ZpQdNhFLpuz+/PyW6GXjNIAJbflmjeYnE0wb6F9ZA5aS48jeF
         QWmhZ5crLj/DtIqqE6sPd/H0u/PBxEehtSY6wPeHN8ll50vziNTlenPMiai6g2nRapT6
         ZENBoNFbXwEYfsYB5WL/sYrvPut5RNBAkJ4aedfkP/cD5aZ9WYaC7mYmJYc6keH77/Yb
         sqvA==
X-Gm-Message-State: AOAM533+3Jqas0VBI8N3T5IpwV4z7Xg8IS51C6qBAYRuPylNk9V5YJ/R
        uCiTLKeaFnQNaNBq/W+t2Vk7PqC2fB37WA==
X-Google-Smtp-Source: ABdhPJx1ph9FO0uJPxiEel7Q0EiHsxe0gr6USoYYB/1q6mYFBTPzokdsLj4T47urJWipkYn7SGLlcg==
X-Received: by 2002:a17:90a:5aa4:: with SMTP id n33mr9911935pji.226.1590761892021;
        Fri, 29 May 2020 07:18:12 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q5sm7594138pfl.199.2020.05.29.07.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 07:18:11 -0700 (PDT)
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, linux-block@vger.kernel.org
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
 <20200529122746.GB28107@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0dbabed4-d233-ce75-7ccd-c1c9922ecd28@kernel.dk>
Date:   Fri, 29 May 2020 08:18:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529122746.GB28107@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/20 6:27 AM, Christoph Hellwig wrote:
> On Thu, May 28, 2020 at 09:36:23AM -0600, Jens Axboe wrote:
>> On 5/28/20 9:34 AM, Keith Busch wrote:
>>> For when drivers have a need to bypass error injection.
>>
>> Acked-by: Jens Axboe <axboe@kernel.dk
>>
>> Assuming this goes in through the NVMe tree.
> 
> Given that other drivers will need this as well, and the nvme queue for
> 5.8 is empty at the moment I think you should pick up the next version
> once it has better naming and documentation.

Sure

-- 
Jens Axboe

