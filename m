Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6BC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EE420823
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WoMWwYYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfC1PHV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:07:21 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:39524 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1PHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:07:21 -0400
Received: by mail-io1-f47.google.com with SMTP id e13so17501505ioq.6
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=laNgreeFIbw83SNwdt/N1Nr9Ge8tGRgnWVJtil+GanA=;
        b=WoMWwYYhcVkl/oe/xFeZjCuk8dRrhN4eAHPYP57ay8ZpPRZM8pgea9KJ9zk0+WSIiN
         0IIwYN3mCpfChZoG/QjsNhCuO4klusbhoQe3f7LPsjmAXm2Lm8fENb81QcWCD6bRPCAJ
         C3f5HfLDz2Z66P9xMCNfs42caPQS14ljBrIIP6/yMZUHEszalJjtFvoBrKw3IpMpt1cD
         fGT4Q4KS3KJR3haVQrlEvYTgY2DkrzdBndbEAK4loh6uKfpiQjek+JGB/wo6g1yq3IaT
         vxNxvkz9bXxuqQcPHHscOVN6a93YcZ/qku3zrR8uVW7nDrMf6yzVu883YQ3S3gBlq+l+
         I6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=laNgreeFIbw83SNwdt/N1Nr9Ge8tGRgnWVJtil+GanA=;
        b=sWr4DGwJ+0UuK0gPrZyKDCHr1IEIbp7sS1gRayDBgPN2Tfzdd5vQYzQNfjgzYIPe61
         LiNUFgGYkTN/2yJnkAejNXHhiiUj8sM4osnqUPunHKJhSFhpir8TdGNODVZROCAwwNkZ
         T/hVFDpDQUyUQLDwvY2BibRMNVDRpH6Mru2+swJ9WteMRYKmHRwxdNKIhVHKMGk+5oXw
         BwHfCzxwmsr5UfILgBBvL07iApUvWg9YQ4vtjy8ooLyyOOnJ8zoNh8Rg5xDbiMnXLk+x
         ZrhPVfPfegQH85T1NfSwn9aKU+rhXC8y5omdUhkr0BUMLfM9PT7A2OQNvyEIzedrLDtL
         uTlg==
X-Gm-Message-State: APjAAAVr4EHLN3vYD87RRT6A4/y7YBezAgwWut0egeM7rLZxXnmcX40Y
        cxmOeOj12MZw0GG9PSyNNHVIKg==
X-Google-Smtp-Source: APXvYqyRIyve+Hb2GTkzntkft3F9PDROKMrVaSLE3AkPNFZp7UMHu5uxOlunQFIF0+loxl8bqEk4ZQ==
X-Received: by 2002:a6b:b757:: with SMTP id h84mr30822442iof.193.1553785640228;
        Thu, 28 Mar 2019 08:07:20 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b17sm11519296ion.0.2019.03.28.08.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:07:19 -0700 (PDT)
Subject: Re: [PATCH] block: loop: mark bvec as ITER_BVEC_FLAG_NO_REF
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190328030531.28279-1-ming.lei@redhat.com>
 <20190328150224.GA9265@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f14d6b1e-2853-cc79-363a-34b5a0596930@kernel.dk>
Date:   Thu, 28 Mar 2019 09:07:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328150224.GA9265@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/19 9:02 AM, Christoph Hellwig wrote:
>> +	iov_iter_bvec(i, direction, bvec, nr_segs, count);
>> +	i->type |= ITER_BVEC_FLAG_NO_REF;
>> +}
> 
> What about simply providing a iov_iter_bvec_noref in core code and
> also using that in io_uring?
> 
> Otherwise this looks fine to me.

I'd be fine with that helper.

-- 
Jens Axboe

