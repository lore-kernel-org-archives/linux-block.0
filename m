Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679DC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989BD20823
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tvSn1oFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfC1PHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:07:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43336 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1PHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:07:06 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so17511422iol.10
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b78i6ZArWnjtH9Ww9AlxlSEgwBRJ8cwhcMbYlVPRXK8=;
        b=tvSn1oFHYIgooZzJFoCEetkeNGmeRR54WinovmLFCKgo2vLBuWx2Gx/P0GGACykR80
         GXhC5g/ROFXUjUQNblY6FeRS3qYt9tZxsEXkP/9mNSrLOWVLD+Yf9OnjlCkgR3B2HVaG
         H1F0pNY39yP2T1kIuWlRt8ZpjEweOb6a95bVbAoATs5gz/guJHsFyzXWC2bnp+/zBE4A
         qcAIfmjV5VE982zvfk7gC+O79VH2uGdfDecVMJV8ojfTQGgNboZXG8Fu4AZSm1331QEC
         aa02WafzObt8FHfEGIX4eu0T50rxr5bjtzXwJpeRSqd1nWORB4ARUTjhi/F+6KZ3QEd7
         Wyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b78i6ZArWnjtH9Ww9AlxlSEgwBRJ8cwhcMbYlVPRXK8=;
        b=eOiqXaExOatTXcom1wln/dvvUqQWakhBuopwArbIWs1AmEs8gpcFxP1OSv2Rnxhua1
         b1zqCRClAHTz7KmmAIZoH52QMrnZU2aiZI5Yj5PUKQUHlIXxCR7D30YaQmugSL/JJqfL
         2YbW/UdoB7jkvWkvnamJeINduqtEvrhUjwwllw3Z3GxiBZYLonWAPbyf4UbzaYSYAZ71
         0Q9hVj5qJnblXZRJDxNfcXbXEzeS81tCVvHolycXivRp3/n9/+n8Yb0gyrMsWVc7BXHX
         yOvmO7tUn8u/HkBThcrbihKTAjWY/ZzOCTz2KlOmjSLNMvfdZgkWk6ThZDlGXNsIUWhV
         c2rg==
X-Gm-Message-State: APjAAAVRpyZVZNiNBg0iqt0+VS/I90vvBe8UdnpogtbV0LuUJS77lvD9
        imSEltrtoZB/MTUXMLUs3/aejg==
X-Google-Smtp-Source: APXvYqx/ITvDxgvPLWcvPr3EWc/OkPqFfX8U/pbV01O7pZ7gCwd3BQo590F8o9bas/fmDNRXrCxAew==
X-Received: by 2002:a5e:d514:: with SMTP id e20mr28664900iom.8.1553785625431;
        Thu, 28 Mar 2019 08:07:05 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b199sm2038449itb.29.2019.03.28.08.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:07:04 -0700 (PDT)
Subject: Re: [PATCH] block: clarify that bio_add_page() and related helpers
 can add multi pages
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190328035001.26276-1-ming.lei@redhat.com>
 <5258cad3-b324-660f-589f-73eb7fb8fa04@kernel.dk>
 <20190328150320.GB9265@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e53a36f-2b73-55bf-e404-52cfa0192981@kernel.dk>
Date:   Thu, 28 Mar 2019 09:07:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328150320.GB9265@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/19 9:03 AM, Christoph Hellwig wrote:
> On Thu, Mar 28, 2019 at 08:21:55AM -0600, Jens Axboe wrote:
>> This is going to create a needless conflict between 5.1 and the 5.2
>> block tree. I haven't pushed the 5.2 tree out yet, plan to do so
>> this week after I've pushed the current 5.1 patches. Can you respin
>> this one on top of for-5.2/block when it comes out?
> 
> Can we also drop the parameter name rename and just add the comments?

Yeah, that might be better to avoid needless churn.

-- 
Jens Axboe

