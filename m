Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF87C43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 09:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF8A20851
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 09:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF8A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeKTTkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:40:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46644 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeKTTkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 14:40:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so608903pgp.13
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 01:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+q5C+uYVKKPqSoB1P44kuuer33ia3HXfMmyHtl6CaQg=;
        b=at70GId0mP7cPvsCweL7AtZT1J20EhtlpzVJWjIDl7MTm/OEzROatSuneSiaqXkwgv
         Dp0oBRnSZwgdr5TVWA21DPWlUpluxZDm5U5+seSAxmaPO94taAyGOyFHRjdZCpUI3q2k
         0BWHihnTJHJXdFJaVdu60rvyUlpvVx7YupgyihT3jxRGWWWznT/FboeUHxz7wNyO/l0Y
         xuNLUhGkdw6imG2BFAE60nuHqny6bVQwOeE2dV2YgmXCksYE8EYkhTFg1Rf7aOBupmt7
         2ufsVb37gDKgdFD831/t4Vw2SP58J95bto9Jev7Zp5nV7rSDYSXIhgMXwsSL3mzeaxNv
         HeZw==
X-Gm-Message-State: AA+aEWZnEKZ0ptmPeH71Dc9Kq18IP3aNvwqq8ZLnlt/IIZtXyma7GCIH
        3kZ0InTtSGEtoXc2gFE8+1kxT9yP
X-Google-Smtp-Source: AFSGD/XGxIpeb5dyexE3wp6S8i3Ns4lcA7eyEQw3nMBBb6hNJYrcJh1/Ds2uoD1v4SvqPtViD8fBBg==
X-Received: by 2002:a63:e001:: with SMTP id e1mr1179803pgh.39.1542705118852;
        Tue, 20 Nov 2018 01:11:58 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:8a0:7611:3223:f4db? ([2601:647:4800:973f:8a0:7611:3223:f4db])
        by smtp.gmail.com with ESMTPSA id z62sm25646716pfl.33.2018.11.20.01.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:11:57 -0800 (PST)
Subject: Re: [PATCH 6/7] block: make blk_poll() take a parameter on whether to
 spin or not
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-7-axboe@kernel.dk> <20181119080544.GF9622@infradead.org>
 <04b6015e-2949-750d-01a0-640373b406ea@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5caad4a6-d9af-df12-1eed-6d2c9906457f@grimberg.me>
Date:   Tue, 20 Nov 2018 01:11:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <04b6015e-2949-750d-01a0-640373b406ea@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> This opportunistic poll is pretty bogus now as we never set the HIPRI
>> flag and it should probably be removed in a prep patch.  We should then
>> later try to use a scheme similar to your aio polling for the nvme
>> target as well.
> 
> I'll kill it in a pre-patch.

Agreed..
