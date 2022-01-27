Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8589C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 13:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiA0Nxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 08:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiA0Nxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 08:53:51 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989CC061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 05:53:51 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z4so2532805ilz.4
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ZCSZmVvUmVjSHnTT3jccpdt6fseuRczjAFEuiIrTbg=;
        b=04NEnHqAgj9kJJcOE7ZLFomq6hubS8cMJGe2CxhxR/FlQot8GzWARFDD7+8FkwdiH1
         +Ypaql6IWkE8hhUMMXnX8DPgUfmgKc9i66/JhLgoaNlZklng31rQ2plZqa5HAPV21WyI
         Kq8Rt92LQ8OFPpgDlaA7K77zbppmDZkIfJZDkkzEHErH7YjduDYc/KCbtolDEYMMN6hH
         c0nteeCflYdW0Vk2UuZ2mfGQ4AyfNJveYYsqaAT7AZ2toMQ77pOdRkbF8BdxeCLv25WA
         leMP+l8KVwpeD7FXeTj/CX52VCm6uIM+6k8sbwiRsIEOrFMCKRkkpwvOJmDjelirZ0eR
         ldUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZCSZmVvUmVjSHnTT3jccpdt6fseuRczjAFEuiIrTbg=;
        b=oUJVirdNxQa0aFNAFGJN212pa1wjqE2xs+jQpAxHXL6IbaocYt5NvFwmpVaC266GG8
         k3KwUm8cl047ms1CsGPh3UZ1VfXpujyL+lpyemBmxVS4onnt3WtxHTHGjp1ogXGNE3kU
         N67gOzmkHF4aW8aEK7axnYViD30+qZUvYlMw/8ZaeFOtPrWhItncj18hQk9xVBs7+cYp
         oaOmgjRtGwFUGhVAoLWwTczUJzqy/4KrwM6wFEXBJ8c94RuDSNaKtsie/fPGxaRG4z9h
         qDnDuIA9LgPD9c/ReqYi950H+zc/IUwNMDwwC7Q5V7LIsTT8mn0ibiZpNq4ZhdPuxa80
         R9rQ==
X-Gm-Message-State: AOAM533f+REFLljfvkMw1GgqE71Tt3pcvE1k8oV8aqXxZSDh251VLoyO
        UtmoJqfGEB0qrRlj9Vh6PCBL4g==
X-Google-Smtp-Source: ABdhPJx1KhHIIH8AnrvN5wIqBozU/p1pu/n4owTzdUnt58ZOw7SmxtKE8xFfaimeEpkPg4dE9xtTOg==
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr2375976ilv.252.1643291630561;
        Thu, 27 Jan 2022 05:53:50 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q4sm1567032ilv.5.2022.01.27.05.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:53:49 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YfJHeoRZIPt2t3aP@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e58dd4de-3079-cc0f-d18d-b7c86df0a3c1@kernel.dk>
Date:   Thu, 27 Jan 2022 06:53:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfJHeoRZIPt2t3aP@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/22 12:19 AM, Christoph Hellwig wrote:
> The following changes since commit 83114df32ae779df57e0af99a8ba6c3968b2ba3d:
> 
>   block: fix memory leak in disk_register_independent_access_ranges (2022-01-23 09:13:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-01-27

Pulled, thanks.

-- 
Jens Axboe

