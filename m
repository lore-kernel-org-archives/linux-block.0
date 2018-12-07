Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D7C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288BB20989
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="kRl8fht4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288BB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLGMDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:03:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35022 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLGMDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 07:03:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so2852398lfc.2
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zl9MlUfZ8KlEDJrGz5J71z/OV/8fL7LzmmyxJqcNJEQ=;
        b=kRl8fht4ySjdVYpxE8HXrJ5V9keTHbOWyYdJdLt/X+FOjFQduoxk3bgidrMz66FiBW
         VDcwEfRfjFxJhf0KqbMUt8CMH6v2vMyyykt7BpiFO7+5l4XUmSuwVywLL9NTg1CEOkfG
         UEHZDh2hI6ozwMmG1TwlkuWB+4jejRw0wqsaLgMIrAvN3SPeu09h91K6ZNHLIpKHY+QY
         xwOLeGEQpNM3JN2SMQ52WnIL+cA0dOzFnV0W4th84laGPpjF2TzowRpiDBC5uLTfDOgQ
         aCcBax3Purbhu2gZNP2Z0iZHkSVvKQxQe/j280W3av0KwX8cS0PwsEXiRmxS3rOl+Cv+
         F9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zl9MlUfZ8KlEDJrGz5J71z/OV/8fL7LzmmyxJqcNJEQ=;
        b=CZOe9r5y+Kjd8suGBSHwqQOypjCUCZhmFtrOTH46ndbgpfwg1jq36TVb4Lnf07pRbp
         KywEkR5rETtFltcIRvD/xI1EcqKyyUsWS6zyFiqMU40a30DbAgAYLMtryhfVnxAOKSPr
         9WcuyDbk+kQba47bWJ4ycZeLEnjqDZzZR1yokktl8rTiecdB94OMhddRp1Vc6hiYN2bj
         UQ3kDvBGZ/C5b46Pw0wy+9UplUvs6kRDkJEbWbiidhV7dsL3/Y56FRYnZarfkezdSiQt
         csh/dr/nm+5ocXrs9tHhRHPse6gZamrX647P2r0WtYo6yajOUltfk6uYVKqGm8BiLK2z
         yKlw==
X-Gm-Message-State: AA+aEWbBl8+YxQQQJEM9Yggrp6fXc7Za3mbIDajtmuZ5i6QxeY/Lz1Rw
        cRSeUtrB2hRaN508N+qAj0k7Wg==
X-Google-Smtp-Source: AFSGD/VKKSUfzEH5xbo5no8FUazEMn9FG5GknYyruxD61Vh2YbJK/k8W0ApWxsrlwHfBJUUIuKLywQ==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr1234486lfj.83.1544184209945;
        Fri, 07 Dec 2018 04:03:29 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id x204sm585296lfa.5.2018.12.07.04.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:03:28 -0800 (PST)
Subject: Re: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
To:     Javier Gonzalez <javier@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20181206154559.5642-1-igor.j.konopko@intel.com>
 <20181206154559.5642-2-igor.j.konopko@intel.com>
 <A790DB4E-9DD0-40CE-94D9-631E0C28D2D6@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0f219bd6-fd49-5d13-f0e2-af8fe7749127@lightnvm.io>
Date:   Fri, 7 Dec 2018 13:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <A790DB4E-9DD0-40CE-94D9-631E0C28D2D6@cnexlabs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/07/2018 10:12 AM, Javier Gonzalez wrote:
> 
>> On 6 Dec 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> When we are using PBLK with 0 sized metadata during recovery
>> process we need to reference a last page of bio. Currently
>> KASAN reports use-after-free in that case, since bio is
>> freed on IO completion.
>>
>> This patch adds addtional bio reference to ensure, that we
>> can still use bio memory after IO completion. It also ensures
>> that we are not reusing the same bio on retry_rq path.
>>
>> Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 12 ++++++++++--
>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 009faf5db40f..3fcf062d752c 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -376,12 +376,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>> 		rq_ppas = pblk->min_write_pgs;
>> 	rq_len = rq_ppas * geo->csecs;
>>
>> +retry_rq:
>> 	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>> 	if (IS_ERR(bio))
>> 		return PTR_ERR(bio);
>>
>> 	bio->bi_iter.bi_sector = 0; /* internal bio */
>> 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
>> +	bio_get(bio);
>>
>> 	rqd->bio = bio;
>> 	rqd->opcode = NVM_OP_PREAD;
>> @@ -394,7 +396,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>> 	if (pblk_io_aligned(pblk, rq_ppas))
>> 		rqd->is_seq = 1;
>>
>> -retry_rq:
>> 	for (i = 0; i < rqd->nr_ppas; ) {
>> 		struct ppa_addr ppa;
>> 		int pos;
>> @@ -417,6 +418,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>> 	if (ret) {
>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>> 		bio_put(bio);
>> +		bio_put(bio);
>> 		return ret;
>> 	}
>>
>> @@ -428,19 +430,25 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>
>> 		if (padded) {
>> 			pblk_log_read_err(pblk, rqd);
>> +			bio_put(bio);
>> 			return -EINTR;
>> 		}
>>
>> 		pad_distance = pblk_pad_distance(pblk, line);
>> 		ret = pblk_recov_pad_line(pblk, line, pad_distance);
>> -		if (ret)
>> +		if (ret) {
>> +			bio_put(bio);
>> 			return ret;
>> +		}
>>
>> 		padded = true;
>> +		bio_put(bio);
>> 		goto retry_rq;
>> 	}
>>
>> 	pblk_get_packed_meta(pblk, rqd);
>> +	bio_put(bio);
>> +
>> 	for (i = 0; i < rqd->nr_ppas; i++) {
>> 		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
>> 		u64 lba = le64_to_cpu(meta->lba);
>> --
>> 2.17.1
> 
> Both patches in this series look good, but since they are fixes to the
> patches you sent for this window, I would suggest that you merge them
> into the original set and resend. We can then test the series again and
> make sure there are no regressions from V1.
> 
> Matias: would this work for you? The current series in your branch is
> broken as is.
> 
> Thanks,
> Javier
> 

I've applied 1 (v2) separately since it did not merge cleanly with the 
lightnvm: pblk: add helpers for OOB metadata patch. 2 has been merged 
with the "lightnvm: pblk: support packed metadata" patch.
