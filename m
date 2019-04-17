Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB9C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B0B217FA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EKSdNm7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfDQWBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:01:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41050 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQWBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 18:01:32 -0400
Received: by mail-io1-f66.google.com with SMTP id v10so327927iom.8
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=K/wzffLtl4zrP0Tc/FXz/h9XrYwXO0JLy7eVSp2CQ4s=;
        b=EKSdNm7WORYPSbGQnW/QK14p/KAa1vFVd4xeQ5E9cLHFRUlKCcDzjZENvzcY2HbZjl
         Fjbxlya2lf78w7ogGg/f/XSHsd7db15i4HWmH+43EEFiy/xTJvBIv0vjbXHtcqh+R8tt
         EfqLr/ZsKjG3aATUJoIaE4FN9Shb1+uxYEjOiP/xcjREgd6V2smZU8fCN83GldBhWyCF
         yMXmOsK4MiMXCqwOJsCv30N/ZsQGCHKQ5UBoZtS0QQ5GCNEVB4CbuJl9kSfMWbQ+6/qM
         zrHTA0rUeU4JDu1OmdAesIurrFUXRztA0NO4wu8PAcNIjOHMxhtBTQ446MUQrIX06x4D
         sfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/wzffLtl4zrP0Tc/FXz/h9XrYwXO0JLy7eVSp2CQ4s=;
        b=obvYB27tWxfRdEPTVBICHujEQYcGmijsZiMDyzGCN9U7f2eb0CAA9vaCNXdQfmJmuz
         xb+20gNrVekmCPbq/Bm9k9jQ1rZYzHvBvSmafgI0RJA1wiisGiHToUINVQUTM+7rsCNe
         aSglQ/W45FcO2K9sq875EO98nTLCpzcUpRp4NjiaXrVZkR5KEs3Ebu1g1LBsTX+BzGL2
         yxwJun3GH2b+ByMY6WiPkhz43OzmsK8Lp/Y/uxNByTdElMU3SVtZqJg71FwA1/xcKDYr
         fx+leGlAxf2T0tL/oHiUN/b2ErO5YglwrOle4YWP8JTwfj6Hrp7zH8wN3OkHZ52yBcpA
         ka6w==
X-Gm-Message-State: APjAAAXIGS1vGsHs7wXBdodPuk3ns0IDLcEMsaluNwsnGCL4iSCEPhNt
        Edg9J0aCgA/3t3vyfZ17yiQKg5RPMo7/Og==
X-Google-Smtp-Source: APXvYqyYoAqteAuKa53LdpM1tSgclR5HwxRTh2nzMEykDHO6k33nwYWHR0hYpNW6NZzog70C0ZNJbQ==
X-Received: by 2002:a5d:8910:: with SMTP id b16mr56184980ion.178.1555538491112;
        Wed, 17 Apr 2019 15:01:31 -0700 (PDT)
Received: from [192.168.1.112] (174-23-158-160.slkc.qwest.net. [174.23.158.160])
        by smtp.gmail.com with ESMTPSA id s124sm117678itb.42.2019.04.17.15.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:01:30 -0700 (PDT)
Subject: Re: [PATCH] fio: Add advise THP option to mmap engine
To:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
References: <20190417212816.6460-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a288283-e4c1-6fdc-6884-d98cfd246492@kernel.dk>
Date:   Wed, 17 Apr 2019 16:01:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417212816.6460-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/19 3:28 PM, Keith Busch wrote:
> The transparent hugepage Linux-specific memory advisory has potentially
> significant implications for how the memory management behaves. Add a
> new mmap specific option that enables private TLP mmap mode when set so
> we can test running fio with anonymous memory (i.e. mmap /dev/zero).

I'm fine with this, but the usual approach to platform stuff like this
is to have

#define FIO_HAVE_THP

or similar in the os/os-linux.h file and then have:

#if FIO_OS==os_linux
	if (o->thp)
		madvise(io_u->mmap_data, fmd->mmap_sz, MADV_HUGEPAGE);
#endif

#if defined(FIO_HAVE_THP)
	...
#endif

instead. Since we need MADV_HUGEPAGE as well, might even make sense to
just have this be a configure check instead...
 
-- 
Jens Axboe

