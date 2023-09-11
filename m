Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD5FCA0ED3
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 21:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbjIKVlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjIKNP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 09:15:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD40EB
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 06:15:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68e2ff0b5c4so415957b3a.0
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694438120; x=1695042920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEzbOAJ4Fb01DDQnzPGrL2255sHl8eJXRyf8OznVFus=;
        b=n+/dPdaFGlslxalFG5dQshZzQ1NB+zrUnqTKRXOBt0CWrJ1DGux/GVpOSWH26sx/og
         InuJVd7502PA3wQLeS5ceHT3aGubpxRykJB0l3wyCG5TLImP15QNSA2eHyNdTUkHrdLo
         GTBnHegJ/5dm5xOCXZMXWtlI/9FS1zRHdlOF5WYVYKdy8DbwILg/ybUGnUsfIzyaMN+X
         NC9gQM5dJVhCG6cjlra4X44FI/M4aB2yDj5X9TsxNVPQOQ3FhEhygrSVo53bBF0eQVyQ
         MdsW0Gh32ePJIznsvwt7DcEmAy2nAgd8lBzcUT8IFhlKb1jtSiURoFsxjK/lYWlZtS5r
         XnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438120; x=1695042920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEzbOAJ4Fb01DDQnzPGrL2255sHl8eJXRyf8OznVFus=;
        b=oVRuKS4avvwQ22/nmL3CYBKqU555t4o2YGAgkScWq3j34IBbW8e0aahkI8u9oLq1NC
         OVmuhsLHkV3AvdTTar75iqpN6Wz0g8m/P9PRAuAZSTclpMHMaLSbMqdmwJsUXRHLDRY6
         W7lYAdGsWIs+r3A3mygjCSOGv++3ZB57AhIbmTnHpz53ekDYKZAi4VLdFRVcNuWbTnS+
         WUxDCGPlyl5h/O7T0x3VAbduxPNO7crB5ynxNan7ukkv4LA2lJDz5FrGbXxG1KxzDfU2
         tGH+K14zM2oxCEUroWmox8hjPrenKpGxWskc+xp3vRt0yDBsdO6B49g/V6qpVRXYRUQv
         qRXg==
X-Gm-Message-State: AOJu0Yys5rki6s7W6Bd1Y3NubYQfmKLHujkhzcRQYiwZfSIK7ib3tDbW
        5pZVsN0W8e4tGrcEdD2vXBlPEQ==
X-Google-Smtp-Source: AGHT+IHudscUtHs0qFn619Ul6rWCuvw3olGAaxVp3mtAfQmBX9Hjci04z7QmU6EfAYODz1sIkdz2/w==
X-Received: by 2002:a05:6a20:a10c:b0:145:3bd9:1389 with SMTP id q12-20020a056a20a10c00b001453bd91389mr11943803pzk.6.1694438120533;
        Mon, 11 Sep 2023 06:15:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001bbb22652a4sm6365069plt.226.2023.09.11.06.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:15:19 -0700 (PDT)
Message-ID: <d6da7de6-e603-4fb3-b68e-8d919f26fefe@kernel.dk>
Date:   Mon, 11 Sep 2023 07:15:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.1 20/22] block: Allow bio_iov_iter_get_pages()
 with bio->bi_bdev unset
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-block@vger.kernel.org
References: <20230908193407.3463368-1-sashal@kernel.org>
 <20230908193407.3463368-20-sashal@kernel.org> <ZP7j2MA5Qk6RBtAd@duo.ucw.cz>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZP7j2MA5Qk6RBtAd@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/23 3:54 AM, Pavel Machek wrote:
> Hi!
> 
>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> [ Upstream commit 168145f617d57bf4e474901b7ffa869337a802e6 ]
>>
>> bio_iov_iter_get_pages() trims the IO based on the block size of the
>> block device the IO will be issued to.
>>
>> However, bcachefs is a multi device filesystem; when we're creating the
>> bio we don't yet know which block device the bio will be submitted to -
>> we have to handle the alignment checks elsewhere.
>>
>> Thus this is needed to avoid a null ptr deref.
> 
> We are certainly not going to backport bcachefs to -stable. Please
> drop.

I already said as much 3 days ago:

https://lore.kernel.org/all/cd341326-cfaf-4796-8894-2241e7b630d9@kernel.dk/

but didn't hear back yet.

-- 
Jens Axboe


