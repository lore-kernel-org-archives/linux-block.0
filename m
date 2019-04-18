Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334CC10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0EC217FA
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YKSvblWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfDRQvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:51:04 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:39129 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRQvD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 12:51:03 -0400
Received: by mail-it1-f176.google.com with SMTP id 139so4328382ita.4
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZBroQlD/x0tjkd/vgeFFg3g0i1ldalUALCF/NiFiav0=;
        b=YKSvblWtZEUTuuq9N3NkcvGnliynBfWGv5rUCj+b/gqwKNFhgo53cBWSoBhRPJYYd9
         qRmnWh8Dnhhp18HstpUa316gh/IZPZQxL3cWvssMoEO5RnGGa4CNpxGhEoiKFDu9m/+M
         Unjyw4hbJwrh4ArGNV+jWK8Cyuibq8xGniBiTIA1qVSpXwDE4xdNd8IRzdhWbF/OVbk8
         hpKY+/d9V6N4lh51WApahHffwpFYHHNSd9TD0JlJbQBGT/c9gZqxOc5LLIZ/Jz26z1Io
         yXwzc9zjkVPKgAUrFiY8YLPUqSASyywW4fcD1BxaGwOLSlafd10Y1jorliYT252JYaoz
         kr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZBroQlD/x0tjkd/vgeFFg3g0i1ldalUALCF/NiFiav0=;
        b=FK+LpxR13IQgmrsPobS/IkmRo7SXvd33xRXE8ywI86YqdwAiMgLrahy+JleHVmgnR+
         5JBC8xYyTKuMv3uduWXF95G8bz4twbP1gBWKL34XRJtz+qDx52Jb6hoORIjDTkrm71kH
         6r3Q3H19WmzzTxR/Azcx4cKHxkSW51eDbju2GU8jSSBZI1S3Yv6FdiuVj7kBd9v36RIW
         yms94Pth84tVWGzRo9GxXPqPXcAb+8vpMsQDNxMRjuP5VsdlrDyyqlmJRv2GbB4kFhhY
         LEaTzqpk1Lldp5MYrSMTGDaXFLvg99xW19yK4X5QhiSLvvjQfjjCPYHvs/BwzNCIhi/Z
         V3lQ==
X-Gm-Message-State: APjAAAWORYhMJ0tcOckXgHxrgBEGpKgZJmt1yiw/2X4Rd7fSIC0wjcza
        c82f91jHSvAtHFTNOhrM7X7UzHRtYHH4eA==
X-Google-Smtp-Source: APXvYqxumkbLsjETU4qvP9NbPS1YZkVHINT9y1I0V20eRF/oV266FgQAg3c5TP637dSmlBHM/Dnxew==
X-Received: by 2002:a24:1052:: with SMTP id 79mr4680012ity.158.1555606262529;
        Thu, 18 Apr 2019 09:51:02 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h77sm1197075ith.2.2019.04.18.09.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:51:01 -0700 (PDT)
Subject: Re: [PATCHv2] fio: Add advise THP option to mmap engine
To:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
References: <20190418162556.7829-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3caa9cd8-c0dd-a1b8-0c1e-cd1d58aa676b@kernel.dk>
Date:   Thu, 18 Apr 2019 10:50:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418162556.7829-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/19 10:25 AM, Keith Busch wrote:
> The Linux specific transparent hugepage memory advisory has potentially
> significant implications for how the memory management behaves. If the
> platform supports it, add a new mmap ioengine specific option that advises
> HUGEPAGE on an mmap'ed range. The option availability is detected during
> configure. If the option is set, fio can test THP when used with private
> anonymous memory (i.e. mmap /dev/zero).

Thanks Keith, applied.

-- 
Jens Axboe

