Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CACC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 20:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF242175B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 20:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EQqHA3tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBGURB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:17:01 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56319 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGURA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 15:17:00 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so3076992ith.5
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eWdV9oggX+2zVW81kQHySe9y/J3WKQbCSO+0nFXDmB0=;
        b=EQqHA3tlpC4eRc/TDthcCJn8aDQEomCnYR/A5lbPXBC0yhSqoLJiqmVk8Obf5SnzyM
         6SlRczG/BwXccLGHGr9v4fWaijvECnNTOTdROInkKBXXZ/9OFWYw8FxXgga0RLNxlsQw
         IdxprB2niG7YXtL27foonqGPdapDHUoef1pFzDDEkMeU87bY3mFhsxG/EuegdZEmDz1D
         nC3NhUfWtb/fulwpLefIhkp5o3vl1DLzH2kBzAqAMqT8XkiXj94NLhaceggWJRoAZFyA
         TDODiDEaFpUdE1nrgcGVs8Mr4y04QxE5ujsxJJ1Z6yJTWDatV0mHPX08ytvKhyDRWHQf
         3C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eWdV9oggX+2zVW81kQHySe9y/J3WKQbCSO+0nFXDmB0=;
        b=FZVqrKw0RYlNQZMsdiPGZnb5zES18Tb2YRunfwaGn7S7Kq4gwQO6O1s4fecIItdaf4
         CFSHj0wJwi0cP8I+ZBp6uvZH3gx3ukiLdQ2xLzSUH66M/ldjlpKqzvfk32B3hLjVlnJm
         ZvMI3CYqf8j++celFEPH5gl+T/wBDGJ+B16hG6wGx8cJuVbs250lebGYvKr4bv6RGzdT
         G7MFXY151fS+kVsPnxJ28olFrMZBBWWJe21ZBRam3CG8GIOzEW1eVPTEtFyTTAfVyBUB
         rIV0pwR8KiH+SdXt6x/NFjKEMDFb+rjOHI5/yw5Wre7CrkmMTC0pJCNRUyEQyPXLQdyW
         rRXA==
X-Gm-Message-State: AHQUAubmSrOmWuHIppB9+5qffIWBrDtUVSU8BNRRt1+K9nlluTsrtSSI
        8hNsDienJGxZuB+oXzF4r3Ojfg==
X-Google-Smtp-Source: AHgI3Iam8OJmAAurnJ8LQCuWnOWpIij0mc5R9kngwwmpR+ftCXHFkc0EZ1f/7/tU7jGQ31/wdrf43w==
X-Received: by 2002:a6b:b7cf:: with SMTP id h198mr9705160iof.175.1549570620006;
        Thu, 07 Feb 2019 12:17:00 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i135sm149163iti.34.2019.02.07.12.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 12:16:59 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-6-axboe@kernel.dk>
 <20190207201508.GA31594@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8acaf8cf-6b5f-1435-aaf1-50449c6a49fd@kernel.dk>
Date:   Thu, 7 Feb 2019 13:16:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207201508.GA31594@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 1:15 PM, Keith Busch wrote:
> On Thu, Feb 07, 2019 at 12:55:39PM -0700, Jens Axboe wrote:
>> IO submissions use the io_uring_sqe data structure, and completions
>> are generated in the form of io_uring_sqe data structures. 
>                                         ^^^
> 
> Completions use _cqe, right?

They do indeed... Fixed the typo, thanks Keith.

-- 
Jens Axboe

