Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D728C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F043E2184C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EOWVRRC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfC2Ow6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:52:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43066 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2Ow6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:52:58 -0400
Received: by mail-io1-f65.google.com with SMTP id x3so1936677iol.10
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v1XtLTr1K6swEx3CJgkH54u6qz6ypOXvifoMMR/CsHo=;
        b=EOWVRRC/wMOV5DZLFqp+iRi3G96Ra1DGX/XUinCeVaxSrQwYhNWEqvaIXffsd+IbfP
         zFMXWTd2L8QV174gHKhdf2SXvFt/sRjwAMn5Osx0S+RrcHEMPpQfSHff7/faJ3tF0C5G
         AsBJfS0gm6bxuGlAv0bhfSchPzyaVLJ9HEj9VVeD34fm4Hs5y6pCutqLNvyjL0CkzthZ
         1EuSKY8xT6nE49gtyNcd0jiXV+Cf5SobN6ZWmwV0p4AsZwMb2MLHtTFEpfgmFjEMYKnz
         iE0PgPZeI/Q5pmKZJOtDjQbcQsGFABEy1DLoRm3xIrLqCrnIWkBMXCOCmePKkwR/+QN9
         e2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v1XtLTr1K6swEx3CJgkH54u6qz6ypOXvifoMMR/CsHo=;
        b=uevMj2QJT5amvEHr3frR7W6hTR71rU1wcrh3ZPtyAWFOD+B0C2rLAqSqbKhcSEMvUo
         ejwc3S/PCJJisNsZLH6TOP1qx1dv8sGH4mVBa7EKaDJoMf+pvAdfJGYjWBFf/AbgTPIA
         iHGfkWvxEqB2OyTwgX7oQzjsb2dsAGYNq5/tCQqj9rw84IhapdQEBa213Uy4yNIfXlX/
         xQm7XuPMfAAgt4X7QSrVLB9Zdzt/R8q6gCuXuqnnqYqGICmzyOgxeIJpYyuID8SxQYOM
         UhGo7ecI6DPvJcMNz84fySdvYWdnBqZAxoWp1o77nM1sw8Jk1lOCAYeyCma+NL6uP34K
         Uw8A==
X-Gm-Message-State: APjAAAVEvfYvENTuHjRhp6SjiG4znFSSYdVWj0bKNCTYJhXountSR9Z7
        hHNehun+C3CC8bxwiWycmfmq8A==
X-Google-Smtp-Source: APXvYqyt0dxNvrMaZd/luTaUsgFcKTb55m1goLw59eGNiR/dVyCxdRJwALjC6LarYU+5Vou21eZJ3w==
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr37355618iop.33.1553871177578;
        Fri, 29 Mar 2019 07:52:57 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v10sm837300iob.30.2019.03.29.07.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:52:56 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        adilger@dilger.ca, tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> <yq1ftr5rbq1.fsf@oracle.com>
 <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk> <yq1bm1trb4y.fsf@oracle.com>
 <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk> <yq17echrax1.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
Date:   Fri, 29 Mar 2019 08:52:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq17echrax1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 8:51 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> The integrity stuff still has that nasty pointer in there. It'd be
>> nice to get rid of that as well, and hide it all in a parent container
>> of the bio.
> 
> That's fine with me. We really didn't have that option a decade ago.

Right, but now we do. Hence trying to nudge things in that direction,
instead of adding another pointer to struct bio for a new use case. I'd
much rather go that route, instead of unionizing with another pointer
that should be going away instead.

-- 
Jens Axboe

