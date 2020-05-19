Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59211C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B3D20657
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pWd5K2r2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgESPkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:40:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF56C08C5C0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:40:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so42722plr.0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGO/bU976Rbw41xP6zn2pcfHAVM+aVs3q5u5hArX4dg=;
        b=pWd5K2r26WSj0olmybcxO2axnHp0KEVS68KcbkerqBNEiv/YZ1ESgS3KjJZgQNcJpc
         4PMxlRcpZuP5XZUqWLnTROCEMpELDP9unZg7ICTieNj9wtrHN03BYVrhTDvZiyWCoz2s
         mz4OTbkD4vNrgIohvjC0w0LvVeL8tsne4KIWJNwvyrCPI9pLBR+DPL8fQckMMThvvZBb
         BSXdUhaPx4aN6LkNp6Y6f5aK1lTkezR3kBsAVEmw/iClnHh0Q0VMMEOERkK5BWGcCsIX
         PGBa8Iqj6VmSGOgFkGKyw7W990Hs5HMr/1CNv5fExfSHn4K++4XFNBBPGNds0jIWIv4r
         biOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGO/bU976Rbw41xP6zn2pcfHAVM+aVs3q5u5hArX4dg=;
        b=hFdFPt/6KuopYc/ZZwU549sLKAoUUO8nKj/a4aOKT7em3B752eUqyFM8ImpXbHfaCD
         p0NCfi47+6cZa5PgiMkdjlj9ZLkg49qZuKgd31v1lFZJ6QyG00SeDxTUEnAYx9GqM9wa
         tfqfCvFlYQ2rB7LqluP3eJgYiI34qIyLyMk2C4QgeXBI3q8CfcgmCqvxJga5G0g3WD6q
         Gr/PKpx1Rog+5AluTflME1Fy8PYbBkMD06950/SoZmTkMDY9aKgfZQXQytL6ngA+XRE8
         Hcp1n8fzWGqlcFO/n4+jdydTOglBRhqu228VnSpyVXnhVsP7yqNVuS7ilLtFiMB41wSx
         hyDw==
X-Gm-Message-State: AOAM531FoC0NDlhp0qBzyHFIa1FF/I73C4/cnEk/HQbVI81jMOe911Pz
        vqETc5Ni/gz/ELhGpJU3Cfc0hQ==
X-Google-Smtp-Source: ABdhPJyyWtD4wFwiCxYZejO84CrBXVEEuQFsjDkzcu+kuViFcLhlNdvU4jojPr4mvR43VG/l2DNxgw==
X-Received: by 2002:a17:90a:840e:: with SMTP id j14mr138230pjn.85.1589902841607;
        Tue, 19 May 2020 08:40:41 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id p24sm11615083pff.92.2020.05.19.08.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:40:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Block layer patches for kernel v5.8
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>
References: <20200519040737.4531-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13a6142f-d0b6-507f-70d8-3ca3ba83c4e6@kernel.dk>
Date:   Tue, 19 May 2020 09:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519040737.4531-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/20 10:07 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> The patches in this series are what I came up with as the result of
> analyzing Alexander Potapenko's report about reading from null_blk.
> Please consider these patches for kernel v5.8.

Applied, thanks.

-- 
Jens Axboe

