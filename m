Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FCCC5CFFE
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 10:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A73204FD
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 10:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ftDBloSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A73204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLJKKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:10:37 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42235 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeLJKKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 05:10:37 -0500
Received: by mail-lf1-f42.google.com with SMTP id l10so7526927lfh.9
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 02:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fif23AHdohLKLC0L1CYr5OmKa+ZSJBadntPEdTmwOvg=;
        b=ftDBloSvi/3EjCdyeNR2uyuRI9IOAn5U8s7aow174C7H+n4L/M8zl1hlXbOlOuG7/Z
         HQbBfg5FLNaIk6MXrXwYANSJVpXlyE54u2QWRli783dGXo4kT8JyYNUVSGD84AS/o8ev
         V7ECQ/WkP0ereKkq4gig+gfcODLEvhdjVnDwN6qs9tulwJNJGPJoIIokapMpvLtBV+HI
         n4RLerCq6EbaQaowpDwDxbMKuxy3j0fzTXc0ecNuzVTVm0900TL9+RZKpQJaFFwq2WAZ
         SCxcrDHIZGtb6VKk0lIcK1VLjThn8up/6kbVYsFfm+HIR/Rt/ziFpaQ/DbTHW9LDNYfh
         68kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fif23AHdohLKLC0L1CYr5OmKa+ZSJBadntPEdTmwOvg=;
        b=nu94C1d8pSlxpPlfR0XQszP7Tznbc4shCuhlk+6RvyD7ilLu5eJjvs4RMmopQNBp+K
         Qafl/aaSXguPnUteZIH3E7SjfIgMS9GgVys2dk6MbppUqoqBkH33Uwe51K1Ywrrg4NLY
         d/jZ80Onu2Cd5ySZIsBXUm1WgOLVTvYBk5Nr0P/NtbaGwqH22MLRZmQQgpMV+xQKaOBK
         R5M+rXFyy5F/HO7MHWRwRByRPeOF5N3/kJqRwy50H4gr/6K1QR4UnZvNZScJI9/TkGgv
         qmBzw/HZZpp3nVhNlDrWkfrdlRu1N3JbhapUH99tpdJ+G4LjSAe9x3IlKMy+3de6jVXR
         AtPw==
X-Gm-Message-State: AA+aEWZDLWEWVoYeHZcm88JMOgHYoJPznHuDsOT0kkMc7Q9hoPaYMbyg
        9g2HcNziBQ+M5qo/EUsWQPwz/w==
X-Google-Smtp-Source: AFSGD/W+kOMwWRzEhnFWFSG5NvTIuORMB8Jvmf9e0QzGWw53tzWETvtcgFH1uDxbLinMI48arbmPbw==
X-Received: by 2002:a19:c345:: with SMTP id t66mr6054843lff.55.1544436635064;
        Mon, 10 Dec 2018 02:10:35 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id a62sm2037880lfa.37.2018.12.10.02.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:10:33 -0800 (PST)
Subject: Re: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
To:     Hans Holmberg <hans@owltronix.com>,
        Javier Gonzalez <javier@cnexlabs.com>
Cc:     igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20181206154559.5642-1-igor.j.konopko@intel.com>
 <20181206154559.5642-2-igor.j.konopko@intel.com>
 <A790DB4E-9DD0-40CE-94D9-631E0C28D2D6@cnexlabs.com>
 <0f219bd6-fd49-5d13-f0e2-af8fe7749127@lightnvm.io>
 <8DCB397C-5A0E-4E85-AEDF-70A8603FC7EF@cnexlabs.com>
 <CANr-nt2jRfJnZiUyxZPhySpJogyy4ROxWKb6BjMDk2UzMig9BA@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <203bc57e-7984-f6fa-3e84-d8d805a30eea@lightnvm.io>
Date:   Mon, 10 Dec 2018 11:10:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt2jRfJnZiUyxZPhySpJogyy4ROxWKb6BjMDk2UzMig9BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/2018 09:29 AM, Hans Holmberg wrote:
> I ran a set of regression tests on one of our cards (with metadata
> support) and some block stress tests in qemu(simulating a drive
> without metadata) on for-4.21/core
> (e805f4c9e74ab75e925927feee9887b1c6e50e8d)
> All good.
> 
> Tested-by: Hans Holmberg <hans.holmber@cnexlabs.com>

Thanks Hans. I appreciate it.


