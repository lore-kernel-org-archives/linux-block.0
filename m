Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF86C6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDC020892
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 10:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nCDO07p+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nCDO07p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDC020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeLNK4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:56:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNK4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 05:56:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6314E60722; Fri, 14 Dec 2018 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544784966;
        bh=S+z5IlGf4W56MziBDNM1UlA7+IR3I8jNB9kNawpKjYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nCDO07p+F9eIwDt4DsqM3P9tyJuCnfaMdwnwyGc3f8kRyHfxrsQpxqC67reSMmvgQ
         uZ4Pg7Uub7ShZP8IaljhzQIIXr8jSS/B0STaI3TxPVyopqc7lRhGj+ZhE0pb9Tg4fF
         IIIQDHcEddB7XSntMN2v/1ANAh4eJyfAf2yZExjY=
Received: from [10.204.79.22] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BE7860312;
        Fri, 14 Dec 2018 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544784966;
        bh=S+z5IlGf4W56MziBDNM1UlA7+IR3I8jNB9kNawpKjYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nCDO07p+F9eIwDt4DsqM3P9tyJuCnfaMdwnwyGc3f8kRyHfxrsQpxqC67reSMmvgQ
         uZ4Pg7Uub7ShZP8IaljhzQIIXr8jSS/B0STaI3TxPVyopqc7lRhGj+ZhE0pb9Tg4fF
         IIIQDHcEddB7XSntMN2v/1ANAh4eJyfAf2yZExjY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BE7860312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] partitions: fix coding style
To:     jotun9935@gmail.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181214101958.90690-1-jotun9935@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3282d005-53e1-b5cd-bd14-964467639403@codeaurora.org>
Date:   Fri, 14 Dec 2018 16:26:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214101958.90690-1-jotun9935@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please read the guideline as well before sending patch.

you need to maintain patchset version as well, e.g: in which patchset 
what is changed on whose comments.


-Mukesh


On 12/14/2018 3:49 PM, jotun9935@gmail.com wrote:
> From: Sungkyung Kim <jotun9935@gmail.com>
>
> Fix coding style of osf.c
>
> Signed-off-by: Sungkyung Kim <jotun9935@gmail.com>
> ---
>   block/partitions/osf.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/block/partitions/osf.c b/block/partitions/osf.c
> index 4b873973d6c0..19f8e91979f0 100644
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
> @@ -50,14 +50,14 @@ int osf_partition(struct parsed_partitions *state)
>   			u8  p_frag;
>   			__le16 p_cpg;
>   		} d_partitions[MAX_OSF_PARTITIONS];
> -	} * label;
> -	struct d_partition * partition;
> +	} *label;
> +	struct d_partition *partition;
>   
>   	data = read_part_sector(state, 0, &sect);
>   	if (!data)
>   		return -1;
>   
> -	label = (struct disklabel *) (data+64);
> +	label = (struct disklabel *) (data + 64);
>   	partition = label->d_partitions;
>   	if (le32_to_cpu(label->d_magic) != DISKLABELMAGIC) {
>   		put_dev_sector(sect);
> @@ -74,7 +74,7 @@ int osf_partition(struct parsed_partitions *state)
>   	}
>   	for (i = 0 ; i < npartitions; i++, partition++) {
>   		if (slot == state->limit)
> -		        break;
> +			break;
>   		if (le32_to_cpu(partition->p_size))
>   			put_partition(state, slot,
>   				le32_to_cpu(partition->p_offset),

