Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53518C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F51C2082F
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QPJ2Aqxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F51C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLDQkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:40:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35653 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLDQkv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 11:40:51 -0500
Received: by mail-io1-f66.google.com with SMTP id n9so6098804ioo.2
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lro4YL6U5GayqRt30XRLIyyC2kuVyY9MWpPuyG3grVI=;
        b=QPJ2AqxhOC0eimZeCeYpcZc9jc5CKMfVp+M4tYvGodts7oc9xaxfqGMn/4du63cApB
         0LdkEH8242HNIpVdjNV79lbpSb8h6OZANben2TiMZchOJ+MM5bgE612set0iSxhEvJ8C
         1tcd0+oG7janYMfJvqNj0Hs0m/ZYft8oTGn4cGDuPscVm9AQzOtA1V91XEmgAKhyOW1t
         0dxo91ZFeXwbUvLLBb8meo2uPeaaoO7vnosm+I2fE4yv1qPoJ0hH2klA34oGc/sjp1FK
         nS8NsB70eP94nH/MrSERtxCH9WGQR6cvmIE1H1aw7s4pc7zXUcoYbDp+QJnVYnblAV2W
         yQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lro4YL6U5GayqRt30XRLIyyC2kuVyY9MWpPuyG3grVI=;
        b=iL2V7YTL4ptjpt8+c2e2KHif89t9MB3gPPT6D82DMwVhZ6uxrPSHZrHEpFk0abPOtI
         S0OBl6JCncd5sAtS3Udhrdvzk5ImsD3AcLT/nVrOqD64UN5eUVsoHdTSM67KiSsIhKNZ
         cq347vXo72IthrJeFcbIZU/JIgoIGeJ+Wp2kQZVuox3tOcxxmsvyBs7cc3r2P+I/m2bo
         DsYKqpfPVceh+kB/4MFxgI+edzj7Qfr2UK7+3UrKLn1U9BU8YQ85toJb+84wpKSNAWPx
         yHcvLwwVU+6htEcpmtBvJJBmvsQjFlbWNkKgqjRvRRTD3tNwIg4tjgWyI+sdvzlWIF/r
         HXJA==
X-Gm-Message-State: AA+aEWa7FL/2k0zTbt+lvh8nlmVzBmO01wVU7pi92HFKTAAQnZnvCF07
        +SA4jGFgtGLdf34utjFSbHo9heF8IYw=
X-Google-Smtp-Source: AFSGD/UcikYW4zX/zhw/cQbaI9DJDxL1I/8HyARv/tZLU4zNTm7iE1Wbsptxudrxus0zcIk16Mn1tg==
X-Received: by 2002:a6b:d908:: with SMTP id r8mr18846968ioc.160.1543941650932;
        Tue, 04 Dec 2018 08:40:50 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u127-v6sm5555300ita.10.2018.12.04.08.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:40:49 -0800 (PST)
Subject: Re: [PATCH 02/27] aio: clear IOCB_HIPRI
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-3-axboe@kernel.dk> <20181130171336.GA17030@lst.de>
 <75612cc8-aa98-92b9-4a0d-02564add9c3f@kernel.dk>
 <20181204144644.GB3180@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89a9e94e-6d35-ea2a-fa1c-f14ca16e6e74@kernel.dk>
Date:   Tue, 4 Dec 2018 09:40:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204144644.GB3180@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 7:46 AM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 10:14:31AM -0700, Jens Axboe wrote:
>> On 11/30/18 10:13 AM, Christoph Hellwig wrote:
>>> I think we'll need to queue this up for 4.21 ASAP independent of the
>>> rest, given that with separate poll queues userspace could otherwise
>>> submit I/O that will never get polled for anywhere.
>>
>> Probably a good idea, I can just move it to my 4.21 branch, it's not
>> strictly dependent on the series.
> 
> So, can you add it to the 4.21 branch?

Done

-- 
Jens Axboe

