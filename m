Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1019AC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D3220857
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pURn1er1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfDHQGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:06:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42463 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfDHQGT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 12:06:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so6436334pfi.9
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UE9ujoGUXVccfCMNHPjF9tRbGyt6CXPSmg5+WMYpY/8=;
        b=pURn1er1A1ytab8pKzfnomujh7tKxcthslwOo+mxMKJ9WqmTtBGOT1bP4v6YO6lcGx
         keo8qVsztm8V1HcjIX11NHQk1H5+afH8WWsTAPS2gAsEjAAFJNzOx6WIyb9jTZPzrWN2
         /IT5JS3LemkeLSNuHMjbdbmIuXuYgLSxOrAJAu7m9o+JbkiJ/SeECSCL4oQBnJsAmqMn
         AgRThliPMy/LSwZu9VfJ1Ho2EEAbeC0bXay9S3Dcg5Sha91bTeEVJCUlpv6m1yFQXUnW
         HoAFQ5asarlJfmd5+396QfqQxjCPxJym7Gq1gQvl7FiPWjL+p06yREShJTJZ1JZjsAwY
         LltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UE9ujoGUXVccfCMNHPjF9tRbGyt6CXPSmg5+WMYpY/8=;
        b=gx0/mtbpSrmEq5qTIkoO0TTLj3O/V6Z8ewvwOAyluGSwn3wObP3F0umExmR+h6wvPg
         DnB2PjKeh2Y4Gyu8j+Jca0Uz1yqMNpcWJhiISwBKKvE/TtQb0IDN6E9SpLTPHC6YObQl
         uwjFPlNSU4ZxKhIAmaJJ4zOB8uiTFSNBLQ1o2FCswVhW0Lt06pNq4oB/eX/6H/LAJFbQ
         VAELyjbdXOvMKgmmkOxX3n0r/b36iGha+/Sw0JPomtqeYIA86ODeowgbLfLF6ohSWByW
         YAPRKUoVHL3NlpwoYMI+GNX4zwIvDPmkhcD9/K7C1KIpvABgMfDFZfsTFCDvG6Nqj2es
         ac4w==
X-Gm-Message-State: APjAAAWXOfChs1OvIIAigjib+WGnWHz0y/iKAQ7EVT+eIozogwEHz5oM
        ye3oCMvUzL6tx5+DiTUChkzE7A==
X-Google-Smtp-Source: APXvYqyXzF6yAdAmV/g+4XodIzAQunxyVQKnj6JFIq84NA0oLnqaO5XUwknSP/ltjar+g3cIDUy/Yw==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr27912821pgm.160.1554739578313;
        Mon, 08 Apr 2019 09:06:18 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l184sm73646861pfc.98.2019.04.08.09.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:06:17 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: fix some typos in comments
To:     Angelo Ruocco <angelo.ruocco.90@gmail.com>,
        linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
References: <20190408153534.6312-1-angeloruocco90@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d1ee9c5-e585-a1b9-d14a-7af1498fd14f@kernel.dk>
Date:   Mon, 8 Apr 2019 10:06:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408153534.6312-1-angeloruocco90@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 9:35 AM, Angelo Ruocco wrote:
> Some of the comments in the bfq files had typos. This patch fixes them.

Applied for 5.2, thanks.

-- 
Jens Axboe

