Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F396ACDB474
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjJPUxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPUxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 16:53:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E1A2
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:53:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f64817809so734590a12.1
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697489588; x=1698094388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttpKw53SYn1T0nC1SsgOvVGo93COVcsvekGY8gxBBTU=;
        b=xGrjW9wRNrXg3z4MgI4cUb7HIKSlY+G1AO+TsO+7Ng+NHajcXPqU9eUJMYblE1buQ6
         3IeTu4d0J7Vd85PgEDjlHrDQpk0NjQMJFN3ThL8BFgCQOcMjdx0iAkynm2MFGo98meyJ
         kWwxaxdp/TSO2d3yiShLc0eG2WnhUiLg8Ee0o7cEa57oOBkp4pycDiU10IRDE7015R/P
         0KaXxdWr3RgitOxhdXBXBwZqzEwN9ZOvJRBqw2HcOYUit55HeDa0P2BnedCd2sAVpyGc
         f+xNL6jU+jYHyBRskUsDGLwwzd+EkoL3KS45quAbFZBBSOoRWX7/v5As3xJDcwiuGRJn
         NYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489588; x=1698094388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttpKw53SYn1T0nC1SsgOvVGo93COVcsvekGY8gxBBTU=;
        b=iKWc2EDk+gynoeTsodvKTLgvec65/JzISSqm/RHsq+u+ipBEkWRLwIvKDWww67xjlW
         lr69LMuRo1MpJFJAs28YTSRCyGecrrxyFFLGRMD/sj4ZWKPFEfanRFMYTzf4cY6oYBIg
         arXRlxc2TC2EoZ+lehhKdiMEcmsrDr8esk4AdBy+InIXlNYch7QtN6N8WlCAOXXF1nIa
         FQjgB446PkKnLCz1ZvYYZbuK+UzT9GmEJZkBdxdfdogptnZE2JzqjefWnutAJX902u2I
         1zjBv9/E45MCxjexw1LfhB12u3ap2pTBSGBJpo5MjHfksO20gI8SpKWWsohjmnDNLk4u
         ogig==
X-Gm-Message-State: AOJu0YyoUWo4vu/QLeFhHFPuZGQM0mxD3Jzvn+cWBLgHJH92BgxdK7oq
        U8TdPTEcFhN72G1VZ2txOH1s4A==
X-Google-Smtp-Source: AGHT+IG2BsHvA2gsoyJSgYeMt11ibLp5258T1Lr9+dav83jgNPjimvcMo2MQU1W3TTl0vPFhpIUhuQ==
X-Received: by 2002:a05:6a20:54a6:b0:163:d382:ba99 with SMTP id i38-20020a056a2054a600b00163d382ba99mr154190pzk.5.1697489588192;
        Mon, 16 Oct 2023 13:53:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b001b8b2a6c4a4sm53931plg.172.2023.10.16.13.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:53:07 -0700 (PDT)
Message-ID: <68a2a403-ab2c-4932-a12f-1751ff6ccd77@kernel.dk>
Date:   Mon, 16 Oct 2023 14:53:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cdrom: Add missing blank lines after declarations
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
References: <20231016204741.1014-1-phil@philpotter.co.uk>
 <20231016204741.1014-2-phil@philpotter.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016204741.1014-2-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/23 2:47 PM, Phillip Potter wrote:
> From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> 
> Add missing blank lines after declarations to fix warning found by
> checkpatch.pl script.

Let's please not do this. It's fine to run checkpatch on new patches to
ensure that you don't make mistakes, but this is just useless churn.
Even worse:

> @@ -1202,6 +1204,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>  {
>          int ret;
>  	tracktype tracks;
> +
>  	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
>  	if (!(cdi->options & CDO_CHECK_TYPE))
>  		return 0;

This int ret is using spaces and not a tab, why even make a newline
change and not sort that out too?

But it's all mostly moot as we should not be doing patches like this.

-- 
Jens Axboe

