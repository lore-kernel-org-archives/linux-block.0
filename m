Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D3C388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 15:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2512068D
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 15:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="05QXNea3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgKJPxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJPxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 10:53:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C50C0613CF
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 07:53:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t11so13203428edj.13
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=blh0TM7uJoA9BF8R6HduWzSMqE4aY37AlNQs2jzT85E=;
        b=05QXNea3sjvnoh1/VZTHsd7S9cTspbIh29C0swjNCXRdbRNYPhE2Xuv+yduCHd6SFr
         mfPDnh6x8sUG7ouo0xLpXsHfI88CdaNCF4h13tpbGsNX3cObcnulm3jalz8zInGEXCC0
         kWTEZPy1gvIMTZIIK11h8lW8wjCMiY5IOOQzZo4WoipHq2SCfEd2DKoQrm9+c/zM/Tou
         keyiZZ/y0tR0ByQJIWwa5f4bK4wbxV/rr9pSv4asSs0RiLUSgR0zsVNbzWP2XCekHDEU
         KWCpMKuMmGTKJyDyZA13RlJ38RDegcsmxTQorYrEqVSzqB++6qSJDRy9kDp+mIVEDrS8
         2/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=blh0TM7uJoA9BF8R6HduWzSMqE4aY37AlNQs2jzT85E=;
        b=RSrKg1JPxzt93VsWPXDU9v69SuUnqtrMsI0EL1C7IcXcMYVQaLA44RGfbHcnfor61P
         VsO8LrhoEX6xaJqoH8ldyd8A3261RAo9PzzGn9Tt5chFbGDJyKK/Ysmg7Y7rtxF7klAn
         782eiK+ofrj2Ovv4KcfCzCkrmnCNQ1Hgkt7OtHVMbzZW0LEW4IYYl0qiF6vJFIW8mqyU
         5FyUJotXuaDQDYHEoueQOj7VfWruMUTzND5/1Mxok9UdA6UZMLQP+ViLiNJJm5buNOZe
         CkPlDYwSECoOUCwqDf1SUB/Kll9VSzrsA+CEpcBMcKVmp1VIOcb1sNr8tkXxqW/Z9wO3
         Om0A==
X-Gm-Message-State: AOAM531i2aSa1a9K3T1rDzm7Bw/zSZ65P31iLURDur+lIB9a+1XjmCDY
        OSZnMZ8wzM0caJlx9lxVgGM0UA==
X-Google-Smtp-Source: ABdhPJzaKCeEtQ9fP0/nRXVhs1jsXDLUI2p42GIalSum/7A5z2g7/Gl2sVymBJyPx06wk0O2pnuU2Q==
X-Received: by 2002:a05:6402:17ad:: with SMTP id j13mr20789280edy.347.1605023586170;
        Tue, 10 Nov 2020 07:53:06 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id nd5sm10671727ejb.37.2020.11.10.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:53:05 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:53:04 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201110155304.elqtz5dkjitofyxn@MacBook-Pro.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110141636.GD2221592@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110141636.GD2221592@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.11.2020 06:16, Keith Busch wrote:
>On Tue, Nov 10, 2020 at 10:39:38AM +0100, Javier González wrote:
>>  	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>>  			NVME_CMD_EFFECTS_CSUPP)) {
>> +		set_bit(NVME_NS_FORCE_RO, &ns->flags);
>>  		dev_warn(ns->ctrl->device,
>> -			"append not supported for zoned namespace:%d\n",
>> +			"append not supported for zoned namespace:%d. Forcing to read-only mode\n",
>>  			ns->head->ns_id);
>> -		return -EINVAL;
>>  	}
>
>In the unlikely event that a f/w upgrade adds append support, do we want
>to bother clearing this flag? If so, we would need to refresh the
>command effects log page.

Good point. Also useful when selecting a new FW slot. Would it make
sense to move the check to the revalidate path and eventually clear the
flag?
