Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9CDC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 04:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3F62084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 04:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfDCEAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:00:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39444 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCEAv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 00:00:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so7455008pfo.6;
        Tue, 02 Apr 2019 21:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TSLl6biD+W8q1xAn5+YEvDoYFlOUYeMhdcIMtnjwto0=;
        b=tSK6PcXt6DpQCmGXemiP+b2FsRBXdv2g0EBJnwP7y8ZygnVvuInSle9p8z+8SM69hy
         Ec8BGom8oNXadBWS9xCzQTOcgYmd77WAYvYk3htgBQLa1Z0vq7ZyotYbbR8k8wGDxO/H
         2s6vMN9zDCKwW0htWmwCH2C0kGZ8nxwBXcl/nGabriz1ZPOqnpz+ecHVgDFDFy21YBzO
         mbBGMdArpiB31VekORuLYzwjAeTy2/6Ftn74yDt9nzU5+lp4BtZhWwHCF+OYmrcrxeEZ
         WjqbiR0/hkiZSOVNqn8GWk/ESQ6uNhHFLqQDG1MqUipuAOFSoU1iI9DIvtF/cuTRSX+b
         8IeA==
X-Gm-Message-State: APjAAAXlLCtVuzNeGdVsRmzX3IZRs8HlKIaCn2LsiDpU9tP970ZkeKIa
        OKK3UT9DhaTMYnL56DrUuTKo88B6XkU=
X-Google-Smtp-Source: APXvYqyP5w9r7BJt80yovlmx9nW1eQNB0nmSm2BA+5Zcnvh4+LaDzDmDNxMZfcfkBdG0PqFBnERFZw==
X-Received: by 2002:a62:ee13:: with SMTP id e19mr72566889pfi.224.1554264050732;
        Tue, 02 Apr 2019 21:00:50 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id i126sm21646074pfc.101.2019.04.02.21.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 21:00:49 -0700 (PDT)
Subject: Re: [PATCH] SCSI: don't hold device refcount in IO path
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190402114800.2281-1-ming.lei@redhat.com>
 <1554220294.118779.142.camel@acm.org>
 <CACVXFVPnMW_2EXQd0Uj5GxSR3aVcW6yrXGghf0By+uSnQ8oG+g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fbd6687e-33ac-3f53-7dc0-a7f8fb5c29e7@acm.org>
Date:   Tue, 2 Apr 2019 21:00:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVPnMW_2EXQd0Uj5GxSR3aVcW6yrXGghf0By+uSnQ8oG+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/19 8:41 PM, Ming Lei wrote:
> On Wed, Apr 3, 2019 at 12:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On Tue, 2019-04-02 at 19:48 +0800, Ming Lei wrote:
>>> scsi_device's refcount is always grabed in IO path.
>>                                     ^^^^^^
>>                                     grabbed?
>>
>>> Turns out it isn't necessary, becasue blk_queue_cleanup() will
>>> drain any in-flight IOs, then cancel timeout/requeue work, and
>>> SCSI's requeue_work is canceled too in __scsi_remove_device().
>>>
>>> Also scsi_device won't go away until blk_cleanup_queue() is done.
>>>
>>> So don't hold the refcount in IO path.
>>
>> Holding the device reference count was definitely necessary in the past.
>> You may want to reflect this in the patch description by mentioning that
>> grabbing that reference count is no longer required today because the
>> draining mechanism now waits for requeuing to occur. I don't think that
>> was the case for the legacy block layer.
> 
> You must forget we have switched to blk_queue_enter() for legacy block
> layer for a while, :-)

I definitely haven't forgotten that. I was referring to the time before 
blk_queue_enter() / blk_queue_exit() was introduced in the legacy block 
layer.

Bart.
