Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E3C001DB
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 18:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjHHSZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjHHSYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 14:24:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C3BC0C
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 10:36:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-790b6761117so69824539f.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691516212; x=1692121012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W12zFQNYWmf7lxVitQTmsPU6ohpCj7vCRxt2BuviHRg=;
        b=xyGAFtDAT2tPBjTd1aJ2XnvUCud1/g6zAx2AYWN70Ly+He1mw+fJy0CddhXj9UAMa1
         BT0sTdPbrjmzUnLFsLkFiJTPh8YdHBLKoIV9BLRBVisNoPW9xjyljU3gy9pSSakFXQRC
         ZsLkvep318DI/l8tr/l0qx3G2LX0HLnQVgo+4IFp9WyqT63g0U7unp/Q21UB1uQRSMb3
         oju4r/2GglDgnu/oWymTVrJaBSPDpiOOqWuQCkNJs/qV0bvyb+p+Q06/Bdc8k+N9uxCY
         fe/akn93vobbJaJ6e+Oso3xFlLzFNctNYzRW7oJHlnDl7nbu4pDLpxM8eA/Oi0U3aNev
         +pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516212; x=1692121012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W12zFQNYWmf7lxVitQTmsPU6ohpCj7vCRxt2BuviHRg=;
        b=iymQjCsA8+D52vdMkN8Od0NZ56mdKFxgHR15Vb3MZAdw06ugg94rqkJtHFNtiHYNXL
         O181TfB4UpRAV1S0Qy/ogt1GejZ9hPtEcNFX+dh7aGHKFyn9+rfnzTVcq+r8bsiShhRM
         Oz0N6xkX5mLgDv5J1iuwIpVctft7stgmSzkyV2jwyYDytFNCHi59ZjbmMD6FKidEX8SQ
         qS6AtOdDu/BJXOykzGYzxLTOEgJFFi0q+pVT+6kWUO/MQpGhix9MWFPxNZvB6tihW1N2
         8G8WNslpVWNgoGIGwERtv5soZSfbOJSrIYkSPzJ7vX32j2u+km41UaOHtzlL6TIACv2O
         eiPQ==
X-Gm-Message-State: AOJu0YwZ+WvAnK++5ZDnJu4zJKTgaXEG8exPhwHeXArVIMcg+bbz+Pxk
        hNfiU6MdbmTtr3V2Ej/FEo5QmcvpYGMCrl3Pb0I=
X-Google-Smtp-Source: AGHT+IH62rOiVnjNuGqI06d97/ArjLGjXdQg2Q222YmDWvHqg+md7I8nZsJjL9J0VbHSwYXwamnV3g==
X-Received: by 2002:a05:6602:3798:b0:780:d65c:d78f with SMTP id be24-20020a056602379800b00780d65cd78fmr335599iob.2.1691516212356;
        Tue, 08 Aug 2023 10:36:52 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a24-20020a6b6618000000b007909b061efbsm3771878ioc.23.2023.08.08.10.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:36:51 -0700 (PDT)
Message-ID: <5e560155-b2a4-e5bd-d22e-0e44a5a85f43@kernel.dk>
Date:   Tue, 8 Aug 2023 11:36:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next] drbd: Use helper put_drbd_dev() and get_drbd_dev()
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
References: <20230808090111.2420717-1-ruanjinjie@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230808090111.2420717-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 3:01 AM, Ruan Jinjie wrote:
> The drbd_destroy_device() arg of this code is already duplicated
> 18 times, use helper function put_drbd_dev() to release drbd_device
> and related resources instead of open coding it to help improve
> code readability a bit.
> 
> And add get_drbd_dev() helper function to be symmetrical with it.
> 
> No functional change involved.

IMHO this just makes the code harder to read. You're not adding a
helper, all it does is call the same get/put parts. Why not just keep
it as-is then?

-- 
Jens Axboe


