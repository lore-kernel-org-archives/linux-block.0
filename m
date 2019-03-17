Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ED7C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4231A20896
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="xR7qI2DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCQTYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:24:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40474 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfCQTYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 15:24:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so745906pfc.7
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bb2Lay00cEWy1liYyfPOeyo88g7dBpxSAROapCvu3A=;
        b=xR7qI2DXbZg8lIiE5hCIgayFDPSPxD89Dc2vhuLxMN++BxQg1Jah6Y3r52xRTckvgK
         wlFPr4H/0D1sTUdknPgSmV90s+kDVE18E0yf2RNS1mDjiUyg/zL0X/H0wD8XIWLIP7+d
         tqqe1lFkw4Oir6yVfp8WN3cikIKdJohiJkjJkdWwKMvJcyKKS6KjVYLzQF3/fktvIZDI
         KlptDXBxUI8Gsuohi5RDuqZ/TVxnM+MoLO2qB2CXO/bN95SV+Z1BVKvR9jzf8mEa4Ibc
         6IzQmeNvVyTKOF9PRaDVdDIKDwDIVv0hwYzCaI1DaW04Ssj4HLBe+7Colc9WSXZq8oMe
         nhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bb2Lay00cEWy1liYyfPOeyo88g7dBpxSAROapCvu3A=;
        b=cp7+r5in0k0eFbXHS90Hlhsv1j4psASzkv6Biz9QMZcv8Vo6AZ+sKhmtb0NTF3fJ72
         2cD7xcVnUqySocv+qr9jWzkIDangUis3nGWY235+/Ep2vw/cMhXv+Ts0EU8+IoB4Lpqi
         LrBr4/6TqdrxyUjOuozFpgnHus2/c2ebXfYv4fqyey+yCc+VKEW19DozREK3fS+LT9Jw
         ylinlFel7NHqJ4N7yl4YxQ9If/IVl67qblQZ8eEoxE9YwhKa2xuYwQ5XE6xawq3IZ1OY
         SFKsoyqgWMRyQwg16RE/M2uNZSvruaFaLO37r84Vs2wR/WYiEaIITJrQPCDxN1lXBBqT
         Fhrw==
X-Gm-Message-State: APjAAAW1lwKf2YOAdDE+o49UVnSk/zERiZMTDVsiUqK/xq6w0GFZwxNr
        2M7E4svvojMKouXpvfisCroQ/mSlhREzkQ==
X-Google-Smtp-Source: APXvYqyNQFpNCan+I5ZmFRMpQQ98bATwPCoi1kLAKKUk3qcWJI6v3wLWUw2VIVYd1Slktu0kpCvImw==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr15761479plb.216.1552850660696;
        Sun, 17 Mar 2019 12:24:20 -0700 (PDT)
Received: from [10.111.76.104] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id e63sm11653608pfa.116.2019.03.17.12.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:24:19 -0700 (PDT)
Subject: Re: [PATCH 04/18] lightnvm: pblk: OOB recovery for closed chunks fix
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-5-igor.j.konopko@intel.com>
 <F7A12A66-ADBD-4B24-9FD0-B02031E2FACB@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5d997ae1-ec1f-6a78-6a93-f15fab542859@lightnvm.io>
Date:   Sun, 17 Mar 2019 12:24:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <F7A12A66-ADBD-4B24-9FD0-B02031E2FACB@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/19 3:43 PM, Javier González wrote:
>> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> In case of OOB recovery, when some of the chunks are in closed state,
>> we are calculating number of written sectors in line incorrectly,
>> because we are always counting chunk WP, which for closed chunks
>> does not longer reflects written sectors in particular chunks. This
>> patch for such a chunks takes clba field instead.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 83b467b..bcd3633 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -101,6 +101,8 @@ static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
>>
>> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>> {
>> +	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> 	struct pblk_line_meta *lm = &pblk->lm;
>> 	int nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
>> 	u64 written_secs = 0;
>> @@ -113,7 +115,11 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>> 		if (chunk->state & NVM_CHK_ST_OFFLINE)
>> 			continue;
>>
>> -		written_secs += chunk->wp;
>> +		if (chunk->state & NVM_CHK_ST_OPEN)
>> +			written_secs += chunk->wp;
>> +		else if (chunk->state & NVM_CHK_ST_CLOSED)
>> +			written_secs += geo->clba;
>> +
>> 		valid_chunks++;
>> 	}
>>
>> --
>> 2.9.5
> 
> Mmmm. The change is correct, but can you develop on why the WP does not
> reflect the written sectors in a closed chunk? As I understand it, the
> WP reflects the last written sector; if it happens to be WP == clba, then
> the chunk state machine transitions to closed, but the WP remains
> untouched. It is only when we reset the chunk that the WP comes back to
> 0. Am I missing something?
> 

I agree with Javier. In OCSSD, the write pointer shall always be valid.
