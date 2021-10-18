Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B40C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4793F60FC3
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhJRMgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJRMgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:36:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB0C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:33:54 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i189so16056859ioa.1
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l9aF7AIxFKicD+DnbunhW1cdQofy5hejmsf1h4dvD5Q=;
        b=nNXo83J1s0yXP6KypBv4ptOcj5u11oFBhXWDVHeYLs5CSRgFWOabD7TqweJfcn/lDu
         bkmByMILLcuaCL1nqW+XiQ9ShMqioaa2d2xZBR3nSR7w61muh9Irvw4q22EsgSrJlaMW
         gtn1UdWI4PK+lajYWXFATVGL3UL8ADOvwzbquHtyb5WzauHa3yKrNNflCKRJKMSx40Tb
         0qvYKeHxSnT2mlHipINsrRrOrUA7Tzhk5Fbly1G7VZyBU9BPmnCwBBB54tXWLM1NIGT6
         5CD5PU49zDrUt3milBqNIeXq6gXnzLmTfTzvzLLWMbtvLx3a8uPGNOg8G+aPvsunL6He
         cN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9aF7AIxFKicD+DnbunhW1cdQofy5hejmsf1h4dvD5Q=;
        b=c7Dk63BxM3HgmpIPCmv4JB0y29wTajANOSrj79cicaNUEyKBJQvZOLpFP5CJLqHcwa
         0SbcNCNy47agfUP0/Ik6K4XhNa/mxoj4UTA4k/OnUjiLRpc8u3FU2l2ezNsCIUkMRv95
         PteTCGsirqR7p5uffuUn/5tVypZwFROhwBzTccccnPbub6mjhgNy5++4/jh18JT2irMV
         LYv2m0IJ8nhzBA29ntocMuRak13jNgDmwPZ0Z+yw2JeNv+G/gR0PnBrjMx0kNnG3Fvex
         ftSY0azF2DPnWrGy7oN6ywCPYMt1AIh91/ewiu9vLbGvvMsWuGYFYIWfXNYw5977IJ5O
         Q9nA==
X-Gm-Message-State: AOAM530qMv4dLxc1v7YeUkNmiKP5FFdP7sRrgoNJuX0bqGgtoz9qajd/
        UzvqQmhEiyBmaXszHR1PRTodLg==
X-Google-Smtp-Source: ABdhPJy0PcboUnhu/gRs/n6mSo+wagcynDkada00XXYBDDSKEZAU7dw8czp8g2sC+VTFPiZUzJH0Xw==
X-Received: by 2002:a05:6602:140d:: with SMTP id t13mr14027198iov.120.1634560433446;
        Mon, 18 Oct 2021 05:33:53 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k83sm6804993iof.12.2021.10.18.05.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:33:52 -0700 (PDT)
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
 <20211013045822.GA24761@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <843b8695-9af7-ec33-da83-e711850223b1@kernel.dk>
Date:   Mon, 18 Oct 2021 06:33:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211013045822.GA24761@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 10:58 PM, Christoph Hellwig wrote:
> I like this in general, but some comments below:
> 
>>  	cmnd->rw.opcode = op;
>> +	cmnd->rw.flags = 0;
>> +	cmnd->rw.command_id = 0;
> 
> The command_id is always set in nvme_setup_cmd, so no need to clear it
> here.

Perfect, I'll drop it.

>>  	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
>> +	cmnd->rw.rsvd2 = 0;
> 
> There should be no need to clear this reserved space.

Actually wasn't sure, sometimes hardware specs required reserved fields
to get cleared. nvme does not? I'd be happy to drop it if not the case.

>> +	cmnd->rw.metadata = 0;
>>  	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
>>  	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
>> +	cmnd->rw.reftag = 0;
>> +	cmnd->rw.apptag = 0;
>> +	cmnd->rw.appmask = 0;
> 
> All these PI fields are reserved when PI isn't enabled using the control
> field.  So I think we can stop clearing reftag here entirely, and move
> clearing the apptag and appmask down next to the reftag assignment.

OK, will move.

>>  
>> +static void nvme_clear_cmd(struct request *req)
>> +{
>> +	if (!(req->rq_flags & RQF_DONTPREP)) {
>> +		nvme_clear_nvme_request(req);
>> +		memset(nvme_req(req)->cmd, 0, sizeof(struct nvme_command));
>> +	}
>> +}
>> +
>>  blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>>  {
>>  	struct nvme_command *cmd = nvme_req(req)->cmd;
>>  	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>>  	blk_status_t ret = BLK_STS_OK;
>>  
>> -	if (!(req->rq_flags & RQF_DONTPREP)) {
>> -		nvme_clear_nvme_request(req);
>> -		memset(cmd, 0, sizeof(*cmd));
>> -	}
> 
> The nvme_clear_nvme_request is not done unconditionally for the read
> and write commands below, which does the wrong thing.  So I think we want
> to keep it here and just move the memset.
> 
> I think the best way is to split this patch into two:
> 
>   1) remove the memset here and do it unconditionally in the individual
>      nvme_setup_* handlers, and document there why the extra memsets don't
>      hurt (no partial completions unlikey SCSI)
>   2) optimize the read/write case

OK I'll do that and resend.

-- 
Jens Axboe

