Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7494EC43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 23:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiGGXjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiGGXjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 19:39:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DB6052B
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 16:39:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so293232pjr.4
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2022 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PP9HkPudxFKzM8yV+TLaxrJjGUojTwU1FfhBFhCGIak=;
        b=k4DbY5CyszwGTRynUgdVmiEQWvjZnndGUrPAPZGQ4Ojy/qbB+yaiCzY9YpS92QfHXi
         8c8b5Pzl63N8gqNO1qSb91heIcdaW1BOBsybROj6J6rXvJtgxQ5a0DIK+gIcqG1YjpgN
         +hcB82NURRBVyEsxs3I5s3hQLdXjgIcXeQL2piz8GcZBuuQF9obPt/DLszZudS46ucub
         DI5Vd9HxarF/LpjejqdQE8wUe/ENl/pJJFn9BOBfFjWC2M2hnYYCMzjPR0bOzLoi66jg
         Tz9gxX5FwRVo8RBpHV2MjKDZpX4DRkBgxjH5LUUPVtPyyHBy3YoMCSSK8+vFtVuHaU1X
         c2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PP9HkPudxFKzM8yV+TLaxrJjGUojTwU1FfhBFhCGIak=;
        b=mduhhXN80XwWoe0iQ6i0tuRN3X3jPCjzsNsjspgP4/eIk3nmDLssLKMw5cPM/1GkDD
         WT4k4ycrGzpSE3PEWbLdvuVziJXpqz2zh4FnoZxzrGz4EvWsr4aJuCJhsiDLHC4Phg78
         ncPqxBKMmoW3Rh77SHPsYqrO9wGeyaG5xs7YyNF33b6bTPaeuKt92f2SlxvOEw4Jz8p/
         VRCbC8INtqSwiFR1C/CnZEDsWooR4tmh90UJvPa/+B6tK77zddNohhGX1Kz+33BaXBl7
         KHIFth0N4jC1mZYm3DG72MjrjTx8o+nQsLIQJGxg8KBVDeyVKFHBHzE6V1IYo/bWzfPG
         pBFQ==
X-Gm-Message-State: AJIora+Ow22QUpyz20yB59kKXbTXiMAMgB9nWjCOWo9jbD32LEheDi1R
        MOHvOMwkxyMAtgzs+kokrTCLtJwu9LbHvA==
X-Google-Smtp-Source: AGRyM1sxQx+dUXvX0uvZBKWwJQ+i/OUosw96hqoXkyxuyiDKgo5ekEl3UoZvfwx71s1oOZoqYs60Fw==
X-Received: by 2002:a17:902:a589:b0:16b:c227:d7f9 with SMTP id az9-20020a170902a58900b0016bc227d7f9mr439863plb.29.1657237139487;
        Thu, 07 Jul 2022 16:38:59 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b0016a7d9e6548sm11888188plf.262.2022.07.07.16.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 16:38:59 -0700 (PDT)
Message-ID: <e4c2a81e-dd57-a55d-9a9f-56b7c03cc861@kernel.dk>
Date:   Thu, 7 Jul 2022 17:38:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Ysbe1DGn9vLRpEOh@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ysbe1DGn9vLRpEOh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/22 7:25 AM, Christoph Hellwig wrote:
> The following changes since commit f3163d8567adbfebe574fb22c647ce5b829c5971:
> 
>   Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19 (2022-06-30 14:00:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-07

Pulled, thanks.

-- 
Jens Axboe

