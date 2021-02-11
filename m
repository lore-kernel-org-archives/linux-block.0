Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24244C433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE33364E65
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBKSeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhBKSck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 13:32:40 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F4C061574
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 10:32:00 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q5so5943834ilc.10
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 10:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AnAjxOD/QFbt9Jf2jIcI+bHB/hd0uOUG+fq9pOrDIk4=;
        b=bSySlswpTRFjWa+bXxino4wBcg1AFxg1uXM/GQgtfxNuM9L0yD2VWwooWTo7qGmKfO
         VIGt7LhhR4PP8lchdw84IY69vp1Zmjj5P0VC+mzwKcO5gyD/QyM70FryNRptKzHoqfWq
         ZBQdtpw3kUHLdNJyBB16ezrg0I/vhk8J65nly3Kt1DUa8T2HXF3aVBelErkGMS+JocG5
         L620UXSEF0PlTYMs0oBqGKDr7ibhpnfiZnkry8TKCOt+vEJN9SWA0yiMSj9bwxemEG1f
         86hW4F6F3vOdrtL5CSVu99WuX2pk3WP7Ti7C+rr33an775pzOVq6pXgW8MIEIuvteae4
         nn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnAjxOD/QFbt9Jf2jIcI+bHB/hd0uOUG+fq9pOrDIk4=;
        b=rv6RKu6JwkA5U9E+5XvUDRgQb3MwHjoFtOgVtmJTSPL//1R2PrwnqrqgCRCy6xjmBH
         14Dn+F25WF7dvBEveZTZ7B3klzZuGb5YKYXyqxlxPvvnO0W0g3NPfvPkTNWIPjMddSOE
         jvh08wKlQnC4YEU0k7qWI4+pIeN3jYcFZGdtj+TFMuXfbe/TIjStzzvfkaE4FcVJpCR9
         GwD81RUbrmnsLOfBIqRKgYxTGHj2qIc6ZanZFZf2Omhuauq43iQenb/mU+6Q6DshJtHq
         yyoryqyNrswAX5Uzt4gLHL4PgmCp0rIbBLaTW8cU+RRNz/CYEpgZnD5owSjdIoNmeuMY
         YXJA==
X-Gm-Message-State: AOAM531AL67qwaarGDscEjPWpAtXeA//kMtAnI1GZ/NSXU2p4PLUEKjl
        wFL6VGK/pMPNoYe50izj75lRMg==
X-Google-Smtp-Source: ABdhPJwb7plA/5DWabOa/BlLbXodn0IbqI5WNUyE/W442JQGUg6/zfWZrKN8aEo27p5N1FeB53/hTA==
X-Received: by 2002:a92:da8a:: with SMTP id u10mr7059230iln.238.1613068319974;
        Thu, 11 Feb 2021 10:31:59 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r9sm3028671ill.72.2021.02.11.10.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:31:59 -0800 (PST)
Subject: Re: [GIT PULL] second round of nvme updates for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YCV0PmcdMDOeQp5Q@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
Date:   Thu, 11 Feb 2021 11:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCV0PmcdMDOeQp5Q@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/21 11:15 AM, Christoph Hellwig wrote:
> Note that we have some issues with the previous updates.  We're working
> fast on fixes for those, but in the meantime I think it is good to get
> these changes out to you and into linux-next.

Pulled - it throws a trivial reject in the quirks list, fwiw.

-- 
Jens Axboe

