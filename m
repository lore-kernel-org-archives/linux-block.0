Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26FC4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317820719
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 23:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2NGWvET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgCWXWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:22:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41790 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWXWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 19:22:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id z22so11671774lfd.8;
        Mon, 23 Mar 2020 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=41uGEk7KN1jul372LnGuHaKgaa055FAOzP8BcsuaDPA=;
        b=n2NGWvETHUzibEU5htvmPy5dAcILSO+jP+jlv1inM0KjNv98qOF1UmUOHu6xfafNpd
         /9pp0oARvGR+6S7JqmUdexvF7FHsicYFtbl7q4CvZVvEXNjAMTB4PGEmVUPBzvR8OIn3
         b8TR0rtzsR0yHABFVtiMoTeDa2fXGR+RSSMAlnXpgEjjr2a6s0nxOqOeqmKVMVnW3mla
         GTvzxq3KpATO0sL6uxvsyXxmAVFqQI6ZqGRTPls5A/YH80gg8jBy5v6xTO5V+jaj29ak
         Fv6RnHXoZSgh1jf9axvhnHRcVQrb2jw9WsUOQR8jO/BO3Bi3qYyP+cQ7VSwN6T4UHDzh
         ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41uGEk7KN1jul372LnGuHaKgaa055FAOzP8BcsuaDPA=;
        b=jB3jRCNCJAHLHSf+gCJOfJ1PdoUTiOKUTzeZKsWoXm4IybIzKrZkRJ1B6R8jIpXxWk
         6xXtRWGNq0uvLvsVEep+krmzmu/OGGTJaYFwDVg08nnT1XArPvVwEUSh711twQ6RGtZ4
         vTnluLjUA/4PD3VmoASB6rCaD7Mhh1iJk1AYYNjI+7QAkdaed2U9bRZ+z2JtzoOYI7b+
         XpXnDtPTwQsXEN8yc2g63MzlNsONCXpc2tVJfr2DociRBxc8l66/Sc9rA2xwQFdAYbWI
         kVAquDl/x45prNjCD1gths2eT3wyIgkSiERO2iJdRPGupr8U4YzP3z3iQdOMKq/XmYY4
         gr2A==
X-Gm-Message-State: ANhLgQ1OGrPoCo8sfsHN0OZB1zqIJ5eTYmHoexdv1OUNp7tyXs7Yt8XA
        iL/efWt8VtVExcRG1oe5NcGVeF6Y
X-Google-Smtp-Source: ADFU+vtmhM+5GqZBY8/zEithbc65SPh24Ye3iCc3hZz0IeH6GbzUzdlEsftlFeENWVZP9ba5fq6OXA==
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr8244771lfb.88.1585005756819;
        Mon, 23 Mar 2020 16:22:36 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id h9sm8861883ljk.96.2020.03.23.16.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 16:22:35 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] partitions: Introduce NVIDIA Tegra Partition
 Table
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200323163431.7678-1-digetx@gmail.com>
 <20200323163431.7678-4-digetx@gmail.com>
 <20200323191748.GB30585@qmqm.qmqm.pl>
 <67140755-c829-5c58-3fbf-efd496e225df@gmail.com>
 <20200323213520.GA16587@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c31a0335-a174-0f45-af03-3267710a8205@gmail.com>
Date:   Tue, 24 Mar 2020 02:22:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323213520.GA16587@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

24.03.2020 00:35, Michał Mirosław пишет:
> On Mon, Mar 23, 2020 at 10:59:52PM +0300, Dmitry Osipenko wrote:
>> 23.03.2020 22:17, Michał Mirosław пишет:
>>> On Mon, Mar 23, 2020 at 07:34:24PM +0300, Dmitry Osipenko wrote:
>>>> All NVIDIA Tegra devices use a special partition table format for the
>>>> internal storage partitioning. Most of Tegra devices have GPT partition
>>>> in addition to TegraPT, but some older Android consumer-grade devices do
>>>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
>>>> in order to support these devices properly in the upstream kernel. This
>>>> patch adds support for NVIDIA Tegra Partition Table format that is used
>>>> at least by all NVIDIA Tegra20 and Tegra30 devices.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  arch/arm/mach-tegra/tegra.c   |  54 ++++
>>> [...]
>>>
>>> Please split off this part and make the information available to
>>> userspace (pt_addr + pt_size) if found. This would make it easier
>>> to support use the partition table later in initrd instead.
>>
>> Please clarify what do you mean by "use the partition table later in
>> initrd instead".
> 
> Configure device-mapper to span eMMC boot+data partitions and then ask
> (modified) kpartx to partition the resulting device. All before rootfs
> is mounted and switched to in initrd.

The whole point of this series is to make partition handling generic in
the kernel, avoiding the need to customize anything.
