Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007BBC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C216C206BB
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 23:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bN518cBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeLTX4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:56:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46528 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLTX4T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 18:56:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so1649351pfe.13
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 15:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hidBdAt5RNqzjOs3uysngXHWa5pUZoO1LBfK7FuyoEI=;
        b=bN518cBmWB3cjI2ZJIxJUJe1lwwdRmUCfmWkcFtYPxq0RWKJZRrAAP+H93vNjRkSC3
         74FoytzA8V3gJgGBXuphfW9vZZDjF68UZJ/dG4deC/lKNEmLEplJgK7LWDt3vabL2FyB
         4wTtFu6PtFjFgEQj2FoW7iRougpQ+kRnC52D3wJpVJboMnOSYBviDZqeqBvRsc0fo076
         ZKm+bOs3OvlS8V2aa1hiNR13q2MJhsX8hVBF3OWAOsxSvXLi0p/TfU3UaIjvBQR02kEf
         PTNd3zXdQJAGRVA6fpbGxfrEMvWARGI6209Rc438rJOY0f6lE99v4+zWnPi0Oyv5ZRhk
         Nulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hidBdAt5RNqzjOs3uysngXHWa5pUZoO1LBfK7FuyoEI=;
        b=II6Cd1tG9LLwNVIZan6gCormam5NXS41/czbECY/7i/xFqJPxVk0NaGHkU4EqyzCOM
         IjgyZzi/STDnBMuH/qChbw0uHjGGdZM8B7kqXgjgoUTzI1jhCEy73gXRdxF0uULhBUe0
         hk6R+ZQVByprvxqGyUCcBStKE/dQnun29zFOEqWx9yVSKHcPg782ktj2XySRBd0lMOsy
         bCb0zqJD7dq/HlfH4MF0UnBtKgYvoASAl+0grW6/YkjjgQlKV0efA6x32LFGqYxHhjDf
         YkV3BRCYShitvN/L16jCdYL1Ro98DKGAaiUicPQTm7OAbz+kOTReW0Usmd8WA0Q09OPv
         7jtQ==
X-Gm-Message-State: AJcUukd5VJd4cSOyse6n2/oKS/BouiI1OCN/TIClnofiwrpuNRa7YHZe
        sTBmctoEWeeMiGAa93J7CHVNBg==
X-Google-Smtp-Source: ALg8bN6WnuTCL4166Vccxklstxsai4zbetlJEIZkJlbeRYM0bQcT+hFiWkFfnYfHzrBNayEiBfQbHw==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr257053pgl.282.1545350178657;
        Thu, 20 Dec 2018 15:56:18 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:ec3d])
        by smtp.gmail.com with ESMTPSA id y184sm28331905pgd.71.2018.12.20.15.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 15:56:18 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:56:17 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 0/2] Add scsi-stress-remove to blktests
Message-ID: <20181220235617.GF11852@vader>
References: <20181220181826.55481-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220181826.55481-1-dennis@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 20, 2018 at 12:18:24PM -0600, Dennis Zhou wrote:
> Hi,
> 
> v2:
> There was a minor typo in 0001 pointed out by Omar which I fixed here.
> 0002 was refactored to use common/scsi_debug. I also rebased onto the
> top of osandov#josef changing the test from block/022 -> block/027.
> 
> From v1:
> Ming Lei's scsi-stress-remove test found a bug in blkg destruction [1]
> where bios being created when the request_queue was being cleaned up
> threw a NPE in blkg association. The fix is currently being discussed in
> [2]. To make this test more accessible, I've ported it to blktests with
> Ming Lei's copyright. I've tested this in my qemu instance and verified
> we do not see the NPE on a fixed kernel.
> 
> Ming, please let me know if you have any objections.
> 
> [1] https://lore.kernel.org/linux-block/CACVXFVO_QXipD3cmPvpLyBYSiEcWPN_ThQ=0pO9AwLqN-Lv93w@mail.gmail.com
> [2] https://lore.kernel.org/lkml/20181211230308.66276-1-dennis@kernel.org/
> 
> This patchset is ontop of osandov#josef 98db2e11c97f.
> 
> diffstats below:
> 
> Dennis Zhou (2):
>   blktests: split out cgroup2 controller and file check
>   blktests: add Ming Lei's scsi-stress-remove
> 
>  common/cgroup       | 18 +++++++----
>  tests/block/027     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/027.out |  2 ++
>  3 files changed, 88 insertions(+), 5 deletions(-)
>  create mode 100755 tests/block/027
>  create mode 100644 tests/block/027.out

Thanks, Dennis, applied along with Josef's cgroup infrastructure patch.
