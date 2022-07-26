Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4CC43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 03:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiGZDkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGZDkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 23:40:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E164F6
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 20:40:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h132so12080078pgc.10
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 20:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+WBv4LTd7aGLHBME8vf9d+v8kM16zKtxRYBYDecYKYo=;
        b=iLzWZ+m2Rx1WBXzgo+RoCGCBDsKpwIMSPGh39jbJOVRYEwXW7m634GOdYAyJ7aPWEY
         1jW+6oQ8EaOzJBc9QvVNYxMlPs+vyTV6LCy+q6kIdjc8n+iMvNrBAZJnCtkCwi4YG1gB
         qcL0f278Gh+Ty4JZcdJR6cFjLXHjpuGmcVX57CjrFRRmu3E1llAehnSzXg3/T5RsU4VW
         QTDEUlRvidLIK83d1HWz/EqD2RCyyFtFH+S7ZbMj2mQnM87LiJIJ8LCp5x6yv5U/twX8
         5CFt1FZ5b2NP8Zq8NKXK/rZXTIc+ezLksHdU38LPJnlzTsYOjIAUBOyFe6qgDnO+fNhz
         RB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+WBv4LTd7aGLHBME8vf9d+v8kM16zKtxRYBYDecYKYo=;
        b=0Sps3UOFsg/YAsRQynEDCwEg8rzK0m8vMG9GAXw0wcjQAitCoRRctg8NRy9BdgkQjz
         ckf0TRBMlj1kTq84qr80x5KG5ekW1TsYQxeYqBLfIP6T0agSnFJ11DwD7Rtwoc9QD9Vd
         e2rYoMNYaqIE7atA5aLz26sMf82fGDMidNx73f134KZkMNR68JxpzDMsBrPL5ZXJ+WOf
         oNiKTw+zbTulUGhA3D2bWw8E9xwbhxILg4Tr0SlLMepd5sHZeG7bYnirEKCsDoJyGKbH
         dxxvF5/vn6zVTVOc6GoAikO3kyBNvU7oGCHVmhj8DpYrRkfn7jtF0K6xOpab6m3jOVBA
         H91Q==
X-Gm-Message-State: AJIora8dJCxYc2XeSTRz8hyveHmS7EySCCS5r7GYYlmLN91zWiGqpxFi
        QLxUaYvxcfucHfWqlVq+YvJAATiFhWA8rw==
X-Google-Smtp-Source: AGRyM1vGQoM73cO/4mRqmSCzSnIgSGchlsNVbhscfk9WilDdCC1VWcvK/iUN296GMh9wsNzWVKv75w==
X-Received: by 2002:a63:5b22:0:b0:41a:a605:f59a with SMTP id p34-20020a635b22000000b0041aa605f59amr13889957pgb.595.1658806821939;
        Mon, 25 Jul 2022 20:40:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79596000000b0050dc7628183sm10628291pfj.93.2022.07.25.20.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 20:40:21 -0700 (PDT)
Message-ID: <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
Date:   Mon, 25 Jul 2022 21:40:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <1539570747-19906-3-git-send-email-schmitzmic@gmail.com>
 <2265295.ElGaqSPkdT@ananda> <5e45c2a8-b35e-9a15-18e6-2e3a7ad00f5f@kernel.dk>
 <e0b99db6-ab3e-1c6d-d431-99cee32c1ced@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e0b99db6-ab3e-1c6d-d431-99cee32c1ced@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/22 7:53 PM, Michael Schmitz wrote:
> Hi Jens,
> 
> there's been quite a bit of review on this patch series back in the
> day (most of that would have been on linux-m68k IIRC; see Geert's
> Reviewed-By tag), and I addressed the issues raised but as you say, it
> did never get merged.
> 
> I've found a copy of the linux-block repo that has these patches, will
> see if I can get them updated to apply to current linux-block.

Thanks, please do resend them and we can get them applied.

-- 
Jens Axboe

