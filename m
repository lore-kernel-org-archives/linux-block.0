Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E41C433FE
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3729B61BE1
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhKQPsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbhKQPsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 10:48:30 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872BC061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:45:31 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k1so3201725ilo.7
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9whkxlKo4rj4ltS4V8ctUa53AuQZqOZnJEJuQ+S1em8=;
        b=Vy53YPwSIErBvboWqKVLMDOK+ryWC3kml/JG21+CiV0DUAY3qDUbgi+mPE4eZOawoD
         SH22So05ntiK52VHdAcgW8A2GUSaOvQa1RYkqAPka60yphyhs2/06tDwiP0nV6nG42I2
         IV/MrGg32wp8xF/vea5JvILHpfIX6glMDqz8j2o47IK1w1b6tHCwa+yuV3VVBvD7NYb3
         iL1xpHP4ON0yQY221jNtuJO+jmMcjLfgncM3dhhoP1Hsshg9+LYQadW4/mUpPGwVUa9x
         9QkhO3sO7q+earbfk/Wg6zB83bt0xpSaLYmiqtIZqBAuPjFdoBz362SxjdCvNw5ZERPY
         PkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9whkxlKo4rj4ltS4V8ctUa53AuQZqOZnJEJuQ+S1em8=;
        b=F+qDoFdEpVlP2B/h37Z2DvVkFm42EVpVUTosbUb+uenyRnRQTTWxScoLkoydAoQcO7
         GnXAm3sm2K0va4XIy8ehRd6xD8kiGKMmPUa5OCccsks7M9C0pB4aDa2yO02gI8VjD2H3
         a2R5722hDQMkqbcP9GYYijIMPsWwAg2EK1KjEsFf7BKGjxKDf22IrFXuzwI66QTsUTR+
         mhu6lHtKVdjncAF/FqxroX7/AxZFQcJ7RoxRZOnT+GpBDmU5h7oTLUUDJTZu875fgfdl
         iX6J4pP3r68gT5FWd3y4826rmUetQen7ZD/nth1iKAHIThMsJ+JTARfVNYqDMjanKjWK
         9PuA==
X-Gm-Message-State: AOAM531R4vSwJe3l96/5msJQ+/zH3uaNkCiuXBCcJogc/SWLfvon9dPs
        97YdhIUVZK2/ApYLb3bEw3aaa+IaqfbToSOn
X-Google-Smtp-Source: ABdhPJyK52c1D6Af7Br2z5Rxl2b6wDgcUYsa3xfFhfrcDiXSA7LYvbyn5Y2wsnvFY8LAW1sgTftCLw==
X-Received: by 2002:a05:6e02:214f:: with SMTP id d15mr11088996ilv.145.1637163930627;
        Wed, 17 Nov 2021 07:45:30 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y8sm77065iox.32.2021.11.17.07.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:45:30 -0800 (PST)
Subject: Re: [PATCH 3/4] nvme: separate command prep and issue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-4-axboe@kernel.dk> <YZSedy1bGe30XEHW@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e285e2c3-6d35-74fa-82c6-626ecb5e9a0e@kernel.dk>
Date:   Wed, 17 Nov 2021 08:45:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZSedy1bGe30XEHW@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 11:17 PM, Christoph Hellwig wrote:
> On Tue, Nov 16, 2021 at 08:38:06PM -0700, Jens Axboe wrote:
>> +	ret = nvme_prep_rq(dev, ns, req, &iod->cmd);
>> +	if (ret == BLK_STS_OK) {
>> +		nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
>> +		return BLK_STS_OK;
>> +	}
>> +	return ret;
> 
> I'd prefer the traditional handle errors outside the straight path
> order here:
> 
> 	ret = nvme_prep_rq(dev, ns, req, &iod->cmd);
> 	if (ret)
> 		return ret;
> 	nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
> 	return BLK_STS_OK;

Sure, changed.

-- 
Jens Axboe

