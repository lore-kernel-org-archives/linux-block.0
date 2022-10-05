Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD949C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 21:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJEVBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJEVBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 17:01:07 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42F80F7A
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 14:01:03 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id c24so16514235plo.3
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 14:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YyPa4QutzSzg5FtKTYZeZ9GVQi8e2JCl2v+MTBZO42M=;
        b=vqcMCflE6+0+7e5nRJm9O3lJeW8sbOlkSoVqqhIj2NVnyYeztr01RDyyke/nsMTv8q
         tpMwohaUwLHFeEoDLH1im9cY2pCEbkApLB67J/aD4KOFvLFoXIGxJRSNLwihMeGDXLZd
         rNqGqBedeIfI49VSLbew3OcZIy2ajkxd6QwzDmtx9NXRecEAi5GxihseBFLn/D2Jh+K9
         tEMuOzYVu8wYKJhwGFT+NyJjepRR6Il9ZFDb4rie3NpYpTiVYTptT7+QiGtERNKIMkUB
         FXB1iaQISeHkL/haurgE0kybGIEE3NHdMs6670LoDce7y0eQavWDHkS9z1l7D/Pifr9K
         tC/g==
X-Gm-Message-State: ACrzQf3iBEqGQ6QT9UkmA4qnTGfm13dhfKpSRm7IFCKPbxyXfUAwUTfj
        gJcP4kmqMOnSBl8GwIGRZSA=
X-Google-Smtp-Source: AMsMyM7B1q0WYUakEUmGylbiUw4OcOi3ZfhPslXjDT98zBXtWdDQeM9F2NY7UnZcGWVUkaWr99G+Dw==
X-Received: by 2002:a17:902:f549:b0:176:c033:db03 with SMTP id h9-20020a170902f54900b00176c033db03mr1162340plf.109.1665003662768;
        Wed, 05 Oct 2022 14:01:02 -0700 (PDT)
Received: from ?IPV6:2600:1010:b028:54bc:3c2a:11bf:3557:f843? ([2600:1010:b028:54bc:3c2a:11bf:3557:f843])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ab8d00b001782aab6318sm10875818plr.68.2022.10.05.14.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:01:01 -0700 (PDT)
Message-ID: <80477886-ed25-780f-a6ce-e38f785d6ed8@acm.org>
Date:   Wed, 5 Oct 2022 14:00:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Supporting segment sizes smaller than the page size
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
 <Yz24Ghonv2xmplz/@kbusch-mbp.dhcp.thefacebook.com>
 <6fd41ef7-a281-cf1b-1f1c-987679abfb24@acm.org>
 <Yz3WmusgrbomYqTk@kbusch-mbp.dhcp.thefacebook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yz3WmusgrbomYqTk@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 12:10, Keith Busch wrote:
> On Wed, Oct 05, 2022 at 11:23:32AM -0700, Bart Van Assche wrote:
>> That's an interesting question. Your question made me realize that the
>> bio_map_kern() changes I proposed can be dropped if the code for counting
>> the number of segments is modified to support small segments.
>>
>> My answer to your question is twofold:
>> * Splitting segments in a driver is easy to do if that doesn't cause the
>> number of segments limit to be exceeded (queue_limits.max_segments). It is
>> the responsibility of the block layer to split bios that exceed the maximum
>> number of segments into multiple bios - this is something that cannot be
>> done in a block driver. This is why I think that a (small number of) block
>> layer changes are needed.
> 
> I believe all bio's that bio_split() yields are supposed to be usable as-is
> with the driver that created the queue limits. If the driver needs to split
> further from there, I feel like that means the limits may need adjusting.
> 
> It sounds like max_hw_sectors is inconsistent with max_segments. Shouldn't this
> work if max_hw_sectors was set to 'max_segments * logical_block_size'?
> 
>> * The blk_rq_map_sg() function really needs to be modified to support
>> segments smaller than the page size.
> 
> That's surprising. We use that in nvme where merges and splits to 4k segments
> are required, but it works with larger page sizes.

Hi Keith,

bio_add_page() can keep adding pages to a bio until either the 
bi_max_vecs limit is reached or the bi_iter.bi_size limit is reached. 
Splitting a bio involves calling bvec_split_segs(). The latter function 
supports multiple segments per bvec. Hence, blk_rq_map_sg() may receive 
a bio with multiple segments per bvec. This is why I think that 
blk_rq_map_sg() has to be modified to support multiple segments per page.

Thanks,

Bart.
