Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B938C282CB
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA9921919
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 08:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="d4jlx/3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfBHIb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:31:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44538 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfBHIbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 03:31:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so1888306lfe.11
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e9o0xEZeVxGkGRYq+FrqLeZRYKbVYwBBNVU1Vhi1O7c=;
        b=d4jlx/3nA/a5G7syHqg2prvdxFpGgbBoY21yMrmJkBeBq03jK/tjjyC3ad2yAifFhc
         cPqTUdPHzxs6WThF95eB9FAe9zclG3k1aJ6TbaJQfqbbDhbOwpGG9CT08esoy9vCiZLE
         +/mPVCXFiYcAHBKiBrj+1FxDmKNJkHjCJJejVnz5i4b7PkKqVIrfU+pinba2vLJTbN6g
         SETyheeaOhPNNm5rbtFCOdNTVLQvlzpQ/iuWf2nvSRt6SB04KW/OwluWcPTRQTXlpzsw
         JuhdbPvzy9BLv5fNtao3neUBWc3QWFsTFa7+e7xQpCTB9dvD7ykGqkh6EfBwWGQr+WE5
         jYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9o0xEZeVxGkGRYq+FrqLeZRYKbVYwBBNVU1Vhi1O7c=;
        b=oFw4YJA4vGhioxGC68Te3VaxfZP7u1Ja/lDFGheAM4t2ZQub2XsezSbIGTS0Oiv57g
         kEsvyfl0pZivtAJve6wSGkU+IKFc7Y/35SGd0lQKNayhR32BcKn0V/aYAXniJ+WXuLxz
         Zw4uxrf47jbPKb0us3US5cufol4JK5JR+Iry1KaZmg0UKDeQ9MO0mRM3T4d2HLp11El7
         U/+THa1bh70BerK9d2GLlISOeYSIhfTF0/6kumlqDpFs3FF0zJqLUSFGiwwBj/bym0M6
         Ev0cV8KZM13JlyHeiAZD3Ei2AvfPdim7XYnr4QoMrLpSkDNmK6P4hyrsDR9k196TvPxq
         VJcw==
X-Gm-Message-State: AHQUAuazL/esc7dCnjZHyKUU/YmB+bNgTH2G2AZhL5+PCeZ1a6CSQuhK
        AoPxE4XeGLdGI0IEnBJkiRPeTDil8/4=
X-Google-Smtp-Source: AHgI3IbZa/PxvTalxyrFemw0ERdwLiKEJ13PYlnSQyzLL5Wel6ke7icNnqLupvzfVXuGjkiT0Rh4+A==
X-Received: by 2002:a19:9508:: with SMTP id x8mr12577498lfd.112.1549614683327;
        Fri, 08 Feb 2019 00:31:23 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id q10-v6sm239573ljj.3.2019.02.08.00.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 00:31:22 -0800 (PST)
Subject: Re: [LSF/MM TOPIC] BPF for Block Devices
To:     Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>
References: <40D2EB06-6BF2-4233-9196-7A26AC43C64E@raithlin.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f1f00282-11be-1682-3802-c8bd0e6fec4b@lightnvm.io>
Date:   Fri, 8 Feb 2019 09:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <40D2EB06-6BF2-4233-9196-7A26AC43C64E@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 6:12 PM, Stephen  Bates wrote:
> Hi All
> 
>> A BPF track will join the annual LSF/MM Summit this year! Please read the updated description and CFP information below.
> 
> Well if we are adding BPF to LSF/MM I have to submit a request to discuss BPF for block devices please!
> 
> There has been quite a bit of activity around the concept of Computational Storage in the past 12 months. SNIA recently formed a Technical Working Group (TWG) and it is expected that this TWG will be making proposals to standards like NVM Express to add APIs for computation elements that reside on or near block devices.
> 
> While some of these Computational Storage accelerators will provide fixed functions (e.g. a RAID, encryption or compression), others will be more flexible. Some of these flexible accelerators will be capable of running BPF code on them (something that certain Linux drivers for SmartNICs support today [1]). I would like to discuss what such a framework could look like for the storage layer and the file-system layer. I'd like to discuss how devices could advertise this capability (a special type of NVMe namespace or SCSI LUN perhaps?) and how the BPF engine could be programmed and then used against block IO. Ideally I'd like to discuss doing this in a vendor-neutral way and develop ideas I can take back to NVMe and the SNIA TWG to help shape how these standard evolve.
> 
> To provide an example use-case one could consider a BPF capable accelerator being used to perform a filtering function and then using p2pdma to scan data on a number of adjacent NVMe SSDs, filtering said data and then only providing filter-matched LBAs to the host. Many other potential applications apply.
> 
> Also, I am interested in the "The end of the DAX Experiment" topic proposed by Dan and the " Zoned Block Devices" from Matias and Damien.
> 
> Cheers
>   
> Stephen
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/netronome/nfp/bpf/offload.c?h=v5.0-rc5
>   
>      
> 

If we're going down that road, we can also look at the block I/O path 
itself.

Now that Jens' has shown that io_uring can beat SPDK. Let's take it a 
step further, and create an API, such that we can bypass the boilerplate 
checking in kernel block I/O path, and go straight to issuing the I/O in 
the block layer.

For example, we could provide an API that allows applications to 
register a fast path through the kernel — one where checks, such as 
generic_make_request_checks(), already has been validated.

The user-space application registers a BFP program with the kernel, the 
kernel prechecks the possible I/O patterns and then green-lights all 
I/Os that goes through that unit. In that way, the checks only have to 
be done once, instead of every I/O. This approach could work beautifully 
with direct io and raw devices, and with a bit more work, we can do more 
complex use-cases as well.
