Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E9C433B4
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AEE6145A
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhD3VNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:13:37 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:44942 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbhD3VNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Apr 2021 17:13:36 -0400
Received: by mail-pf1-f174.google.com with SMTP id m11so6165106pfc.11
        for <linux-block@vger.kernel.org>; Fri, 30 Apr 2021 14:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJVRbjgMjkBqhc3MOP/kRS9kVrpbjy+Gj7VZlV7M4Sw=;
        b=FZuVYpOjSiU76V1B6t4g0VtVLf5q+9vts41DhsyYDdPCYT8nvvXsM+1AiT00k9ZGNy
         GE4CRcFOS8OXlG7aWR7LUl+N8gQxRSsq80xXnUo1V/Ls5IaV78mn0S25W2oTAX/fu+tz
         YNSUW3vjWWHAlo/7Jh0NSa7Oq+dBOSggJy53HzLntLVdbIUp5TV1RM+rSk2Wg+wwJLYg
         ozido7TF9+HAGE5fj1GgBv56Js3Dyjb1+pyicjuKA1M1mZIAdHAuJflXIef0NPSM2J0X
         QwNbeOkEJWOxX/wyuU3YpTZ4I0eFCsXf7zTTYkPFzflldRVuCiOJWg/J/5fYZukNp3TS
         1qMQ==
X-Gm-Message-State: AOAM530mPEr/0ikyleVWLTG6lX8FTil3GJWSTGjbzN1RXiJ86JZcnxpk
        sDDSEESNcD0dr+s0UM6FSgM=
X-Google-Smtp-Source: ABdhPJz3eL+t6Dg1nqOMtbXH8G3Q/sOwzwjQbJpqJixOkSvPC4i/h6TqfkrtvQUScR89exTuAoOjyA==
X-Received: by 2002:a63:205d:: with SMTP id r29mr6472707pgm.340.1619817167797;
        Fri, 30 Apr 2021 14:12:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a75c:e2e0:cb86:23e0? ([2601:647:4000:d7:a75c:e2e0:cb86:23e0])
        by smtp.gmail.com with ESMTPSA id m188sm2821390pfm.167.2021.04.30.14.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 14:12:46 -0700 (PDT)
Subject: Re: [dm-devel] [RFC PATCH v2 1/2] scsi: convert
 scsi_result_to_blk_status() to inline
To:     Martin Wilck <mwilck@suse.com>, Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210429155024.4947-1-mwilck@suse.com>
 <20210429155024.4947-2-mwilck@suse.com>
 <08440651-6e8f-734a-ef43-561d9c2596a6@acm.org>
 <bb30875e11913a33bcaf491d0f752132ebb9ce5e.camel@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <39a59df5-9fdb-a1f1-39a2-c41b62e8076c@acm.org>
Date:   Fri, 30 Apr 2021 14:12:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <bb30875e11913a33bcaf491d0f752132ebb9ce5e.camel@suse.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/21 1:33 PM, Martin Wilck wrote:
> On Thu, 2021-04-29 at 09:20 -0700, Bart Van Assche wrote:
>> On 4/29/21 8:50 AM, mwilck@suse.com wrote:
>>> This makes it possible to use scsi_result_to_blk_status() from
>>> code that shouldn't depend on scsi_mod (e.g. device mapper).
>>
>> I think that's the wrong reason to make a function inline. Please
>> consider moving scsi_result_to_blk_status() into one of the block
>> layer
>> source code files that already deals with SG I/O, e.g.
>> block/scsi_ioctl.c.
> 
> scsi_ioctl.c, are you certain? scsi_result_to_blk_status() is an
> important part of the block/scsi interface... You're right that that
> this function is not a prime candidate for inlining, but I'm still
> wondering where it belongs if we don't.

The block/scsi_ioctl.c file is included in the kernel if and only if
BLK_SCSI_REQUEST is enabled. And that Kconfig symbol only selects the
block/scsi_ioctl.c file. Additionally, the following occurs in the SCSI
Kconfig file:

config SCSI
	tristate "SCSI device support"
	[ ... ]
	select BLK_SCSI_REQUEST

In other words, block/scsi_ioctl.c is built unconditionally if SCSI is
enabled. Adding the scsi_result_to_blk_status() function to the
block/scsi_ioctl.c file would increase the size of kernels that enable
bsg, ide, the SCSI target code or nfsd but not the SCSI initiator code.
If the latter is a concern, how about moving scsi_result_to_blk_status()
into a new file in the block directory?

Thanks,

Bart.
