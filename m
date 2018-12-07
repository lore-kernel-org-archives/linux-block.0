Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742F8C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BACC20868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="VXnfpIrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BACC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGMBK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:01:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37624 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeLGMBK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 07:01:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so3340224lja.4
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 04:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9PAcI/wv7r10omQMugO2/NkCvqtv6/TxQ0y9p/tWvIs=;
        b=VXnfpIrcfjo0KTbYLq/4SQgQMmXOjgWyTIJFMHCsgaHDY3ZjCs+O2hGI3+143uleeg
         T3ZXStletHhSU7YTlTt9gigZWylF/7EwbCxe/lDq6MXsvNLsFuTPFJcp4Hp8DvKp4kpv
         6a/CmWQWXsqwh5BhP4FQkKL77Ytt4bNP3WptKDhde2101eEt24OLw2CeqX8qOWe9xogX
         iRKkp51RY8DjTOBC7jxhbe/zokqjbjewZdhqaZmOsSXHb/tCsgJxK8SM+x6eyjYxAn9D
         ych3O/HPZ3qBo/9ZjgIYGkXfKBs/Gb0u4bmv2+5fX/fUgwHBd7EM4dH6RfHj1ZiaRaTm
         quVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9PAcI/wv7r10omQMugO2/NkCvqtv6/TxQ0y9p/tWvIs=;
        b=B5TNEy366M67vv9BTeOiS+QuzOCmHxa50qDQwOC4BQ6Vs1tFQ22aw10yj4ausQ7k1X
         cLwvG4qhx60oWJH40Ebi6x8jvLKG7pacwNyinCNBA4/i/UqjBeReWvEH6pM1rLyiN4aK
         tOAfFi+259CarGblHSLEPzBDZoY2/wUqfe+Bqi+ZoRsZKJvCd9Ws24bEHalthlwDUYKl
         VfGf7eZAN4cxTcw7A9gRlAl8El9JNpqF8lHuE0+arzNA80M1/g32W2EUkZJf4/Rj/fas
         fHWJeJPczo/UjBHrBB5DljLxoW+6A6oFwSKlQRmJ/gDa7xD3TczPxUdbkmcNd6EuhzDZ
         dGAg==
X-Gm-Message-State: AA+aEWbKPFGN1+alOhgOe0QJe75T+V+jYaZ09NXiNuLC7YXr4sTWuEPx
        EodvYm/pCsddyxM4vEGOAvMvqA==
X-Google-Smtp-Source: AFSGD/XnclNgm1FQldYBhQp7TlyiOspDubabyBHeePrFUT0uRfcmuJF5ZJZRVOlwmJGXf/67ha3Phg==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr1166856lju.116.1544184068146;
        Fri, 07 Dec 2018 04:01:08 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id m77sm577744lfg.3.2018.12.07.04.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:01:07 -0800 (PST)
Subject: Re: [PATCH v2 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com
References: <20181207082550.10409-1-igor.j.konopko@intel.com>
 <20181207082550.10409-2-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f376db7a-1fec-499f-b7d1-b02d29c438f4@lightnvm.io>
Date:   Fri, 7 Dec 2018 13:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181207082550.10409-2-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/07/2018 09:25 AM, Igor Konopko wrote:
> When we are using PBLK with 0 sized metadata during recovery
> process we need to reference a last page of bio. Currently
> KASAN reports use-after-free in that case, since bio is
> freed on IO completion.
> 
> This patch adds addtional bio reference to ensure, that we
> can still use bio memory after IO completion. It also ensures
> that we are not reusing the same bio on retry_rq path.
> 
> Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 009faf5db40f..3fcf062d752c 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -376,12 +376,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   		rq_ppas = pblk->min_write_pgs;
>   	rq_len = rq_ppas * geo->csecs;
>   
> +retry_rq:
>   	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>   	if (IS_ERR(bio))
>   		return PTR_ERR(bio);
>   
>   	bio->bi_iter.bi_sector = 0; /* internal bio */
>   	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> +	bio_get(bio);
>   
>   	rqd->bio = bio;
>   	rqd->opcode = NVM_OP_PREAD;
> @@ -394,7 +396,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (pblk_io_aligned(pblk, rq_ppas))
>   		rqd->is_seq = 1;
>   
> -retry_rq:
>   	for (i = 0; i < rqd->nr_ppas; ) {
>   		struct ppa_addr ppa;
>   		int pos;
> @@ -417,6 +418,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (ret) {
>   		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> +		bio_put(bio);
>   		return ret;
>   	}
>   
> @@ -428,19 +430,25 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   
>   		if (padded) {
>   			pblk_log_read_err(pblk, rqd);
> +			bio_put(bio);
>   			return -EINTR;
>   		}
>   
>   		pad_distance = pblk_pad_distance(pblk, line);
>   		ret = pblk_recov_pad_line(pblk, line, pad_distance);
> -		if (ret)
> +		if (ret) {
> +			bio_put(bio);
>   			return ret;
> +		}
>   
>   		padded = true;
> +		bio_put(bio);
>   		goto retry_rq;
>   	}
>   
>   	pblk_get_packed_meta(pblk, rqd);
> +	bio_put(bio);
> +
>   	for (i = 0; i < rqd->nr_ppas; i++) {
>   		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
>   		u64 lba = le64_to_cpu(meta->lba);
> 

Thanks Igor. I've merged this patch with your "lightnvm: pblk: support 
packed metadata" patch.
