Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F246C6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 08:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D862C2080F
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 08:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YBDfLKtF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YBDfLKtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D862C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeLNIrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:47:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 03:47:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C3D7A6071B; Fri, 14 Dec 2018 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544777268;
        bh=7VcXAJEE8mpYdb3QXeBNFkdik2X6FkSGjb/XkzckzMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YBDfLKtFYGyAHlgmea0AEdnfHQVSWggOM3/nwer2L3T1uDQhOLyr8PyKIr20bsbMG
         yfvmlh9466OAzkyAV1Ur2dwE+X10rpoQvlfBv94CkE2NGvXXRaDMOGNit8QYTvXJqu
         Sa48sRbSZlYFoj94PCQC/9LtZarg1wh1nNE9e4aU=
Received: from [10.204.79.22] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFAF260208;
        Fri, 14 Dec 2018 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544777268;
        bh=7VcXAJEE8mpYdb3QXeBNFkdik2X6FkSGjb/XkzckzMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YBDfLKtFYGyAHlgmea0AEdnfHQVSWggOM3/nwer2L3T1uDQhOLyr8PyKIr20bsbMG
         yfvmlh9466OAzkyAV1Ur2dwE+X10rpoQvlfBv94CkE2NGvXXRaDMOGNit8QYTvXJqu
         Sa48sRbSZlYFoj94PCQC/9LtZarg1wh1nNE9e4aU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFAF260208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] partitions: fix coding style
To:     jotun9935@gmail.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181214070402.92541-1-jotun9935@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e1fd45ed-a482-f387-687c-cb4375367a67@codeaurora.org>
Date:   Fri, 14 Dec 2018 14:17:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214070402.92541-1-jotun9935@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/14/2018 12:34 PM, jotun9935@gmail.com wrote:
> From: Sungkyung Kim <jotun9935@gmail.com>
>
> Fix coding style of osf.c
>
> Signed-off-by: Sungkyung Kim <jotun9935@gmail.com>
> ---
>   block/partitions/osf.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/block/partitions/osf.c b/block/partitions/osf.c
> index 4b873973d6c0..96921a1e31ce 100644
> --- a/block/partitions/osf.c
> +++ b/block/partitions/osf.c
> @@ -22,7 +22,7 @@ int osf_partition(struct parsed_partitions *state)
>   	unsigned char *data;
>   	struct disklabel {
>   		__le32 d_magic;
> -		__le16 d_type,d_subtype;
> +		__le16 d_type, d_subtype;
>   		u8 d_typename[16];
>   		u8 d_packname[16];
>   		__le32 d_secsize;
> @@ -50,8 +50,8 @@ int osf_partition(struct parsed_partitions *state)
>   			u8  p_frag;
>   			__le16 p_cpg;
>   		} d_partitions[MAX_OSF_PARTITIONS];

Also include this change as well

--- a/block/partitions/osf.c
+++ b/block/partitions/osf.c
@@ -57,7 +57,7 @@ int osf_partition(struct parsed_partitions *state)
         if (!data)
                 return -1;

-       label = (struct disklabel *) (data+64);
+       label = (struct disklabel *) (data + 64);
         partition = label->d_partitions;


would be better a bit more you add in your changelog.

Cheers,
Mukesh
> -	} * label;
> -	struct d_partition * partition;
> +	} *label;
> +	struct d_partition *partition;
>   
>   	data = read_part_sector(state, 0, &sect);
>   	if (!data)
> @@ -74,7 +74,7 @@ int osf_partition(struct parsed_partitions *state)
>   	}
>   	for (i = 0 ; i < npartitions; i++, partition++) {
>   		if (slot == state->limit)
> -		        break;
> +			break;
>   		if (le32_to_cpu(partition->p_size))
>   			put_partition(state, slot,
>   				le32_to_cpu(partition->p_offset),

