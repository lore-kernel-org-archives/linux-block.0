Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB5C10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2392084D
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w5KqEqEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLPPL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:15:11 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40023 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLPPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 11:15:11 -0400
Received: by mail-pl1-f182.google.com with SMTP id b3so5283344plr.7
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2019 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Ycgg4Afnb+vlRVtOUwu3IY3C4esXyrX1AS6M3ab8/0=;
        b=w5KqEqEMuxDAsrLWutx/vY9SSLmtQ5MyqTM3zsjy74zQA0di9CjO7bvlb0Yuk7Q9+P
         M/Qc4sk4zkE/CB4cjIknGd9O0TNmU/qvsskOg9662YckOs/auaXxd/+zvYIDEWqfK5Ky
         Nej9fBXu9mII7EXQGrTKjTZaYRlRguetsOUFmECEDNDOA0SXteWmwJTceS4sdzNT92w2
         Su/sNvi+Y1u7lqrzwdZgsQqrnKzuPbJVMiazrCqAyJYS78LBAKUmPasEWJFi1/t9B7L5
         6AZILoHTI0KEkB2RYNyUKDthJ4Yus74ADXhaqJ8jTNsLdbKUc+lFld50j3JHjFiGTfvS
         9oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Ycgg4Afnb+vlRVtOUwu3IY3C4esXyrX1AS6M3ab8/0=;
        b=LqSFYB01wyeL2QDu4TEaxilwPRQI39RugHdcCYrF862kfM1AuUdDKNUULtBYNv6VEw
         pSjVFQpw5mXSXLJSwydmRmiEz8QLML+pKT5ByhXHaYOXCmHMWb7R4nZOvjiT4EWERq6a
         5/XSS5Pyt6OhtuGI2iKCeynhTJE7Z3BFIIMaf9nWeL4g1OSu+XB+BVlSvm6/UE/5738L
         t+jFzzYFWKWWs2mrwrGYAL5nhNqn7Pp02q7bcs/awM7P/q00B+KIiDkewSAmODPx91aG
         s4Gs3H+F/twAkf8tYApL1IAKUViirBrMhl130XNRkbpvv1d4YFRNE97g+XOCOlJqMDzH
         mFug==
X-Gm-Message-State: APjAAAXek8e2u+dNcBRjcpEIwYYWLpmyCfdq90KfclaVhi8sF2QXpq68
        kLoJ2SKJgAQSDRm7FVQwjU5bfexOoWiK8A==
X-Google-Smtp-Source: APXvYqxJDkDGnRD0N6WlRijpAhV9VovGO1dtdK2NHaPcV60tMYgzdNb2k81vZMFgDtXK3Fw3rJ6Ing==
X-Received: by 2002:a17:902:8c89:: with SMTP id t9mr58333519plo.265.1555082109947;
        Fri, 12 Apr 2019 08:15:09 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p14sm46738111pfa.26.2019.04.12.08.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 08:15:08 -0700 (PDT)
Subject: Re: avoid calling nth_page in the block I/O path v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20190411062331.27800-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a5a3a14-0438-2a31-661f-02fcb16dc767@kernel.dk>
Date:   Fri, 12 Apr 2019 09:15:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411062331.27800-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/19 12:23 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> you complained about the overhead of calling nth_page in the multipage
> bio_vec enabled I/O path a while ago.  While I can't really reproduce
> the numbers on my (slower) hardware we could avoid the nth_page calls
> pretty easily with a few tweaks.  Can you take a look at this series?
> 
> Changes since v1:
>  - remove a spurious variable initialization

Applied for 5.2, thanks.

-- 
Jens Axboe

