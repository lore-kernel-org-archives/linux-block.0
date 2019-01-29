Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D040EC282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 13:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EC520882
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 13:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sKjqd918"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfA2NUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:20:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45381 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfA2NU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 08:20:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so9315105plm.12
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UzLOb18K11OsNberZck0wuKlPNfkrhdj0gwIdvtpeDw=;
        b=sKjqd918WV1jTFTdRJhciwHjJJEfWhmDghOCOrKrhZCp5T3xNhLt/lVmLOrEauLrx4
         LNMEfZ/zaA3pbchTHm4b0VOAwnKzxprGA3immq5jc83kLEasN7LYKAolE3tyLkbXdPJQ
         UE5a28aaMaPsZ877NlX5wOV3BibuPLYmdVaDAdgIvUbYBtLbjaHFg+EuQR4GovWTIdOJ
         N8Jqn2kQD7lDXEcXpiynTBHAvFW7RUCYp81VB7wMjoyknDO5oOdq7RViQzsPSqFXZO/Z
         TjkGAywBvvR59sxE7Ips5jyTDEcaFCzT2lGFeIXiWSCVSWfzTZVD7g0U9mn9lhHxvCjp
         3h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UzLOb18K11OsNberZck0wuKlPNfkrhdj0gwIdvtpeDw=;
        b=tS5fyyg1TFPhy09GVUtqMglQqeE7jJZZBSEZvG8qx8NS+AuFkEemwqFudw9ljLtP6/
         7avVNfSmqsjf7+L1SbXQOTf/ryFzsMJWzAWiATKyF8Sz8qb5qUTG7SKXdPgm+JzTgNbh
         3gvgSeXTcFwKUYDSP8Sb7VljAXC9IX6cD1pprwZwY5lDl0ttJ7qJR3i5oXinF3V0eEMn
         Rt48FWZc/shXy+Xi9N3V3bqWfXmkANUMYz4o25DNbSEDqmbf2ye04FPX/mpC7pnw710H
         ZU7bZd0pHNfJjeB+qsavgJ5IePAwcL7VpKYUjF6WTjwuDSUTgvIMwmVileke3FBuaRKw
         NBNg==
X-Gm-Message-State: AJcUukdXi9nmOOF83JyKOr/cC7HXOhDEvnq+mJdMsVNjjl68T09d8txT
        iq0NKBROVSQoOg3MInV2xvmSjX5z9ro=
X-Google-Smtp-Source: ALg8bN6pJHdtCxxJj9g87QtgLcGhTlklXRxxb83mw1bO6cU2uaTzQ/PrdRVayLO9GwLJo/346HJt8A==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr25641468plp.36.1548768029210;
        Tue, 29 Jan 2019 05:20:29 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o189sm65723088pfg.117.2019.01.29.05.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:20:28 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-9-axboe@kernel.dk> <20190128150240.GA10110@lst.de>
 <faca4aec-bf73-bece-6509-46137c7b7b44@kernel.dk>
 <20190129062742.GA2996@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b8d681d-f418-dda1-ec80-45c192e9b7e5@kernel.dk>
Date:   Tue, 29 Jan 2019 06:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129062742.GA2996@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 11:27 PM, Christoph Hellwig wrote:
> On Mon, Jan 28, 2019 at 09:46:17AM -0700, Jens Axboe wrote:
>> I think that can go both ways. If we create it early, it'll just be a
>> pointless helper. Don't really care too much about this particular case.
> 
> Without the no-op locking fix we don't really need the current
> __io_cqring_add_event anymore, so we'd still have two somewhat
> reasonably defined helpers.

Yeah, killed it, which also fixes your complaint about adding a new
helper in the poll patch.

-- 
Jens Axboe

