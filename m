Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9339CC433DF
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 21:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A920838
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 21:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="PYFxoLIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHLVbr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:31:47 -0400
Received: from ale.deltatee.com ([204.191.154.188]:38670 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLVbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 17:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wZUfbWD2oBKIbcbRhn2MlHBlsAt09/GiRlxjIAJiqj0=; b=PYFxoLIaaTeOjTA6L1Grk2PoP/
        oohcnDZvDLUWM3SgcIGGzS4nkSYAtfAnxIS6aFMahUYZF47lYeFrz+VfJ7GuY6p/l2y5lIRLd63xQ
        oVKpTYqHf6uB5PJJnJB8KGqv7PtbkXi3pwCZcIjLMBafrFmICRXavdYfSDTZFcJ/Fmk9dHli/pJgb
        rl+Mya1p0IC6PZ7hVkZX6RjYy5XM8lb9/+U89MjMZPrOcFRUbnoSzSZRcO5G4kwbIKYscZ9lCWA7C
        94R53Wby5ZDUGd5WMlZws5yT/VJ+J7EnRhOD2B7FD4YpLeqoWoiNRJwhBIWZcJlF/odoaxs7NDWif
        gfcmEjvg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k5yLW-0004Gg-PO; Wed, 12 Aug 2020 15:31:43 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>, Jens Axboe <axboe@kernel.dk>
References: <20200812210119.7155-1-logang@deltatee.com>
 <20200812211959.GA1238450@dhcp-10-100-145-180.wdl.wdc.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b86772c1-17ed-ec44-1b60-7f2ad80bd73c@deltatee.com>
Date:   Wed, 12 Aug 2020 15:31:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812211959.GA1238450@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: axboe@kernel.dk, keith.busch@wdc.com, sagi@grimberg.me, hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RESEND PATCH] nvme: Use spin_lock_irqsave() when taking the
 ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-08-12 3:19 p.m., Keith Busch wrote:
> On Wed, Aug 12, 2020 at 03:01:19PM -0600, Logan Gunthorpe wrote:
>> @@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>>  static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
>>  {
>>  	struct nvme_cel *cel, *ret = NULL;
>> +	unsigned long flags;
>>
>> -	spin_lock(&ctrl->lock);
>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>  	list_for_each_entry(cel, &ctrl->cels, entry) {
>>  		if (cel->csi == csi) {
>>  			ret = cel;
>>  			break;
>>  		}
>>  	}
>> -	spin_unlock(&ctrl->lock);
>> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>>
>>  	return ret;
>>  }
>> @@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>>  				struct nvme_effects_log **log)
>>  {
>>  	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
>> +	unsigned long flags;
>>  	int ret;
>>
>>  	if (cel)
>> @@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>>
>>  	cel->csi = csi;
>>
>> -	spin_lock(&ctrl->lock);
>> +	spin_lock_irqsave(&ctrl->lock, flags);
>>  	list_add_tail(&cel->entry, &ctrl->cels);
>> -	spin_unlock(&ctrl->lock);
>> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>>  out:
>>  	*log = &cel->log;
>>  	return 0;
>>
> 
> Neither of these are ever called from an interrupt disabled context,
> correct? If so, you can just use spin_lock_irq() without saving the
> current irq state.

Yes, I believe that is correct. I'll send a v2 shortly.

Thanks,

Logan
