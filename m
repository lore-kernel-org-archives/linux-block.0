Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2524FC10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E765A214DA
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwvQnf1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbfDRS03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:26:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390704AbfDRS02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 14:26:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so1484852pfr.4
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0dLjWuLOVM1BXsffnF2r4B5OR17QMluC6b0XNSw767Y=;
        b=bwvQnf1LOSQjz0QUM5GLmlUK7C8xEFzxc+5BZdMEUxKXZwxTtLNRqxDR15v80wAYTr
         6VX2y8FKuxofoCTFp83IKm2CGNE9NxMXwAg9JnWiPBq4q3ueRu+K51iTGMaVV5iHRy+x
         063KVHqGZfDrBl0WSMolBnGvFKK/9fiQVCxossNWaE/HSaialkeBV6GpidA/nxe3EpUS
         D91fg4SUqIauwJdcRVQYYlmlQUkdVS6RsIU4pAE/Mjcj6XywRutqjnINSJrS8lMihtgj
         phfgpb442CBbCwo0fVoX4faLPYr9FOSKidM96k2AM+rqUP8s7WK4s84NY3RiEhad62EK
         0D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0dLjWuLOVM1BXsffnF2r4B5OR17QMluC6b0XNSw767Y=;
        b=CmKyTqxm7C1eZ9izpzI8iYsoxhTd5OfWKHGYoCgyMNJ6A5WsDvTppOH+NIxswXDpj7
         z51vMwGW8cK66PV7XEcTdgjn7gjI+pLH0mm12G4GJn9HoB5ciLGwNvyVDznIBz4Guo5Y
         h7aOwj4E+DUqw+9PyojNu9OWq09ndM5m+ShbVsja3Lbz9Rn0U56MxvO7tCbmPjlEtneV
         faRDcavEbWZ6bzOt1MxPPWhDUlpxlLSpV6ZT42IpJdTTedePb9hmpELb2EnI4Dc0O0qS
         af3h3ETBYJoBG8doOfTXWSJvNUq5HvumASV9QhhLOMyEQSxJqQspaWwHNGGQSPIodYxC
         u1VQ==
X-Gm-Message-State: APjAAAXtPa76+DWpIAiiEIlICFcOzmOndsU09Uiv9ct13fwJgTDqeRR9
        +31zS1ff7VCaP/wE4EdBXl4=
X-Google-Smtp-Source: APXvYqxo9VHaVEhtPkxwgjHK13sFoaixlCU1iNTsTliYWUsSy/Cyy5E7EQHOEP2ZO019p1AwpOONwQ==
X-Received: by 2002:a62:be13:: with SMTP id l19mr97037323pff.137.1555611988093;
        Thu, 18 Apr 2019 11:26:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:80e8:7:4410:95ba:6d7:2a33])
        by smtp.gmail.com with ESMTPSA id p66sm5660606pfb.4.2019.04.18.11.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 11:26:27 -0700 (PDT)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <28f8343f-3159-9ca2-f98f-a37ecce31fd5@suse.de>
From:   "Edmund Nadolski (Microsoft)" <edmund.f.nadolski@gmail.com>
Message-ID: <532b6027-3bc9-def3-0fd8-2b6f32c4463b@gmail.com>
Date:   Thu, 18 Apr 2019 11:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <28f8343f-3159-9ca2-f98f-a37ecce31fd5@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/19 8:02 AM, Hannes Reinecke wrote:
> On 4/18/19 4:34 PM, Ming Lei wrote:
>> Hi Hannes,
>> 
>> On Thu, Apr 18, 2019 at 04:06:32PM +0200, Hannes Reinecke wrote:
>>> When calling blk_queue_split() it will be using the per-queue
>>> bioset to allocate the split bio from. However, blk_steal_bios()
>>> might move the bio to another queue, _and_ the original queue
>>> might be removed completely (nvme is especially prone to do so).
>> 
>> Could you explain a bit how the original queue is removed in case
>> that blk_steal_bios() is involved?
>> 
> It's not blk_steal_bios() which removes the queue. What happens is:
> 
> - bio returns with error
> - blk_steal_bios() moves bio over to a different queue
> - nvme_reset_ctrl() is called
> - Error detection finds that the original device is gone
> - nvme calls nvme_remove_ns()
> - nvme_remove_ns() removes the original request queue alongside the
> bio_set from which the bvecs have been allocated from.
> - 'stolen' bio is completed
> - 'stolen' bio calls bio_endio()
> - bio_endio() calls mempool_free() on the bvecs, referencing the mempool
> from the original queue
> - crash
> 
>>> That leaves the bvecs of the split bio with a missing / destroyed
>>> mempool, and a really fun crash in bio_endio().
>> 
>> per-queue bioset is used originally for avoiding deadlock, are you
>> sure the static bioset is safe?
>> 
> If that turns out be be an issue we could be having a per 'ns_head'
> bio_set for allocating the split bio from.
> But the main point is that we cannot use the bioset from the request
> queue as the queue (and the bioset) might be removed during the lifetime
> of the bio.

Does this mean that as-is, this is safe because nvme (currently) is the 
only consumer of blk_steal_bios()?

(Sorry if this is a lame question, I'm in the process of learning this 
code.)

TIA,
Ed

