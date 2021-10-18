Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C8C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A64C60F9F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhJROO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhJROOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:14:25 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053DFC0612ED
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 06:41:32 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a8so14884767ilj.10
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEyJnDXb2l3KttH5g2PlRPPMeXSZR9Hke9tLs0RWY8A=;
        b=o5FFV6qgEfwCS3IoGfVXF57bydYPQMAPrCcGSKsuKCR/fL92RVGG+2ZTFw9il8rjrT
         q38YPxMBm7ImfBPBcMSUznZjnUktqsWWsFSNTmx+VZ64esIZ62jg8IuBcD3H6rpgHut+
         5QUqO7jbxFR08tmyNz4Nsg3Y3g5ibzCP0BqOSm7JNxNa6fy5jJBq3jOmfpUhugKbEAhP
         enTw4p+bwE0jufiCkYu5+rV/0XSYzVB3uWM5I2LC3XgVyw6xOvVxTlMZiRcxdpUeuT7O
         zKsYM2SWEVWDnadL9+FJmq4/PPf4TWONcF7+/N8kh4BT6Lh0to5bBnT3QuIRRlPmuexj
         w0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEyJnDXb2l3KttH5g2PlRPPMeXSZR9Hke9tLs0RWY8A=;
        b=WFjkT3RQhysLM+jWwIIGhtnDP8+5YTPjjUHIde0v9iVBdHDn14Ec0ZEi/SL6odeahD
         wM8ij6ID3VBymD5HKEK8LW2/aL6qrgY3y7iDURhocQrIUM49KXy6c74M23G2ugYzu0NG
         vwN/NQb9w+50h7ny1vxrFw9rOrtMgzlCwHGGwB+Y0zRAplmum5mB+vNnYpdzh+5xY6hJ
         desw0af7HalY6+q+hP7jJ+eLyBNf/1hu/M8jSAwkDNN/Jthtwb2/ZPgmfKlCnypJ1AB7
         yMJBWowsiIGqy+xQQ8tFYu5DtE0x/Je/EjKMFzp96S0LUvDImyf9pRwS977c15tj4YgQ
         /i5g==
X-Gm-Message-State: AOAM530QGzsHuJhD5xDZn5kycG4//cASV7LOv3UH174LiHPSWexnWxVu
        crqSi3Ev3kleleCwQVyz412mb+br18E=
X-Google-Smtp-Source: ABdhPJz0KDCPy1iSLVrNDRt3mDE7D4rB3Sxs3FQadx65FM3D0AgnixkEtMfjjfZdVeCRih8+PRBDhg==
X-Received: by 2002:a92:1a10:: with SMTP id a16mr13875646ila.116.1634564491256;
        Mon, 18 Oct 2021 06:41:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j22sm7343085ila.6.2021.10.18.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 06:41:30 -0700 (PDT)
Subject: Re: [PATCH 6/6] nvme: wire up completion batching for the IRQ path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-7-axboe@kernel.dk> <YW1K7RR2F+dL9ntI@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <458fdc6d-e006-48fb-b66c-c4c2b631b236@kernel.dk>
Date:   Mon, 18 Oct 2021 07:41:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW1K7RR2F+dL9ntI@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 4:22 AM, Christoph Hellwig wrote:
> On Sat, Oct 16, 2021 at 08:06:23PM -0600, Jens Axboe wrote:
>>  static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>>  {
>> -	return nvme_poll_cq(nvmeq, NULL);
>> +	DEFINE_IO_COMP_BATCH(iob);
>> +	int found;
>> +
>> +	found = nvme_poll_cq(nvmeq, &iob);
>> +	if (iob.req_list)
>> +		nvme_pci_complete_batch(&iob);
>> +	return found;
> 
> Ok, here the splitt makes sense.  That being said I'd rather only add
> what is nvme_poll_cq as a separate function here, and I'd probably
> name it __nvme_process_cq as the poll name could create some confusion.

Sure, I can shuffle that around. Can I add your reviewed/acked by with
that for those two, or do you want the series resent?

-- 
Jens Axboe

