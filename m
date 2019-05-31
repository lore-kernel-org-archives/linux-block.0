Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F0C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA08526D47
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 17:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YDA6oUSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaRkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 13:40:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34148 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 13:40:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so4280796plz.1
        for <linux-block@vger.kernel.org>; Fri, 31 May 2019 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXAYTSeCVr2gLg/a+5dNGWtUD0IovTL+OQWKjFW0NAk=;
        b=YDA6oUSdZKlchLK6/34LOEot3qfxo/lAPt+jmKStTPdXC8lrWh7o17JTRtzwEfZUQC
         CS2EJz2TEXcL8ID6weGxBwH43c81wH3RxCxVFW+hWBL1rDo8qo/nUvbmcSK3fyrlw83/
         U2WHmV1GCEc6UPHdxj8NQx8SxYnbgO/EJI+XbQfDMdJKtistFXiNzQhnG3XtwWR66MfZ
         riphu+kt78EVBbrY/vrdYL2RVlgNnHTkWpC2V0W5tbspMOzEVgObh9lMMVIp1oAkvWxZ
         LmBbcCGd94XQ15wvEWk2Y4hjYZWc2V/XFpggNlHrDN0BwdpMsOQCBYUqyaGoK7H1PPt0
         el3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXAYTSeCVr2gLg/a+5dNGWtUD0IovTL+OQWKjFW0NAk=;
        b=jQNQbFRjl0kunIzgYkKWUDfYqkTqky03ddIejAdDbzW5jko/tkqAR1i64MwO3wemZn
         uhHthhHrrnZ348Qga2nUQSmI7VJ7idFHfoLx+lpr7EX2tv3yLNn6ZJu3xhlVLYDTyKbd
         i8PtF2DPD2y+kMSluUP/IKU2YSSP7CfpyKMUNSsobcsb6yuJlIiTV2sRttvydEl40NRf
         OVpzlzq5E20cD07shc6o8ApX0yNa25ntBjUfSyHM/vIvjp9/4OsJhmP+PWjggUhLOxi7
         m7uvpEw6lAO4arWbPkhsI6DKsj6pj3uQWeQiguOs3hsN2cgurZfp0+cCes3WdLst1Nps
         m4TQ==
X-Gm-Message-State: APjAAAVFhyND8ejyw7Rl2vdhJN6RDYM1+ftQ3OmUkzT30sB5JSnlR4z7
        C52CPmbBWop2/hIsmW12XlMQAA==
X-Google-Smtp-Source: APXvYqzHk55enDF3nP7bqenWacz6glVRFSlwIyDxGBzvP5wWI6kNXOJYU9dgacHoQ1KK62V/UAovjg==
X-Received: by 2002:a17:902:28ab:: with SMTP id f40mr10917610plb.295.1559324441380;
        Fri, 31 May 2019 10:40:41 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id e12sm9549803pfl.122.2019.05.31.10.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 10:40:39 -0700 (PDT)
Subject: Re: [PATCH] block: print offending values when cloned rq limits are
 exceeded
To:     John Pittman <jpittman@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "djeffery@redhat.com" <djeffery@redhat.com>
References: <20190523214939.30277-1-jpittman@redhat.com>
 <BYAPR04MB5749B68BB9E3BD3B19F006D986020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CA+RJvhyLihk0tgSG5nAVMGNgBQTPnOCv==A886L_ca3q1aqMPQ@mail.gmail.com>
 <BYAPR04MB5749C6907333D8869917774186020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CA+RJvhyTYMGKg9Hn57Y9kkPU_fysHC6jF=ZTRyULE2OWirsA3Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac27f719-f3e7-8fae-49ef-aec2c103f0d0@kernel.dk>
Date:   Fri, 31 May 2019 11:40:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CA+RJvhyTYMGKg9Hn57Y9kkPU_fysHC6jF=ZTRyULE2OWirsA3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/19 11:34 AM, John Pittman wrote:
> Hi Jens.  Does this patch seem reasonable?

Looks good to me, applied.

-- 
Jens Axboe

