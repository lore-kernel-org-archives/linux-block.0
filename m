Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5424DC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E738F2243B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XT2i3wCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E738F2243B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLFTOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:14:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37935 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFTOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 14:14:33 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so1278407ioj.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G5QoLwe5cf9eZn66KsXnLuNTDEFGByiadWjgqtI4qcg=;
        b=XT2i3wCNJgzDt04u1ZfTZNjk6mZWFD/dso6h3WqFqJAUolU6WYtIRDaMQ/F3T7ZN4d
         6+CKN63/15gYxLDnNSdilpGYhJ+cwcVRNmCG1SPU1ilhgjt5Y9wjbHMekakMQIJfWOJ/
         Q6gfXXPs40LUdFi0MLa9jH6r4jfUQbW5CGIbIRRWZqkYZ5vT4en6pemg1NXWvwpbSKd7
         J6dfJowhD3sAdlEmEPNRBk3iQbsHUoA4xmLryG9Hp3ugnZalBZmabTBzjZAa9tnSmZ2c
         KX6MoIh1yoN82ZXDWPGK7Z0m6XFojrh73hVc3sQnMFtBRcEcnyQOJbyJKA33LhC+KGRF
         PS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G5QoLwe5cf9eZn66KsXnLuNTDEFGByiadWjgqtI4qcg=;
        b=cok0hWByWWsOkqlH6BwqaRa4edLBx7dMWe8ReZ7JnRh25j8cEK11vNOUVE+m2bMn3J
         D75VQaAWuMZ9miMwWJUzc8eHzvvel3bXCGFbLJhsb7hH9KJFbdeHAiIfhsK0jQSYw/Ux
         ersvtpGw0MHVTrzpA10TxN/9MfuOmE5/SWejy4uVIWbzgV85jFUcTv2QrwsETdSenBAq
         l5oCLo786Syd0uZxWGP3cyRhUpVBoUFlmtdwZgl9LQiFKgPLeNtcs5jB0Rk+siQUga17
         M0CO5ApA/wJZUiMASM7mjZ5iN1TBChBJslZmktPHg2EnZ9uH+eVy4DT99PkaSJ+hYgit
         XGXw==
X-Gm-Message-State: AA+aEWZLByfOwkgf4vY79rduyHbumTJQbNoPyPZUQB/HDFSt75C39N+e
        kaMImJqLEewk9x5EWDm0TWw8WA==
X-Google-Smtp-Source: AFSGD/XBrsbpNYjRNwVKbVK6sVsIv8ipQlVsGuIXxR2FXsSue5ZsdVEKz7N6e95u59I4XWNEtfMFrQ==
X-Received: by 2002:a6b:6e17:: with SMTP id d23mr13713061ioh.138.1544123672124;
        Thu, 06 Dec 2018 11:14:32 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r139sm687980ior.53.2018.12.06.11.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:14:31 -0800 (PST)
Subject: Re: [PATCH 03/26] block: wire up block device iopoll method
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181204233729.26776-1-axboe@kernel.dk>
 <20181204233729.26776-4-axboe@kernel.dk>
 <x49a7lih3n4.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72b6acc7-5017-a72c-3fb0-90e5ad95ebb7@kernel.dk>
Date:   Thu, 6 Dec 2018 12:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49a7lih3n4.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 12:11 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> From: Christoph Hellwig <hch@lst.de>
>>
>> Just call blk_poll on the iocb cookie, we can derive the block device
>> from the inode trivially.
> 
> Does this work for multi-device file systems?

It should, that's the whole purpose of having fops->iopoll. You should
be able to derive it from inode + cookie.

-- 
Jens Axboe

