Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E01C35247
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D342084E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 20:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AVuAMkdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBDU7s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:59:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36321 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBDU7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 15:59:48 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so22624108iog.3
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2020 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wcoCSL79vCMpL4xbAIQZtZxYV6URdwM3aAy8gbih72U=;
        b=AVuAMkdQ83IhrPAGvOB81omosd9y2/W7kJ1IbTzAd03hFvfCnuKBf9QFkq7mPPjo00
         xipS9/+FIBcT6FikYTJqnkp8UYcIu3aUpD9bTIU6qpTmb37ladSbLuknSbi1p21Tzdg+
         wyc68t8WGZFkOpz73QxOYrqbPoyFu/LhVqdZS2/h59aY3ofahzFDvCGpv+/8p6bLIfUb
         8SGOethG/GmI3OXXBM/9v8MzbHZAnc7sLlQ3GONt2yxLiDbUXRyLDFMbkjTg+4aMkwUS
         4jrdzKurScXFy82HdMoNHSDoluNV0Ms4euWCWC9xnGbH//vz9m9HO6glOoaFEGNkKJ4I
         nNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcoCSL79vCMpL4xbAIQZtZxYV6URdwM3aAy8gbih72U=;
        b=WEnejsdRKx5iyFftZEHfRHNxlh9ddUpgP9ajZroaCc0TxxNmacONLtexlsNOJUeVKz
         8LWxq3xeqkTT38xAPkA9TZrhuCC3+f1x7LlmjJP2tdv1jVqkTMYUnb1AMrdA8EsxXOlz
         KrqhikC5lgHlPc+U3JYOm2zkak+At5qun1XSiHb9OUo0ZEQToEv/EEPHqU5SmDL6SqK0
         biPs4Aff9idRKkllZXG07NEJWrSFl9ro1gA2m2GAJeb+lHkcJbl/YMi6uyRPCYqoA/aW
         BX2x6+NUAO4xqiN1M4vyzDaKy0K7Dow9PSyJ9OIYU9iLVGGRzU0Z0Vt3ccZ94LleJ+KY
         nBhA==
X-Gm-Message-State: APjAAAU+gR7e1BM1EGZQ7UdaYSfvH9DfEqP7BLyLMbtgv0Iu48zSfQs7
        z3TgJCrOh+DFQ4cL7+/7TSKuhA==
X-Google-Smtp-Source: APXvYqwHasdSja9IbPNJm+N/4hDJQSShJ6cMBEbdL/EmsnMKk93VlHXamEEowYviNlWzEQD0PlBckw==
X-Received: by 2002:a5d:9285:: with SMTP id s5mr25050555iom.85.1580849985986;
        Tue, 04 Feb 2020 12:59:45 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm6213345ilm.74.2020.02.04.12.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 12:59:45 -0800 (PST)
Subject: Re: [PATCH 1/1] block: Manage bio references so the bio persists
 until necessary
To:     Christoph Hellwig <hch@infradead.org>,
        Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <1580441022-59129-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1580441022-59129-2-git-send-email-bijan.mottahedeh@oracle.com>
 <20200131064230.GA28151@infradead.org>
 <9f29fbc7-baf3-00d1-a20c-d2a115439db2@oracle.com>
 <20200203083422.GA2671@infradead.org>
 <aaecd43b-dd44-f6c5-4e2d-1772cf135d2a@oracle.com>
 <20200204075124.GA29349@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46bf2ea0-7677-44af-8e23-45a10710ca3d@kernel.dk>
Date:   Tue, 4 Feb 2020 13:59:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204075124.GA29349@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/20 12:51 AM, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 01:07:48PM -0800, Bijan Mottahedeh wrote:
>> My concern is with the code below for the single bio async case:
>>
>>                            qc = submit_bio(bio);
>>
>>                            if (polled)
>>                                    WRITE_ONCE(iocb->ki_cookie, qc);
>>
>> The bio/dio can be freed before the the cookie is written which is what I'm
>> seeing, and I thought this may lead to a scenario where that iocb request
>> could be completed, freed, reallocated, and resubmitted in io_uring layer;
>> i.e., I thought the cookie could be written into the wrong iocb.
> 
> I think we do have a potential use after free of the iocb here.
> But taking a bio reference isn't going to help with that, as the iocb
> and bio/dio life times are unrelated.
> 
> I vaguely remember having that discussion with Jens a while ago, and
> tried to pass a pointer to the qc to submit_bio so that we can set
> it at submission time, but he came up with a reason why that might not
> be required.  I'd have to dig out all notes unless Jens remembers
> better.

Don't remember that either, so I'd have to dig out emails! But looking
at it now, for the async case with io_uring, the iocb is embedded in the
io_kiocb from io_uring. We hold two references to the io_kiocb, one for
submit and one for completion. Hence even if the bio completes
immediately and someone else finds the completion before the application
doing this submit, we still hold the submission reference to the
io_kiocb. Hence I don't really see how we can end up with a
use-after-free situation here.

IIRC, Bijan had traces showing this can happen, KASAN complaining about
it. Which makes me think that I'm missing a case here, though I don't
immediately see what it is.

Bijan, could post your trace again, I can't seem to find it?

-- 
Jens Axboe

