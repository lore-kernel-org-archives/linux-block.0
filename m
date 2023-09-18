Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2635CD13D2
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIRUPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIRUPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 16:15:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439A8F
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 13:15:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77dcff76e35so62527639f.1
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695068142; x=1695672942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjmj7plkbnOlDMjCra3y3a09oBx1pW45VyaUM21Y7AM=;
        b=VvO4wGnHhG/8yjHEZ+ktbqa+0WjjZOpfuhYQhzYHwRmO3Tfs5PrCeFVIGb+RuvuoVS
         o3uXe1boJTJycm6bAbDMp6Hd/tbkXt9Cuuw7LO1rqVIDX9I3NM4rla0o6VeMpKwUW0jl
         ANojvXB0M+qOAVYToTPvF0TDjLZd1axval+XzTlrF496/Tayu32+0GypnTJJ2bCtd50l
         aCB90HkTSL4VvjqbxYDpq0q7IbdGjjPWb9m6D8PIvCl32b55qUTrUmuYrtBXpaF9PX3V
         NkzmW68hNHy/OLqhwsh1kVB+mDibMa3Zi2NIwDE8cet2LPMT06TB+jpN78sj2ENKx4ww
         T2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068142; x=1695672942;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjmj7plkbnOlDMjCra3y3a09oBx1pW45VyaUM21Y7AM=;
        b=Yr2bHyR582p3Sbfj4xmmtomAHsR7TWYdraoB04YyA55YZF9lBX/AKML7ThYzDwWvWS
         P++tbZdDYgSKgAZFZb8crHAfuiBURtU8vFPadMPbVoIc/531yso3ijLqvVGHsRTzb/8W
         wg1KWDn2/8Y5ShWxL2mx3qG7BzYiBaVunyKQhsjRF9TxNW/2c8h6Dh3pFkXjIy0PChC+
         6M64cwE5bGSbBNrSZ2YDsyOVzqfaz8jmMLs6NMOGvalIRMee08iSTmd4kYTD0WbR6nLZ
         DdWeAkvoIWcEuTcrXih69/xfcV+2jCGmKfPjts4DO5UTbZUQlEGwcJVsJfwCYUrDD8b3
         wOuQ==
X-Gm-Message-State: AOJu0YxHbogOSRFPsuG/7kkXy9h7Cf60wLOMv9cnPyB4PDglg8YsltxN
        mvmJu8cOK+DJEi8C+2Rcmf1KtYwAIsDEdRsffDN8Jw==
X-Google-Smtp-Source: AGHT+IF6ZrFTRNOlSrFYsTgxKrHJFPd36vms08lvaqfmFTt5ikRLAhqAeHlPU/sHGBbXLkoXXETm0w==
X-Received: by 2002:a92:907:0:b0:34f:6e08:d6a3 with SMTP id y7-20020a920907000000b0034f6e08d6a3mr10411038ilg.0.1695068141828;
        Mon, 18 Sep 2023 13:15:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o20-20020a056638125400b0042b451aa95esm2945116jas.150.2023.09.18.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:15:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
In-Reply-To: <20230914091508.36232-1-shikemeng@huaweicloud.com>
References: <20230914091508.36232-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH] block: correct stale comment in rq_qos_wait
Message-Id: <169506814063.372099.2658807658177703138.b4-ty@kernel.dk>
Date:   Mon, 18 Sep 2023 14:15:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 14 Sep 2023 17:15:08 +0800, Kemeng Shi wrote:
> The rq_qos_wait calls common wake-up function rq_qos_wake_function to get
> token. Just replace stale wbt_wake_function with rq_qos_wake_function in
> comment.
> 
> 

Applied, thanks!

[1/1] block: correct stale comment in rq_qos_wait
      commit: e599ed7866cd804ca15de7a92f7f629944cc278d

Best regards,
-- 
Jens Axboe



