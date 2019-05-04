Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC56C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF912086C
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 13:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u8tHeUIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfEDNYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 09:24:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34342 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfEDNYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 09:24:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so4135220pgt.1
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bi+tTaf/wZxULvPr2R5pEUvps2HmQg1idM+DekrMjAI=;
        b=u8tHeUIArZl/2gl/zOQqrYmvl47md4nlymszpwZWufaZgh4j7ODuju9pOVRMmkQbBF
         YtYNHRyOEVX4iGChYe3/ZJHcoL9qWjXaa9/Nzql9mXhfKRiysoIG9GdGK5qYGMipv2ym
         F9BfA7xXPe1V3/o56bpfLWwPsvlrn8HoC1QVVJPNGLSf5S0GXTztD3FVGJK2LSVa89A9
         sSMEmMIhxCCOImghVvFABJYMW9mx3XgLRXLrm3rbdHjnUYYN6NqcGuvRC+8yf3cfKtEb
         5E7f8Vl8vbmLJVYrCZYYsp2Ds06nlU+5/s3FR0UI+Vyb9wmnIrXB2uewCI71jTSD76vf
         oy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bi+tTaf/wZxULvPr2R5pEUvps2HmQg1idM+DekrMjAI=;
        b=fFIXClJDeDhgto6eSKqO3OJgyzf7bHCfdOJG1UkJjPUWI41MfzUwPxReLqSHNV80RM
         XAd4zHDMs7Tg1xHUI2pLYVzCG+o3GrlhWKv71rQl9u61qw0kqDumJDnJpdT3oVh6mAwV
         TUmd+Ez9jZ7WvFhKfYv6lZhSneO6euUSIpo5U7DuJXX3SFP7DYwp27uSDtm6ObEi3Nwu
         Suc1bKOiVmvmDUysb2Fx0+gp1RsX2gNkfCrIY4duLhJUsh4T5XhE/jdDA3xtbGjEZiwr
         8xmmbYZDgp9wV0GWU/zjPc2MMJHR01aBQ31hhIKn8kZ4T1qoyUl61fE8CLXU/W1paXQg
         QmoQ==
X-Gm-Message-State: APjAAAUvIwYga/8DR2aqHf/Rbm4pC0ru4JOjxErz9fZeaeFfHIMia6Sh
        RcYrDrWHveimR0FMK5TpJ4JhHQ==
X-Google-Smtp-Source: APXvYqzFgKCFnperPrSbKjvxIIJ92eRIQ3VPsqwuoN0rKXHq5pO3DA42F85jV77P4i65nJdPAHFAow==
X-Received: by 2002:a62:5fc7:: with SMTP id t190mr19203370pfb.191.1556976285412;
        Sat, 04 May 2019 06:24:45 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g32sm6079343pgl.16.2019.05.04.06.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 06:24:44 -0700 (PDT)
Subject: Re: [PATCH V9 0/7] blk-mq: fix races related with freeing queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190430015229.23141-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2472816-1994-be7c-239c-865a915567ef@kernel.dk>
Date:   Sat, 4 May 2019 07:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430015229.23141-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/19 7:52 PM, Ming Lei wrote:
> Hi,
> 
> Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
> allowed during cleanup queue even though queue refcount is held.
> 
> This change has caused lots of kernel oops triggered in run queue path,
> turns out it isn't easy to fix them all.
> 
> So move freeing of hw queue resources into hctx's release handler, then
> the above issue is fixed. Meantime, this way is safe given freeing hw
> queue resource doesn't require tags.

Applied, thanks Ming.

-- 
Jens Axboe

